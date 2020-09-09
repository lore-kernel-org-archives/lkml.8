Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4542C10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A412087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Q5nGQsgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgIIIOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:14:23 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12006 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730079AbgIIIK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:10:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f588e020000>; Wed, 09 Sep 2020 01:10:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 01:10:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 09 Sep 2020 01:10:55 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 08:10:54 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 9 Sep 2020 08:10:54 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.100.126]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f588e0c0001>; Wed, 09 Sep 2020 01:10:53 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v3 04/15] phy: tegra: xusb: tegra210: Do not reset UPHY PLL
Date:   Wed, 9 Sep 2020 16:10:30 +0800
Message-ID: <20200909081041.3190157-5-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909081041.3190157-1-jckuo@nvidia.com>
References: <20200909081041.3190157-1-jckuo@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599639042; bh=WaPfusjwRvQ4H9NcenSUy4hF1eq88SicA4fEhsVWqjw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=Q5nGQsgh0+bP9r7e12Y7HkPmLoHFhvJ0TCEXtXEP9PAOtr62M6mIUg0SUCAkZsPF2
         GyvkuLuU9Ig3UKXvBAqnjmLzpQS0PeTdl1/oN9CH4xp1v0GHFyttumT3iyGx4bBYo4
         yuNNWWvo8gZZyYEsxrAzPGr8l5e5xn/4mltXml5u0ADUy/r07spkECaEbCYou2v8z2
         bvTf80sq29Zs55/iwl0JLWsv1Q2nLpGT0JY2XBSAWqSOawqyKzAJl/AlT1jZJXB2vC
         RNDHN8dwh4QnwsmC10MZsUQi2ucVB6v4Ys5yiol3uxvadYkMDxPcu2bWM4KWMjNHZe
         lGZzw6SRYmmmQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once UPHY PLL hardware power sequencer is enabled, do not assert
reset to PEX/SATA PLLs, otherwise UPHY PLL operation will be broken.
This commit removes reset_control_assert(pcie->rst) and
reset_control_assert(sata->rst) from PEX/SATA UPHY disable procedure.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
v3:
   new, was a part of "phy: tegra: xusb: Rearrange UPHY init on Tegra210"

 drivers/phy/tegra/xusb-tegra210.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-teg=
ra210.c
index f06e7bc7a51b..ef4bbcbed60b 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -504,7 +504,6 @@ static void tegra210_pex_uphy_disable(struct tegra_xusb=
_padctl *padctl)
 	if (--pcie->enable > 0)
 		goto unlock;
=20
-	reset_control_assert(pcie->rst);
 	clk_disable_unprepare(pcie->pll);
=20
 unlock:
@@ -746,7 +745,6 @@ static void tegra210_sata_uphy_disable(struct tegra_xus=
b_padctl *padctl)
 	if (--sata->enable > 0)
 		goto unlock;
=20
-	reset_control_assert(sata->rst);
 	clk_disable_unprepare(sata->pll);
=20
 unlock:
--=20
2.25.1

