Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825F0C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 15:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5938122B4E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 15:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595171790;
	bh=bUHUr8f704qfasOHLj7vXLRRYUwyFmxfe3IyM5uTxcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LE6v5iW/qYzFIVfaCaNj1b7c1ToHRx61sVa5zwE9BOliCdbrN3J8TH7CH3/eWjHbu
	 BD8i30g2U4r+q4GHKEpb17BQ3WAc9CBSI+PwZ5nPAC+QZQwdFdMlgz4HegS7KX3oQy
	 BePy+KZS+dhKNXJBLMrFvSJjywwd5NsbGQk/lVA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgGSPQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 11:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgGSPQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 11:16:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F344422B4D;
        Sun, 19 Jul 2020 15:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595171788;
        bh=bUHUr8f704qfasOHLj7vXLRRYUwyFmxfe3IyM5uTxcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bDBYRNpmL2M5sfmkgiJWS3XCx5IzAXxr0VWlgyZtoZGe2ptUpbQyPKuXtyCiCUq3M
         2L0PJLwBReVvJjL9W7ykO7KHA77DAfN9b8wyEczaC5hOTi9WwPJhjaSV/wqZfN4Bpl
         TX5cv/URXmkSyvc/1cJg/VpmESwM+Ko6qhdqvfl0=
Date:   Sun, 19 Jul 2020 17:16:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH 1/2] f2fs: add sysfs symbolic link to kobject with volume
 name
Message-ID: <20200719151640.GA301791@kroah.com>
References: <20200719054409.3050516-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719054409.3050516-1-daeho43@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 02:44:08PM +0900, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added a symbolic link directory pointing to its device name
> directory using the volume name of the partition in sysfs.
> (i.e., /sys/fs/f2fs/vol_#x -> /sys/fs/f2fs/sda1)

No, please no.

That is already created today for you in /dev/disk/  The kernel does not
need to do this again.

If your distro/system/whatever does not provide you with /dev/disk/ and
all of the symlinks in there, then work with your distro/system/whatever
to do so.

Again, no need to do this on a per-filesystem-basis when we already have
this around for all filesystems, and have had it for 15+ years now.

thanks,

greg k-h
