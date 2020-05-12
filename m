Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8786FC54E8F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655D620753
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqWbIdJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgELLtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 07:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbgELLtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 07:49:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53B1C05BD09
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 04:49:49 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z72so13311762wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 04:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A2Mcpf/ILTeuFmBUFhpYWTiaZtQu3vqTzJ1nZU97Aks=;
        b=KqWbIdJUedo7tBvw/qpVmXNEaBG5VLl8QeLV+5HY5XNd4xPo67WpsvwwHtegd5XxZ6
         Jet8kLCrLPZx8SXE6MfuLtwzJUxHL6YFTbQGFN8JJzTx4Grt5lDA0l0ZWpzLbEEt7aIx
         VMK9ivwx/G1Hxu2kxYPfMdpm2FKU4wdZk15IewaBxGvMxpVSE4cFcb07gPRx5P5usPnW
         h6l5FARMKkfUq9unek8GxLm19q4kqk/FTfd80n5YLY8wEmvLMeixK6zhKEvVYFKY7lq9
         bt9R0oQ0NsKT7eijP6zLLudxANtB3ISCXt2WTykzMtp5iE8/3tq4THclvhAItAvvl8sx
         CEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A2Mcpf/ILTeuFmBUFhpYWTiaZtQu3vqTzJ1nZU97Aks=;
        b=R9DYM8YS1RDa2+4gUTjI3g3aGV3KH+O4upTl3JXKIuS2ST+xR3Xqpuda/MVCzGITkG
         6bRk9i6w4mTVlaNSUJfr1gP0ELVprm1isQ+kLiPijggYirM9mtsyN8RN3H2VZ/RAsThX
         xOXxRsSD+7AE5jMlDuy6KYIMdPs5QHBAUnboyZ+yArxhV5WNGBApqS/8HOwQwjla6kQN
         8KHqMtoC57XHnNo++jbtnnnYCszElfTEc8nlPNkPxPGkLUcqVya2E/XRLIc7Fx+ume4l
         bdphTTNgwlcb0sR487Eo6Zjw6nA13MWqMfmdSntBt4kTyuhO0l1ZlLL9VykUszoQpQfv
         1i0Q==
X-Gm-Message-State: AGi0PuYUSgNUblXamQ7eVFew0C5Segs3Mz5I5PbsNi7bOv+Q8Hll8Pkc
        cGRwfXDDWXrBYhJj0FdjsyY3fQ==
X-Google-Smtp-Source: APiQypLN2bAiVp61F45KywfR703a8KYR4PiJo/5siuqqoiFFKRaDBQfVIvi/C6A5bnDqZirbU4HyVA==
X-Received: by 2002:a1c:9a45:: with SMTP id c66mr11192058wme.133.1589284188478;
        Tue, 12 May 2020 04:49:48 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id 10sm8970405wmw.26.2020.05.12.04.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 04:49:47 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        shawn.guo@linaro.org, p.zabel@pengutronix.de,
        vincent.knecht@mailoo.org, konradybcio@gmail.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH v4 0/2] Add Qualcomm MSM8939 GCC binding and driver
Date:   Tue, 12 May 2020 12:50:21 +0100
Message-Id: <20200512115023.2856617-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V4:
- Moves headers from 1/1 to 0/1 - patch squashing error - Rob
- Identifies licensing as GPL v2.0-only, thanks for pointing this out. - Rob
- Adds Tested-by: Vincent Knecht <vincent.knecht@mailoo.org>, thanks for
  testing this. - Vincent
- https://github.com/bryanodonoghue/linux/pull/new/clk-next+msm8939-v2.1
- https://github.com/bryanodonoghue/linux/pull/new/clk-next+msm8939-v4

V3:
This update removes the old clock name arrays which I forgot to prune in
the previous V2.

git diff bod/clk-next+msm8939 bod/clk-next+msm8939-v2.1

V2:
This update does the following

1. Drops code in the probe routine to add xo and sleep_clk. Instead
   the DTS for the GCC will need to declare both of those clocks for the
   GCC controller.

2. Supplants parent_names for parent_data for all clocks.

3. Squashes down the previous three patches into two.

4. Drops the git log of copying files. The git log makes clear the silicon
   is highly similar, so, you can just as easily read the log and do a
   diff.

5. Doesn't update the MSM8916 with parent_data.
   Happy to do this at a later date but, don't have the time to validate
   this properly at the moment. This set focuses on the MSM8939 alone.

6. Dropped comment and boilerplate license text as indicated.

7. Dropped dependency on COMMON_CLK_QCOM seems to not be needed.

8. Easily view the changes here:
   git add bod https://github.com/bryanodonoghue/linux.git
   git fetch bod
   git diff bod/clk-next+msm8939 bod/clk-next+msm8939-v2   

V1:
These three patches add support for the MSM8939 Global Clock Controller.
The MSM8939 is a derivation of the MSM8916 sharing the large majority of
its clock settings with MSM8916, however, there are enough changes, in some
cases mutually incompatible changes that necessitate a separate driver.

I thought it was both important and useful to show in the git log the
differences between MSM8916 and MSM8939 so, one patch copies the MSM8916
driver while another patch applies the entire gamut of MSM8939 changes,
squashing down from a git log of approximately 31 separate commits.

For reference that log is here:
https://github.com/bryanodonoghue/linux/pull/new/msm8939-clk-next-reference-log

Generally speaking MSM8939 differes from MSM8916 in two key ways.

- New and higher clock frequencies for existing IP blocks.
- New PLLs to drive those higher frequencies

Bryan O'Donoghue (2):
  clk: qcom: Add DT bindings for MSM8939 GCC
  clk: qcom: gcc-msm8939: Add MSM8939 Generic Clock Controller

 .../devicetree/bindings/clock/qcom,gcc.yaml   |    3 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/gcc-msm8939.c                | 3999 +++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-msm8939.h  |  206 +
 include/dt-bindings/reset/qcom,gcc-msm8939.h  |  110 +
 6 files changed, 4327 insertions(+)
 create mode 100644 drivers/clk/qcom/gcc-msm8939.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-msm8939.h
 create mode 100644 include/dt-bindings/reset/qcom,gcc-msm8939.h

-- 
2.25.1

