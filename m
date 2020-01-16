Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3719C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E8924686
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193755;
	bh=pe9gi9seQl7hcW9P43+6bjO+7AKVzu18za24nVIwzT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hSnTsx82TpdpJM/2oucWUhFvFEkEC1egrFjs1XWoqUnqEjQzKkYMdstlWlsJ/OSyL
	 THq44zZym5wiNKf3A8CbOhoegFAU1QNh4HKLYd0c2i6+UjT4s3T3it9r5zBVs8c9wm
	 YJFt79E5eZ3O7jXvRGjgzbWQSbAJtt89NBe36VXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbgAPQzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:55:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:41046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733073AbgAPQzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:55:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A787D214AF;
        Thu, 16 Jan 2020 16:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193736;
        bh=pe9gi9seQl7hcW9P43+6bjO+7AKVzu18za24nVIwzT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iCvTdUf1f5/rwoQlS+84xfCo1D18fieMfjhijJJGVWcW6Jd8cM1thiWv0a200kPam
         /ZX9vAXXf+wbHUklEjNL5sBygk2y46e6yCFjTayhb0YO1uWxRYXk7ooyhp8sXGvIh2
         fC33AezEgTMba1UG0pPtKvL/92QhId7PeJ4vlQTA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 028/671] of: Fix property name in of_node_get_device_type
Date:   Thu, 16 Jan 2020 11:44:19 -0500
Message-Id: <20200116165502.8838-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit 5d5a0ab1a7918fce5ca5c0fb1871a3e2000f85de ]

Commit 0413bedabc88 ("of: Add device_type access helper functions")
added a new helper not yet used in preparation for some treewide clean
up of accesses to 'device_type' properties. Unfortunately, there's an
error and 'type' was used for the property name. Fix this.

Fixes: 0413bedabc88 ("of: Add device_type access helper functions")
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/of.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index d5a863c1ee39..dac0201eacef 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1001,7 +1001,7 @@ static inline struct device_node *of_find_matching_node(
 
 static inline const char *of_node_get_device_type(const struct device_node *np)
 {
-	return of_get_property(np, "type", NULL);
+	return of_get_property(np, "device_type", NULL);
 }
 
 static inline bool of_node_is_type(const struct device_node *np, const char *type)
-- 
2.20.1

