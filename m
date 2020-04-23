Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB75C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E2020787
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ML8Zyc4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgDWKdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725863AbgDWKdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:33:39 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375C6C035494
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 03:33:39 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r26so6004632wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 03:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6jPdlcIxfEbZ7t28aDiBn6sEBBwa7mpS/DnDKlaphSU=;
        b=ML8Zyc4mlZRhLCXmy4qzW7nX9oIJfOtbfiHZYvQjeqyH1oqqLkdFPIqnmn76pOZjSH
         lEI+yoBOXKlNeTeNbj+HnTskuSWg2wtdQ3WImhDNxfcAIFbgJq9z80eU5ijQD0g2xzWa
         ejfm6FZFUS49oei0VyUZYtHgYmBnjMPApm/TdQ4ZhizA666dpf9U2KtJ1F/SpRaLJvQH
         0wpmC7ncQ4yQSzvTLWrgk0WkCRUkM+ypesSlCwxweAaEC8OOTfwpY5fmmLIOdujOTxTO
         cfbkyVuLvM+qk2Ho3dmdLI7iIzZ5sdqGAdUt9vtF47POujaVtAxdytqs4ZfAqV3xd71l
         0wgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6jPdlcIxfEbZ7t28aDiBn6sEBBwa7mpS/DnDKlaphSU=;
        b=kn5jeqY7Asqkk2NXkAgwckeUcGnm40jrmd7CDh8iuqbLir5O7jyIGBtuVgAXSRtai0
         dg3yqCQ9DHetXlqQ2wj/pOEzmwRZfU7bClMGBRzVLGg/TOyuHKUtXd8op5PxUGHyAKMZ
         9ldsVqUmIouK+DNk/vRvto9WQxwlqyFkW1V5CmzPNdw71+fRLaUgoih2LsU5MqZhTFAE
         7gljRih6Abjy2QfAgSJ2hYrxKqp2xFo22q9NEF2tyPelTXFxVlgbVNTEG+4/niHWiw5J
         YSoD1PSgmlEXiRfm5jf81PYjnjUwCM+VSORXfe/86zfSAnkZ5po50GEy9RxZKsN0tssu
         Xnzw==
X-Gm-Message-State: AGi0PuYV7KL3ZpVslQAukqeY/Aekr0o4TNIdn4apCaT6hvFnNFQIi/rk
        YCi2xaADVjE5uRO1bSen62SEew==
X-Google-Smtp-Source: APiQypKiod48xHrM5Fm8UUhAEWoL3u9Xlj9qcFBgpftfn4avtKeo3nYQtZZ7MDTuS0KAYnyZmnpweA==
X-Received: by 2002:a1c:f418:: with SMTP id z24mr3393652wma.122.1587638017711;
        Thu, 23 Apr 2020 03:33:37 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id x18sm3086757wrs.11.2020.04.23.03.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 03:33:37 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        shawn.guo@linaro.org, p.zabel@pengutronix.de,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v3 0/2] Add Qualcomm MSM8939 GCC binding and driver
Date:   Thu, 23 Apr 2020 11:34:04 +0100
Message-Id: <20200423103406.481289-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

