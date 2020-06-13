Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3EAC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 13:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC7B207DD
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 13:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgFMNcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 09:32:00 -0400
Received: from hera.iit.uni-miskolc.hu ([193.6.5.4]:50760 "EHLO
        hera.iit.uni-miskolc.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgFMNbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 09:31:50 -0400
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Jun 2020 09:31:49 EDT
Received: from localhost (localhost [127.0.0.1])
        by hera.iit.uni-miskolc.hu (Postfix) with ESMTP id 8623DE2C;
        Sat, 13 Jun 2020 15:23:45 +0200 (CEST)
X-Virus-Scanned: Kamavis at iit.uni-miskolc.hu
Received: from hera.iit.uni-miskolc.hu ([127.0.0.1])
        by localhost (hera.iit.uni-miskolc.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 85NOM64VODJ9; Sat, 13 Jun 2020 15:23:32 +0200 (CEST)
Received: from titan.hitronhub.home (unknown [IPv6:2a02:8109:a180:2114:226:9eff:fe30:2af8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: szucst@iit.uni-miskolc.hu)
        by hera.iit.uni-miskolc.hu (Postfix) with ESMTPSA id 7A0D0E2D;
        Sat, 13 Jun 2020 15:23:29 +0200 (CEST)
From:   =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        JC Kuo <jckuo@nvidia.com>, Sameer Pujar <spujar@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>
Subject: [PATCH 0/4] arm64: tegra: Xavier SDMMC changes
Date:   Sat, 13 Jun 2020 15:22:08 +0200
Message-Id: <20200613132212.8538-1-tszucs@protonmail.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I've encountered some issues with the Xavier while integrating some of our SDIO
modules. It turns out card detection was not working for the uSD socket and
I/Os were limited to 3.3 V. Also, the on-board eMMC module was using HS200 only.
I think it would make sense for the changes to go upstream. Please have a look.

Kind regards,
Tamas

Tamás Szűcs (4):
  arm64: tegra: Enable signal voltage switching on Tegra194 SDMMC1 and
    SDMMC3
  arm64: tegra: Fix CD on Jetson Xavier SDMMC1
  arm64: tegra: Configure SDIO cards on Jetson Xavier SDMMC1
  arm64: tegra: Enable HS400 on Tegra194 SDMMC4

 .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi |  4 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      | 46 +++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.20.1

