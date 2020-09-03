Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21036C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2CE20709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgICSjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:39:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41253 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbgICSi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:38:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id y4so4939631ljk.8;
        Thu, 03 Sep 2020 11:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5iYxU30/OZKxnckXSXEWILSjZda9qorCD3gugu2wz9o=;
        b=rB+9uoQV5w005Yj/PG0rgRN5lbud04Xc11yToJTG6ItujNdrcALV/6M7mzd8ZSve+h
         ExQlIDqtanELe2IWnIYuluIU8qVm+1awBezYJtHmaROfwfBzJA+DHaEqYVxC+gj8Guku
         bWZ8BRQCjC/xAaD3fKcumEQDt18sXp+8i4yLE1qE5IprEac6kz9s7aQCOIDRj4Uhrg0k
         bFoumxxAF4gWzflss+35MY84syAGv5sztoGUn3uZ0fSykr6oMSpXjE4WweeCrec37Bgq
         V1iZhwoCOQpcaEaGPErTT8n051AtoCBw4vym2Loy1ezWj6uFS815rh5XSTt38aj64GBE
         adYQ==
X-Gm-Message-State: AOAM5325ikheBNH8pl6briB7h/i8gh7kTZMTcrnVlKxcoJSOehNrJfEg
        Uy38HgjpgCDTsYe3GsZC5fo=
X-Google-Smtp-Source: ABdhPJy56HEYdmlDK2TJ5EjyvnQGyCdaEDgByVPVSsqW7lWVioe221WrlQi3S1QWBft8tmoV+7aqSA==
X-Received: by 2002:a2e:9595:: with SMTP id w21mr2039373ljh.334.1599158336613;
        Thu, 03 Sep 2020 11:38:56 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id w4sm765817ljm.50.2020.09.03.11.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 11:38:56 -0700 (PDT)
Date:   Thu, 3 Sep 2020 21:38:48 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [PATCH 3/4] dt-bindings: regulator: bd71847: add property for
 omitting ON/OFF control
Message-ID: <51022c60412297ad9b22501452d60ba2dce38d2e.1599029334.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1599029334.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1599029334.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BD718(37/47/50) regulator enable states can be controlled either by SW
or by PMIC internal state machine.

On some systems mixture of SW and HW state machine controlled regulators is
needed.

Specifically, some SoCs signal SUSPEND state change to PMIC via
STBY_REQ line. Now there are setups that expect certain regulators then to
be disabled (by PMIC state machine) while other regulators should stay
enabled (regardless of HW state => SW control required).

Add a new device-tree property "rohm,no-regulator-enable-control" which can
be used to leave regulator(s) under HW state machine control.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 .../bindings/regulator/rohm,bd71847-regulator.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
index 07256a4b50b9..eeac32cd15d6 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
@@ -88,6 +88,17 @@ patternProperties:
         # ----------------------------------------------------------------
         # rest | not supported   | not supported    | not supported
 
+      # BD718(47/50) power outputs can either be controlled by the PMIC internal
+      # hardware state machine or by software. If you need regulators to be
+      # turned ON/OFF for example based on PMIC_STBY_REQ line (which toggles
+      # PMIC HW state machine) - then you should set this property.
+      # Tradeoff is that then SW can't control the ON/OFF state for this
+      # regulator (other than invoking a PMIC state change).
+      rohm,no-regulator-enable-control:
+        description: |
+          Enable/Disable control of this regulator must be left to the
+          PMIC hardware state machine.
+        type: boolean
     required:
       - regulator-name
 
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
