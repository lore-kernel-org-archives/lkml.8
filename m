Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AF3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7684820885
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445472;
	bh=Z41N+cIfPZq6+16FIiby5DDwyV51obckIwKxYJuq+4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fkhWTDRy4ZblRtz50MrFMUmMPXi1IIcXeZXOGS1CnM0fuiVbbXVYhzQRkCvQcgKMK
	 ZdjnLJVoTWJDxHjQwAdOBDSQv7KdzJOsnxYuUAzBU+fdxD5Bb9hv8CZS2HWzdK9Heq
	 ptKrItHow0vjPfxBy38MZt0kGo05fZ0NQfZJlckQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbgFRB5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731349AbgFRBZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:25:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86387221EB;
        Thu, 18 Jun 2020 01:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443505;
        bh=Z41N+cIfPZq6+16FIiby5DDwyV51obckIwKxYJuq+4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uu94Fvic27skO+Ng7LieYt2IWXloXekIPgJSFkYwQnwc68/LHUdscKWi5fYMdwFOj
         qWltOfH74NChIOWP9mLmxV1CS18vu7Am9ezesV5ekyGlwb7BmHyBUgV6drZPC3ZOnB
         kGKbDBbyXAWLL7nw/SmPbQbQL3YqEs3xHlK+UHaI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 130/172] of: Fix a refcounting bug in __of_attach_node_sysfs()
Date:   Wed, 17 Jun 2020 21:21:36 -0400
Message-Id: <20200618012218.607130-130-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 8a325dd06f2358ea0888e4ff1c9ca4bc23bd53f3 ]

The problem in this code is that if kobject_add() fails, then it should
call of_node_put(np) to drop the reference count.  I've actually moved
the of_node_get(np) later in the function to avoid needing to do clean
up.

Fixes: 5b2c2f5a0ea3 ("of: overlay: add missing of_node_get() in __of_attach_node_sysfs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/kobj.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
index c72eef988041..a32e60b024b8 100644
--- a/drivers/of/kobj.c
+++ b/drivers/of/kobj.c
@@ -134,8 +134,6 @@ int __of_attach_node_sysfs(struct device_node *np)
 	if (!name)
 		return -ENOMEM;
 
-	of_node_get(np);
-
 	rc = kobject_add(&np->kobj, parent, "%s", name);
 	kfree(name);
 	if (rc)
@@ -144,6 +142,7 @@ int __of_attach_node_sysfs(struct device_node *np)
 	for_each_property_of_node(np, pp)
 		__of_add_property_sysfs(np, pp);
 
+	of_node_get(np);
 	return 0;
 }
 
-- 
2.25.1

