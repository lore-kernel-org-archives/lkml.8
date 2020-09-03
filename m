Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39547C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 253D320709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgICSit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:38:49 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35711 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgICSiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:38:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id a15so5009329ljk.2;
        Thu, 03 Sep 2020 11:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gt6OM1dCG0l0sdiM2MxOpC1YxXaQJC64+fjRHPpV5jw=;
        b=HsSEys8XvVsqsWS4jjVGDRiIIOdEznuCazDSOGpDBRjNkaaL7dvIBBm8AIvYCOpgeo
         6JFVEcrrOR0uz9UpcLRX6+zHrceMKkJdkNAdr1N3C2vT5ayHgRiI+CoHNzTZFK+l2xRr
         R5ZWmQ3+BMAok8d81xMHRQAFU7dA831QZ5TTQn8tqlro2qP+/4Vz97O0sXngPjhRossE
         ayvpqfcxio0Ks9ra5vYS7xZwwP0SczL8zXOs0PYxJGQzhDYOyuh3ViQ8Uh9vFGIthZiR
         9RGQuw68VqBnJAlnPFdvUzi9u9+MfKEyUOpSyKgq/pEltwLThCM8WSpvLmj2aP35h8By
         OVbA==
X-Gm-Message-State: AOAM531KEdqMBVRy6pYEhuMs+rGFWkwuFLhMZH/Y+SBxsiQrhadko07v
        IyBCX/DDEnJrX9ftHdyxKKc=
X-Google-Smtp-Source: ABdhPJxb33CV5VrpWMDxn4KavwGPkQnNW6lBR3wF2L2opvs9JUyJU1qldyhjcgGR8a2lMLywOLHu5A==
X-Received: by 2002:a05:651c:1073:: with SMTP id y19mr1973019ljm.57.1599158322509;
        Thu, 03 Sep 2020 11:38:42 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id t1sm755494lfc.52.2020.09.03.11.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 11:38:42 -0700 (PDT)
Date:   Thu, 3 Sep 2020 21:38:34 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [PATCH 2/4] dt-bindings: regulator: bd71837: add property for
 omitting ON/OFF control
Message-ID: <9ff1104579093e7977944be769d625b9e33bc663.1599029334.git.matti.vaittinen@fi.rohmeurope.com>
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
 .../bindings/regulator/rohm,bd71837-regulator.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
index 19d9408d9c3b..f5e31196a646 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
@@ -93,6 +93,17 @@ patternProperties:
         # ----------------------------------------------------------------
         # rest | not supported   | not supported    | not supported
 
+      # BD71837 power outputs can either be controlled by the PMIC internal
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
