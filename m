Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04423C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB8520409
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584383268;
	bh=MlbJeIevRZO4ycIkqOCsGp7532IJjEKRO30YrAyzB5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=UvO/qQkMgLR2T1TYBn4mS13HJsWClAOrZmpdEZPET9ENaEmHeXnKqkVSEMtlamiXf
	 7oAB8LO6RDmJ2HaFaKItjV60w+anS5SRiRUTxZ0Is0uiCyWvtCb7WQ4Ebh1XmTFLAa
	 R6uJxI8akAhdgyUTx0aj9kFfThNZVOMZNyzZNEt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbgCPS1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:27:47 -0400
Received: from foss.arm.com ([217.140.110.172]:55248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731967AbgCPS1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:27:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACF941FB;
        Mon, 16 Mar 2020 11:27:46 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FCBB3F67D;
        Mon, 16 Mar 2020 11:27:46 -0700 (PDT)
Date:   Mon, 16 Mar 2020 18:27:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Applied "regulator: mp886x: Document MP8867 support" to the regulator tree
In-Reply-To:  <20200316223100.37805b22@xhacker>
Message-Id:  <applied-20200316223100.37805b22@xhacker>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mp886x: Document MP8867 support

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From b11dec18e6334da2f2a11e07cf43e2a394b12c06 Mon Sep 17 00:00:00 2001
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Date: Mon, 16 Mar 2020 22:31:00 +0800
Subject: [PATCH] regulator: mp886x: Document MP8867 support

MP8867 is an I2C-controlled adjustable voltage regulator made by
Monolithic Power Systems. The difference between MP8867 and MP8869
are:
1.If V_BOOT, the vref of MP8869 is fixed at 600mv while vref of MP8867
is determined by the I2C control.
2.For MP8867, when setting voltage, if the steps is within 5, we need
to manually set the GO_BIT to 0.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Link: https://lore.kernel.org/r/20200316223100.37805b22@xhacker
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/regulator/mp886x.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/mp886x.txt b/Documentation/devicetree/bindings/regulator/mp886x.txt
index 6858e38eb47d..551867829459 100644
--- a/Documentation/devicetree/bindings/regulator/mp886x.txt
+++ b/Documentation/devicetree/bindings/regulator/mp886x.txt
@@ -1,7 +1,9 @@
-Monolithic Power Systems MP8869 voltage regulator
+Monolithic Power Systems MP8867/MP8869 voltage regulator
 
 Required properties:
-- compatible: "mps,mp8869";
+- compatible: Must be one of the following.
+	"mps,mp8867"
+	"mps,mp8869"
 - reg: I2C slave address.
 - enable-gpios: enable gpios.
 - mps,fb-voltage-divider: An array of two integers containing the resistor
-- 
2.20.1

