Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2DDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17DDF206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vU6CM3mu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgEOHHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 03:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726664AbgEOHHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:07:35 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F39C061A0C;
        Fri, 15 May 2020 00:07:35 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b8so551677plm.11;
        Fri, 15 May 2020 00:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M7hX/J76tBtL7VRebaHJrw9xmZRzEx8WmpLsqjkC1B4=;
        b=vU6CM3mun5/XIqHsnKuxhXN5MylGXPGNRiXohIC9XPH62/E0+oScClKAlhhdoACQMj
         BjUjhvgW/ebKfPRMW4RYeYyaIU9XZdnFbRqMSKH+uzdl/J6xxrkLi4nj/HUVKqPKPHjC
         ALWTTQOEuzQ0dScjO0gQYKo9tHZfP9muBFZQ3KTtgB4SsvbtQlgCtv1LXb/opOzEetcJ
         QRQhFt2j1+eXJz7nqzZ7UjonlmYlWsNS/YendGw6inJJlF7VMsSd65H0to+xRhDb7BG7
         irhIkur3UQJQIBz3+T0O6knb0dpMaHdZ9e9HJfhetw2cTnRXAog2dzj+U7iJh+tFEVto
         m9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M7hX/J76tBtL7VRebaHJrw9xmZRzEx8WmpLsqjkC1B4=;
        b=rQX9UrjVItD0PB7Kg6bA0ArgLzDi4SM1Gm4RFuX+gM9/8oshfD9NOoAsnDhCVqHNOd
         YAKUyhj2LGp1i5CmBx1cMO/o9r7ZIiaENU0ZDYmAo2uIY/KzAW8Vh8B46Hc2637XsFxG
         jkdBxL1JntZq+e3uG31ZScD7ipbXv6Kzu80i7WuehY/Yx3QOYole6GX4kSnLauuu60Do
         7xhAFO1eiLgNBsr6fxV8sqhXX+yomb+fe9iXGW7Kb6YptrICEiYBXeh69ep5Li29xrEs
         +V08xjJmN2nswMJbsy+AKTJoiby5qnC3JUeORjnTpqvWI4RAAVZFzvow0iIWeGdt8nP5
         Zpyw==
X-Gm-Message-State: AOAM533GQ+n65ucuLH2LMtTeliDhz++MgZxGRy31WpyK5/I3/w5ar7Nm
        DVdg6mSdAj5Oh9SSg+JllqY=
X-Google-Smtp-Source: ABdhPJwXZtIr/mXUcf/FXQH02w4WrWzvrLMq+bbqeL4qm+DMH7iqUNEYKh7qJ4BVzN1fNmiewnNSHg==
X-Received: by 2002:a17:90a:a402:: with SMTP id y2mr1853709pjp.24.1589526455357;
        Fri, 15 May 2020 00:07:35 -0700 (PDT)
Received: from localhost.localdomain ([2001:2d8:e99a:364e:d5fe:3ea6:5791:c8e8])
        by smtp.gmail.com with ESMTPSA id c124sm1062656pfb.187.2020.05.15.00.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 00:07:34 -0700 (PDT)
From:   Steve Lee <steves.lee.maxim@gmail.com>
X-Google-Original-From: Steve Lee <steves.lee@maximintegrated.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com,
        steves.lee@maximintegrated.com, steves.lee.maxim@gmail.com
Subject: [V5 PATCH 1/2] dt-bindings: Added device tree binding for max98390
Date:   Fri, 15 May 2020 16:07:01 +0900
Message-Id: <20200515070701.14102-1-steves.lee@maximintegrated.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for DT binding of max98390 amplifier driver.

Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
---


Changed since V4:
	* No changes.
Changed since V3:
	* No changes.
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

