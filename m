Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA8CC433F7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA5E722CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uoxcNeLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgGTLYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbgGTLYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:24:41 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C64C061794;
        Mon, 20 Jul 2020 04:24:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f2so17427559wrp.7;
        Mon, 20 Jul 2020 04:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EqLyPhmrOwod1tcRJ7mEQ+gXPXSq7Nk5K0GWxKk/b8A=;
        b=uoxcNeLNN++s3CWu6vvva5p4VzC/EcNdioQeI0zDkgICA/xJUyqa1RglF40tuPFMud
         7UkpBFggaOkg6bJCuJEmGPECUHcrGFjkH+7lAqn+NV+SonmNIQu9tcMg5lR0KQdiv+cF
         z0KkTb/1ZJfSuXdCh9PxvPAUV1Jau/PAbT1vTq/891AYUJvtbDrmTT3CXeZlo4E5G5KD
         SjtWuxanIhkd3htWcV1qZiLqLQ2v3ZfeieFuNMfEHc5OgulagVInEvola8/pQLMlIb9Z
         ZqV66wYqHsmjWmmXJFMj+9YVSyk5Nfcx4xUN5N0ea3+1WQs5nIuRCyR3ScNnuq9Pkppe
         oQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EqLyPhmrOwod1tcRJ7mEQ+gXPXSq7Nk5K0GWxKk/b8A=;
        b=prFREc1VF6LFcasRyPutOirNnP/5hdZyVsWrLGQYR2p/X4V5rM90uhLdXHLmLR6qLB
         y+odysTDT3/QUAiIbf2b1a8dDhcuVDtFgvR0puwD0Cdzfo5YZxIqGi0u2gbbiSRpaKqY
         rBR/hlM54/UfP65I3JEwDb6M0frgVeGv74brnT0WTPbOhgzzLIW1dIReL0Gf5IIqA90z
         EH4cnFcB5zS7w1c9ExAoluGN/NzH97KjeKs4tITVCoC66NEn2qHhrFbljTBgQzhpkrCT
         bydJAmnAIs8k7J9Y9eCz+VrF/BmC3/lkzlKkilFXW0cT3g9nhwcbUyQgjIqSCfIEoqDn
         Nf5w==
X-Gm-Message-State: AOAM531Nv7fuXoz1fM1I1GDYsdGzr/NLsBWzF+ldg7kn3h740qvjp+JR
        1mY6QqCmXh7MYWrSfTRfc3w=
X-Google-Smtp-Source: ABdhPJw1rTMDjy6l3Gfu8wVrvKT/8l7SQoqnujkgsJS6aGgqWPGIh2pnXQEQuM0XyP1EqWZ85jSt6g==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr21929317wro.413.1595244280304;
        Mon, 20 Jul 2020 04:24:40 -0700 (PDT)
Received: from localhost.localdomain ([148.63.172.143])
        by smtp.gmail.com with ESMTPSA id t4sm33452942wmf.4.2020.07.20.04.24.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2020 04:24:39 -0700 (PDT)
From:   miguelborgesdefreitas@gmail.com
To:     a.zummo@towertech.it
Cc:     baruch@tkos.co.il, linux@armlinux.org.uk,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        miguelborgesdefreitas@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: rtc: pcf8523: add DSM pm option for battery switch-over
Date:   Mon, 20 Jul 2020 12:23:59 +0100
Message-Id: <20200720112401.4620-2-miguelborgesdefreitas@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200720112401.4620-1-miguelborgesdefreitas@gmail.com>
References: <20200719145028.3370-3-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-1-miguelborgesdefreitas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>

This adds direct-switching mode as a configurable DT flag for
RTC modules supporting it (e.g. nxp pcf8523).
DSM switches the power source to the battery supply whenever the
VDD drops below VBAT. The option is recommended for hw designs
where VDD is always expected to be higher than VBAT.

Signed-off-by: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
---
Changes in v2:
- Added extended commit message for git history
- Separate dt bindings documentation into a single patch

 Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt | 7 ++++++-
 Documentation/devicetree/bindings/rtc/rtc.yaml        | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
index 0b1080c..f715a8f 100644
--- a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
@@ -4,10 +4,14 @@ Required properties:
 - compatible: Should contain "nxp,pcf8523".
 - reg: I2C address for chip.
 
-Optional property:
+Optional properties:
 - quartz-load-femtofarads: The capacitive load of the quartz(x-tal),
   expressed in femto Farad (fF). Valid values are 7000 and 12500.
   Default value (if no value is specified) is 12500fF.
+- pm-enable-dsm: battery switch-over function is enabled in direct
+  switching mode. The power failure condition happens when VDD < VBAT,
+  without requiring VDD to drop below Vth(sw)bat.
+  Default value (if not provided) is the standard mode.
 
 Example:
 
@@ -15,4 +19,5 @@ pcf8523: rtc@68 {
 	compatible = "nxp,pcf8523";
 	reg = <0x68>;
 	quartz-load-femtofarads = <7000>;
+	pm-enable-dsm;
 };
diff --git a/Documentation/devicetree/bindings/rtc/rtc.yaml b/Documentation/devicetree/bindings/rtc/rtc.yaml
index ee237b2..a0048f4 100644
--- a/Documentation/devicetree/bindings/rtc/rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/rtc.yaml
@@ -47,4 +47,11 @@ properties:
     description:
       Enables wake up of host system on alarm.
 
+  pm-enable-dsm:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enables the battery switch-over function in direct switching
+      mode. Should be set in systems where VDD is higher than VBAT
+      at all times.
+
 ...
-- 
1.8.3.1

