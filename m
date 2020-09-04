Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05763C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFAD32073B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="pMgwV8Aw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgIDQne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgIDQnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:43:33 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E371C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 09:43:31 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 2so3460971pjx.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nAm7MkjzNXisCy7+ch7x2r9mkDHgpbPGhxOYS7CWrr8=;
        b=pMgwV8AwEVjWFwQEo3b9bjaCVQOzRhRYlj67mzvuxz41dYkiFtbEa7de9YWFJBt4oo
         C+yXh9XQ+jGgCfDBdLREUZlqAbm+cGapY3Icls5ablcKOZx/kSMafbPFxakLEtKhNhjz
         sYjup3WZCwImNdUhySG86Xxpu9chVsn3Q833DtxkIBYkRWH9bvMQk1LelqvcaaeJCbRm
         C22tw26aDLzp+dp0ZgmT7oQbrAeVg0uiUCPmTUSuEtre2JXyXXpTxk8JAngl06yauasd
         PkYAqJjnVl5iEp1ju9BWgHrS9ZGl905m1H+404bcSDjZVgTv7aCdfLPI/h+z31GEggHm
         gE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nAm7MkjzNXisCy7+ch7x2r9mkDHgpbPGhxOYS7CWrr8=;
        b=NHPeoxolrJbWbtf8RdLa/ri6L983jbQDBVy8TeBAnolvnJnsPiDiKxs/+nbFp5qT83
         fz7PxlkCu0D9lrAWLyL16xo4HIN2C2BJk/n9/5S735G/KKmzrLVgGVvQfxKAc/o2BFt6
         Lmtb9KBHvsIognC/uAAjCzLsEK5gS97ZCnhZSeWMgf3OqkcW9p9hokvwe/vCApciMdtC
         TqkE4IiWjkfH8RWLp9eL5cBlDZv/1fnsdBq+WZYsymFl+c11Qt9f+Igl4XwtIiTsZARI
         IXRrM4YZudbli6NhHoe3dOusP8yQwd17sTL7kfpv5tXwTpbnxtB9Z6IDMPM7TkvnAXtG
         EAGw==
X-Gm-Message-State: AOAM530jRxsImhLKi5eYlTS5FeCTnKrwiZGBUkABPhsKVrKQKZFwaEQr
        rpLgQ1RR2oNIFKm04Nhl1bzw9k6Cl48rn29yB6HJTw==
X-Google-Smtp-Source: ABdhPJzvtfKsPfB8wh9Y9fOxdFUYrY1cJ00wnwe/aHTdlspsZb2WXoGDwFjNhzzwMYfD4B6Wijlv9/qEBKeMX2COua4=
X-Received: by 2002:a17:90b:360a:: with SMTP id ml10mr8567244pjb.198.1599237810537;
 Fri, 04 Sep 2020 09:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200904162121.279578-1-anup.patel@wdc.com> <20200904162530.GA32095@lst.de>
In-Reply-To: <20200904162530.GA32095@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 4 Sep 2020 22:13:18 +0530
Message-ID: <CAAhSdy2ru2xuOC76UvCBhUoDNEv=f_w0Q4N+9UmQaVnNyMaE-Q@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Allow drivers to provide custom read_cycles64 for
 M-mode kernel
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 9:55 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Sep 04, 2020 at 09:51:21PM +0530, Anup Patel wrote:
> > The TIME CSR is usually not present on most RISC-V systems so the
> > M-mode firmware will emulate the TIME CSR for the S-mode (MMU) kernel
> > whereas the M-mode (NoMMU) kernel will have to use MMIO clocksource.
> >
> > Currently, the get_cycles() implementation in asm/timex.h does not
> > consider the above fact so we provide alternate implementation of
> > the get_cycles() for the M-mode (NoMMU) kernel which expects drivers
> > to provide custom MMIO based read_cycles64() method.
>
> Please just go back to the previous working version without all the
> crazy indirections.
>
> The whole timer and irq code has been turned into a giant maze of
> indirections lately.

I respectfully disagree. IMHO, the previous code made the RISC-V
timer driver convoluted (both SBI call and CLINT in one place) and
mandated CLINT for NoMMU kernel. In fact, RISC-V spec does not
mandate CLINT or PLIC. The RISC-V SOC vendors are free to
implement their own timer device, IPI device and interrupt controller.

We already have RISC-V systems (e.g. Andes AE350) where we
have a different timer and IPI device instead of CLINT.

The current code is more flexible and allows SOC vendors to write
their own timer driver under drivers/clocksource.

Regards,
Anup
