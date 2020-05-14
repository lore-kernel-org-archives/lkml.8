Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645E7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E42220575
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AM36biAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgENGTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 02:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725806AbgENGTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 02:19:36 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C9DC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 23:19:36 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v4so2000329qte.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 23:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XIp0C6QEPTimGYUPcVoxPiQyF3c7NZmGIbhayylshvE=;
        b=AM36biAsbTjLsRTjDL56VJ5PrEQ8YgKLjtaMKJs6NpfDbI3YobZdDQx5/GYs+XuVBL
         PgW0dc4T5m/YXTiuqLHPAKY5wH/bzfWdTXmGinwcma+uVDggFuap7S9GyqSmffm3PpJK
         Y51AtI+eMPmvPw/GUO9OdEUccUe21kxKHUEasARb8ACgcKZA5FFBKbAPiYpSBHMu5Ewy
         kX+empwZi80UcVZhz844tszKKgrDqvrFK0hCKZuucD54JEt/ZUsZdiWvIb6AwZYnNoAO
         JZahSRceUwef3rdhIFwZPbHwsjBnkFdHT3Pq3zWxClU+wK/KylxGF8qlaTyaJUyVoj6W
         zHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIp0C6QEPTimGYUPcVoxPiQyF3c7NZmGIbhayylshvE=;
        b=e6ahn9yIxgO5TDkSyr714VUaF9yQejBdeq3xOQzHZ8nc7rXHy3CgW6fD73NUNyWGyI
         09pWgUgP1lgYGtxvPwhWt8bpe15qnT+QsGpG3qYR0+MK/r0J8NqW4HCenVycK8BZcbgw
         +80g+zb2+jUfEeOzbIKblkQl/+oI2NwgIz0b6lJzqGguRR6NJBgZGXPp+odlF2ddSe9d
         0VMYUvd4J21eQuro0/yklTV9fQrgrH12HbcnwPpNVeJJRrEdZawNK87Q7je5a4BPVOSl
         hufcQqrMtuZvQIm92CloFwWNxHcsE++De0x/fkjdfZECel8lvBJq0HjBhtggJIYb6bRI
         WIjw==
X-Gm-Message-State: AOAM533MAnNL5Wdk/oGKvf37//YsVVaAABmdN/oDafiOt5NKOyKLpx2+
        mFSItuFjVeqQEKJ6Nqw8KJY/zvZcjCcgPqIZkqb+mQ==
X-Google-Smtp-Source: ABdhPJxA4cM/yN+6mVcWJS+D6dYpV33uij4dpEVoppkIP5cNZRkjEPci3kVh8K2SFlTRjEC8bf8jfZwTdZ41z3BcayE=
X-Received: by 2002:aed:37e7:: with SMTP id j94mr449468qtb.57.1589437175632;
 Wed, 13 May 2020 23:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f0d8d205a531f1a3@google.com> <20200509074507.GC1831917@kroah.com>
 <87wo5l4ecm.fsf@nanos.tec.linutronix.de> <20200513124445.GA1082735@kroah.com>
 <87zhab249p.fsf@nanos.tec.linutronix.de> <20200514035458.14760-1-hdanton@sina.com>
 <20200514061417.GA8367@lst.de>
In-Reply-To: <20200514061417.GA8367@lst.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 14 May 2020 08:19:23 +0200
Message-ID: <CACT4Y+Y3g+NCCLP_twHeU9+Q=MfrRM4OrDQFFTGXsE=s2kKXYA@mail.gmail.com>
Subject: Re: WARNING in memtype_reserve
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+353be47c9ce21b68b7ed@syzkaller.appspotmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, jeremy.linton@arm.com,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 8:14 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Guys, can you please start formal thread on this?  I have no
> idea where this came from and what the rationale is.  Btw, if the
> pfn is crap in dma_direct_mmap then the dma_addr_t passed in is
> crap, as it is derived from that.  What is the caller, and how is
> this triggered?

FWIW the whole thread is available on lore:
https://lore.kernel.org/lkml/20200514061417.GA8367@lst.de/T/#t
