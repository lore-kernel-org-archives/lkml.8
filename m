Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D750C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F18205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kckx/+5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732869AbgCPWvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 18:51:31 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:36655 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732843AbgCPWva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 18:51:30 -0400
Received: by mail-qt1-f174.google.com with SMTP id m33so15844374qtb.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 15:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wZC7KqQ/+MEL0RDvWDxQg83WbFpNiASJj0i4ST9YezU=;
        b=Kckx/+5TKFM6oNsXeSsWaGuvP98pQxJb9gmnW77ZG1854D8UFfynC0jAggJwtrhjIF
         9alhhG9kfxEQB+YNC40JYxo0vD/uSbjJPYBn3dWOpVSm7Fm7MHa2QxeWQqDgZoCbxq1v
         Mq1bg9Vqty9S+tTJnVkHE6ndbYTqoiGaKqmrmetM+FQyOYnjm612DFSChlCtm9z1f0dJ
         bioD/QXFU2jPo3+w520F4CsZnMwAxdi1BqcllQguHryhQeqlK9ZFkb4HF3/LnDnuccc1
         47xOdxBbA4eD8ITBbgNUuFQeuonc70oQp8VFos7CbwrwWNB4S4gh/+n1DIBM8tZ3tuRl
         VQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wZC7KqQ/+MEL0RDvWDxQg83WbFpNiASJj0i4ST9YezU=;
        b=hsQ16ZlnmsaxBqBvU+ixz3gxv4jWZUfG+aqsPXE2lYhT8N8FuJhThk3ga+vtb0PusK
         M8pwVn973MY7pzCPRBMTdasRR0DCcGFy7fpJvL4tY4pds5JT7hItbFf1QuJ38UJ4HIJ6
         uHes07PNFXwHEqH2opYGRnKaMC+Jfk3SCEh7udsk1yPOQS9iIVXV0pyzXFp5cXKL0gwo
         Rek50kyaPJ03Jnr00yxWDCwmCkq2cfgDZgu/XXWPttphSWV4hZWXLfoFzzmxrLsxNaRk
         N+C12oybVcTTNc0h5DZcqFTNXq1eY8mi+pfRfur33R9qusT0AhAx1G4LjJLepP9zYK2x
         NUDg==
X-Gm-Message-State: ANhLgQ3jl1mQuoGAObkduLTN/yna4+MyyFfkHGz1ZJsxFMV6T2lcvwdV
        1aBEMCioQhIokITIUVScaOiRqQ==
X-Google-Smtp-Source: ADFU+vtS5ehGLxCEUNEx01AjWQCPaIOivLegew1i/z6iCJOeLXOM4UVmIMp8KMFPiE9hAtmvjmcsOw==
X-Received: by 2002:aed:37c3:: with SMTP id j61mr2627756qtb.284.1584399086746;
        Mon, 16 Mar 2020 15:51:26 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id 31sm838735qta.56.2020.03.16.15.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 15:51:25 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] remoteproc: clean up notification config
Date:   Mon, 16 Mar 2020 17:51:21 -0500
Message-Id: <20200316225121.29905-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange the config files for remoteproc and IPA to fix their
interdependencies.

First, have CONFIG_QCOM_Q6V5_MSS select QCOM_Q6V5_IPA_NOTIFY so the
notification code is built regardless of whether IPA needs it.

Next, represent QCOM_IPA as being dependent on QCOM_Q6V5_MSS rather
than setting its value to match QCOM_Q6V5_COMMON (which is selected
by QCOM_Q6V5_MSS).

Drop all dependencies from QCOM_Q6V5_IPA_NOTIFY.  The notification
code will be built whenever QCOM_Q6V5_MSS is set, and it has no other
dependencies.

Signed-off-by: Alex Elder <elder@linaro.org>
---
v2: - Fix subject line
    - Incorporate a change I thought I had already squashed

Dave,
    I noticed some problems with the interaction between the IPA and
    remoteproc configs, and after some discussion with Bjorn we came
    up with this, which simplifies things a bit.  Both Kconfig files
    are in net-next now, so I'm sending this to you.

    Two other things:
    - I will *not* be implementing the COMPILE_TEST suggestion until
      after the next merge window.
    - I learned of another issue that arises when ARM64 is built
      with PAGE_SIZE > 4096.  I intend to fix that in the next day
      or so.

      					-Alex

 drivers/net/ipa/Kconfig    | 2 +-
 drivers/remoteproc/Kconfig | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
index b8cb7cadbf75..9f0d2a93379c 100644
--- a/drivers/net/ipa/Kconfig
+++ b/drivers/net/ipa/Kconfig
@@ -1,9 +1,9 @@
 config QCOM_IPA
 	tristate "Qualcomm IPA support"
 	depends on ARCH_QCOM && 64BIT && NET
+	depends on QCOM_Q6V5_MSS
 	select QCOM_QMI_HELPERS
 	select QCOM_MDT_LOADER
-	default QCOM_Q6V5_COMMON
 	help
 	  Choose Y or M here to include support for the Qualcomm
 	  IP Accelerator (IPA), a hardware block present in some
diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 56084635dd63..ffdb5bc25d6d 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -128,6 +128,7 @@ config QCOM_Q6V5_MSS
 	select MFD_SYSCON
 	select QCOM_MDT_LOADER
 	select QCOM_Q6V5_COMMON
+	select QCOM_Q6V5_IPA_NOTIFY
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
 	help
@@ -169,9 +170,6 @@ config QCOM_Q6V5_WCSS
 
 config QCOM_Q6V5_IPA_NOTIFY
 	tristate
-	depends on QCOM_IPA
-	depends on QCOM_Q6V5_MSS
-	default QCOM_IPA
 
 config QCOM_SYSMON
 	tristate "Qualcomm sysmon driver"
-- 
2.20.1

