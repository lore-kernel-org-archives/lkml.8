Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9407AC433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 13:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE142075F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 13:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i5eAJGHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgEQNN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgEQNNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 09:13:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D2FC05BD09
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 06:13:14 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u188so7338259wmu.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 06:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xbx4AAvUu+PImpbbOyBz7usygROnOomrJpTLkIJ23N0=;
        b=i5eAJGHqhepJuY5F2o5LNzQ8qvuNQ04n2slXSGTKH++XkQtTYgZ40Ahbzg/r+zL4PB
         Cx8/QZ4+tE3lHCwB06PAPtf3PB+k7X0Eu8gEWRB0nZIqX/9Hffetm3dK2r8qCbC9/lcE
         F/ctmyPX4NT/hFTPGtnPAqBE/QMxDb2OCuV/aImIK6+ILpGgEyimZ4hbvLriHbjz430m
         q6MVpZr+vRbgSLl9yVz6HN7j23f+1vIOew9RwJBlI4UzqOGDnjRS2eDaL5dKy8o534Kh
         6S5t9onBBZWaIgiM0yjOKsPDZclMmmMZ1Wmr+5OZyKGgubw2KVEaryTVvu+smFRBODOV
         9mDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xbx4AAvUu+PImpbbOyBz7usygROnOomrJpTLkIJ23N0=;
        b=J2zwN5rhlUThN0qMbZ3+jAicCzd265tH07oGwR1gldwI7MUZ6MMvDalSMcAidqhoa8
         CMInxdpSr7KQUmMLkiCVwqw95PXQRuTNSLu61xdlH/te5Q8jDCxE+L/reO8BqJvlVVPc
         4JV9qjfT3pQA+Ys1/Smmv4DJ+t4I4j4aNwEyYTgU/Oecb/gKpym++G4vY2goMUo//uaR
         2qNSU/T1u2+aoVEBp5qPQPyFPvU0+gJG6ueJQEsNs+HvB6hrLWbBLDaq39bFKcoji/hu
         w6jjfcf2f9nWFB1lAx4K+uyiHO3jLOjeWcuj+7IWQB9q3tokmUnisdkL5x9cbN7guhR8
         PAkg==
X-Gm-Message-State: AOAM532epy73/8wvCsEPno2UNmabCgWtXQe0PDYdTKEQffU7kfTg1bXg
        6gW/1W2kspFN+RTIhGfXoJOXZg==
X-Google-Smtp-Source: ABdhPJxNO/826caXBkww9KVSmNWQtlu/p2qQaVMMhAqWUmhvt4lH1qWiwY1D49vFYz3rd5lMNgf6BA==
X-Received: by 2002:a1c:307:: with SMTP id 7mr3409917wmd.104.1589721191385;
        Sun, 17 May 2020 06:13:11 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id i21sm10962271wml.5.2020.05.17.06.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 06:13:10 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        shawn.guo@linaro.org, p.zabel@pengutronix.de,
        vincent.knecht@mailoo.org, konradybcio@gmail.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH v5 0/2] Add Qualcomm MSM8939 GCC binding and driver
Date:   Sun, 17 May 2020 14:13:46 +0100
Message-Id: <20200517131348.688405-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V5:
- Drops unnecessary .name = "xo" - Stephen
- Re-orders probe to put PLL configuration and regmap before
  qcom_cc_really_probe() - Stephen
- Removes MODULE_ALIAS("platform:gcc-msm8939"); - Stephen
- Marks Shawn's contribution as Co-developed-by - Stephen
- https://github.com/bryanodonoghue/linux/pull/new/clk-next+msm8939-v4
- https://github.com/bryanodonoghue/linux/pull/new/clk-next+msm8939-v5
- https://github.com/bryanodonoghue/linux/pull/new/clk-next+msm8939-tip-v5

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
 drivers/clk/qcom/gcc-msm8939.c                | 3989 +++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-msm8939.h  |  206 +
 include/dt-bindings/reset/qcom,gcc-msm8939.h  |  110 +
 6 files changed, 4317 insertions(+)
 create mode 100644 drivers/clk/qcom/gcc-msm8939.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-msm8939.h
 create mode 100644 include/dt-bindings/reset/qcom,gcc-msm8939.h

-- 
2.25.1

