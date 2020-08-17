Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F6DC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5451120748
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxOQzsE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgHQO4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbgHQO4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:56:22 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56B5C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:56:21 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id g1so3454119oop.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LEq4BmbM6NwhbOqFE2FhCpoi1VYEMSkPRFzPRH5IW3c=;
        b=GxOQzsE9dyQ0IXoSsbmKr2359q3ZzDs0IxkZWDpwb4+2iXAZxvFUsZfUHoMC06NeTC
         6v0XrZMi30iGDfmm83vM6I0vq+6XuIMG89r+0PXkGirpA1VYpvOr294kP+dwfGKY3WkI
         BCQW8KVjDUG41CXcjn7rp6EBizvMI4vF1ETFJ3jKt41LexinclP1eL32cvugpXDXpgi7
         U8Ns8QK8UL8S6vPW0PyCctvrALDaSv9UmPzDGdfoMi5p3fdQqP4/+MaQINnIAyIFB9iI
         6bpkMXdG2blDsTIB0t4ohbm8Xns3eO87NJLorAJIYIa/GVapbapM/bJfH74uggwqjBme
         rlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LEq4BmbM6NwhbOqFE2FhCpoi1VYEMSkPRFzPRH5IW3c=;
        b=KBPOspR7egySTzhK5ZD6dT3b+/9nhODATTHQGnC5MCZ0iImWgRS9qgm+BS877ve8zG
         9S4017oizmuyouvDH8MRsZvq0KUUXaPnvePr3+yFu1RzJwXmTStHQ8x4JEM2KjMnYUi+
         FqSAkAp0feKxuRGllaiw8WD+VOO0P7tn6Kck2pFiylk3l/Okb2pXnp26kmIEIKA+j14K
         psZtOrS5KsKNzICI1taxkj3jUUZ3EnO/pOwq+loSNi09dxG7LFLUqeKivs/VxCyu2cv1
         uxkmxPx/DrA7uTbZ7Xa3a2YnzqdHYpnqc4Qbqsg/wy+xslXeNJ717k+YBp9c6f9fbWVX
         01Bw==
X-Gm-Message-State: AOAM530iA6fksFg80BiPlt24qRkB+0qL0Xb0CtoJIsJOtfdc4gkgR+E/
        h7QvC3cq8TaVVNlZtxglXhYDMxgIe8aaMBevRraY3Gf3EGs=
X-Google-Smtp-Source: ABdhPJwd03kpRCw1Zwh51o7SjseXp7aqp5Pc25IzoSjgjnnMBF52f+6xOCwpjK6xqadlMK7REEVUaIhRjDmpvnN0KQ4=
X-Received: by 2002:a4a:e618:: with SMTP id f24mr11184531oot.75.1597676180613;
 Mon, 17 Aug 2020 07:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-e15639c2-d077-4b70-b351-a5888543688c-1597675629284@3c-app-gmx-bs07>
In-Reply-To: <trinity-e15639c2-d077-4b70-b351-a5888543688c-1597675629284@3c-app-gmx-bs07>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 17 Aug 2020 16:56:08 +0200
Message-ID: <CAFqH_510ykRd=79hUKbK5k8fqWzt=wri6=-Mv1zvV8inquPmPg@mail.gmail.com>
Subject: Re: [BUG] 5.9-rc1 broken bootup on mt7622/mt7623
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Missatge de Frank Wunderlich <frank-w@public-files.de> del dia dl., 17
d=E2=80=99ag. 2020 a les 16:48:
>
> Hi
>
> at least my Bananapi R2/R64 does not bootup (no output on serial console)=
 with 5.9-rc1
>
> made a bisect which points me to this commit:
>
> commit f97dbf48ca43009e8b8bcdf07f47fc9f06149b36
> Author: Saravana Kannan <saravanak@google.com>
> Date:   Fri Jul 17 17:06:36 2020 -0700
>
>     irqchip/mtk-sysirq: Convert to a platform driver
>
>     This driver can work as a platform driver. So covert it to a platform
>     driver.
>
>     Signed-off-by: Saravana Kannan <saravanak@google.com>
>     Signed-off-by: Marc Zyngier <maz@kernel.org>
>     Reviewed-by: Hanks Chen <hanks.chen@mediatek.com>
>     Link: https://lore.kernel.org/r/20200718000637.3632841-4-saravanak@go=
ogle.com
>

Looks like all Mediatek devices are broken, you should try if this [1]
fixes the issue for you. It fixes for me.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/c=
ommit/?h=3Dirq/irqchip-next&id=3D7828a3ef8646fb2e69ed45616c8453a037ca7867

Cheers,
 Enric

>  drivers/irqchip/irq-mtk-sysirq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> at least on my devices i got 5.9 working by reverting the commit, will se=
nd a revert-Patch
>
> $ git bisect log
> git bisect start
> # bad: [d24b5abc4640b46bb356bb5371d244866a5fe0a3] gitignore: add from 5.8=
 + itb/mod
> git bisect bad d24b5abc4640b46bb356bb5371d244866a5fe0a3
> # good: [bcf876870b95592b52519ed4aafcf9d95999bc9c] Linux 5.8
> git bisect good bcf876870b95592b52519ed4aafcf9d95999bc9c
> # bad: [8186749621ed6b8fc42644c399e8c755a2b6f630] Merge tag 'drm-next-202=
0-08-06' of git://anongit.freedesktop.org/drm/drm
> git bisect bad 8186749621ed6b8fc42644c399e8c755a2b6f630
> # bad: [2324d50d051ec0f14a548e78554fb02513d6dcef] Merge tag 'docs-5.9' of=
 git://git.lwn.net/linux
> git bisect bad 2324d50d051ec0f14a548e78554fb02513d6dcef
> # good: [92c59e126b21fd212195358a0d296e787e444087] Merge tag 'arm-defconf=
ig-5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect good 92c59e126b21fd212195358a0d296e787e444087
> # good: [d4db4e553249eda9016fab2e363c26e52c47926f] Merge tag 'arm-newsoc-=
5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect good d4db4e553249eda9016fab2e363c26e52c47926f
> # good: [fd76a74d940ae3d6b8b2395cd12914630c7e1739] Merge tag 'audit-pr-20=
200803' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit
> git bisect good fd76a74d940ae3d6b8b2395cd12914630c7e1739
> # bad: [95ffa676583b23baed40861d30b65fe31397da00] Merge branch 'parisc-5.=
9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
> git bisect bad 95ffa676583b23baed40861d30b65fe31397da00
> # bad: [f8b036a7fc231fe6e8297daddee5dffdbbf2581f] Merge tag 'irq-core-202=
0-08-04' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad f8b036a7fc231fe6e8297daddee5dffdbbf2581f
> # good: [4f30a60aa78410496e5ffe632a371c00f0d83a8d] Merge tag 'close-range=
-v5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux
> git bisect good 4f30a60aa78410496e5ffe632a371c00f0d83a8d
> # good: [8d16f5b979660c0fdcfa21a418cc03f1fde60cf7] genirq: Export irq_chi=
p_retrigger_hierarchy and irq_chip_set_vcpu_affinity_parent
> git bisect good 8d16f5b979660c0fdcfa21a418cc03f1fde60cf7
> # bad: [c9c73a05413ea4a465cae1cb3593b01b190a233f] irqchip/loongson-lioint=
c: Fix misuse of gc->mask_cache
> git bisect bad c9c73a05413ea4a465cae1cb3593b01b190a233f
> # bad: [f97dbf48ca43009e8b8bcdf07f47fc9f06149b36] irqchip/mtk-sysirq: Con=
vert to a platform driver
> git bisect bad f97dbf48ca43009e8b8bcdf07f47fc9f06149b36
> # bad: [f97dbf48ca43009e8b8bcdf07f47fc9f06149b36] irqchip/mtk-sysirq: Con=
vert to a platform driver
> git bisect bad f97dbf48ca43009e8b8bcdf07f47fc9f06149b36 //needs change fr=
om 762a21fd45e0 as build-fix
> # good: [3af9571cd585efafc2facbd8dbd407317ff898cf] irqchip/gic-v4.1: Ensu=
re accessing the correct RD when writing INVALLR
> git bisect good 3af9571cd585efafc2facbd8dbd407317ff898cf
> # good: [f8410e626569324cfe831aaecc0504cafc12b471] irqchip: Add IRQCHIP_P=
LATFORM_DRIVER_BEGIN/END and IRQCHIP_MATCH helper macros
> git bisect good f8410e626569324cfe831aaecc0504cafc12b471
> # good: [5be57099d44550d2c4cf44a86c44df87edb79a57] irqchip/qcom-pdc: Swit=
ch to using IRQCHIP_PLATFORM_DRIVER helper macros
> git bisect good 5be57099d44550d2c4cf44a86c44df87edb79a57
> # first bad commit: [f97dbf48ca43009e8b8bcdf07f47fc9f06149b36] irqchip/mt=
k-sysirq: Convert to a platform driver
>
> regards Frank
>
