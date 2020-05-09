Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7B0C47257
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 03:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27FF7217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 03:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njmdmu/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgEIDSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 23:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgEIDSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 23:18:14 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB81C061A0C;
        Fri,  8 May 2020 20:18:12 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y25so2000069pfn.5;
        Fri, 08 May 2020 20:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zzJCC69wo4d+308QEV5gjkekcxD2iqQ/9p1JPveRTkA=;
        b=njmdmu/oDmlDhvjpaoG+P9T5eIShCdBkEG0nTzCSLP+xwYW+whiw2yvxZfH5RUAxHP
         uc4+e0Kxj37xj6l6eFhPdkfWS3Hx5geToWAXIH76IcSnGYfwcMPnw/zxnqglqz9sA+Qt
         1AgcwGIVKUMRAyILk5apYTQ5fPf+Qc0UB1dlKIzdEAzdf/GvsgoDySSyyqL5EeopGBjw
         FJ2iLX3VNZvZXgaCY4fpJ+hnoF248TuxXOJwyUQye2hcoAofjJeQKm/CVO73CxVAUFK0
         2iBY7o0xku8/H/hGBNcOZfrmgP0tetYVDF1woW8Ai83qqMOGvRxmlFL7di6v+Tzzi32C
         2oUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zzJCC69wo4d+308QEV5gjkekcxD2iqQ/9p1JPveRTkA=;
        b=qNtjCou26xOAjPP9smxuyDge8AwgFplHqmaIC8YP5tXvKCtRokAPAIrzROeWVVrCkP
         htTuj6ogjqdM0UGbYL2sMwEL40bHMX4QzN842nvtAEUZlPSmuA9m+CqKXOawPmJTAUAl
         XTqdjSRvokHdm0KcySUYjCPDde5WUS4JUrU2P7rF7Ageo1sND/02U2A0ZBPgRlIptI3N
         wXxjxAu6q5hNrwLgUZ0IXrCxSMUm8rSnsuPwHTHUtRNNU2LCtzXMNmexzpMinI8riWcU
         topO6oaYnNGs3ErDmCBea090xBaFMwPiNv5fGnFKD1neDWGldZQvx67+uiqYM9Mfy4CR
         i6qQ==
X-Gm-Message-State: AGi0PuYLIGvkn8ftxaU+8RVEQH7Q35jy3EFwMRqioDDWE2Fd0YmEiPin
        pDMr051HLf54XEAmbog7Axr1q9M4
X-Google-Smtp-Source: APiQypJkAC0n3gvoXXV0efJrhOQSNYN+H5GDw3dyc2NlKep//fT8F1LF9A72TusOtQrlbVT+XzlFmQ==
X-Received: by 2002:a63:150:: with SMTP id 77mr4558840pgb.136.1588994292345;
        Fri, 08 May 2020 20:18:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:2d8:eb61:15a8:d5fe:3ea6:5791:c8e8])
        by smtp.gmail.com with ESMTPSA id a22sm2413872pga.28.2020.05.08.20.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 20:18:11 -0700 (PDT)
From:   Steve Lee <steves.lee.maxim@gmail.com>
X-Google-Original-From: Steve Lee <steves.lee@maximintegrated.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     steves.lee.maxim@gmail.com, steves.lee@maximintegrated.com
Subject: [PATCH 1/2] dt-bindings: Added device tree binding for max98390
Date:   Sat,  9 May 2020 12:17:37 +0900
Message-Id: <20200509031737.8937-1-steves.lee@maximintegrated.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
---
 .../devicetree/bindings/sound/max98390.txt    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max98390.txt

diff --git a/Documentation/devicetree/bindings/sound/max98390.txt b/Documentation/devicetree/bindings/sound/max98390.txt
new file mode 100644
index 000000000000..147dfd88cd3b
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
+ - maxim,temperature_calib
+   u32. The calculated temperature data was measured while doing the calibration. Data calibration : Temp / 100 * 2^12
+
+ - maxim,r0_calib
+   u32. This is r0 calibration data which was measured in factory mode.
+
+Example:
+
+codec: max98390@38 {
+   compatible = "maxim,max98390";
+   reg = <0x38>;
+   maxim,temperature_calib = <1024>;
+   maxim,r0_calib = <0x224050>;
+};
-- 
2.17.1

