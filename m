Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55F5C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33DE2166E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583146318;
	bh=QhrSpr4F/VHir8Gjk0KuUg34z4MvdyKSC/6orAOEeT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1i2b02uBsnuBZLtaZJTrsJ9k8oEuPKJs/gqeFSSMyoSHrtQBKDYxj/LWdpcMCyNC5
	 5vSex4FqcG8X3YZupFj/l7hRbF0ww1xnnQS8Kn2xX9RiAFre8meUNCnu9pIMsI8Ron
	 5x8S6xWxTV2K8EZ9wiYclQkm3ERH0/6fIrWCD7Mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgCBKv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:51:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727689AbgCBKv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:51:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BD6B22B48;
        Mon,  2 Mar 2020 10:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583146316;
        bh=QhrSpr4F/VHir8Gjk0KuUg34z4MvdyKSC/6orAOEeT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CSJj0LAt/6zmv+NRxBy9coFYVpN96bhoJ+2Yd8MYlWYa6093en9efrbDhXwq228wX
         k8G5YKkALFqlkUK+sFLVMRsycZsvWifAFOLTLkAVhWyl/uashoPabfUMFzCptaj7XC
         82IK5hOm5BD2ha/Gd1M9+8DRjhOxVGLdehNZtQzo=
Date:   Mon, 2 Mar 2020 11:51:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pty: define and set show_fdinfo only if procfs is
 enabled
Message-ID: <20200302105153.GA39968@kroah.com>
References: <20200302104954.2812-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302104954.2812-1-tklauser@distanz.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 11:49:53AM +0100, Tobias Klauser wrote:
> Follow the pattern used with other *_show_fdinfo functions and only
> define and use pty_show_fdinfo if CONFIG_PROC_FS is set.

if proc_fs is not set, it will not be used anyway, right?

I'd rather keep #ifdef out of the .c files than add this.  How much
memory does it save, and are you using a system without procfs that
needs this savings?

thanks,

greg k-h
