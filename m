Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671F9C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF8F2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qzK0hDhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgCDP6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:58:25 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34550 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388019AbgCDP6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:58:24 -0500
Received: by mail-lj1-f195.google.com with SMTP id j19so322958lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 07:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=U2afUUo7gcqKGsZXm1132Z2DinxFoznPEB9ahOfUs5k=;
        b=qzK0hDhWmDi+wb9g1tsq8Vo5sOBJTKo4poMC642is7FDaHHY4CS4jN9R0281x/wl09
         +fj8oA2vifprD7EudIOKS9bTNeGAUeZp4pIN1hkCunkV7mCBMdlg/TNgSWY6pqCzY39D
         CJJ+ocA4d6uPBooiF1JT6sz/DrFIUXLdp3WheLBY5l1eS5BMyxKyjJgn+Di9PyQ+Hwku
         6w4h7gei5ClbyOut1K4C1Ngo9l2UL//7RE3FUveNqXPM6UnOS/PdWjGQXp+30ToOWM2a
         Po2HUBnz+l9fDhn9/KvP+KwUTwZj/o/Lhw4Sq6DWcsCteEVceLZh4fIZuILnhaPyRZ+g
         j1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U2afUUo7gcqKGsZXm1132Z2DinxFoznPEB9ahOfUs5k=;
        b=NHmAFtIKyUGW/b6SfDSxFrm8UreXR96n5nzc2JHk17sUtm6aPto+b9FyflTW1AHhgG
         /w0O1ISWucMIWLNJuh4qeqfWV6ovVRe16IG0sLxUzvA856R0arnxWKJv6AYnkKgXDvAo
         DV+lNQnu0Ji9ZCvsVrRSvwwHmpuP1PGSxUuI2dQ1SbwwOEl3WX9TfFi/SCoF9OQHTxOn
         bJezYCAWAG7qxXIvE/KZh9NeQ8rTnX6Lqvs98tEnXsRhXjhTIHyGgh4OE0/7T1MZs8Fe
         w4d3/lm3yKOVihYFgXi622ZXTzLklYnMxhCkeLq4t/GGThT2rgtXCUxzEgMH0nN/oLJ9
         z8ew==
X-Gm-Message-State: ANhLgQ14goomKkua+MmCt6x/b1wnVGwxbiRBs+v9U/AGApbV14OfOg9M
        LbxuQYRYlIB0PfiAUcUeEcZbjvVPXGE=
X-Google-Smtp-Source: ADFU+vsVg5RJIaMPwnWAYk62YemrpgFiO40xq3WzGuOXCGINg04alWqT3DGb5/ui1ePPvjmIW5XPjg==
X-Received: by 2002:a2e:a486:: with SMTP id h6mr2300591lji.202.1583337501273;
        Wed, 04 Mar 2020 07:58:21 -0800 (PST)
Received: from localhost.localdomain ([94.155.124.210])
        by smtp.gmail.com with ESMTPSA id 67sm10531217ljj.31.2020.03.04.07.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:58:20 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Elliot Berman <eberman@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] venus: firmware: Ignore secure call error on first resume
Date:   Wed,  4 Mar 2020 17:58:09 +0200
Message-Id: <20200304155809.19637-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the latest cleanup in qcom scm driver the secure monitor
call for setting the remote processor state returns EINVAL when
it is called for the first time and after another scm call
auth_and_reset. The error returned from scm call could be ignored
because the state transition is already done in auth_and_reset.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/firmware.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index de6812fb55f4..8801a6a7543d 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -44,8 +44,14 @@ static void venus_reset_cpu(struct venus_core *core)
 
 int venus_set_hw_state(struct venus_core *core, bool resume)
 {
-	if (core->use_tz)
-		return qcom_scm_set_remote_state(resume, 0);
+	int ret;
+
+	if (core->use_tz) {
+		ret = qcom_scm_set_remote_state(resume, 0);
+		if (resume && ret == -EINVAL)
+			ret = 0;
+		return ret;
+	}
 
 	if (resume)
 		venus_reset_cpu(core);
-- 
2.17.1

