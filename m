Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDA1C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 17:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D872078E
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 17:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="PQI3pEBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgIERlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 13:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbgIERkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 13:40:09 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C189FC061247
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 10:40:07 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id 19so5686427qtp.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0O2sDN9MRUJx80UJH/oPfzt4dGApmPFTm8Og0trLMlM=;
        b=PQI3pEBu3s9c3wGVmIuNH334mS4Xc4eJzP8j71PrrLcxVfR5EeZBMcR+Auusaw6/Ff
         1Fw+D1h5tmrw410p9aWH+jF5Z6dnxjbIEeE8J+In0S47NcWyOr0vBighN1vBS3/I+N8t
         n9VYeGfCxt7F4CbUBDAUk9DlIoEz+kJfWhdIGY/EY2XPGAsDrKhZQlUhDEf/ez9cb9Z0
         +hIc9YK3pnmY/ms0/Uo1h0c7mEiEpKJx0wPTUtky8whMSvqzRf3vJ0tXk2/adb+V0Xkl
         nyEaTca83iCgVUT5X2KZzNhHyEgCmexoxmyxXY5r6kPXh9lsiSd/W+eN1IAo++f2Wkiy
         iW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0O2sDN9MRUJx80UJH/oPfzt4dGApmPFTm8Og0trLMlM=;
        b=k0sqXS4wga6t/gfJ0g7JFoeIhNxBJhkRWIakCp7kOA3UJLi2N1encHAu3ihq5oYgk8
         8VI8pAwbJY8/1tSRs0gL/yEZFfhCCBjVbGfAmab4fqiJ8dF05U52VCXrx/GA1aeII7m/
         ct0LYNeuaxbU8PLk2gOTQQE2sx/l1zAis/GYzNjNsYly26yza9FLWOH9J169Rl4Q4b1v
         lXo0wQIFP3BlpcKE3eGpOLzo9Ka53J2fWCG9QPv5NxUOTpiqnFZPKN/YPLvPSh04Yoga
         UCoz6nd5JQZA3S7cnz81ZBz9+d01iHacWjCM+n8nVjeER07o1lyiIeVCocHoLLxlzyeZ
         K5Fw==
X-Gm-Message-State: AOAM531TQTFOShq7BRuBVcvdkrXmfolupMlzAt0inc1K0yF9c5evSNwK
        YyBfX1jzuq/P21/4yqA9pE+xRQ==
X-Google-Smtp-Source: ABdhPJxvu7IqOsyVda774F6SOjLfLez3tafKaihOLf6twPF1uFQYTPqcfzR9nDz531vmBmKxjwOt6w==
X-Received: by 2002:aed:2d06:: with SMTP id h6mr14027558qtd.301.1599327605930;
        Sat, 05 Sep 2020 10:40:05 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id k22sm4612076qkk.13.2020.09.05.10.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 10:40:05 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        alsa-devel@alsa-project.org (moderated list:SOUNDWIRE SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/4] soundwire: qcom: fix abh/ahb typo
Date:   Sat,  5 Sep 2020 13:39:02 -0400
Message-Id: <20200905173905.16541-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200905173905.16541-1-jonathan@marek.ca>
References: <20200905173905.16541-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function name qcom_swrm_abh_reg_read should say ahb, fix that.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 915c2cf0c274..d1e33ef1afac 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -114,7 +114,7 @@ struct qcom_swrm_ctrl {
 
 #define to_qcom_sdw(b)	container_of(b, struct qcom_swrm_ctrl, bus)
 
-static int qcom_swrm_abh_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
+static int qcom_swrm_ahb_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
 				  u32 *val)
 {
 	struct regmap *wcd_regmap = ctrl->regmap;
@@ -754,7 +754,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	if (dev->parent->bus == &slimbus_bus) {
-		ctrl->reg_read = qcom_swrm_abh_reg_read;
+		ctrl->reg_read = qcom_swrm_ahb_reg_read;
 		ctrl->reg_write = qcom_swrm_ahb_reg_write;
 		ctrl->regmap = dev_get_regmap(dev->parent, NULL);
 		if (!ctrl->regmap)
-- 
2.26.1

