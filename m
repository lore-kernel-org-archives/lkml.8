Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7BFC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CE020792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="N7T8aAN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbgGVKdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:33:36 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:21657 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732120AbgGVKdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:33:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595414014; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=e1nXptN9Z0Jnt0YG3V7bShAkWJVfryvKmgHwdtz5DRY=; b=N7T8aAN3coOvE+ynl5sQcXFxK+0q9GWEYD947qxOtslyLcSgYm+S1vjq300Kt6ETF/Rc9cSu
 krBQ9EXNK0d9KywaWPaU+1ZLMPu84h5rdziRMihOP2nDnozxWilUYFouRh+Z5CGs2vkvFY0F
 YCN/wuy/aCxSHPS8m8asMH/IOPI=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f1815f35b75bcda60170c62 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 22 Jul 2020 10:33:23
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B3010C433AD; Wed, 22 Jul 2020 10:33:21 +0000 (UTC)
Received: from rohkumar-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 062F6C433B1;
        Wed, 22 Jul 2020 10:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 062F6C433B1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ajit Pandey <ajitp@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v4 08/12] include: dt-bindings: sound: Add sc7180-lpass bindings header
Date:   Wed, 22 Jul 2020 16:01:51 +0530
Message-Id: <1595413915-17867-9-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595413915-17867-1-git-send-email-rohitkr@codeaurora.org>
References: <1595413915-17867-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajit Pandey <ajitp@codeaurora.org>

Add header defining dai-id and mclk id for SC7180 lpass soc.

Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 include/dt-bindings/sound/sc7180-lpass.h | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 include/dt-bindings/sound/sc7180-lpass.h

diff --git a/include/dt-bindings/sound/sc7180-lpass.h b/include/dt-bindings/sound/sc7180-lpass.h
new file mode 100644
index 00000000..7d988f6
--- /dev/null
+++ b/include/dt-bindings/sound/sc7180-lpass.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_SC7180_LPASS_H
+#define __DT_SC7180_LPASS_H
+
+#define MI2S_PRIMARY	0
+#define MI2S_SECONDARY	1
+
+#define LPASS_MCLK0	0
+
+#endif /* __DT_APQ8016_LPASS_H */
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

