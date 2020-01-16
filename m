Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F11AC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CC9206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200791;
	bh=QpYERrgkh0whBg/uo4s9zBgACzT9vkRLbjjTrgrqeqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rgf8EaAVU7+v7kxe/+qLtH0G9OkeYyDG8AGPIZ5lJHfBtwTmhzphpRPa8rhEXF8mh
	 NdDM71kCm8lFTn+vZy/vBylAnrieJrghBNU05kKi5c5r1qf0Gk/gKjNoXr/iaR6RiB
	 CI1Hysk+U9gZY+oWxUIrFy9Dj+ajKqitJmyAbaWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437131AbgAPSxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:53:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389366AbgAPRIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:08:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64AC324653;
        Thu, 16 Jan 2020 17:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194497;
        bh=QpYERrgkh0whBg/uo4s9zBgACzT9vkRLbjjTrgrqeqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3mrYiYH2o6BywU3GFH20EnQMN990kQTrDb7ctAhgwW/iyj/bnSc7GZ3SuSPqLb4p
         33kdMV/sDKHUaOf7A+IV96ZqLK8CYXc03jYlxwlnzqgNv1nQ5I2Oi5Eiu1uN1SgaHH
         FFkdMQyUZIDFzbsF9km7wlVuncFiLPF3JH2/wuR0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 394/671] cpufreq: brcmstb-avs-cpufreq: Fix initial command check
Date:   Thu, 16 Jan 2020 12:00:32 -0500
Message-Id: <20200116170509.12787-131-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 22a26cc6a51ef73dcfeb64c50513903f6b2d53d8 ]

There is a logical error in brcm_avs_is_firmware_loaded() whereby if the
firmware returns -EINVAL, we will be reporting this as an error. The
comment is correct, the code was not.

Fixes: de322e085995 ("cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Markus Mayer <mmayer@broadcom.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index e6f9cbe5835f..6ed53ca8aa98 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -446,8 +446,8 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
 	rc = brcm_avs_get_pmap(priv, NULL);
 	magic = readl(priv->base + AVS_MBOX_MAGIC);
 
-	return (magic == AVS_FIRMWARE_MAGIC) && (rc != -ENOTSUPP) &&
-		(rc != -EINVAL);
+	return (magic == AVS_FIRMWARE_MAGIC) && ((rc != -ENOTSUPP) ||
+		(rc != -EINVAL));
 }
 
 static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
-- 
2.20.1

