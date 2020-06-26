Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4365EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D1020E65
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593181179;
	bh=xGvMhYdL0SsIxlp6493J5SH2f1tkLzZPbB6DcFRR/Co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OSEx2zzPg0ZMc7yBlLdbk3m+0a6a46K1wcwWuK4Q9QjDgkJhsVOYwG9qkEpgTCC6d
	 +L6OrthuyDFAOnxWUQddifOklMJ8ST0MA1ni8jfgXcOTfksr5D7LDx+82xqP9faEm2
	 Zc/0bv+mYo7IbFwQZXN2Oeyh/6a9HXKOqJ+Mij+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgFZOTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:19:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbgFZOTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:19:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E848F208C9;
        Fri, 26 Jun 2020 14:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593181177;
        bh=xGvMhYdL0SsIxlp6493J5SH2f1tkLzZPbB6DcFRR/Co=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0C0kKj/2XZdz9AYwQRO/gF40TOgr9vGcgeorNTOKAxS0spCnbQ7L2AZDVz564hjjC
         FIa0OrEAe6k+xkWRUrtWHFDdXedZRQtqQrZyJNeWvAy6T4tsnom5I/yP/4v2vpuGC4
         GZQqIm8GJ6oiSCu4DrEt5SUH885r/3zoomHi9WS4=
Date:   Fri, 26 Jun 2020 16:19:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, jslaby@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] kdb: Switch to use safer dbg_io_ops over console
 APIs
Message-ID: <20200626141932.GC4141629@kroah.com>
References: <1591264879-25920-1-git-send-email-sumit.garg@linaro.org>
 <1591264879-25920-5-git-send-email-sumit.garg@linaro.org>
 <20200626121348.eeutt4py34f2yg3y@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626121348.eeutt4py34f2yg3y@holly.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 01:13:48PM +0100, Daniel Thompson wrote:
> Hi Greg
> 
> This patch touches some kgdb related code in both serial and usb trees.
> 
> Any objections to my queuing this via the kgdb tree?
> 
> After testing I've concluded that this, and its friends (which only
> touch kgdb), fix enough problems that I plan to queue it for v5.8.

No objections at all:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
