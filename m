Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE89C2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A67F20672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586161744;
	bh=Bs/Gw3wFcv8hnvO+CBtPHuv8rggilD6plAwwRLi7Ito=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fVnRIWKIWszOTmdIwInKHv7Qom3X9sk5Rry72iM7PM15dcgn0XuV13YGFseyCT1SA
	 RjhxJ0kwK7S5pVaPqpMzLPGIfU5nPm4fCt+TabMyaH3FltQJfZdACHnBSMU6njLZLN
	 nl72NyN9xxYA27G6AbfmMftiZar8QLoI43D3hdiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgDFI3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 04:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgDFI3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:29:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5892220672;
        Mon,  6 Apr 2020 08:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586161741;
        bh=Bs/Gw3wFcv8hnvO+CBtPHuv8rggilD6plAwwRLi7Ito=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MbSnRcAnfcmTpOWMlDpF2S8R2p40IWbqXlhKGGeWqFBOA/5IB8gRGtQUqDm3OLOfU
         8JSyO3sn2pwKMoomhnkK2bbhf3CS+4PW+3Roxo2KyyTeT2C9Zy/RoPiGcVdZtajQxP
         BPVImBvLX6Uo9EOBlziEWv/7aUdJ16MDwoH7+moo=
Date:   Mon, 6 Apr 2020 10:28:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fei Zhang <zhangfeionline@gmail.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH] driver core: Fix possible use after free on name
Message-ID: <20200406082857.GA1646464@kroah.com>
References: <1586102749-3364-1-git-send-email-zhangfeionline@gmail.com>
 <20200405164006.GA1582475@kroah.com>
 <CAC_binJNLLxfOm0W2TuVTJZxJRTZTvPPocSDNQMU=21XO37oZg@mail.gmail.com>
 <20200406054110.GA1638548@kroah.com>
 <CAC_binJMn-uRNy1dwp=2fhF54R8DpaTZYskwEz3GNE-U0pShDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_binJMn-uRNy1dwp=2fhF54R8DpaTZYskwEz3GNE-U0pShDQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Mon, Apr 06, 2020 at 03:40:41PM +0800, Fei Zhang wrote:
> Dear Greg,
> 
> Mostly, "class_creat" is used in kernel driver module, basically
> read-only strings,
> but it is easier to use a local variable string. When writing drive module,
> it fails to judge the local variable string which cannot be passed in
> only via interface.
> I found that someone else may also face the same problem.

An individual driver should NOT be creating a class, that is not what it
is there for.

Class names are very "rare" and should not be dynamically created at
all.

> If we have 2 identical hardwares with different internal logic(fpga),
> it may be more
> appropriate to create dynamic classes according to the logical functions.

No it is not appropriate at all to do that.

So, I'll ignore this patch as this is not something that you all should
do.  If an in-kernel user needs this, I will be glad to revisit this
issue, so I strongly suggest you work to get your code merged upstream
properly, so we can review it and suggest what you should be doing
instead.

thanks,

greg k-h
