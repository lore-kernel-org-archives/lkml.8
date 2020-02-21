Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA3FC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D77206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582274558;
	bh=QeBSYpadQfSDA4Xgw0Sen4+eBJpHM7k+4D5WCwfz2ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j7ijvIV1NxAiExUVoG33PbKs+aAt9jbY/XCyDryPLPWT4uOQZbvyj7lPJuTsDfvpp
	 eygSjVKjUTnBeKXIG2d6wv+gD12vzIszcsxqiF2nwPINeUlZsb34qhSVCq8pssLkX1
	 mXiyZ1LT04z72mXERsBZgwDof4VAnKJOzUQimCZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgBUImh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:42:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:53660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729067AbgBUHy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:54:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E86020801;
        Fri, 21 Feb 2020 07:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271697;
        bh=QeBSYpadQfSDA4Xgw0Sen4+eBJpHM7k+4D5WCwfz2ps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AlTGsXQxAAXXwk9Jw0cSduLLeQ5V5fpupzBLIDrDBlZhotFED2d2AmBTVZnZEOGhP
         65VxOeWrMoTzEXC5qUJWmubB4ESW9pUgmqGFTos4Ccf2Le1/TXNYQMJo6SC4jr/Ozt
         kZTmqVtVhvRpCD9KnnaG1g2EOHvipJdy2PPtVSOc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 263/399] drm/vmwgfx: prevent memory leak in vmw_cmdbuf_res_add
Date:   Fri, 21 Feb 2020 08:39:48 +0100
Message-Id: <20200221072427.944761547@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 40efb09a7f53125719e49864da008495e39aaa1e ]

In vmw_cmdbuf_res_add if drm_ht_insert_item fails the allocated memory
for cres should be released.

Fixes: 18e4a4669c50 ("drm/vmwgfx: Fix compat shader namespace")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
index 4ac55fc2bf970..44d858ce4ce7f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
@@ -209,8 +209,10 @@ int vmw_cmdbuf_res_add(struct vmw_cmdbuf_res_manager *man,
 
 	cres->hash.key = user_key | (res_type << 24);
 	ret = drm_ht_insert_item(&man->resources, &cres->hash);
-	if (unlikely(ret != 0))
+	if (unlikely(ret != 0)) {
+		kfree(cres);
 		goto out_invalid_key;
+	}
 
 	cres->state = VMW_CMDBUF_RES_ADD;
 	cres->res = vmw_resource_reference(res);
-- 
2.20.1



