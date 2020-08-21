Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9B9C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAFF42076E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="nMOPtEpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHUXTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 19:19:32 -0400
Received: from crapouillou.net ([89.234.176.41]:35744 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgHUXTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 19:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1598051968; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0CsTuiMTiEu/xIUOx6Ma+PuIV6t5tONatR3HrhWSYoU=;
        b=nMOPtEpqnXusppBfIetJ3PFR8jN8ZSDgO7jM0PyRCv1yqbym/lKM4q9bY51WadT8fLmbRX
        r+j1u1bX0M6SHUGOeJ+uzSVt34LJbOQA6xstV+26q7VfTfQXf2Th+VDi6qhRZu52w5wJWB
        c6tYC1zrc/usdPyVnpMuS4PuiQb2aHU=
Date:   Sat, 22 Aug 2020 01:19:16 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 00/13] MIPS: Convert Ingenic to a generic board
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, od@zcrc.me,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        =?UTF-8?b?5ryG6bmP5oyv?= <aric.pzqi@ingenic.com>,
        dongsheng.qiu@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, xuwanhao@wanyeetech.com
Message-Id: <4SSFFQ.3I498N5I41LP3@crapouillou.net>
In-Reply-To: <alpine.LFD.2.21.2008211949220.3460685@eddie.linux-mips.org>
References: <20200803170124.231110-1-paul@crapouillou.net>
        <ab985296-8441-4006-210d-a71503bd01f0@wanyeetech.com>
        <L8DPEQ.71Z8YA0QXBJA@crapouillou.net>
        <alpine.LFD.2.21.2008211949220.3460685@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

Le ven. 21 ao=FBt 2020 =E0 20:23, Maciej W. Rozycki=20
<macro@linux-mips.org> a =E9crit :
> On Fri, 7 Aug 2020, Paul Cercueil wrote:
>=20
>>  > I'm not too sure if remove "cpu-feature-overrides.h" will cause=20
>> some
>>  > problems for X2000, because according to my current test on=20
>> X2000, I found
>>  > that it is somewhat different from the SoCs using XBurst1 CPU=20
>> core, with the
>>  > kernel source code provided by Ingenic, for example, we must=20
>> configure
>>  > "#define cpu_has_tlbinv 1" in "cpu-feature-overrides.h" to make=20
>> the X2000
>>  > work normally, otherwise the kernel will get stuck. And X2000's=20
>> interrupt
>>  > controller has also been redesigned. If these differences make it=20
>> impossible
>>  > to share code, should we set a subdirectory of "xburst" and=20
>> "xburst2" in
>>  > "arch/mips/ingenic"? (I am just worried about this situation, so=20
>> far I have
>>  > not been able to successfully run the mainline kernel on X2000).
>>=20
>>  The <cpu-feature-overrides.h> is kind of a hack, to hardcode=20
>> settings in case
>>  the CPU is not properly detected. The cpu-probe.c should be able to
>>  auto-detect these settings, including the inverted TLB that the=20
>> X2000 has,
>>  reading from the CPU config registers ("TLB INV" info should be in=20
>> config4).
>>  Right now cpu_probe_ingenic() doesn't read config4 (not present on=20
>> older SoCs)
>>  but that's trivial to add.
>=20
>  FAOD <cpu-feature-overrides.h> is not a hack, but an optimisation=20
> measure
> so that features known to be hardwired for a given machine/CPU do not=20
> have
> to be dynamically queried every time referred.  In some cases that=20
> results
> in large portions of code being optimised away by the compiler as=20
> well.

Fair enough. Bloat-o-meter reports about ~100 KiB saved when that file=20
is present. But we can't use it in a generic kernel, unfortunately.

>  The hardcoded value for a feature defined in=20
> <cpu-feature-overrides.h>
> always has to be the same as one in the corresponding bit of the=20
> `options'
> member of `struct cpuinfo_mips', in this case MIPS_CPU_TLBINV.

In theory yes, in practice the CPU detection code is lagging behind...

Cheers,
-Paul


