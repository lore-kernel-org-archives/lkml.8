Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD0CC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2784124653
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194339;
	bh=9Rn4GRxm6QBiuv9AcsOIb6ehnEHzVQPYhQyM2Vj24mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ff9If3RSkiLhn6bTygVsdmE+khm5gY3GDuDPkJlb/e7gjTm3julwPO58fcPT2BCgC
	 gRUEa0Vp8FZKSteGTeX3a8OwyQwYN1XZCMYXlSWNjLLYU35WYji5Uuf51NXVMxaSf1
	 z/h3bkgR7WxPOluxb/7K37yuU7fsV6R0bure/jSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388771AbgAPRFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:05:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:34082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388656AbgAPRFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:05:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA9AC20730;
        Thu, 16 Jan 2020 17:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194324;
        bh=9Rn4GRxm6QBiuv9AcsOIb6ehnEHzVQPYhQyM2Vj24mQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x1rUvPM7F7zTHEUjFprHnEUz+CEpcrsu0TvVtab3+Bi1EO0j5+/VtVE0kAFw2QSHJ
         ph7Q9WUeZyJHELT3a1j1du7dJHdp9TeFNHfNc0GsHb41JY99FCLUasd8J9teaY/0n5
         BdZqwqDkjCHfasLBNkz86/YeQnVtMejeT/IzIHsM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Li Yang <leoyang.li@nxp.com>, Sasha Levin <sashal@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 273/671] soc/fsl/qe: Fix an error code in qe_pin_request()
Date:   Thu, 16 Jan 2020 11:58:31 -0500
Message-Id: <20200116170509.12787-10-sashal@kernel.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 5674a92ca4b7e5a6a19231edd10298d30324cd27 ]

We forgot to set "err" on this error path.

Fixes: 1a2d397a6eb5 ("gpio/powerpc: Eliminate duplication of of_get_named_gpio_flags()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/fsl/qe/gpio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/gpio.c b/drivers/soc/fsl/qe/gpio.c
index 819bed0f5667..51b3a47b5a55 100644
--- a/drivers/soc/fsl/qe/gpio.c
+++ b/drivers/soc/fsl/qe/gpio.c
@@ -179,8 +179,10 @@ struct qe_pin *qe_pin_request(struct device_node *np, int index)
 	if (err < 0)
 		goto err0;
 	gc = gpio_to_chip(err);
-	if (WARN_ON(!gc))
+	if (WARN_ON(!gc)) {
+		err = -ENODEV;
 		goto err0;
+	}
 
 	if (!of_device_is_compatible(gc->of_node, "fsl,mpc8323-qe-pario-bank")) {
 		pr_debug("%s: tried to get a non-qe pin\n", __func__);
-- 
2.20.1

