Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48FDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB745217D8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580363;
	bh=Sl/PYpXNg++EVQUk+AQqR0ej8vbmve0/ub7u9lPRBMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qTmNQ4sXWqIKLu9WuHUVTKKzaAv/9ghqEeIBxGZSQXVt58o0RV7TN9c9b1lxMQo2e
	 d65fRaGvAyGBt5E5xnOzmVMej9BHhnBf3wNBPttQankF6BNilsWNMotZfGcevoPYMp
	 EY4UGhhdLHpUrxsUEDjp2xOtOkAMw8+0Nlbu127k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404265AbgFSP0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:26:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393184AbgFSPXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:23:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E44282158C;
        Fri, 19 Jun 2020 15:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580209;
        bh=Sl/PYpXNg++EVQUk+AQqR0ej8vbmve0/ub7u9lPRBMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vBKLiG/sJpdRokNCEcX0NWQUojNRIbWMfiKw70xao10KAi/kIqbtpPSm+xHhK1wzm
         u7Y3nuxztWIRXdPVNdClA1uVWkZIPbkcxyexWKJM1raq2qqlxx6VrkVEVZBpwo+2J8
         VRoi75AdMxDxjNmsALaz6FPe9KSS6yDWlhCul12o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ansuel Smith <ansuelsmth@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 146/376] cpufreq: qcom: fix wrong compatible binding
Date:   Fri, 19 Jun 2020 16:31:04 +0200
Message-Id: <20200619141717.242087123@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ansuel Smith <ansuelsmth@gmail.com>

[ Upstream commit 2dea651680cea1f3a29925de51002f33d1f55711 ]

Binding in Documentation is still "operating-points-v2-kryo-cpu".
Restore the old binding to fix the compatibility problem.

Fixes: a8811ec764f9 ("cpufreq: qcom: Add support for krait based socs")
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index a1b8238872a2..d06b37822c3d 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -277,7 +277,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	if (!np)
 		return -ENOENT;
 
-	ret = of_device_is_compatible(np, "operating-points-v2-qcom-cpu");
+	ret = of_device_is_compatible(np, "operating-points-v2-kryo-cpu");
 	if (!ret) {
 		of_node_put(np);
 		return -ENOENT;
-- 
2.25.1



