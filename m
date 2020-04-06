Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B96C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 07:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D800220672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 07:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgDFHaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 03:30:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44353 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgDFHaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 03:30:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id p14so13490937lji.11;
        Mon, 06 Apr 2020 00:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dgmZ0bjqyUvm/qPZv62N1I4mJZ+HWVLMJ51Jy00jq/g=;
        b=i6kBbKWfw/uGkbJj9F4mVkzO8TB+e0MjgrXI6OGbGagrncVEzQW6HjvyTBcf4fIFT+
         kqKn4uJNmn6f0ol0aeQGmDXYYbDgjVnbnnXhvJ7TZglCOd3doNXeU9xDKYaQ73S4pNTa
         dmqMQDFXBOuMvfqMM3LJBsj0IrP3SeseXVRZRwkzm6wnhddUXosEiIVvMjxmWon+dkA+
         o0paejTCPQrCLvt4EKTjCQZPCVfp4gO4c3NJMY0waZp4M4myQLKZPSxx2X8CgYFDYL3Q
         3EswPeHpaOo+4F2nCRkP/4QXwKYF2epe4QaAERNNXS6GEDpsCUR0Do1/npStP5y4U973
         4jgw==
X-Gm-Message-State: AGi0PuZGYQ/GJywMJSo57mvlGTwGFTc3o+Z8rqGl+xnr8LFWIraNxbNm
        2X/m79csM4my24T5Bk/7hAo1bUk0
X-Google-Smtp-Source: APiQypIDh8ERPkAwJp6PTql+5aLtPMaYL8QLB0SEl5+4n2GutnKQ4T6lJD9sCsX9xn2EsCOl8GqwRw==
X-Received: by 2002:a2e:5450:: with SMTP id y16mr11870330ljd.121.1586158215774;
        Mon, 06 Apr 2020 00:30:15 -0700 (PDT)
Received: from localhost.localdomain (dc7t7ryyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16e1:b700::3])
        by smtp.gmail.com with ESMTPSA id m7sm12956837lfh.54.2020.04.06.00.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 00:30:15 -0700 (PDT)
Date:   Mon, 6 Apr 2020 10:30:08 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: BD718x7 - add missing I2C bus properties
Message-ID: <20200406073008.GA13084@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT example needs #address-cells and #size-cells for I2C bus or
validity checker will generate warnings. Add these properties in
BD71837 and BD71847 binding examples.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

This patch was created against Lee's for-mfd-next branch. Please let
me know if this was not feasible.

 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml | 4 +++-
 Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
index aa922c560fcc..65018a019e1d 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
@@ -123,7 +123,9 @@ examples:
     #include <dt-bindings/leds/common.h>
 
     i2c {
-      pmic: pmic@4b {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pmic: pmic@4b {
             compatible = "rohm,bd71837";
             reg = <0x4b>;
             interrupt-parent = <&gpio1>;
diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
index 402e40dfe0b8..77bcca2d414f 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
@@ -128,7 +128,9 @@ examples:
     #include <dt-bindings/leds/common.h>
 
     i2c {
-      pmic: pmic@4b {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pmic: pmic@4b {
             compatible = "rohm,bd71847";
             reg = <0x4b>;
             interrupt-parent = <&gpio1>;

base-commit: d2923aa4535664ae5c46c3a093985afd18fec118
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
