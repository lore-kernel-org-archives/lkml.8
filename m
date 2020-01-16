Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E04C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE84214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195338;
	bh=/+tlWGtQQlVArvWt2Onf8esOdt9YBNdy8vZHN0T9pU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J6ggYIi4JdYigdbS+0xs+rF9Y+G7HmnH1SYJteI7skwjpCwI5Aq4CGBYlqVyUU3C0
	 wHYtylMPlRf48XiJUT97UQFSQku7pJ2D2Tawt0SLAhCdDh/CF6Nvolj/Annzyf3L2A
	 AzA/cYY5Wl7BeBlAq8a6NJpBoc6oPqzJMeymI6CM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389709AbgAPRNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:13:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390779AbgAPRNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:13:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A039246AC;
        Thu, 16 Jan 2020 17:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194819;
        bh=/+tlWGtQQlVArvWt2Onf8esOdt9YBNdy8vZHN0T9pU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KJFiEYIiEc/m6QAQvVSn6FJV7kaYoxpy9rcoU+e0+RqLjsEUSJB69Qib2YKnLy+D8
         shMBWHLiWQqmSo0rQdTA/F4biG48WXDalwQEdKZ+KKIAnaFj4nNPzT90zvG7DKpKHB
         Ilr0Yyy0tvamoVAW9zYmkHqprtUd+GgLy85F0atc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <sashal@kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 624/671] ipmi: Fix memory leak in __ipmi_bmc_register
Date:   Thu, 16 Jan 2020 12:04:22 -0500
Message-Id: <20200116170509.12787-361-sashal@kernel.org>
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

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 4aa7afb0ee20a97fbf0c5bab3df028d5fb85fdab ]

In the impelementation of __ipmi_bmc_register() the allocated memory for
bmc should be released in case ida_simple_get() fails.

Fixes: 68e7e50f195f ("ipmi: Don't use BMC product/dev ids in the BMC name")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Message-Id: <20191021200649.1511-1-navid.emamdoost@gmail.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmi_msghandler.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 91f2d9219489..980eb7c60952 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -2965,8 +2965,11 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
 		bmc->pdev.name = "ipmi_bmc";
 
 		rv = ida_simple_get(&ipmi_bmc_ida, 0, 0, GFP_KERNEL);
-		if (rv < 0)
+		if (rv < 0) {
+			kfree(bmc);
 			goto out;
+		}
+
 		bmc->pdev.dev.driver = &ipmidriver.driver;
 		bmc->pdev.id = rv;
 		bmc->pdev.dev.release = release_bmc_device;
-- 
2.20.1

