Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A05BC3F348
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7102220578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811317;
	bh=1ncGh5Rk9EITS77TL+pGGDb/7PSP3K5PnHevgyuW3vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mVKs2pSZYDXnuHQfmeuMZSCXPuKYu6aOnDmDEjkVNEv3q2VkVCYMR8LcdqkWPUjKe
	 gr6A948BtduW8EDlEk1mifb8l2r5DNeO6MCLCzkHKZ4tY/2wuy5qsW/ITlXr6yNjo0
	 x5beJBwjmu4TWzsRgCO1HAyNi3Bwhkh8gWIt/q90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbgB0Nsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:48:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:45352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730425AbgB0Nsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:48:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA96020578;
        Thu, 27 Feb 2020 13:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811313;
        bh=1ncGh5Rk9EITS77TL+pGGDb/7PSP3K5PnHevgyuW3vM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KvmIkrOfOeISQxFa5sMXPdxkfP2Y5L+Sid6k8A8rU5bnf26Jvni2rgqbDiLS0UqBZ
         xTwwrXeRloWYZApONPEwZgZxjSQAkp2+4Ih5vKHyOB/uhzIIMqLkwZXKEqc9cWPiCO
         DDCsqt88qhZO2sij+sa9oI31tu9VaB+6iyhrlTl8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 082/165] drm/vmwgfx: prevent memory leak in vmw_cmdbuf_res_add
Date:   Thu, 27 Feb 2020 14:35:56 +0100
Message-Id: <20200227132243.304829733@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
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
index 1f013d45c9e9a..0c7c3005594cc 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
@@ -210,8 +210,10 @@ int vmw_cmdbuf_res_add(struct vmw_cmdbuf_res_manager *man,
 
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



