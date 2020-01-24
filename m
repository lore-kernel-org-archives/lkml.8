Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C157C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533D22075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864954;
	bh=g1bklclulOfUGGTkxLgElSyO7t5xiu/IgxxpDobmRbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fP7Sp39yRdUSaXUD7qXrwfoFDB4+GM8wMdIRDK58P2RM9toJlxeW89avYCs6+iMWs
	 AgH0i+rg6qdKr2nX8m/Tw+BR/aQjmhwIU6OTj7jj/g5amGnNUt/c4EKsbHoD0VnQGb
	 SqbnmMH29gz4U/fCk0IVK/a1l+kvkXuruy0Wh94k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391221AbgAXLWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:22:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:33946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391195AbgAXLW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:22:28 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80851206D4;
        Fri, 24 Jan 2020 11:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864948;
        bh=g1bklclulOfUGGTkxLgElSyO7t5xiu/IgxxpDobmRbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2lgaRbBDNVOImmJqI/mMKIyhjFWYuB8eoY1mwD2zuRwGv1laGSWy81j69z3RcCld
         Ua1xuu12NxLGCYe45OtlxpIVipV7t5CBvFRYsktoUN42YKdQtkJKfR+v5FoTfZMjwz
         aH44zrtUR6GIoqRotMURMXRVFChw4pI/6jp84JLI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 410/639] cpufreq: brcmstb-avs-cpufreq: Fix types for voltage/frequency
Date:   Fri, 24 Jan 2020 10:29:40 +0100
Message-Id: <20200124093138.404709035@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 4c5681fcc684c762b09435de3e82ffeee7769d21 ]

What we read back from the register is going to be capped at 32-bits,
and cpufreq_freq_table.frequency is an unsigned int. Avoid any possible
value truncation by using the appropriate return value.

Fixes: de322e085995 ("cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Markus Mayer <mmayer@broadcom.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 6ed53ca8aa980..77b0e5d0fb134 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -384,12 +384,12 @@ static int brcm_avs_set_pstate(struct private_data *priv, unsigned int pstate)
 	return __issue_avs_command(priv, AVS_CMD_SET_PSTATE, true, args);
 }
 
-static unsigned long brcm_avs_get_voltage(void __iomem *base)
+static u32 brcm_avs_get_voltage(void __iomem *base)
 {
 	return readl(base + AVS_MBOX_VOLTAGE1);
 }
 
-static unsigned long brcm_avs_get_frequency(void __iomem *base)
+static u32 brcm_avs_get_frequency(void __iomem *base)
 {
 	return readl(base + AVS_MBOX_FREQUENCY) * 1000;	/* in kHz */
 }
@@ -653,14 +653,14 @@ static ssize_t show_brcm_avs_voltage(struct cpufreq_policy *policy, char *buf)
 {
 	struct private_data *priv = policy->driver_data;
 
-	return sprintf(buf, "0x%08lx\n", brcm_avs_get_voltage(priv->base));
+	return sprintf(buf, "0x%08x\n", brcm_avs_get_voltage(priv->base));
 }
 
 static ssize_t show_brcm_avs_frequency(struct cpufreq_policy *policy, char *buf)
 {
 	struct private_data *priv = policy->driver_data;
 
-	return sprintf(buf, "0x%08lx\n", brcm_avs_get_frequency(priv->base));
+	return sprintf(buf, "0x%08x\n", brcm_avs_get_frequency(priv->base));
 }
 
 cpufreq_freq_attr_ro(brcm_avs_pstate);
-- 
2.20.1



