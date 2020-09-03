Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B97C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B48420709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgICSiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:38:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33856 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgICSiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:38:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id v23so4992571ljd.1;
        Thu, 03 Sep 2020 11:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=G8YdvudDKsl+XH0TOF/XGHJYZCEazEGmxSJA0OmXFOE=;
        b=oK6rdLfEyiFBHF7I1UbuUdVAe7OHA843VoZ7QpJwfTdtBONwAUIXaGLDRhKC35Mc7N
         bJl2DArHRwBNBZlBoElDBfYQ+eshSO07yIZJROYse3meFBnos4uIW8ZxhTBPBGwAFRLJ
         zBE0VQfdtn0Eh7Lg0TamoUoX6+HUySoM1ja1U8CSK3tA9cWlORrusAGxFDCpTeI9cl2E
         k8CQ5IHg6QXAfCHCd1wm39JFPv9MTJ+fHms2Dd8o5GQvmU+oyF1fi88Ic7SCqQItZPKK
         2ej6yGd3nXgZkxHCjUwlRurw1uynVaLqkNOjxvY7vp8/ploJIA9UGhBya23Iddh/7pEJ
         jLrw==
X-Gm-Message-State: AOAM533Az1HRA75t38SXpsqqqQ34uAMOyUFeHWbgtlVbfxeN0lkeqqkf
        hZ5a+leenCPys5QCo3grQzcfBUPtGiK3yQ==
X-Google-Smtp-Source: ABdhPJxHC3DyCh/w3nbKS4ojbn/lt46EVnDBhoQzvoXwfFDpjIXFa/OHkrq/dv9VF4Gckx1SBxgo2A==
X-Received: by 2002:a2e:9d04:: with SMTP id t4mr2007184lji.293.1599158279199;
        Thu, 03 Sep 2020 11:37:59 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id w4sm765396ljm.50.2020.09.03.11.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 11:37:58 -0700 (PDT)
Date:   Thu, 3 Sep 2020 21:37:51 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [PATCH 0/4] Support regulator ON/OFF by PMIC state machine.
Message-ID: <cover.1599029334.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support regulator enable/disable via BD718(37/47/50) PMIC state machine.

The ROHM BD718(37/47/50) PMICs are mainly used for powering i.MX8 based
systems. On some setups the i.MX8 SoC uses a IO line to suspend the
system. These PMICs support this via PMIC internal HW state machine
which can be toggled for example by the PMIC_STBY_REQ IO-pin.

Regulators can be controlled either by this state machine or by SW via
I2C. This patch series allows mixed control model by adding a
device-tree property which is intended to be used to leave some of the
regulators under HW state machine control while allowing other to be
still controlled using the driver. The driver can also be used to set
voltages levels for all regulators no matter if enable/disable state is
controlled by SW or HW.

---

Matti Vaittinen (4):
  regulator: bd718x7 initialize regulator config only once
  dt-bindings: regulator: bd71837: add property for omitting ON/OFF
    control
  dt-bindings: regulator: bd71847: add property for omitting ON/OFF
    control
  regulator: bd718x7 fix regulator states at SUSPEND

 .../regulator/rohm,bd71837-regulator.yaml     |  11 +
 .../regulator/rohm,bd71847-regulator.yaml     |  11 +
 drivers/regulator/bd718x7-regulator.c         | 422 +++++++++++-------
 3 files changed, 293 insertions(+), 151 deletions(-)

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
