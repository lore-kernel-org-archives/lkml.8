Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0CFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E966020724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="Ttm+//iX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgHUOEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgHUOD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:03:57 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35328C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 07:03:57 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout3.routing.net (Postfix) with ESMTP id 1F3BB600E3;
        Fri, 21 Aug 2020 14:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1598018629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3uwhXQPwN7FPz65pMgdPSDnQeJydLmXsPIKMifEpXlY=;
        b=Ttm+//iX1eUjhmNpOhcZr0EJVANL4/aMV+hFs1aBFQHSZpxDImZst5eKj0kjJpGR1uqk3D
        bwvXJXQfHPOCXdAp4pBImBqdKOc5gDAH5rBYb26oi2pv0gyw6kq8ayn7NXtCifx3r7DcNb
        hCaFTQJTuDFXkgNB/5e7oyVERpc0jy0=
Received: from frank-s9 (fttx-pool-185.76.97.101.bambit.de [185.76.97.101])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 53963402D3;
        Fri, 21 Aug 2020 14:03:48 +0000 (UTC)
Date:   Fri, 21 Aug 2020 16:03:42 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <93debe6a0308b66d3f307af67ba7ec2c@kernel.org>
References: <20200819161907.1155110-1-enric.balletbo@collabora.com> <C9E59107-CE83-4554-9447-5DE5BEE09A3B@fw-web.de> <CAGETcx9_A-E5b-JxT2G142mGxqoo8xqFNEgT+CNWt=oOv0Z5+w@mail.gmail.com> <a23bac35d20eb002bdfb5263bf5dd213@kernel.org> <CAGETcx-NpRzzeXYN-UBP1eAsC3s_AofSQ9rXOEmCjhLhKLnxWg@mail.gmail.com> <14b8f4b9667d29ee25e25eb19c69e3f7@kernel.org> <95ae0ae3-7798-d6d5-fc37-391862a0b4ca@collabora.com> <93debe6a0308b66d3f307af67ba7ec2c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Revert "irqchip/mtk-sysirq: Convert to a platform driver"
To:     Marc Zyngier <maz@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
CC:     Saravana Kannan <saravanak@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
From:   Frank Wunderlich <linux@fw-web.de>
Message-ID: <C4270F76-C385-4D5B-96BF-F3B9DEB555E3@fw-web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21=2E August 2020 12:17:36 MESZ schrieb Marc Zyngier <maz@kernel=2Eorg>:

>It'd be good if you could help with that, but I will definitely apply
>the revert (below for the revert list)=2E Any change is too invasive to
>be added to this cycle=2E
>
>920ecb8c35cb irqchip/mtk-cirq: Convert to a platform driver
>f97dbf48ca43 irqchip/mtk-sysirq: Convert to a platform driver
>5be57099d445 irqchip/qcom-pdc: Switch to using IRQCHIP_PLATFORM_DRIVER=20
>helper macros

with Patch "irqchip: Fix probing deferal when using IRQCHIP_PLATFORM_DRIVE=
R helper" i can boot my board, but i get these errors:

[ 0=2E014234] irq: no irq domain found for interrupt-controller@10200100 !
[ 0=2E020981] Failed to map interrupt for /timer@10008000
[ 0=2E026248] Failed to initialize '/timer@10008000': -22
[ 4=2E314126] hw perfevents: /pmu: failed to register PMU devices!

if i revert f97dbf48ca43009e8b8bcdf07f47fc9f06149b36 these are gone

So from my pov revert is best way at the moment

regards Frank
