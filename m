Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0298EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6242087C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599210320;
	bh=XNGgU6FL4GG/Ybgkx7RbgtTnqNVDiwMqE5Ylbo8CxC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2ngAciau/4V11GaK6E1n6ACoZd7Thf3r1HsxVsB58KomAmb160QnS2ZjnVRoons6K
	 vNPaXUEQxc1eSdms2A9t1u9sjFmFzlDAE0Qxyvx412J9COYDbJtQTfMwE7NPZun9Z5
	 69WssG7klvH+zgRTFGomJprU0wvJjRalWFr1/KFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgIDJFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgIDJFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:05:14 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A02D620748;
        Fri,  4 Sep 2020 09:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599210314;
        bh=XNGgU6FL4GG/Ybgkx7RbgtTnqNVDiwMqE5Ylbo8CxC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nPEQtiWtZt+knQqNgK7ktbFh8jtL+1qKksiKXegqXhpg4NVgeeRSIGlEfIOopE7jo
         LPsKcrSFzZy1PpH8Rj2VT3ppZ9WYuHFdI9yFidM9Py5svD9erVulcJz0xMt0TR5LLL
         kTt+LDZXMi8ODg2PrEepMrM+G+S9As1XJX45ISPk=
Date:   Fri, 4 Sep 2020 11:05:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Changki Kim <changki.kim@samsung.com>
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        changbin.du@intel.com, masahiroy@kernel.org, rd.dunlap@gmail.com,
        krzk@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: printk: Add process name information to printk() output.
Message-ID: <20200904090535.GA2440145@kroah.com>
References: <CGME20200904082449epcas2p4420d5df2083325b328a182c79f5c0948@epcas2p4.samsung.com>
 <20200904082438.20707-1-changki.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904082438.20707-1-changki.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 05:24:38PM +0900, Changki Kim wrote:
> Printk() meesages are the most basic and useful debug method.
> However, additional information needs in multi-processor.
> If we add messages with processor id and process name, we can find
> a problem only with messages when the problem occurs with H/W IP or CPU.
> This is very useful in narrowing down the scope of the problems.
> 
> Therefore, instead of trying to help buffering, let's try to help
> reconstructing messages by saving caller information as of calling
> log_store() and adding it as "[$processor_id: $process_name: $thread_id]"
> upon printing to consoles.
> 
> Some examples for console output:
> 
>   [    0.059580] [0:      swapper/0:    1] CPU: All CPU(s) started at EL1i
>   [    2.153157] [5:           init:    1] migov: complete to probe migov
>   [    7.441317] [4:           init:    1] NET: Registered protocol family 39
>   [   22.793389] [5:  kworker/u16:1:  184] SMP: stopping secondary CPUs
> 
> Signed-off-by: Changki Kim <changki.kim@samsung.com>
> ---
>  kernel/printk/printk.c            | 20 ++++++++++++++++++--
>  kernel/printk/printk_ringbuffer.h |  7 +++++++
>  lib/Kconfig.debug                 | 16 ++++++++++++++++
>  3 files changed, 41 insertions(+), 2 deletions(-)

Isn't the CPU number already present if you want it today?  Why add it
again?

thanks,

greg k-h
