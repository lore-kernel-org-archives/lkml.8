Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F92C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FFA2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597730996;
	bh=zRSoZcxxtlGv7Uhf96NOWLK06H4oKEDZby8VR4L6QTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X0Y2CPOZFXhiqNbQpzvo1khpZOQymQqvvoryhXLwC1e12GhSIt3sMfHPoFNdoDXsV
	 qoNWPmSY+vyNfHHB5hh+R0x/FWBYWZOTW1PfL70ytOMkfYmmIUNAVuIBuaNejBnl3v
	 kfOl9LrlpEffaAZ3tFBWQ7KwKw9jYw9oxrywpQfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHRGJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:09:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgHRGJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:09:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBDAB20709;
        Tue, 18 Aug 2020 06:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597730994;
        bh=zRSoZcxxtlGv7Uhf96NOWLK06H4oKEDZby8VR4L6QTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+Zu/6dCiM8xP0df+50OiO6fN50f1cVZsI9u3rQaVJOZ3VnHn6tiVvtLjSIceZPg8
         zmVASdKd4bNQ8hFNzgYe6SpT65No+Ux6g9j3bnXyw8GAS3gGXE7v4jzRFqBEETga9U
         WyGrpYN+VBRqglzyevKDF1PZOG5g+J89lPGH7JZk=
Date:   Tue, 18 Aug 2020 08:09:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] romfs: Fix uninitialized memory leak in romfs_dev_read()
Message-ID: <20200818060951.GC1742213@kroah.com>
References: <20200818013202.2246365-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818013202.2246365-1-jannh@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 03:32:02AM +0200, Jann Horn wrote:
> romfs has a superblock field that limits the size of the filesystem;
> data beyond that limit is never accessed.
> 
> romfs_dev_read() fetches a caller-supplied number of bytes from the
> backing device. It returns 0 on success or an error code on failure;
> therefore, its API can't represent short reads, it's all-or-nothing.
> 
> However, when romfs_dev_read() detects that the requested operation
> would cross the filesystem size limit, it currently silently truncates
> the requested number of bytes. This e.g. means that when the content
> of a file with size 0x1000 starts one byte before the filesystem size
> limit, ->readpage() will only fill a single byte of the supplied page
> while leaving the rest uninitialized, leaking that uninitialized memory
> to userspace.
> 
> Fix it by returning an error code instead of truncating the read when
> the requested read operation would go beyond the end of the filesystem.
> 
> Cc: stable@vger.kernel.org
> Fixes: da4458bda237 ("NOMMU: Make it possible for RomFS to use MTD devices directly")
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
