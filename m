Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7C6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF6720774
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWS3+plU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgGHNPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbgGHNPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:15:34 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D90C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 06:15:34 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q17so3746121pls.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 06:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TkaB98nQDQAZj54VpdleIAAukarhv3l749JNi1B5PxQ=;
        b=MWS3+plUn1olq+Vl0HSnSx9XuX4+qccQPmHePb7EJ1x/+hpS5X72De+w9gp5zePmi2
         uEBEj8+vpc2d0ZmfNZEu1tR3fmnZhOyjMH+CGfPikEuRleWqZSsb83T8bG1JmRTOj3PC
         OUlziPQqB9o29Ey6JIKiRDbMkEZU02veExKlAElj9QyWRc2DhuVCqfHXzwH4JqS1Uzv7
         XVI+mgUKRw4/U7uBudtvva9dc2A9QC6hak0Shp8idznMrB8p4oHtrXgztaxFurPnbKek
         tx1HungF0YCw9Q6kraf4iK64nLxrK7mltzcVpd95MsBgh093XGC8AlO3r8IautX/orHp
         +aSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TkaB98nQDQAZj54VpdleIAAukarhv3l749JNi1B5PxQ=;
        b=LZ/naoZkfkSlP3q+QCChb6PiLokV0z/Rg8FelEl4fjPV8Caf2bsZi26zmYMUe32tzq
         tiIXrwVxfD/qez1tFheqcUN2mrvjhdJs1j8j5FC6a8PDOtgJul4ry7TgUcsQjWUKKNlQ
         rRAk59Jh4RXssyCKIudHvNZ2LZl3zZYhNYioN2Lh7QytkyOQlbvKk8fbKkESReI4IZBF
         +rXsJ8XlTcd3DnFJAWy1CLsl6j3jJ0q1gazMjYtK1PCFlBI1bj5AqSuMew7QwyltDV4U
         z4iAGUXLhR9pdWYDtI81kbE1f47Gi5DPhUI8C2RxBGeGDaD7EeBHO6dUyy5dXv6cmI4X
         Wkmg==
X-Gm-Message-State: AOAM5337cpIZidGZTdvS6xoxfHnePEwG6OYpM0EPrxBto5dbcU2B5Xoc
        CCrvfE9DgDIRVZPBDkS9EY6GTLT8LpIKDw==
X-Google-Smtp-Source: ABdhPJySUm0xfOTXmzrFgBr8CFij0vt7Ulz8YKPVEAGa5Pv1sa2H7kaBEkbqYnBp9p21gKkAyuCYLw==
X-Received: by 2002:a17:902:bd97:: with SMTP id q23mr46309205pls.251.1594214133211;
        Wed, 08 Jul 2020 06:15:33 -0700 (PDT)
Received: from debian.flets-east.jp ([2400:2411:502:a100:c84b:19e2:9b53:48bb])
        by smtp.gmail.com with ESMTPSA id y63sm4096366pgb.49.2020.07.08.06.15.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 06:15:32 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     masahisa.kojima@linaro.org, jarkko.sakkinen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 2/2] dt-bindings: Add SynQucer TPM MMIO as a trivial device
Date:   Wed,  8 Jul 2020 22:14:24 +0900
Message-Id: <20200708131424.18729-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200708131424.18729-1-masahisa.kojima@linaro.org>
References: <20200708131424.18729-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for the SynQuacer TPM to the binding for a
TPM exposed via a memory mapped TIS frame. The MMIO window behaves
slightly differently on this hardware, so it requires its own
identifier.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 4165352a590a..814148939e5a 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -328,6 +328,8 @@ properties:
           - silabs,si7020
             # Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
           - skyworks,sky81452
+            # Socionext SynQuacer TPM MMIO module
+          - socionext,synquacer-tpm-mmio
             # i2c serial eeprom  (24cxx)
           - st,24c256
             # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
-- 
2.20.1

