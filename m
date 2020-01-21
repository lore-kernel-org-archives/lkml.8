Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791B0C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A8E20882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="k5YqhzWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgAUJv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:51:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40177 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgAUJv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:51:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so2238094wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 01:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gS+im0irDRkIpBOIxh0kBgop9pZ/8UFs7AEVh7IT1XM=;
        b=k5YqhzWsmtaevRKLBveGSXHbJ+jS0UE3AFL+ggoEmJDPmMezqWJu4cYFv87tGVqj1+
         dA+glBi8pVmrnGoBNcRJjao98GtsyfevEnG4moYXuiFut5o3a+Th2CTdKJYxEo/g28xR
         7lna9Hc4cOwnz9Ia8i7waKKBLTmZMbizpEEbu7DajHLURDWm/usKN3i+5Ot+2ukBGxVk
         L38OMFDC2sBrKu9d16AXkmAf/6dxx9Y1jKGVvSDqkUV7+BGKnRvpGc4UkWzokq3jU4HQ
         oG4HArkTB/Rg6zeZo5S71GD2HAph9pGjJZSUdwga24jTgxv7ZCFNtEjjbRn1kQmWyCpe
         Mw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gS+im0irDRkIpBOIxh0kBgop9pZ/8UFs7AEVh7IT1XM=;
        b=Cl3QtT8UzUxOw4PqwTsz+kY0mVzk8ZgT9WYRrjG6i43JDbMQChA4SsIiyK1hyHqRT4
         0LYKowWzxnXv3HP8OXr6xpiL5KRNj6jDlJVLjpXJF5hCZfRbuFaFAMH1ln6Ij9yICo0/
         l986IzbLgJRlzzlfmhjc1Cij5E8L2axGCEepVt416geCHoPBvL5LUPa94ofknkRebE1K
         2ZTOQq/haXbRt+bxwCARlPR17+4SOuwVOYB9B8vbFF95/3A3p0wuRoaYBFizwbEARrH/
         30YQ6uU1t9fJNAqM2vRXQL1ERVdTWqjjP36oNtsMGT89myOIDB9vu1/M1fMvlMY1fG9p
         fLvw==
X-Gm-Message-State: APjAAAXfR+mjKMz5Y93was/64BwGAskTy8/UJMCcsgislEbv6VBzuS5X
        FBpp+nK1fedGJBofoQXLZ8ZLjYs2QEPpTJeacAbumEkN9zU=
X-Google-Smtp-Source: APXvYqySBjrfH9msv3yjAVX+psBOoVmoNSdn5FqtxTiOBRmWLSLdQtHhiPdrzBOO1B3Jh6WxpM6urcMjW7D6vYtdHgA=
X-Received: by 2002:a1c:6406:: with SMTP id y6mr3604057wmb.144.1579600316779;
 Tue, 21 Jan 2020 01:51:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578577931.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1578577931.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Tue, 21 Jan 2020 10:51:45 +0100
Message-ID: <CAHTX3dL-rO9h=+5A2QS7r1aWi+bOdkEmZQHXAmGB=TnSJrVdeg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] arm64: zynqmp: Various DT fixes
To:     linux-arm <linux-arm-kernel@lists.infradead.org>,
        git <git@xilinx.com>
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C4=8Dt 9. 1. 2020 v 14:52 odes=C3=ADlatel Michal Simek <michal.simek@xilin=
x.com> napsal:
>
> Hi,
>
> I am sending various DT fixes which have been found over the xilinx
> release.
> 1-2 patches are fixing reported description issues
> 3-8 patches are actual fixes.
>
> Thanks,
> Michal
>
> Changes in v2:
> - Add missing patch
> - Add missing patch
>
> Michal Simek (7):
>   arm64: zynqmp: Use ethernet-phy as node name for ethernet phys
>   arm64: zynqmp: Remove addition number in node name
>   arm64: zynqmp: Fix address for tca6416_u97 chip on zcu104
>   arm64: zynqmp: Turn comment to gpio-line-names
>   arm64: zynqmp: Setup clock-output-names for si570 chips
>   arm64: zynqmp: Remove broken-cd from zcu100-revC
>   arm64: zynqmp: Setup default number of chipselects for zcu100
>
> Venkatesh Yadav Abbarapu (1):
>   arm64: zynqmp: Fix the si570 clock frequency on zcu111
>
>  .../dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |  2 +-
>  .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |  6 +--
>  .../dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |  2 +-
>  .../dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    |  2 +-
>  .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    |  3 +-
>  .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 47 +++++--------------
>  .../boot/dts/xilinx/zynqmp-zcu102-revB.dts    |  4 +-
>  .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    |  6 +--
>  .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    |  4 +-
>  .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    |  6 ++-
>  10 files changed, 32 insertions(+), 50 deletions(-)
>
> --
> 2.24.0
>

Applied all.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
