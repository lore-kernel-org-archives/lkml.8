Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE273C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C9D21775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581014647;
	bh=zrILCCCEDx7rKqJjdtvUZLYFTZ9XBxOcTr5tliB7lMw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=M8MgJUk+Jj8mHQmozZI0ZjUWhCTRfm1O3FwWg/riSnTVEYLfFSb2SKYBxmUxlAHTY
	 HU+xNiy9ZjWslmG1I8yNKoJFJ1hmK4lgCXnLoJKhOn1xeeUpO8zuj/cQapVpWIEWqJ
	 4XbT+z0eQCC6/rfb9e6uDsPdItDDHVAP4evKM8tQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgBFSoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:44:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgBFSoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 13:44:07 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03EE5214AF;
        Thu,  6 Feb 2020 18:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581014646;
        bh=zrILCCCEDx7rKqJjdtvUZLYFTZ9XBxOcTr5tliB7lMw=;
        h=From:To:Cc:Subject:Date:From;
        b=Dsw5UQLNST/YCAH8NkDdiWUUtIedt5hBu0lZ/xbZAVapwSDJHmTdSqfKvDlOLT/5+
         4ju8a24QKmWOKvxvBHS6HpaJJDRz/GytT1MrXf8bZZtpZigdX7ueaEZYxSzdPm35v3
         2PTfFt1DPWjQOTArJ5S0Aw1MyzGrOqW0QVUbqpEs=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] more clk changes for the merge window
Date:   Thu,  6 Feb 2020 10:44:05 -0800
Message-Id: <20200206184405.183679-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fc6a15c853085f04c30e08bbba7d49cb611f7773:

  dt/bindings: clk: fsl,plldig: Drop 'bindings' from schema id (2020-02-03 10:33:34 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 5df867145f8adad9e5cdf9d67db1fbc0f71351e9:

  of: clk: Make <linux/of_clk.h> self-contained (2020-02-05 14:52:03 -0800)

----------------------------------------------------------------
A collection of fixes that would be good to get merged before -rc1.

 - Make of_clk.h self contained
 - Fix new qcom DT bindings that just merged to match the DTS files
 - Fix qcom clk driver to properly detect DFS clk frequencies
 - Fix the ls1028a driver to not deref a pointer before assigning it

There are some conflicts in the dt bindings files.

----------------------------------------------------------------
Colin Ian King (1):
      clk: ls1028a: fix a dereference of pointer 'parent' before a null check

Douglas Anderson (12):
      dt-bindings: clk: qcom: Fix self-validation, split, and clean cruft
      clk: qcom: rcg2: Don't crash if our parent can't be found; return an error
      dt-bindings: clock: Fix qcom,dispcc bindings for sdm845/sc7180
      clk: qcom: Get rid of fallback global names for dispcc-sc7180
      clk: qcom: Get rid of the test clock for dispcc-sc7180
      clk: qcom: Use ARRAY_SIZE in dispcc-sc7180 for parent clocks
      dt-bindings: clock: Fix qcom,gpucc bindings for sdm845/sc7180/msm8998
      clk: qcom: Get rid of the test clock for gpucc-sc7180
      clk: qcom: Use ARRAY_SIZE in gpucc-sc7180 for parent clocks
      dt-bindings: clock: Cleanup qcom,videocc bindings for sdm845/sc7180
      clk: qcom: Get rid of the test clock for videocc-sc7180
      clk: qcom: Use ARRAY_SIZE in videocc-sc7180 for parent clocks

Geert Uytterhoeven (1):
      of: clk: Make <linux/of_clk.h> self-contained

Stephen Boyd (1):
      clk: qcom: Don't overwrite 'cfg' in clk_rcg2_dfs_populate_freq()

 .../bindings/clock/qcom,gcc-apq8064.yaml           |  83 ++++++++
 .../bindings/clock/qcom,gcc-ipq8074.yaml           |  51 +++++
 .../bindings/clock/qcom,gcc-msm8996.yaml           |  68 ++++++
 .../bindings/clock/qcom,gcc-msm8998.yaml           |  93 +++++++++
 .../devicetree/bindings/clock/qcom,gcc-qcs404.yaml |  51 +++++
 .../devicetree/bindings/clock/qcom,gcc-sc7180.yaml |  75 +++++++
 .../devicetree/bindings/clock/qcom,gcc-sm8150.yaml |  72 +++++++
 .../devicetree/bindings/clock/qcom,gcc.yaml        | 230 ++++-----------------
 .../devicetree/bindings/clock/qcom,gpucc.yaml      |  72 -------
 .../{qcom,dispcc.yaml => qcom,msm8998-gpucc.yaml}  |  33 ++-
 .../bindings/clock/qcom,sc7180-dispcc.yaml         |  84 ++++++++
 .../bindings/clock/qcom,sc7180-gpucc.yaml          |  72 +++++++
 .../bindings/clock/qcom,sc7180-videocc.yaml        |  63 ++++++
 .../bindings/clock/qcom,sdm845-dispcc.yaml         |  99 +++++++++
 .../bindings/clock/qcom,sdm845-gpucc.yaml          |  72 +++++++
 ...{qcom,videocc.yaml => qcom,sdm845-videocc.yaml} |  27 +--
 drivers/clk/clk-plldig.c                           |   4 +-
 drivers/clk/qcom/clk-rcg2.c                        |  11 +-
 drivers/clk/qcom/dispcc-sc7180.c                   |  45 ++--
 drivers/clk/qcom/gpucc-sc7180.c                    |   4 +-
 drivers/clk/qcom/videocc-sc7180.c                  |   4 +-
 include/linux/of_clk.h                             |   3 +
 22 files changed, 979 insertions(+), 337 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-msm8996.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-msm8998.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-qcs404.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
 rename Documentation/devicetree/bindings/clock/{qcom,dispcc.yaml => qcom,msm8998-gpucc.yaml} (51%)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-gpucc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-videocc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sdm845-gpucc.yaml
 rename Documentation/devicetree/bindings/clock/{qcom,videocc.yaml => qcom,sdm845-videocc.yaml} (61%)

-- 
Sent by a computer, using git, on the internet
