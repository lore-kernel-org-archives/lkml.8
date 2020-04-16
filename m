Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D5DC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78AAE214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587052006;
	bh=Ikc0AYvLKTZZv4VYpqWl7cUBvSOW5ZMNjoOQKDLh2aA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sCauxb/mJGBIlEqtJENqf/MmmGnuimLmVIE/YgPUdQ5Dsvvx1Uifpx600lFVI7A1F
	 IkOh0FhdBKe1W4mm8RDpluv2DTUjz/XUB3rKRRchZUtgEJiqecU5Ap01RjPb5oRtM9
	 /y6BngEYD0TTjfug5fgMyUHeNmXKXtSqyfv8qQOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896536AbgDPPqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896910AbgDPNeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:34:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D46F7221F4;
        Thu, 16 Apr 2020 13:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044057;
        bh=Ikc0AYvLKTZZv4VYpqWl7cUBvSOW5ZMNjoOQKDLh2aA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dRys4uyTs8ISZdxcTERpCdFCwTYJR+w01HRdl1qSzsWL/MXYo0yFMrs1AE0YrTw6r
         AiN/TX7ghjyfZEO3F5LVskTx6tMWLpuxhMqpNr2srYibhCqcM9dxd1grCJfjVN7b4z
         fWjBc/wd5Z5pRb1g3tSyV0N1OXD3s9ANWvselq2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 062/257] cpufreq: imx6q: fix error handling
Date:   Thu, 16 Apr 2020 15:21:53 +0200
Message-Id: <20200416131333.708145163@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit 3646f50a3838c5949a89ecbdb868497cdc05b8fd ]

When speed checking failed, direclty jumping to put_node label
is not correct. Need jump to out_free_opp to avoid resources leak.

Fixes: 2733fb0d0699 ("cpufreq: imx6q: read OCOTP through nvmem for imx6ul/imx6ull")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 1fcbbd53a48a2..edef3399c9794 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -381,23 +381,24 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		goto put_reg;
 	}
 
+	/* Because we have added the OPPs here, we must free them */
+	free_opp = true;
+
 	if (of_machine_is_compatible("fsl,imx6ul") ||
 	    of_machine_is_compatible("fsl,imx6ull")) {
 		ret = imx6ul_opp_check_speed_grading(cpu_dev);
 		if (ret) {
 			if (ret == -EPROBE_DEFER)
-				goto put_node;
+				goto out_free_opp;
 
 			dev_err(cpu_dev, "failed to read ocotp: %d\n",
 				ret);
-			goto put_node;
+			goto out_free_opp;
 		}
 	} else {
 		imx6q_opp_check_speed_grading(cpu_dev);
 	}
 
-	/* Because we have added the OPPs here, we must free them */
-	free_opp = true;
 	num = dev_pm_opp_get_opp_count(cpu_dev);
 	if (num < 0) {
 		ret = num;
-- 
2.20.1



