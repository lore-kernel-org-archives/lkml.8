Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D24C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 15:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D29206E2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 15:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="KTaFWwUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgBWPf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 10:35:28 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:58482 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgBWPf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 10:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bVRqXwiffdLCCmotaKsx3cF84pTUkg8/0dSkEqWxyLg=; b=KTaFWwUkI530bngwbt9AGw3IxZ
        zymiPfZvXN1OL6QRSL6PObacbu2JKUBePwLRtTvv/Uwhu6GORkU2Jek/7HI+AV8JuP31Yub/T1jB7
        NxMrRKxCTsMaAWrMYBujB87lWgc6uNSCMJ2QjkZLr4ec240MZ43GfkYMPzr7YQwg9xHY=;
Received: from p200300ccff47d700e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff47:d700:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1j5tHo-0000SP-2x; Sun, 23 Feb 2020 16:35:16 +0100
Received: from andi by eeepc with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1j5tHn-00040X-J5; Sun, 23 Feb 2020 16:35:15 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     hns@goldelico.com, j.neuschaefer@gmx.net, contact@paulk.fr,
        GNUtoo@cyberdimension.org, josua.mayer@jm0.eu, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RFC] regulator: core: fix handling negative voltages e.g. in EPD PMICs
Date:   Sun, 23 Feb 2020 16:35:01 +0100
Message-Id: <20200223153502.15306-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Basically regulator_get_voltage() returns the voltage and
 -Esomething on error. If the voltage is negative, results of
regulator_ops->get_voltage() are interpreted as error in the core,
so even if a consumer can handle negative voltages, it won't
get access to the regulator because the regulator will not be
registered at all due to a failing set_machine_constraints() call.

An alternative would be to handle voltages as absolute values.
There are probably no regulators with support both negative
and positive output.

The patch solves only the registration problem and does not fix
everything involved.

It has to be checked whether there is anything in mainline kernel
which uses negative voltages.

There are several regulator drivers found in the wild (often with
kernel version <= 4.1.15) for EPD PMICs which use negative
voltages for their VCOM regulator:
- sy7636
- fp9928
- tps6518x
- max17135

consumer is e.g. the EPDC of imx6 SoCs which is not in mainline.
Typical out-of-tree devicetrees contain snippets like this:
 VCOM_reg: VCOM {
      regulator-name = "VCOM";
      /* 2's-compliment, -4325000 */
      regulator-min-microvolt = <0xffbe0178>;
      /* 2's-compliment, -500000 */
      regulator-max-microvolt = <0xfff85ee0>;
 };

This kind of description will cause trouble as soon as these
uint32_t are casted to an int64_t (now they are casted to int
on 32bit architectures).

For the following devices which contain the tps6518x there are
partial devicetrees in mainline:
- Kobo Aura (N514)
- Kobo Clara HD
- Tolino Shine 3

No idea about the "Amazon Kindle Fire (first generation)"
which also has a partial devicetree in mainline.

Before cleaning up these drivers for upstreaming it would be
good to know which road to go in regards of negative voltages.

If we go the road with absolute voltages, there is a risk of
accidential booting a vendor devicetree with mainline kernel
this kind of negative voltages, which might cause bogous setups
so maybe voltages with bit 31 set should be filtered by the core,
besides of additional checking in the drivers itself.
Lukily form my experience, these out-of-tree devicetrees for
imx6 systems are incompatible enough to not boot even to a serial
console.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/regulator/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d015d99cb59d..2f2f31c3b9f1 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1129,7 +1129,7 @@ static int machine_constraints_voltage(struct regulator_dev *rdev,
 			current_uV = regulator_get_voltage_rdev(rdev);
 		}
 
-		if (current_uV < 0) {
+		if ((current_uV < 0) && (current_uV > -MAX_ERRNO)) {
 			rdev_err(rdev,
 				 "failed to get the current voltage(%d)\n",
 				 current_uV);
@@ -3022,7 +3022,7 @@ int regulator_is_supported_voltage(struct regulator *regulator,
 	/* If we can't change voltage check the current voltage */
 	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_VOLTAGE)) {
 		ret = regulator_get_voltage(regulator);
-		if (ret >= 0)
+		if ((ret >= 0) || (ret < -MAX_ERRNO))
 			return min_uV <= ret && ret <= max_uV;
 		else
 			return ret;
@@ -4031,7 +4031,7 @@ int regulator_get_voltage_rdev(struct regulator_dev *rdev)
 		return -EINVAL;
 	}
 
-	if (ret < 0)
+	if ((ret < 0) && (ret > -MAX_ERRNO))
 		return ret;
 	return ret - rdev->constraints->uV_offset;
 }
-- 
2.20.1

