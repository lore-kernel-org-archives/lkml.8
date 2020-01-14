Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547CCC33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 03:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A2B214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 03:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nQc8qxdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgANDse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 22:48:34 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43477 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbgANDse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 22:48:34 -0500
Received: by mail-qk1-f193.google.com with SMTP id t129so10884172qke.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 19:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTJ2coo4RHoH/lJGEL6/xkagWbBVDH7gBcZR8SjOkz8=;
        b=nQc8qxdX/AeOVnGOFlRCgCYp1v+Q9S3HUvIYqgb2rMKCYn9H5NsgVRHIHo5c7toLey
         TL4BEKQxXsuUYLj7+4+xMp3q50jmsSvEjvG+9J0yvLmS8T2iQrpzs2qY9wRhbRKmCJxn
         qhL8WI1HWHG9fPkkH8HxV/eOlqTHBINXjp0kFBOeruRYTz/qagED/LKtJMr+FJECKcye
         axHnG/a53UeioPdkcDOXPDm5WZygoCFWZYwZpEcMGe9FJhkcook5Z5qNfC7miQ2HUWte
         nB5mIAF0jz0sjypPQprD8RerGyQAys+ZI5JkALp+Xx77+fFJp+XHYzq6w+NKG6SkW/jn
         6+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTJ2coo4RHoH/lJGEL6/xkagWbBVDH7gBcZR8SjOkz8=;
        b=IXbyat4n5aa4v4W3LDn2hBav3asH+POG2t11+1RDx6kLCUPGA5CokdCr4cdSXENxQY
         45k3JT97dbeB1C7cTwn96kzVLawce/QkdfTjg1wQnHu9lb534KSbTaEwPuXJL9T9A1cx
         9DPU+EhbsWEED33HUnMJFmS8B1keefjhIzMg0V3Pa/uLhu3Eki0bnZuQKppWGU/CVUC2
         Adsm2+tX/pi83x7wn/mO2lUfgCcqKWdJXfNrVd/m8xIdXEhYduKcC59t/qLg1CPJgvfB
         LkWcJM4+S42r+8G5CyPNAmt1xH1sofnEabF/AWUMaqWi7tHdd0Z2cjYWJqkYpIAQklrN
         HJTw==
X-Gm-Message-State: APjAAAWj25i9vD4vTdgAso4RtvG+kkjXokbjpptilSew2R9dkIP5DVw6
        FpW25MVj6k+unmZg1uuZKcp5HZuT76C3uN+misYMmg==
X-Google-Smtp-Source: APXvYqzDpb9Yyqx7bCFNZvCTSYvZ5WdMj+Wq11S0hKuv/ey3nRFiCF4ih93/7FilTGOzb44QaMjq/NvjhXCEP9VwNiA=
X-Received: by 2002:ae9:c018:: with SMTP id u24mr19621044qkk.339.1578973713171;
 Mon, 13 Jan 2020 19:48:33 -0800 (PST)
MIME-Version: 1.0
References: <20200109031516.29639-1-greentime.hu@sifive.com>
 <alpine.DEB.2.21.9999.2001091126480.135239@viisi.sifive.com> <alpine.DEB.2.21.9999.2001121011100.160130@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.2001121011100.160130@viisi.sifive.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Tue, 14 Jan 2020 11:48:21 +0800
Message-ID: <CAHCEehKchrwd7TTmSrhtEPeCmkrYrx7TX_c6ogpCpSkCKnBQoQ@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: make sure the cores stay looping in .Lsecondary_park
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Gt <green.hu@gmail.com>, greentime@kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Mon, Jan 13, 2020 at 2:12 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> Hi Greentime,
>
> On Thu, 9 Jan 2020, Paul Walmsley wrote:
>
> > On Thu, 9 Jan 2020, Greentime Hu wrote:
> >
> > > The code in secondary_park is currently placed in the .init section.  The
> > > kernel reclaims and clears this code when it finishes booting.  That
> > > causes the cores parked in it to go to somewhere unpredictable, so we
> > > move this function out of init to make sure the cores stay looping there.
> > >
> > > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > > Reviewed-by: Anup Patel <anup@brainfault.org>
> >
> > Thanks, the following is what's been queued for v5.5-rc.
>
> During final testing, when building the kernel with an initramfs, I hit
> the following linker error:
>
>   LD      .tmp_vmlinux1
> arch/riscv/kernel/head.o: in function `.L0 ':(.init.text+0x5c): relocation truncated to fit: R_RISCV_JAL against `.Lsecondary_park'
> make[1]: *** [Makefile:1079: vmlinux] Error 1
> make: *** [Makefile:326: __build_one_by_one] Error 2
>
> Could you take a look at this?

I think it is because the sections are too far for bqeu to jump and
the config I used just small enough for it to jump so I didn't see
this bug. Sorry about that.
I tried this fix to boot in Unleashed board.

 #ifdef CONFIG_SMP
        li t0, CONFIG_NR_CPUS
-       bgeu a0, t0, .Lsecondary_park
+       blt a0, t0, .Lgood_cores
+       tail .Lsecondary_park
+.Lgood_cores:
 #endif
