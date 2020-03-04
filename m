Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE59C3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE31820842
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.washington.edu header.i=@cs.washington.edu header.b="YA+26ZyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387620AbgCDCd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 21:33:29 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45586 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387411AbgCDCd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 21:33:29 -0500
Received: by mail-io1-f65.google.com with SMTP id w9so646490iob.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 18:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z8i39F29uItXrQ0Vm+/tnYAlpVrh5Zrfz37MFCt4wqg=;
        b=YA+26ZyPPsXhtvsAfcQdDGKF76soF525p7XOyeC2g3fWKaRu7Nchx0JivsPHU9+mVx
         L2n+BpbDPm4VZ0rdcng/wCTI7pmzhvs1BTt5zoXCYUBmigd7w6CB7jsBLqS/tRZ3sBra
         ttxpQ4mYrMFxanwRq3ExFUcoGdLn+TstWEZGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z8i39F29uItXrQ0Vm+/tnYAlpVrh5Zrfz37MFCt4wqg=;
        b=QaCYrN67NQM6OB7Fx+c/aCv6LOYb43A7DRBMyrgL7SHrBfXm8ktsJazBx9rZTbiGyI
         khnOAKHXyt/UN3AS84kuuLVnVtNRPKNGNjSOjClrZfQKzaSzsTEYKvVua0U0G2/4xjT3
         SUWIVUNbSra+tG7VIl251+4trFiqq/7gcQbEz6xWcDp2PgU558EdnRockEoKdLQ1N8jU
         OzDEvKgv5GRozym6Wc/D/b+c3IMzVgH2M9A5L/0LC93RMdvO/ZjGBN4NXIe2OcPu7Hme
         M0gV4YUawjdYEtwTSgSb6DAXvOZhyTXZLVz7ENzP+bybr27HBcnu1C/W97mxiVs74Goa
         zETA==
X-Gm-Message-State: ANhLgQ2rI7Koq2H9fNYdt1SevLHwoClDFJjxZlpIwYhKRhTSNqL3FMz+
        lup9L9OfpKt3H82wFIt73+tXDxz9KRkKF66Ca6mn/w==
X-Google-Smtp-Source: ADFU+vtdbhJTXt1bRm93LupwhvNWTGVMBaqbP4QMYe4hxwp7dnVdENhAaLm/Y73xWVIRUbZJWq6Ns+B//0CejhYYfa0=
X-Received: by 2002:a6b:e310:: with SMTP id u16mr451066ioc.43.1583289208493;
 Tue, 03 Mar 2020 18:33:28 -0800 (PST)
MIME-Version: 1.0
References: <20200303005035.13814-1-luke.r.nels@gmail.com> <20200303005035.13814-5-luke.r.nels@gmail.com>
 <20200303100228.GJ1224808@smile.fi.intel.com>
In-Reply-To: <20200303100228.GJ1224808@smile.fi.intel.com>
From:   Luke Nelson <lukenels@cs.washington.edu>
Date:   Tue, 3 Mar 2020 18:33:17 -0800
Message-ID: <CADasFoCq7S2KRYg+ghAKt1e+hELzEMJaNH74sGdjM7E=z3KcnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/4] MAINTAINERS: Add entry for RV32G BPF JIT
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     bpf <bpf@vger.kernel.org>, Luke Nelson <luke.r.nels@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Xi Wang <xi.wang@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 2:02 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> > -BPF JIT for RISC-V (RV64G)
> > +BPF JIT for 32-bit RISC-V (RV32G)
> > +M:   Luke Nelson <luke.r.nels@gmail.com>
> > +M:   Xi Wang <xi.wang@gmail.com>
> > +L:   bpf@vger.kernel.org
> > +S:   Maintained
> > +F:   arch/riscv/net/
> > +X:   arch/riscv/net/bpf_jit_comp.c
> > +
> > +BPF JIT for 64-bit RISC-V (RV64G)
> >  M:   Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com>
> > -L:   netdev@vger.kernel.org
> > +L:   bpf@vger.kernel.org
> >  S:   Maintained
> >  F:   arch/riscv/net/
> > +X:   arch/riscv/net/bpf_jit_comp32.c
>
> Obviously this breaks an order. Please, fix.
> Hint: run parse-maintainers.pl after the change.

Hi,

Thanks for the comment!

I'll change the entry names in v5 to be "BPF JIT for RISC-V (32-bit)"
and "BPF JIT for RISC-V (64-bit)", similar to the x86 JIT entries.
This will pass parse-maintainers.pl and the entries are still in
order.

Thanks again,

Luke
