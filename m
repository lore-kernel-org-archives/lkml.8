Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02293C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD51D2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="TxixLvjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgIJRHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgIJRGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:06:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18566C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:06:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l39so2313620ybe.14
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to;
        bh=adI7wIapGHyMuBg8Kx00Pr23ARAsrS6b/e9orFM8JOA=;
        b=TxixLvjFpgGmwKdMeWaIR8kRBrFRRk06I6hOZ9AnaRZjohco0VkPVEq1D45uXsls+1
         bXKkgPTkNAYkdNwC63x96d4F9C+deAvT6NOcfjza5Ista3qCP4u231q7B5emR4cawDf7
         5TDSdzCNod5MEmQIsw7kq4ZBGbGR+XUXidwXtrHWD63lggQgGXd1Zok+9ldBzpH15208
         Skljw+OPWZmt72AjmO+/jaiJZ1/T3c/1GL0+m4GkAtshks0hRWJMRtILLGhSb48mNiCL
         zbpmVmsm58N5BnPMtjoj797wJVSBQG1KQwI0eqgFb0XRYuPeAgnnNDksnZLT+mdpcMVi
         LJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to;
        bh=adI7wIapGHyMuBg8Kx00Pr23ARAsrS6b/e9orFM8JOA=;
        b=Mvy57Bpvg9QEh05UhssV2E5y0Q09qmYF6rFEgvhnNAZ1xRwqMox96nn07sPrJ4x1Ef
         hFmX9e/sitY/fScOtZ6RzBams7iCR8onwdiRLYFSeSbH5LVWPwUfpbdKk3LgXuATJTYx
         NgbD6+Fs8o2aNtC2Ewz/ADz+S1h9XXIq/3WbcEAFmkIy08PyMfEZGG8O1Mv5PVkGFgd7
         lGFBY9yzhV2t2z2YCGchiKhaYTdz29elLspDgXzrh2PTjQIt6e+kKMd2ovxEpZctIhoT
         nYaOJ9ttoEMkAbLkjdTxzkhfxtXT2K8rcZ0+w5Vndv/7MmRLxzMwC1jqWDGY1iGXacvX
         S91g==
X-Gm-Message-State: AOAM5310RMWBCepXlBucOh+L3qR25fEFI1LFElVAyWqexHrQ3qXx7iwN
        5C/+Dku6aj8qFu7JxvmHD770Q7yNQ0LUm36U
X-Google-Smtp-Source: ABdhPJyTReOFIEOH4u3OH8hr4+z1tGzkBXnTI1Wp04EnSFLUMzrekUKJ7atrss2kzIi0XvJ8DrKoGoqZaudODrpE
X-Received: from chu-dev.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3cfb])
 (user=linchuyuan job=sendgmr) by 2002:a25:61c2:: with SMTP id
 v185mr14987007ybb.314.1599757604064; Thu, 10 Sep 2020 10:06:44 -0700 (PDT)
Date:   Thu, 10 Sep 2020 17:06:38 +0000
Message-Id: <20200910170638.1985729-1-linchuyuan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH] dt-bindings: hwmon: max20730: adding device tree doc for max20730
From:   Chu Lin <linchuyuan@google.com>
To:     linchuyuan@google.com, jdelvare@suse.com, linux@roeck-us.net,
        robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        qiongwang@google.com, zhongqil@google.com, jasonling@google.com,
        belgaied@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing:
make dt_binding_check

Signed-off-by: Chu Lin <linchuyuan@google.com>
---
 .../devicetree/bindings/hwmon/max20730.txt    | 23 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/max20730.txt

diff --git a/Documentation/devicetree/bindings/hwmon/max20730.txt b/Documentation/devicetree/bindings/hwmon/max20730.txt
new file mode 100644
index 000000000000..3afb42b04567
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/max20730.txt
@@ -0,0 +1,23 @@
+max20730 properties
+
+Required properties:
+- compatible: Must be one of the supported compatible strings:
+	"maxim,max20730" for max20730
+	"maxim,max20734" for max20734
+	"maxim,max20743" for max20743
+- reg: I2C address
+
+Optional properties:
+
+- vout-voltage-divider
+	Resistance of the vout voltage divider.
+	Two numbers, the first number is the output resistor,
+	the second number is the total resistance.
+
+Example:
+
+max20730@10 {
+	compatible = "maxim,max20730";
+	reg = <0x10>;
+	vout-voltage-divider = <1000 2000>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 0a6ac3f00ed5..a04bf34a65b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12371,6 +12371,7 @@ W:	http://www.roeck-us.net/linux/drivers/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 S:	Maintained
 F:	Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
+F:	Documentation/devicetree/bindings/hwmon/max20730.txt
 F:	Documentation/devicetree/bindings/hwmon/max31785.txt
 F:	Documentation/devicetree/bindings/hwmon/ltc2978.txt
 F:	Documentation/hwmon/adm1275
-- 
2.28.0.526.ge36021eeef-goog

