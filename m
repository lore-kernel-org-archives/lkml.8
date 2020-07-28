Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE36C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 03:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB6F20829
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 03:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjwAA3KC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgG1DPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 23:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgG1DPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 23:15:17 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9FCC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 20:15:17 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id lw1so2077228pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 20:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PD2ZLQCvLaWVcoV1PzZsr55F59ipm51nH9LfNuI1BWE=;
        b=EjwAA3KCQnsgyym83+P1cOxkyODRcSK9IpoGYOEK8mo9VSqUL4M+G3WzSpNJSRYQA9
         y586nY0JjXTtfFnWhUCaxaE/0h4A5BMb85AH2INGsMulbg6VPaM/sY6p2gGS3DSzIqlX
         boAOW4/CtUL/7SK30IKifPmDizDBLglxmwmJh9IqHU/TYIA5Ru0CPlWcQ3nU0eQhDO5T
         Gtx4lpvl0TnG/jCP92EzfoGeSIQRbklRXSZmbE92OyLda3zwF7BtF6C/OB5EweH1I6e7
         qKnPgAMoeLt4IVhHIvneIRBJkhNGkLh9ClXVIslrK10smMjWzOTuc4hyJddRtz3Q2vDv
         XdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PD2ZLQCvLaWVcoV1PzZsr55F59ipm51nH9LfNuI1BWE=;
        b=pwgzHGelQqgH/TReSTHMX9ZKFJn9MKdNI88RZAPNLw4JzOEYgbStQcJiX3I0y/C40K
         8jK3Kjq9D/8GcKKlPu63Zri0Jukh+ofSbEfHNKvWcyMeeGZVpw//SXAC8ItZoHC6tD9j
         1N9WD/k9gi4j8PfcoIurpajSUsiSQpwhLN4YkBS5mCEqFjDI4zo2JH5rxt22SGJpd/mL
         vz4faBrV5n9V2lO6HmNQE/zkwUekExCESrWNbrIusKEv9iYZOVo3xUIpq4XkhA6Pl4mw
         L/UirDAcNe5VqnYpdrXs59rweqdDXeBecA/ZFlp52goYqLWS1aMqX5cF94YzpXlq4xWF
         tb9Q==
X-Gm-Message-State: AOAM531NlIrZZ3EpfCGQEbE0Zmp2kXHrTJDAAEhHjSFaOS68nasQZLL4
        AZdLVusXDW7ysFtt+OOS01u7TBCPDSfL3OnV
X-Google-Smtp-Source: ABdhPJzhKrz0Xncjr22aQGFtwZngq8XVXIgQIPz03Ds2RskP8S8nIqrepHCZERgvSrGwYwgIXpZ4iA==
X-Received: by 2002:a17:90a:7805:: with SMTP id w5mr2362904pjk.192.1595906116854;
        Mon, 27 Jul 2020 20:15:16 -0700 (PDT)
Received: from debian.flets-east.jp ([2400:2411:502:a100:c84b:19e2:9b53:48bb])
        by smtp.gmail.com with ESMTPSA id s10sm3895285pjf.3.2020.07.27.20.15.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2020 20:15:15 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     masahisa.kojima@linaro.org, jarkko.sakkinen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/2] dt-bindings: Add SynQucer TPM MMIO as a trivial device
Date:   Tue, 28 Jul 2020 12:14:32 +0900
Message-Id: <20200728031433.3370-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200728031433.3370-1-masahisa.kojima@linaro.org>
References: <20200728031433.3370-1-masahisa.kojima@linaro.org>
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
Acked-by: Rob Herring <robh@kernel.org>
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

