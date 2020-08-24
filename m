Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC178C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF23D20738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1H+z8gNo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fZa/eesR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgHXTfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:35:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44446 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXTf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:35:29 -0400
Date:   Mon, 24 Aug 2020 21:35:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598297727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s1UXCq2sCaXk8D9Ftb5SFZUbL2VtwY3Bdh1ohHy/nq0=;
        b=1H+z8gNouO152NAeUgGE/+lFf0x5m7yXvhjIBQKe7rY/L+0Ma/xmY+HEoyu15U/Nyv6FWP
        b3u6Vxct3tkicdHE/OEdruk91HjETkCvJ77h3JBEKELtqtLdwv+6G2/WKQx7uncf7+Gb6e
        eR5uCtWGGTV/F1QyrKS+aT/OX2ZSQz2Z471TqdXM4L+V8j3Kh3Wn6Fh2yhDByOpZl6uRpM
        /7aoeAAJGVwCqOoSKH8cIgWHMLGqf8Ip6ITxIT17v2dYxfuCTHIncUXwzcNXg1Yz8xp43/
        wgr7mqO+9lKYyefs7jLmTmmm19gqO902VG1wJyVab7ujw/3emzTNvicnIj4iAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598297727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s1UXCq2sCaXk8D9Ftb5SFZUbL2VtwY3Bdh1ohHy/nq0=;
        b=fZa/eesRoqGb6lVXqdy4Hl63qcEQvwOr3IKcp1Cl/dW6Y9lnPDr9FVk7yAfiFU6clSAJG6
        aYGQIu+YQB4LKXCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     kernel test robot <lkp@intel.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ofer Levi <oferle@mellanox.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: {standard input}:5973: Error: operand out of range (512 is not
 between -512 and 511)
Message-ID: <20200824193525.utkbrhgvwpi2i37m@linutronix.de>
References: <202008241018.RkyIlLKd%lkp@intel.com>
 <20200824095831.5lpkmkafelnvlpi2@linutronix.de>
 <28384fea-4a07-c57d-04b0-f44f1c70adc2@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28384fea-4a07-c57d-04b0-f44f1c70adc2@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-24 18:21:21 [+0000], Vineet Gupta wrote:
> >>>> {standard input}:5973: Error: operand out of range (512 is not between -512 and 511)
> >>
> 
> The error above was fixed back in April:
> 799587d5731db9dc ("ARC: [plat-eznps]: Restrict to CONFIG_ISA_ARCOMPACT")

This commit is
|git describe --contains 799587d5731db9dc
|v5.7-rc7~32^2~2

and CI said:
|head:   d012a7190fc1fd72ed48911e77ca97ba4521bccd
^^ v5.9-rc2
|commit: de8f5e4f2dc1f032b46afda0a78cab5456974f89 lockdep: Introduce wait-type checks
^^ v5.7-rc1

so my assumption was that it tested rc2 and bisected it down to that
commit. Otherwise I don't see the point in testing such an old commit on
a recent -rc2 and complaining about things not related to one another.

> > I have here gcc 10 and the output is:
> 
> I suppose this is mainline gcc 10 ? Although it doesn't seem like compiler version
> related.

Sorry for that. It is
|$ ~/cross-gcc/gcc-10.1.0-nolibc/arc-linux/bin/arc-linux-gcc -v
|Using built-in specs.
|COLLECT_GCC=/home/bigeasy/cross-gcc/gcc-10.1.0-nolibc/arc-linux/bin/arc-linux-gcc
|COLLECT_LTO_WRAPPER=/home/bigeasy/cross-gcc/gcc-10.1.0-nolibc/arc-linux/bin/../libexec/gcc/arc-linux/10.1.0/lto-wrapper
|Target: arc-linux
|Configured with: /home/arnd/git/gcc/configure --target=arc-linux --enable-targets=all --prefix=/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/arc-linux --enable-languages=c --without-headers --disable-bootstrap --disable-nls --disable-threads --disable-shared --disable-libmudflap --disable-libssp --disable-libgomp --disable-decimal-float --disable-libquadmath --disable-libatomic --disable-libcc1 --disable-libmpx --enable-checking=release
|Thread model: single
|Supported LTO compression algorithms: zlib
|gcc version 10.1.0 (GCC) 

This is the one built by Arnd and hosted at
	https://www.kernel.org/pub/tools/crosstool/

Is it suitable for testing?

> > and the assembler does not like that.
> > After the removal CONFIG_ARC_PLAT_EZNPS I got to stage 2:
> > |drivers/irqchip/irq-eznps.c:80:16: error: 'CTOP_AUX_IACK' undeclared (first use in this function)
> > |   80 |  write_aux_reg(CTOP_AUX_IACK, 1 << irq);
> > 
> 
> Indeed this is a problem I can reproduce. Enabling CONFIG_EZNPS_GIC on a non
> ARC700 build causes the issue: the ctop header is inside platform code
> (arch/arc/plat-eznps/include/plat/ctop.h) which obviously fails if not building
> for ARC.
> 
> My solution is to move ctop.h to include/soc/nps/plat/.

You know probably best :)

> > so I removed CONFIG_EZNPS_GIC. And then I ended with:
> > |  LD      vmlinux.o
> > |arc-linux-ld: gcc-10.1.0-nolibc/arc-linux/bin/../lib/gcc/arc-linux/10.1.0/arc700/libgcc.a(_muldi3.o): compiled for a little endian system and target is big endian
> > |arc-linux-ld: failed to merge target specific data of file gcc-10.1.0-nolibc/arc-linux/bin/../lib/gcc/arc-linux/10.1.0/arc700/libgcc.a(_muldi3.o)
> 
> This is unrelated since original .config with CONFIG_ARC_PLAT_EZNPS would have
> selected Big endina build, but you need a BE toolchain to get that working (since
> libgcc emulation code still comes from toolchain).

Is a switch missing while building the gcc, another gcc target needed or
is this something that is not part of upstream gcc?
 
> > 
> > Please update CI and ARC.
> 
> Nothing to update in CI. I'll send the ARC patch as a follow up.

but it shouldn't complain about a commit merged in v5.7-rc1 because it
caused an error which was then fixed in v5.7-rc7 while using HEAD
v5.9-rc2?

> Thx for reporting.

You are welcome.

> -Vineet

Sebastian
