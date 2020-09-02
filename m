Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B53C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE33207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bCBFH+rV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIBIwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgIBIwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 04:52:21 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7308C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 01:52:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id a8so1985519plm.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 01:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w3VbD7LbrSIV+AJhlX9wGvBGH7WMn863FXViRRDiMM4=;
        b=bCBFH+rVPID9ii0sH5CtTpsTmP3uO1pnii5mbbyYZCsdeRY9cVTRSgJ2SDfFbmBeFv
         VoQ2HIF0sinQ2qjlxZCckhUePRL+hIUe0W0ZAqBqKC35HETCBYZTpFBasWVjYJMSll5y
         Jik6wgaxs4frbjmWajns1AmZYL0HBhZpC9v2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w3VbD7LbrSIV+AJhlX9wGvBGH7WMn863FXViRRDiMM4=;
        b=Ijr/NKXDdxhb6+S3jtX5ysptBjNa4bfsy4G6Lv1hckDqQlo0W+ebZ1rQPH9/wYqDgf
         4VBlMvjCqMIGHALYhp+6LLklo/JK5Pwun1CfbKt/8Sr0yt+o9miMhbBEyvUakr4cgUhF
         06jZy45AYb2HjdZGu25xThOUgFOZUvvLyTCHxTUsRZ3rXR3ZTGMEQ54MRhoIKnFj2IpF
         YVhF8ffcviMnzy8yZbNZCdEsofpah3TB6gl3v8KOhsPiaqUdjOtEdsGZK2gEy0SfiiDG
         i1Rujy4LHIfsVRb7Bsi2YdEPc2r0K8J35dlpo61QAcANfnKgIn2Fv7YO/zvKcRKPHhXN
         dcUQ==
X-Gm-Message-State: AOAM53239YutjO8VjV2QjJg8XtsQLfJQRix0LAWfHngyUeEQcY3UQqnV
        vrXo9KN/uQv/fZlTJJnN6ZTbqg==
X-Google-Smtp-Source: ABdhPJxKqtFkU/U9HA+gDoFaweJo/+5PSsuycPrw6yluyFQdgQr0IsbJb68L4DRa/jf4kZLEuEiISw==
X-Received: by 2002:a17:90b:796:: with SMTP id l22mr1381398pjz.199.1599036740488;
        Wed, 02 Sep 2020 01:52:20 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:eeb1:d7ff:fe57:b7e5])
        by smtp.gmail.com with ESMTPSA id x22sm4698693pfn.41.2020.09.02.01.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 01:52:19 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH RESEND] remoteproc: scp: add COMPILE_TEST dependency
Date:   Wed,  2 Sep 2020 17:51:59 +0900
Message-Id: <20200902085159.1392703-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will improve this driver's build coverage.

Reported-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
Hi Ohad, Bjorn,

As explained in
https://www.spinics.net/lists/linux-media/msg175991.html, we need this
patch in order to merge a driver series in the media tree. If that looks
ok to you, can we pull it in the media tree along with the series that
depends on it?

 drivers/remoteproc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index c6659dfea7c7..d1fcada71017 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -43,7 +43,7 @@ config INGENIC_VPU_RPROC
 
 config MTK_SCP
 	tristate "Mediatek SCP support"
-	depends on ARCH_MEDIATEK
+	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select RPMSG_MTK_SCP
 	help
 	  Say y here to support Mediatek's System Companion Processor (SCP) via
-- 
2.28.0.526.ge36021eeef-goog

