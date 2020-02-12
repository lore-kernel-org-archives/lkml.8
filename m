Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95E9C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02DD20714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3Io6NjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgBLMUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:20:31 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41761 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgBLMUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:20:31 -0500
Received: by mail-qk1-f195.google.com with SMTP id d11so1783564qko.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 04:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ktAYg1cBzxLknL7OVJd4+pqAQ0FvDJqHPGKojt5tkNY=;
        b=L3Io6NjIrV6NQO0Q1xuuhaqAlL2d1lMZiPjedIJg+2SyhAdfUx3dZ28LsUa9cloK8D
         QZuOn3/bvfDku6+XuwTcahOUzG4v/o6xUFgrtXerBplm7iyAT5Vi2Jsz9Mj4LruUVsJk
         2+0p2mHk6R4UI4S5i7A62yL+uyL1+zTFLn4L8XxhdUo5Gtl6Uhg341OKVLfWiFk7jf0c
         2MnYaVa1JmIPRs4qojIOtwTInd8JloXDDbFr1I9u/lk0MMlS/QWe6bKdMw0qKIr1/b9C
         pSmYRynOA+UArR0jkcVqyoeOY/WRFoxhBOXTIY9eKP0qFZm5DDBnrtdOGdHImTJukZYp
         htVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ktAYg1cBzxLknL7OVJd4+pqAQ0FvDJqHPGKojt5tkNY=;
        b=bIhbdbX9rh3dQ9Aq9TZzgqTVXcF0/Hcee7Wkji4mb2GNwTYyZ7QtgW7HrQ0ORgnfrs
         fBvgmr7CC5SxHZBc9wTHg9+x0yoc2viJt2nbzwZn6zoQ/7KeTKTRK7l9oCbd/M6yTdwh
         40lH/tuwRcKfiJZoDr4CIi87mFhVn5lhzlQ8I8Zv19WXBZiQQYrUMQtMe6w6aEZahkuc
         dwR2R7IcGq4CGHMjDxybEQ81mZ1G0L9H/b9CpVhXT1TP5nS4V8mUAKehwxtoHZjjP0Jy
         TtWvP7fYLY8CFmnVzvaoVLp5jiVzkTQKw8Fuq4BgzaUNywg/thtHiBEZNChZiVExQ0Zs
         ZuBg==
X-Gm-Message-State: APjAAAWckkdYVohku6RV2abAvhYPZQTuNXOHxzse/Y6bj1o25O1yUib7
        FYKSQzIdcOveFAKfwPNlXR4YCjJHLZpKe1+Oi0TDRim4
X-Google-Smtp-Source: APXvYqwASG+q0bWOqqNa6UUKFkgpPuwB9vF/8qr6lH3GpnDNnJjv7AvDOj1hpNkjrIS4lYTHXsKiICbu7SRPri5O49k=
X-Received: by 2002:a37:8505:: with SMTP id h5mr10419574qkd.281.1581510028867;
 Wed, 12 Feb 2020 04:20:28 -0800 (PST)
MIME-Version: 1.0
References: <20191028121043.22934-1-hch@lst.de> <alpine.DEB.2.21.9999.1910301311240.6452@viisi.sifive.com>
 <20191031155222.GA7270@lst.de> <alpine.DEB.2.21.9999.1911221817010.14532@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1911221817010.14532@viisi.sifive.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 12 Feb 2020 20:19:51 +0800
Message-ID: <CAEbi=3eAFDD1Su_SKBfPXp0g_+U=EvkbRm7=ULVBb7xaaiZLTQ@mail.gmail.com>
Subject: Re: RISC-V nommu support v6
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Walmsley <paul.walmsley@sifive.com> =E6=96=BC 2019=E5=B9=B411=E6=9C=88=
23=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8810:24=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Thu, 31 Oct 2019, Christoph Hellwig wrote:
>
> > On Wed, Oct 30, 2019 at 01:21:21PM -0700, Paul Walmsley wrote:
> > > I tried building this series from your git branch mentioned above, an=
d
> > > booted it with a buildroot userspace built from your custom buildroot
> > > tree.  Am seeing some segmentation faults from userspace (below).
> > >
> > > Am still planning to merge your patches.
> > >
> > > But I'm wondering whether you are seeing these segmentation faults al=
so?
> > > Or is it something that might be specific to my test setup?
> >
> > I just built a fresh image using make -j4 with that report and it works
> > perfectly fine with my tree.
>
> Another colleague just gave this a quick test, following your instruction=
s
> as I did.  He encountered the same segmentation faulting issue.  Might be
> worth taking a look at this once v5.5-rc1 is released.  Could be a
> userspace issue, though.
>

Hi all,

I have the same symptom too.

    [    0.389983] Run /init as init process
    [    0.457294] mount[24]: unhandled signal 11 code 0x2 at 0x00000000834=
000e8
    [    0.458057] CPU: 0 PID: 24 Comm: mount Not tainted
5.4.0-rc5-00021-g1a87b1010118 #44
    [    0.458477] epc: 00000000834000e8 ra : 000000008341c140 sp :
000000008348add0
    [    0.458803]  gp : 0000000083471300 tp : 0000000000000000 t0 :
0000000000000032
    [    0.459319]  t1 : 8101010101010100 t2 : 0000000000000007 s0 :
0000000000000001
    [    0.459678]  s1 : 0000000000000001 a0 : 0000000000000000 a1 :
000000008348afb8
    [    0.460027]  a2 : 000000008348afa6 a3 : 0000000000008000 a4 :
0000000000000000
    [    0.460370]  a5 : 0000000000084000 a6 : 70f8fefcf8fef0fc a7 :
0000000000000028
    [    0.460829]  s2 : 0000000083483fd0 s3 : fffffffffffffff8 s4 :
0000000083425dcc
    [    0.461200]  s5 : 0000000000000001 s6 : 0000000000000001 s7 :
0000000000000001
    [    0.461592]  s8 : 0000000000000000 s9 : 00000000838ccbd0 s10:
0000000000000000
    [    0.461912]  s11: 0000000000000000 t3 : 000000000000003d t4 :
000000000000002b
    [    0.462283]  t5 : 0000000000000002 t6 : 0000000000000001
    [    0.462562] status: 0000000000004080 badaddr: 0000000000084010
cause: 0000000000000005
    SEGV

    This failure is because of it tries access the absolute address. This
    address is generated by gcc. It tries to access __bss_start in a non-PI=
C
    way. The code sequence will be looked like this.
    00000000000000a4 <__do_global_dtors_aux>:
          a4:       000847b7                lui     a5,0x84
          a8:       0107c703                lbu     a4,16(a5) # 84010
<__bss_start>

    However this is a user program and it will be loaded to any
address of RAM by kernel loader
    so that it could not use the absolute address.

    In this case, we have to enable PIC when compiling these codes and it i=
s in
    gcc so we have to set the correct configuration options for gcc in
buildroot.

-BR2_EXTRA_GCC_CONFIG_OPTIONS=3D""
+BR2_EXTRA_GCC_CONFIG_OPTIONS=3D"CFLAGS_FOR_TARGET=3D'-O2 -fPIC'
CXXFLAGS_FOR_TARGET=3D'-O2 -fPIC'"

    After applying this fix, the code will be looked like this.
    00000000000000a0 <__do_global_dtors_aux>:
          a0:       00085797                auipc   a5,0x85
          a4:       bf07c783                lbu     a5,-1040(a5) #
84c90 <__bss_start>

It could boot to shell without any segmentation fault.

Hi Christoph,
Would you like to upstream the buildroot porting for nommu support?
Then I can upstream this fix. :)
