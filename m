Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15A2C55189
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 00:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A0820776
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 00:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bt1mUO+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgDWAiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 20:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726006AbgDWAiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 20:38:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5E0C03C1AB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 17:38:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d24so1632335pll.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 17:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75TUGWxKMG+i7tFa2VqXTsbczTpvn8gAWE0prn7/ZWo=;
        b=Bt1mUO+l/1mVfkOUUYZ/vPLooOPPe2yy40kGK8VcjvtAzsSqTHrRzK2SrxdZfESL25
         xIhyrTUVQOpkLdo2Cy3uiDoEjf3Jbz7eT1wgoK9POxngD3LR5FziEYCRZYgW6NJY6GGw
         5Ud1iXBI0aLIgsvXnrO9Y8T07eEsOCqRd2cY1a3kpqOc34nnZoNmeVqri1MpehT38tTX
         mKNE+EGdlZ3oySSoIghIScraOGmz/RuK4j20yUW7xf3Ip2aDehUuteE3XSC4Z0HMKw/L
         IAasCCd0aLdN18dqDWj0SyEPxg+qjZvTRVmlS3aDZvHSjsTdPpuJqqGZxuROsUD9Fcjx
         wvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75TUGWxKMG+i7tFa2VqXTsbczTpvn8gAWE0prn7/ZWo=;
        b=emnoNHnK6z45ffwp/t0RZ/97r7JGHNfjlSB4CQiR8VUJpMgopw9zOVyzB2PR4X2ubt
         11veDs7uY0OTr1XrIgUHLzpKWnr90oaxPWuC8k7yJMqd3PRAcuxWnyNpmPrBfylvjPLv
         spRMCVHyHTqfyeDCFSRVMztUEF/N0mrhn2ocWb1ZIybYJL7OCWJt0VOrj6yNL78o7oja
         nEj3qwPVPf71cL4bjqLum2uHD63Q/LLAQ8jkoP6V9CVQXNWaOVzGFYfWeR9+zH/DVc3m
         6rOSBd4r45jVjcjBDMVQxmzzR0p37vlD4I3jXIoN9U1ZcwTI8EmdoKZ7n204lbpCD0FF
         niUQ==
X-Gm-Message-State: AGi0PuZaQUDFCgXtDQ+q6t3gyMgs49ZzXQkMb+hyrze9x+mNGg1Zy+cg
        X9z31UyHeXlwZw8HILxqbaYtuQ==
X-Google-Smtp-Source: APiQypKajNV82QXE5K2iKfsEJ0r4+uN55Qcwur5XRKTlxsgeo77a7Pr94QQHDYOrM+bNQLwFdLPljQ==
X-Received: by 2002:a17:902:b187:: with SMTP id s7mr1435976plr.0.1587602286693;
        Wed, 22 Apr 2020 17:38:06 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 6sm432225pgz.0.2020.04.22.17.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 17:38:05 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Chris Lew <clew@codeaurora.org>, Sibi <sibis@codeaurora.org>,
        Siddharth Gupta <sidgup@codeaurora.org>
Subject: [PATCH 0/4] rpmsg: Refactor Qualcomm glink_ssr
Date:   Wed, 22 Apr 2020 17:37:32 -0700
Message-Id: <20200423003736.2027371-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow for wider use of the SSR notifier in remoteproc's qcom_common
this series internalizes the notifier chain used by glink_ssr. To simplify the
Kconfig dependencies it also moves the glink_ssr implementation to rpmsg and
merges it with qcom_glink_native, as these do go hand in hand.

Bjorn Andersson (4):
  remoteproc: qcom: Pass ssr_name to glink subdevice
  soc: qcom: glink_ssr: Internalize ssr_notifiers
  rpmsg: glink: Integrate glink_ssr in qcom_glink
  arm64: defconfig: Remove QCOM_GLINK_SSR

 arch/arm64/configs/defconfig                  |  1 -
 drivers/remoteproc/qcom_common.c              | 17 ++++++++++-
 drivers/remoteproc/qcom_common.h              |  5 +++-
 drivers/remoteproc/qcom_q6v5_adsp.c           |  2 +-
 drivers/remoteproc/qcom_q6v5_mss.c            |  2 +-
 drivers/remoteproc/qcom_q6v5_pas.c            |  2 +-
 drivers/rpmsg/Kconfig                         |  6 ++--
 drivers/rpmsg/Makefile                        |  3 +-
 .../glink_ssr.c => rpmsg/qcom_glink_ssr.c}    | 28 +++++++++++++------
 drivers/soc/qcom/Kconfig                      |  9 ------
 drivers/soc/qcom/Makefile                     |  1 -
 include/linux/rpmsg/qcom_glink.h              |  3 +-
 12 files changed, 49 insertions(+), 30 deletions(-)
 rename drivers/{soc/qcom/glink_ssr.c => rpmsg/qcom_glink_ssr.c} (83%)

-- 
2.24.0

