Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A68BC2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB202206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7NxJ5me"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbgEMHpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbgEMHpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:45:09 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8449CC061A0C;
        Wed, 13 May 2020 00:45:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id b8so7403481pgi.11;
        Wed, 13 May 2020 00:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H65Vxu253kb3zW5OLT3gqxYyLx+OY58AmrFPbg1BtQ4=;
        b=G7NxJ5mehnMYlEkMa3a29ghSVoJRGjhjmf8xIlvmrFbJEIKb3mRhE30cyNyB19m3cw
         XeqIrzewNcYkLpzKPHAp2pHdPUQRm8rV3JdlbpIleIZNk7XmHgdRcq9MTkRPa5KL1Zj/
         bqyKIpWZX+DFYSuGd3kjGWvDD4Oul3E5sLQvSMDljrHiKm7hcY3iL4csf5CpXfSNDPo8
         5GHvjJEPdMEsiYSOmoUCwhAqSOLn8j8ssHto6wstiEf3WwWjaHT26KOqSH7m8zmbsnoq
         82dzbBUe7hJGWPGJaQQic71EMwOk5VB04q47ho9D33b/SDMizL3cZZjVN5FgCJ5U9PHI
         waTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H65Vxu253kb3zW5OLT3gqxYyLx+OY58AmrFPbg1BtQ4=;
        b=Sk2wEysGmDgnmcSkXZOO2G62GCq0MQUnBt1OPsSVu+FzZEHwOOZBfgwvmZi3/QQ8Zj
         Ht+l1D5HJsCPpaBhhNiLrbBxVhkCiH5a4LWi10sdb+/HE+ocKBo3JyW6QgqYzNupdHVy
         f0iBwDbh3Rc0ccL5U4pNbwIKIGl+OU+7DtbVju0dd1D386/B5NybOM/M07rFBQn26ogM
         Un4DXg9ZawnZx8+NwyxLfYfsSultb2TwsEWFqnftyAI+aSDfRJgEmFiHqx8yQ6WK87hI
         rLgxuYCByPf0SnBdimz3zhZcIp7kXZd5+NR8fqwxDYGg3lwgJeECvnv3lboOWJBNeW0Z
         +/sg==
X-Gm-Message-State: AGi0Pub2kdp0qDmhI2Yp4e3Zaslvmxb47FTFs21Zsq1E1+koPbUKDhFk
        xKNpPlGjRwSuPgdcQsjIykM=
X-Google-Smtp-Source: APiQypIER4ye/hOz4oLh6skERHRUkzmMFbigD5b/Te7MST5tFsN6gh4pp6TGiqHg49eP8ruTP9JQCg==
X-Received: by 2002:a63:d64:: with SMTP id 36mr17709173pgn.143.1589355908024;
        Wed, 13 May 2020 00:45:08 -0700 (PDT)
Received: from localhost.localdomain ([2001:2d8:eb02:505a:d5fe:3ea6:5791:c8e8])
        by smtp.gmail.com with ESMTPSA id v3sm2740091pfv.186.2020.05.13.00.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 00:45:07 -0700 (PDT)
From:   Steve Lee <steves.lee.maxim@gmail.com>
X-Google-Original-From: Steve Lee <steves.lee@maximintegrated.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com,
        steves.lee@maximintegrated.com, steves.lee.maxim@gmail.com
Subject: [V3 PATCH 1/2] dt-bindings: Added device tree binding for max98390
Date:   Wed, 13 May 2020 16:44:23 +0900
Message-Id: <20200513074423.21034-1-steves.lee@maximintegrated.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for DT binding of max98390 amplifier driver.

Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
---

Changed since V2:
	* No changes.
Changed since V1:
	* Modified sample text in example

 .../devicetree/bindings/sound/max98390.txt    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max98390.txt

diff --git a/Documentation/devicetree/bindings/sound/max98390.txt b/Documentation/devicetree/bindings/sound/max98390.txt
new file mode 100644
index 000000000000..0ddd4c6ae55e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/max98390.txt
@@ -0,0 +1,26 @@
+Maxim Integrated MAX98390 Speaker Amplifier
+
+This device supports I2C.
+
+Required properties:
+
+ - compatible : "maxim,max98390"
+
+ - reg : the I2C address of the device.
+
+Optional properties:
+
+- maxim,temperature_calib
+  u32. The calculated temperature data was measured while doing the calibration. Data : Temp / 100 * 2^12
+
+- maxim,r0_calib
+  u32. This is r0 calibration data which was measured in factory mode.
+
+Example:
+
+codec: max98390@38 {
+	compatible = "maxim,max98390";
+	reg = <0x38>;
+	maxim,temperature_calib = <1024>;
+	maxim,r0_calib = <100232>;
+};
-- 
2.17.1

