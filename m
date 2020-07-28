Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B589C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56EF020714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="bqUQy7jh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgG1Cjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgG1Cjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:39:44 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AE5C0619D4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 19:39:43 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id y11so5541636qvl.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 19:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JpBwI5rh1VmR9dJCXKb+bJH00mu8Lm9wehnoKvU4jcQ=;
        b=bqUQy7jhnL0rGAZVXzl2pr3NWaTgdIriU12FTryPEPMVY5wt51fHrXJ0vbVkcfIr4d
         WAYoI66DcIz8Z2qRIvZ5yKiv5D8YgwxBTnylMztk4s16k5XUIlc/re9PODqvhvkRtB5B
         TVZSkva+UhquRQULicJzDN9icgzBm2blLaIyZTP9OL8mv9ugJTBJiyDe6iSjRBOZvOBv
         sA1vH0643u/pUW6E2y/lTzK2XhtF6fnFY5q02YCUSNgODaW+bprgm2eXlDdmxyLptMyH
         yBoE+/88gElgn3TEvFtyRfqbBLxv6nxBgMXkuxf+SNdXWTYMbOiK7VH6fSm1eh9enAGr
         DsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JpBwI5rh1VmR9dJCXKb+bJH00mu8Lm9wehnoKvU4jcQ=;
        b=Yf0SXdzXhKcDBASfuNVVcCOsv2Ev36b4uV+Zpn5kWL9ViKwsQL0ec+kSFuMDs5ijje
         L7p1+2S9zyfXbV9MqmequXSK0ajuB6EkRvJ1GYxbXwGvR/5PqNP8I33lmatpdGFy+jtI
         7tJ684Y8m4jtkN9OEQiRqAWCfxj5/kULCMSoidgoKkIjn5DVkuCoITKCB66wvekjU6cJ
         MyPBCBqdbkeSWlUkGu+RK42y0gtpqFmuhYqp9YdDRp4XYtXc8sVD9UnKf8D5qdp1Q6s8
         v7XXvsjGvqAQJomuFzdfrDMp81L28A9UlrywIRy6yKRNU9Mhh/llCZju+sM93LKG/8Ol
         TdGQ==
X-Gm-Message-State: AOAM530gjGW/8ejjPca44Csm/5XYm/RZFJjrLpHD9RhjIJl07/foBkzu
        bHPXE05/u417q2axgHhw9G8gVw==
X-Google-Smtp-Source: ABdhPJz9E9SJY8pj6+WMHEhK2Nhev880nCCsyeRYYub0FM05PwJIPJreA7LDFUu+Z4vWX3RN2jcOLA==
X-Received: by 2002:ad4:49a1:: with SMTP id u1mr7434725qvx.245.1595903982912;
        Mon, 27 Jul 2020 19:39:42 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id z3sm13885548qkc.4.2020.07.27.19.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 19:39:42 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Georgi Djakov <georgi.djakov@linaro.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-pm@vger.kernel.org (open list:INTERCONNECT API),
        Odelu Kukatla <okukatla@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 0/7] Add SM8150 and SM8250 interconnect drivers
Date:   Mon, 27 Jul 2020 22:37:59 -0400
Message-Id: <20200728023811.5607-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of this is generated from downstream dts using a script.

v2: single yaml file for RPMh interconnect bindings, drop display RSC
v3:
 - removed the sc7180 example from the combined yaml file, two
   examples with conflicting includes doesn't seem possible
 - Removed MASTER_ALC and bcm_alc (sm8150 and sm8250)
 - Set keep alive for SH0, MC0, MM0, SN0 and CN0 (both)
 - Used Sibi Sankar's suggestions for reg base/size in dts

Jonathan Marek (7):
  dt-bindings: interconnect: single yaml file for RPMh interconnect
    drivers
  dt-bindings: interconnect: Add Qualcomm SM8150 DT bindings
  dt-bindings: interconnect: Add Qualcomm SM8250 DT bindings
  interconnect: qcom: Add SM8150 interconnect provider driver
  interconnect: qcom: Add SM8250 interconnect provider driver
  arm64: dts: qcom: sm8150: add interconnect nodes
  arm64: dts: qcom: sm8250: add interconnect nodes

 .../{qcom,sdm845.yaml => qcom,rpmh.yaml}      |  42 +-
 .../bindings/interconnect/qcom,sc7180.yaml    |  85 ---
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  82 +++
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  82 +++
 drivers/interconnect/qcom/Kconfig             |  20 +
 drivers/interconnect/qcom/Makefile            |   4 +
 drivers/interconnect/qcom/sm8150.c            | 635 +++++++++++++++++
 drivers/interconnect/qcom/sm8150.h            | 152 ++++
 drivers/interconnect/qcom/sm8250.c            | 651 ++++++++++++++++++
 drivers/interconnect/qcom/sm8250.h            | 162 +++++
 .../dt-bindings/interconnect/qcom,sm8150.h    | 162 +++++
 .../dt-bindings/interconnect/qcom,sm8250.h    | 172 +++++
 12 files changed, 2161 insertions(+), 88 deletions(-)
 rename Documentation/devicetree/bindings/interconnect/{qcom,sdm845.yaml => qcom,rpmh.yaml} (60%)
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
 create mode 100644 drivers/interconnect/qcom/sm8150.c
 create mode 100644 drivers/interconnect/qcom/sm8150.h
 create mode 100644 drivers/interconnect/qcom/sm8250.c
 create mode 100644 drivers/interconnect/qcom/sm8250.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8150.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8250.h

-- 
2.26.1

