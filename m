Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFB5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F163520672
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PxSV06nJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgG3Jy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgG3Jy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:54:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DFEC0619D4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:54:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z18so20727248wrm.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4ubq+0N6t4zFwdqdaV7a4c0lcWwdgP8nONkvvrGpptQ=;
        b=PxSV06nJbz2Wlj5+mD9+D4WtvW+WritueOAK7eJVvPy7tD85/ybAbCCVxdUiXjbbUK
         ScuX7ajaXYqpKHm+AUXXdkDtAGpMJHWLbGEQTwNSSjsJZyBW4tZk+7+YQwH0E95askF+
         sc2fqR+q1vfK6m9pnv70O4ffrFaIbrOSsaO3tuTBmhOOFRXmF24IUNh0m5+rV31VDPEq
         /YvTti9nZt6jg7klOsBnMLwkc6+hoH8LQi17MrVNxsKuc0bTMW1MABI7Lx9POFSZ5JLB
         j8ZGwCnCwRYj3og1k5gy6B5giSW2cuSeT7u2uJ000I5L0oCE4GrnsU710W8lMuy5Vufm
         h7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4ubq+0N6t4zFwdqdaV7a4c0lcWwdgP8nONkvvrGpptQ=;
        b=Re2dj1HIO87jVPbeRcI7S+FC8jxXR6pGtXMN3oXd42lIt89TiloE1XUhZmcAIza2yc
         GhcIKWm78HFbdUPZ42/mxL+TneKwpnmZGjp5P5NLsHxwX5Aigk7sD9dX9IepCJ+dt/Zm
         L8anKs4k0z/HB67/b5l1viPLmcVcHZ/2haRD8PdfZp6E0A4WyeWg+ezuK3oUmoWDhtEx
         7gnFEdLvDutm/iublYXbdVwpz2dNMPDGUZldkpaMIUy4lE2cETpGGAsR16ntV/BAxPgH
         7a53P60BodcHrAl5Q7w2dOr9gEqcQlw6CloYNKPtd/14O9Dpyeggy6hjmkcbwRg6TBk3
         wYEw==
X-Gm-Message-State: AOAM533vmMfMqzJv9N0e+JVrt1OWXRv49leKIn6N8ZRHiAX9vdrILEQo
        1XRCn4MD1iyQp67AymjEebhmzA/YSFuW1A==
X-Google-Smtp-Source: ABdhPJz/1FPDcdLPnQfmmjxGfMlUz6eHMuyfbi/bHn38xXp8gJIV7CaRQ7aKFDXIjgL9rP5e9LYh4Q==
X-Received: by 2002:adf:e6cc:: with SMTP id y12mr24219838wrm.391.1596102864884;
        Thu, 30 Jul 2020 02:54:24 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id u1sm10623139wrb.78.2020.07.30.02.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 02:54:24 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     jim.cromie@gmail.com, Joe Perches <joe@perches.com>,
        Jason Baron <jbaron@akamai.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 0/3] Venus dynamic debug
Date:   Thu, 30 Jul 2020 12:53:47 +0300
Message-Id: <20200730095350.13925-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Changes in v5:
 * 1/3 - dropped dev_warn when set FW debug level - Greg KH
 * 3/3 - dropped pr_debug, and now group levels by prefix in dev_dbg

v4 can be fount at [1].

regards,
Stan

[1] https://www.spinics.net/lists/kernel/msg3550106.html

Stanimir Varbanov (3):
  venus: Add debugfs interface to set firmware log level
  venus: Add a debugfs file for SSR trigger
  venus: Make debug infrastructure more flexible

 drivers/media/platform/qcom/venus/Makefile    |  2 +-
 drivers/media/platform/qcom/venus/core.c      |  3 ++
 drivers/media/platform/qcom/venus/core.h      |  8 +++
 drivers/media/platform/qcom/venus/dbgfs.c     | 51 +++++++++++++++++++
 drivers/media/platform/qcom/venus/dbgfs.h     | 12 +++++
 drivers/media/platform/qcom/venus/helpers.c   |  2 +-
 drivers/media/platform/qcom/venus/hfi_msgs.c  | 18 +++----
 drivers/media/platform/qcom/venus/hfi_venus.c | 10 ++--
 .../media/platform/qcom/venus/pm_helpers.c    |  2 +-
 drivers/media/platform/qcom/venus/vdec.c      |  6 +--
 10 files changed, 96 insertions(+), 18 deletions(-)
 create mode 100644 drivers/media/platform/qcom/venus/dbgfs.c
 create mode 100644 drivers/media/platform/qcom/venus/dbgfs.h

-- 
2.17.1

