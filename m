Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFF3C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 10:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBD1A20720
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 10:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BRI7EJNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgGLKG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 06:06:58 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6374 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGLKG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 06:06:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0ae0870000>; Sun, 12 Jul 2020 03:06:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 12 Jul 2020 03:06:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 12 Jul 2020 03:06:57 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 12 Jul
 2020 10:06:55 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 12 Jul 2020 10:06:55 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.75.246]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f0ae0be0000>; Sun, 12 Jul 2020 03:06:55 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 2/2] cpufreq: tegra186: Simplify probe return path
Date:   Sun, 12 Jul 2020 11:06:45 +0100
Message-ID: <20200712100645.13927-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200712100645.13927-1-jonathanh@nvidia.com>
References: <20200712100645.13927-1-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594548361; bh=nz3cJSjF3NMjq5LmbqTUriy0lkrKQK3j38oB5/xDGQU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=BRI7EJNbWMEaprvOwmA+ve/vgPKNWxdyeWYk921IJPDQTqaXCLiEEGqju8ls8fza8
         uwBsUQEtQBEd6eufardF4yEE1vAOWvdTzYgpDYt+Vd2rM6TweEVVhMMdgQAUm4j4XZ
         6QyDIc2nWnRyjXoKchlsKcyzT7FzzC1XaEeVrhur0fQ4yrSRi5BeDdTY97Esco0bWG
         qsjFWeNMScNu64vSO0nmFNYg9qlOSxJ3qWD5N4X1gay53iQM54W74nT7ahpaaKZRVA
         wWYw7+jrUokoXrUfb+B5/kWBI3a/jKqp318yW0IeNRcvSJ1uIEL708x160n1F+J6f1
         RYliZWjay2bxQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We always put the reference to BPMP device on exit of the Tegra186
CPUFREQ driver and so there is no need to have separate exit paths
for success and failure. Therefore, simplify the probe return path
in the Tegra186 CPUFREQ driver by combining the success and failure
paths.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/cpufreq/tegra186-cpufreq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index c44190ce3f03..bf8cab357277 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -231,15 +231,9 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
 		}
 	}
 
-	tegra_bpmp_put(bpmp);
-
 	tegra186_cpufreq_driver.driver_data = data;
 
 	err = cpufreq_register_driver(&tegra186_cpufreq_driver);
-	if (err)
-		return err;
-
-	return 0;
 
 put_bpmp:
 	tegra_bpmp_put(bpmp);
-- 
2.17.1

