Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1005AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E13C320825
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VSI/i/VY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgEUN2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbgEUN2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:28:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF35C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:28:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id x1so8794434ejd.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PMQK+3WLgMeeHuMYX4OY8IdBlPdvrGSBUdMUAg90qrw=;
        b=VSI/i/VYlS6Qf6xzt4vUaC31mRMvFHSyaRUaZpNboeEQ5TSV0dwz+nG5FjSGw9R/Br
         jxsaXjESXxQnZemdZN8eo66EcwUpztft4LwGo6k4wSWGlOd2BiHODKWruug/89Twui0K
         7QtNaN2r9XZ8RNz3y8w8KDTU7LjZo5RpOChqm27kTtgYcSQuvQEiqeCSz+NP8tM7VNtN
         DcOZzw+f6adniFONs3u8Wk6GPKXuE5fqMAembdV0HfTRbxeF84JeA3ECA8k9+9CjEfDV
         LyK/3C3G/aBumi86SV3WndfirKrY60Y8xwhC13nS61Ym2HvUFnPaKw4BR380e/KwfiNz
         OoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PMQK+3WLgMeeHuMYX4OY8IdBlPdvrGSBUdMUAg90qrw=;
        b=TXmMiWOkA4JLaqsQ2MVZ2Z+ziQ+B7d7bbSSJtDpt1kv60EXVUFlxJpUqDpH496jLMQ
         oiCu9iz1PHloG4PntN8gPNQW1f1MMQyv+2RUuyzQU/PikosAqIYMk5b6rD7cMciMUMWe
         UVOUFvDSC3UzZH8mG9Nxr1c8bvUNI8vbmzPEHeMKfZxvytmUCb4D8s0jDAt/U1imRFTd
         aMC3p/KNLdLe1HNpm2JxVLAPU6OD5iSYm1PvXznVNtafKcjqIGbx7bNa4yW41oA5XMTC
         OmW59V1CKHx4iQtF4PhV7TSITPYBLBEsikTByX2ntHjxmYD2JTvyLonEIOBi4RKU1J4W
         EggA==
X-Gm-Message-State: AOAM530tbYrZeoSj2KKB7M6H5EBgG/hfNSPHHdbTImRCE2nU9WQ7Xt9m
        kWadnWb51I3U+32Aiw4L4mxdGA==
X-Google-Smtp-Source: ABdhPJySHieCQClv3MvdhiiKAz09ylapZ6SdvZ6J9R6+DeNuh6EVoBtx2AVE4C+ly7UrOiLTCEKSPA==
X-Received: by 2002:a17:906:84cf:: with SMTP id f15mr3472941ejy.185.1590067714453;
        Thu, 21 May 2020 06:28:34 -0700 (PDT)
Received: from localhost.localdomain (212-5-158-12.ip.btc-net.bg. [212.5.158.12])
        by smtp.gmail.com with ESMTPSA id lr21sm4980580ejb.117.2020.05.21.06.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 06:28:33 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 0/3] Venus dynamic debug
Date:   Thu, 21 May 2020 16:28:13 +0300
Message-Id: <20200521132816.31111-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is second version of the dynamic debug series.

Few things are changed since v1:

 * Rebased on current media-tree master
 * Added one more patch for SSR trigger debug file

regards,
Stan

Stanimir Varbanov (3):
  venus: Add debugfs interface to set firmware log level
  venus: Make debug infrastructure more flexible
  venus: Add a debugfs file for SSR trigger

 drivers/media/platform/qcom/venus/Makefile    |  2 +-
 drivers/media/platform/qcom/venus/core.c      |  5 ++
 drivers/media/platform/qcom/venus/core.h      |  8 +++
 drivers/media/platform/qcom/venus/dbgfs.c     | 57 +++++++++++++++++
 drivers/media/platform/qcom/venus/dbgfs.h     | 12 ++++
 drivers/media/platform/qcom/venus/helpers.c   |  2 +-
 drivers/media/platform/qcom/venus/hfi_msgs.c  | 30 ++++-----
 drivers/media/platform/qcom/venus/hfi_venus.c | 27 ++++++--
 .../media/platform/qcom/venus/pm_helpers.c    |  3 +-
 drivers/media/platform/qcom/venus/vdec.c      | 63 +++++++++++++++++--
 drivers/media/platform/qcom/venus/venc.c      |  4 ++
 11 files changed, 180 insertions(+), 33 deletions(-)
 create mode 100644 drivers/media/platform/qcom/venus/dbgfs.c
 create mode 100644 drivers/media/platform/qcom/venus/dbgfs.h

-- 
2.17.1

