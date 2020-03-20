Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECC9C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 01:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9DF2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 01:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ch9QVTq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgCTBlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 21:41:11 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34643 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbgCTBlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 21:41:11 -0400
Received: by mail-qk1-f194.google.com with SMTP id f3so5438746qkh.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 18:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eZP0u8ITunLiIIRvSTm1UDhFa2x+FOEr9rW1o7749xQ=;
        b=ch9QVTq4I67QoriwHaevg8GW7hXScd11/w/CBbCQ7WxRxps1cAMVtSS6fHp9gCncIZ
         S78U66ED8dfSrlv95xnu/Eyg5Z1Mnlg1sOfTgqTrxCmMGsPf3W9IGy1vAKNiIgXXbA0d
         BOSCBXlTGB66Kt8TKlqT4G9y43hVCO20Q8pvNBDnbJ/D3tbRjTlGGxl1CsWfy4+gj/kJ
         /ozhlhuSfH2+lcIEEdWAeQ+NDIBRv6Oks/lBViT0vCDcqDj1P4UZuev0K9cK5pMdvkIO
         wTO66o7+GMiKoRws/uakv1R3YiPY+SK0oZRTwUToFigy5QhCfpAASMlt2MywZ3943Avs
         TJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eZP0u8ITunLiIIRvSTm1UDhFa2x+FOEr9rW1o7749xQ=;
        b=Ht+q+3Yrp4OmEYQIn6X9XqUaG4cFRLUnm3OaAxFO6V6/U+HgP0EKnMfQ7WQsYDHv2T
         ErN62LvPB93qPqI1x2hDV7gskBqFi86esJKnYRu5xyONsgQxLcLtTpkW9EhzCo7rugDe
         jZnfSNvEG5dpXtkHkmJvtlwqHZetn88KsAkC796+aXs1VjwaRjVG3rbsc48BFxURYNZM
         L40+v8sfvD11uRtxZgJIVaR+jQxedS4z/qAbz6EUxT+rR3LDRajfOCgJX/MyZOKQT0aL
         D+dnBF3386uytnqOdnh0yarqsE2H4n5hjd+OTt4dym88DNv/AtavyQIANOE4BMP0pApe
         Hbug==
X-Gm-Message-State: ANhLgQ0/Yp6r22RSK/UW7ai+mDHNZFJkzXT21xNgcIfOzxdXzw8EdyV9
        SV7RE3msc/OxMqvwlIkJFDoeYA==
X-Google-Smtp-Source: ADFU+vtHoEjmxDMNZ3DTXsUDWYUwN7WHrNIVQU4FEmg3Vg32kJaDK07DIpk0aYZpGhtYL0mspWm+WA==
X-Received: by 2002:a37:4bd1:: with SMTP id y200mr4044290qka.205.1584668469530;
        Thu, 19 Mar 2020 18:41:09 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 2sm2706287qtp.33.2020.03.19.18.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 18:41:08 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v5 0/6] Introduce Power domain based warming device driver
Date:   Thu, 19 Mar 2020 21:41:01 -0400
Message-Id: <20200320014107.26087-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain resources modeled as a generic power domain in linux kernel can be
used to warm up the SoC (mx power domain on sdm845) if the temperature
falls below certain threshold. These power domains can be considered as
thermal warming devices.  (opposite of thermal cooling devices).

In kernel, these warming devices can be modeled as a thermal cooling
device. Since linux kernel today has no instance of a resource modeled as
a power domain acting as a thermal warming device, a generic power domain
based thermal warming device driver that can be used pan-Socs is the
approach taken in this patch series. Since thermal warming devices can be
thought of as the mirror opposite of thermal cooling devices, this patch
series re-uses thermal cooling device framework. To use these power
domains as warming devices require further tweaks in the thermal framework
which are out of scope of this patch series. These tweaks have been posted
as a separate series[1].

The first patch in this series extends the genpd framework to export out
the performance states of a power domain so that when a power domain is
modeled as a cooling device, the number of possible states and current
state of the cooling device can be retrieved from the genpd framework.

The second patch implements the newly added genpd callback for Qualcomm
RPMH power domain driver which hosts the mx power domain.

The third patch introduces a new cooling device register API that allows
a parent to be specified for the cooling device.

The fourth patch introduces the generic power domain warming device
driver.

The fifth patch extends Qualcomm RPMh power controller driver to register
mx power domain as a thermal warming device in the kernel.

The sixth patch describes the dt binding extensions for mx power domain to
be a thermal warming device.

The seventh patch introduces the DT entreis for sdm845 to register mx
power domain as a thermal warming device.

v1->v2:
	- Rename the patch series from "qcom: Model RPMH power domains as
	  thermal cooling devices" to "Introduce Power domain based
	  thermal warming devices" as it is more appropriate.
	- Introduce a new patch(patch 3) describing the dt-bindings for
	  generic power domain warming device.
	- Patch specific changes mentioned in respective patches.

v2->v3:
	- Changed power domain warming device from a virtual device node
	  entry in DT to being a subnode of power domain controller
	  binding following Rob's review comments.
	- Implemented Ulf's review comments.
	- The changes above introduced two new patches (patch 3 and 4)
v3->v4:
	- Dropped late_init hook in cooling device ops. Instead introduced
	  a new cooling device register API that allows to define a parent
	  for the cooling device.
	- Patch specific changes mentioned in respective patches. 

v4->v5:
	- Dropped the patch that introduced the cooling device register
	  API with parent as per review comments from Ulf. 
	- Patch specific changes mentioned in respective patches.

1. https://lkml.org/lkml/2019/9/18/1180

Thara Gopinath (6):
  PM/Domains: Add support for retrieving genpd performance states
    information
  soc: qcom: rpmhpd: Introduce function to retrieve power domain
    performance state count
  thermal: Add generic power domain warming device driver.
  soc: qcom: Extend RPMh power controller driver to register warming
    devices.
  dt-bindings: power: Extend RPMh power controller binding to describe
    thermal warming device
  arm64: dts: qcom: Indicate rpmhpd hosts a power domain that can be
    used as a warming device.

 .../devicetree/bindings/power/qcom,rpmpd.yaml |   3 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   1 +
 drivers/base/power/domain.c                   |  37 ++++
 drivers/soc/qcom/rpmhpd.c                     |  46 ++++-
 drivers/thermal/Kconfig                       |  10 ++
 drivers/thermal/Makefile                      |   2 +
 drivers/thermal/pd_warming.c                  | 168 ++++++++++++++++++
 include/linux/pd_warming.h                    |  29 +++
 include/linux/pm_domain.h                     |  13 ++
 9 files changed, 308 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/pd_warming.c
 create mode 100644 include/linux/pd_warming.h

-- 
2.20.1

