Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5472FC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27CF72495A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mglqha6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgELJTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726024AbgELJTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:19:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD24C061A0C;
        Tue, 12 May 2020 02:19:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t40so9093817pjb.3;
        Tue, 12 May 2020 02:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eljqxU5QjvaLul3lBAtBBOmNN4PsgBS7SMSl69Yllas=;
        b=Mglqha6zf4yCyBuN1JhM/UvGpoJccJ0mz+FVC/tYpYCPTiXEuamRf/XY7WUy6QyNfI
         LY1DNTH4E3eV3ddLsU6PxfXjmwgQkXShWdfg6VlQffwoJ/JJv/79gQrLI18ZDZYA9rdA
         t765sebL8CNfI4SlkzDSYOliuKxlDN5vp9SwwNkYSQpQvc1S8u8BnKdikmDu+pjLxa3O
         UonXJq41yRadaD4J7083xLeRG5fbyXy4/FML4a/8cjcSP8+dm7epzTVzNJVR9htmqmSv
         fRLBlj4ZoL/IV6usCtprKQDBb9UpZCyWwecUCazD8CsARM0pGNB1bRki9TfcgNeIVTuF
         GhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eljqxU5QjvaLul3lBAtBBOmNN4PsgBS7SMSl69Yllas=;
        b=SWolA+qRmi/9GSEDNndtIdttpQnz7cH7+AfDO0vRJERgNya7JShW3G/j/audzq+/lz
         laUdloVraTA7E+pqtHwFP5T7OEfqkMzVTOVlukQ0GYszvc7tpYbBxlv2u38ouWZwx9Np
         w8Vvv7gXnjRlDhvsm3x1l+/kMeHoLsQbgFaMBi0kp9Z7a1p6BHjXu/m2+NS7+K4NO9We
         ybVPOS8i6/LXbJA5clHk9NIGH+j3QAlGGXyeKTfBXip+pBQohqa3IKMgOF9YANmEHyPJ
         cQribLkj1fpTDJ25no6tzR+nWQ73kYqK5rf5hT0bZiRUpu6YnK/voadN47K39u0ViE4o
         QxUQ==
X-Gm-Message-State: AGi0PuZKWnbIzW2qcrQmi8JBUoG2+dTlO5WGMvfqnoxGEgzGDR0zVvc1
        w50/C0rgp+4g8log+Tr9IYo=
X-Google-Smtp-Source: APiQypJ9gTfQbVWhwVvBIvaeS/BnzgA7vFw4SAoPPieKhgGQanQt+xg/c333SFLbyoeyvyjH3AqW4g==
X-Received: by 2002:a17:90a:9295:: with SMTP id n21mr26444117pjo.195.1589275189436;
        Tue, 12 May 2020 02:19:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:2d8:308:9c7a:d5fe:3ea6:5791:c8e8])
        by smtp.gmail.com with ESMTPSA id b16sm11546944pfp.89.2020.05.12.02.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 02:19:48 -0700 (PDT)
From:   Steve Lee <steves.lee.maxim@gmail.com>
X-Google-Original-From: Steve Lee <steves.lee@maximintegrated.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com,
        steves.lee@maximintegrated.com, steves.lee.maxim@gmail.com
Subject: [V2 PATCH 1/2] dt-bindings: Added device tree binding for max98390
Date:   Tue, 12 May 2020 18:18:46 +0900
Message-Id: <20200512091846.31207-1-steves.lee@maximintegrated.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for DT binding of max98390 amplifier driver.

Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
---
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

