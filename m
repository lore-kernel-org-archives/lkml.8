Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2E4C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 17:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 992D92078E
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 17:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="jAX0shsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgIERkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 13:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbgIERkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 13:40:12 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A81C061251
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 10:40:08 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id y11so1093218qtn.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gCuchGSyeN1SA4c28kpGChZYxpEctYzHgQAHlgn61ZY=;
        b=jAX0shsQRBi8WwQiwWenimkMPM+JLgv8FYxLya1CKoQSuwc6jUwz9RwHz+pEnoIL2q
         9kGXSYgaDZrH0Wkkx+Ufc79W0ByqnBlqByqTcz+KZARiExXjzW4FhNK6Zvm/EvjZLf6+
         l2bti/wH7Uu64/ak9oJ288mcso3jkdCGH3b2IMyTPUj70J0LHTctw85xs82V0eiJRcKb
         E87tkV6eDeM/aTQOvzZ7+7SRkqIFqPX54w7qcAWsd44l+XyywcK48wgQh85prip1qOl0
         1K4ztZFzkJEXPRPHwpGzLUi2LMS2z8O3nh+gaG+uO1YmkxYvnHC4CZAnLNd5kCxuEsYo
         I4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gCuchGSyeN1SA4c28kpGChZYxpEctYzHgQAHlgn61ZY=;
        b=kugGLPPG9nrv9+e3yOn+QjW+cfdTuDN3z7Ayu6yqQXM7T1s5rh4gWmRblKr9QJYiOx
         4zW2z7O85US/oYKpwMH8VJcvh8eXjruL6JrAcxCfNDgBYOAq5BcZrV7sWOWkWgdzbb0R
         aIa1hdcZA2d9VYV5dQsfCJCeutIGUzqrSFGuDaEK5+AFuRS/dDGoFqWQDypqCnGAwRZQ
         Z2ZFK4h5txNkaanpQTkJDsRGx0zp/thyBrMLbKxIuGp+9lnKeQnenoByPDwCz0TjS9+3
         1QyYFG3Ms6nqybc97CL1euGZB5nfmWbfYR7UBkgnBOd58Kj0tSig60/gSONUH+eNv79X
         nsCw==
X-Gm-Message-State: AOAM5314T5MpXYCD5J/GiQ6xWLAhHaT/0IAJM4NdYxaV4B4+br3aViRn
        1mp3kM4y+p2YFkmb55SV6Y8GhQ==
X-Google-Smtp-Source: ABdhPJwuhACwry7xvRE2wBQ9naoMrPAAX6O0+ahqxxrxKUd9wiHRK3QwKSBHcf43LGWu25mqzk01FA==
X-Received: by 2002:ac8:4906:: with SMTP id e6mr7514712qtq.360.1599327607134;
        Sat, 05 Sep 2020 10:40:07 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id k22sm4612076qkk.13.2020.09.05.10.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 10:40:06 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        alsa-devel@alsa-project.org (moderated list:SOUNDWIRE SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/4] soundwire: qcom: avoid dependency on CONFIG_SLIMBUS
Date:   Sat,  5 Sep 2020 13:39:03 -0400
Message-Id: <20200905173905.16541-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200905173905.16541-1-jonathan@marek.ca>
References: <20200905173905.16541-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may be used without slimbus, so don't depend on slimbus.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/soundwire/Kconfig | 2 +-
 drivers/soundwire/qcom.c  | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index fa2b4ab92ed9..f83d02c9c60a 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -33,7 +33,7 @@ config SOUNDWIRE_INTEL
 
 config SOUNDWIRE_QCOM
 	tristate "Qualcomm SoundWire Master driver"
-	depends on SLIMBUS
+	imply SLIMBUS
 	depends on SND_SOC
 	help
 	  SoundWire Qualcomm Master driver.
diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index d1e33ef1afac..6401ad451eee 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -753,7 +753,11 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	if (!ctrl)
 		return -ENOMEM;
 
+#if IS_ENABLED(CONFIG_SLIBMUS)
 	if (dev->parent->bus == &slimbus_bus) {
+#else
+	if (false) {
+#endif
 		ctrl->reg_read = qcom_swrm_ahb_reg_read;
 		ctrl->reg_write = qcom_swrm_ahb_reg_write;
 		ctrl->regmap = dev_get_regmap(dev->parent, NULL);
-- 
2.26.1

