Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EC4C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600CA2467F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yJby5aKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgCJGfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:35:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40161 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgCJGfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 02:35:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so1854088plk.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 23:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nP9PNS9eIJgQJAIRsXlp8n4P+pGeRNDem1/JAJ9CZoo=;
        b=yJby5aKYmht78gbCPLKW/yR9kFDyyMOl0hhOcLl9Yv1XCDJgxKqDFQ/VY/Cm4+78Du
         +IXhtz6sRqDL+pbulDPLtlduJdTc0rLACLbmB2Ldp9LZJkHsAZAWrnhtozeQAnDVoSBI
         styPVyZA5xIQFeRnye0NpOM8eKb1OABAEcMq1qLc3FxW4gDXggoW3CCdKelcxrovDwfy
         JckNwcerrnx3xqbuTV35u5gOMdGzCLXP41n/GdmEWZ4gEReWLNM6aV4BcDHwPs0/9OcX
         xgVyrlM+ScKNfn4uMWnrGj7zEPMfT8CFJnM1bzLHDW9mTBewjXgc9m2s52hNUBAtMyVW
         6/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nP9PNS9eIJgQJAIRsXlp8n4P+pGeRNDem1/JAJ9CZoo=;
        b=GqTfvvTOx/3RNKfAJVUBBywN+ZsACM5QmqpUGnmMClQEaPDtwkI4UtMr27Ghb+MhRz
         EE4kuDmf+jBuAZYsUrZNPlwJxW6tHKYv/9mpEqvBGzze+zAHWGvNCNoe9rLnzCB3EPQe
         ori/GmJLz+IVrGVIj+uFFZsI4LfptI5nXzTiLLXdTXxduYbmnTpO21pYZnppWg7tszOX
         7XewB0FH6ePR6giHbymbVr7vF2ChWVg/HHiY6uK4vD5JnY3Jz9cURlUKgNQdbr1EfmpG
         rN4SP9ta1/AWKgB25IC1fze1eJV495tJek0jjsDFJszM7H8F79gYDChGqQ+HSaJb+y/e
         7wCw==
X-Gm-Message-State: ANhLgQ3d6Afk6e5Qejm1h9m7Op32FnhU3LgKlYN+eKXHnWoQdespy0M7
        xtQNimhCm32HTT1+MzyVufidIw==
X-Google-Smtp-Source: ADFU+vvNU8SVNQz3C9Imsfqn/W1TG5Peq/nh++Xv6kdj+KouUr/6rTO+KMeCdRN12xY5J1qFbutcuw==
X-Received: by 2002:a17:90b:438d:: with SMTP id in13mr202775pjb.114.1583822110408;
        Mon, 09 Mar 2020 23:35:10 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v8sm1388029pjr.10.2020.03.09.23.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 23:35:09 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v4 0/5] remoteproc: qcom: PIL info support
Date:   Mon,  9 Mar 2020 23:33:33 -0700
Message-Id: <20200310063338.3344582-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce support for filling out the relocation information in IMEM, to aid
post mortem debug tools to locate the various remoteprocs.

Bjorn Andersson (5):
  dt-bindings: remoteproc: Add Qualcomm PIL info binding
  remoteproc: qcom: Introduce driver to store pil info in IMEM
  remoteproc: qcom: Update PIL relocation info on load
  arm64: dts: qcom: qcs404: Add IMEM and PIL info region
  arm64: dts: qcom: sdm845: Add IMEM and PIL info region

 .../bindings/remoteproc/qcom,pil-info.yaml    |  44 +++++
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  15 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  15 ++
 drivers/remoteproc/Kconfig                    |   6 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/qcom_pil_info.c            | 180 ++++++++++++++++++
 drivers/remoteproc/qcom_pil_info.h            |   8 +
 drivers/remoteproc/qcom_q6v5_adsp.c           |  20 +-
 drivers/remoteproc/qcom_q6v5_mss.c            |   7 +
 drivers/remoteproc/qcom_q6v5_pas.c            |  19 +-
 drivers/remoteproc/qcom_q6v5_wcss.c           |  14 +-
 drivers/remoteproc/qcom_wcnss.c               |  18 +-
 12 files changed, 335 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
 create mode 100644 drivers/remoteproc/qcom_pil_info.c
 create mode 100644 drivers/remoteproc/qcom_pil_info.h

-- 
2.24.0

