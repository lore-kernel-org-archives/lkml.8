Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E504C32771
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 01:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6066246AF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 01:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579397082;
	bh=bwr+hP379jYs+rWDpkPKIaoVn0NC6L0EedWAKy4DKCk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OSpd+9hlZHnXfcRsTLR1Anso6YTFRpJApwVGZSu+qvSsTkW/OmTQHe2M7dHX4PY87
	 TD1A7c+QZjHMduRcpisrqXwml8cbOrzKKfuXOWz7Zkw5OvLvgM2r+SmC5/envW72ku
	 5Z5tQSZ0+sA17JuHHNV8x91RwUpG2jeD1DbxHjZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgASBYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 20:24:41 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:54263 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgASBYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 20:24:41 -0500
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 00J1Ocw0003417
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 10:24:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 00J1Ocw0003417
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579397079;
        bh=Jqo96td/ObWYQIbBXemOoirCWsxHweKiuuiVKjHEhbs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ktBKhBGY7/AO421S1PPiqoqApEJgEhGfpDay+7kocfKoh+XYauiR2oNthuKEqY/yE
         nPFGdqnlkx/eEr5nFBuqMcuXZet/hlwtcPI0MtMWTnMdSWzW5dupMfHZ3ZMUKOPCep
         FlqSTdTtgWPPiSS+7wmVSS50Il9dHByzl9cFJmRXA8yiLBf3wJUI4zEI4TfxOgYmtp
         RqIHpZys/h+EwTURU6AWh6gDBSck1lczcJWVphkPihK1lf/VgzcoR2kP5kPyLxO3MN
         kNfCqQvVNEHFy+M+P51b8H6P89Qm85MzYVwNCVFf6V88PdmW6CCQECX/xv1UOryNNi
         doC/w1Nme93hA==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id 73so10315476uac.6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 17:24:38 -0800 (PST)
X-Gm-Message-State: APjAAAW6gUnPmnvWOh3a8z3Md7fl9k4mJB1nvC1BbthzX/8cunVDpcVC
        Q16xmI3Tc10Me5JmmQd4LvoFF8vZta4uhEp7EmE=
X-Google-Smtp-Source: APXvYqyXaHIRtN2qaDHZBVtF6xp/fQ55KREgbCsXUHTfL4JL2dpAskq6hijX/0Y7xBawJuy3ggiPQhoJLZ3umHondYw=
X-Received: by 2002:ab0:14ea:: with SMTP id f39mr25531225uae.40.1579397077609;
 Sat, 18 Jan 2020 17:24:37 -0800 (PST)
MIME-Version: 1.0
References: <20191204044950.10418-1-masahiroy@kernel.org> <20200117221534.GR25745@shell.armlinux.org.uk>
In-Reply-To: <20200117221534.GR25745@shell.armlinux.org.uk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 19 Jan 2020 10:24:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR2zdOLyoJRJpYVt0C+TqQ172z32OJMQi5tHKP6=0G=WA@mail.gmail.com>
Message-ID: <CAK7LNAR2zdOLyoJRJpYVt0C+TqQ172z32OJMQi5tHKP6=0G=WA@mail.gmail.com>
Subject: Re: [PATCH] ARM: decompressor: simplify libfdt builds
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Sat, Jan 18, 2020 at 7:15 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> > -ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
> > -OBJS += $(libfdt_objs) atags_to_fdt.o
> > +# -fstack-protector-strong triggers protection checks in this code,
> > +# but it is being used too early to link to meaningful stack_chk logic.
> > +nossp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
> > +$(foreach o, $(libfdt_objs), \
> > +     $(eval CFLAGS_$(o) := -I $(srctree)/scripts/dtc/libfdt) $(nossp-flags-y))
>
> The above change causes build breakage over a number of ARM builds,
> which unfortunately doesn't result in emails from any build system
> containing the cause of the failure.
>
> See
> https://kernelci.org/build/rmk/branch/for-next/kernel/v5.5-rc1-12-g9a6545e2fc83/
>
> where the failures are reported as:
>
> ../arch/arm/boot/compressed/Makefile:87: *** missing separator. Stop.
>
> Thanks.  Patch dropped.


Sorry, I made a mistake about the location of
the closing parenthesis.


I fixed the build error, and posted v2:

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8953/1





-- 
Best Regards
Masahiro Yamada
