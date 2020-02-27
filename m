Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525DAC52D54
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE3E20578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811936;
	bh=0yK99yL8zKpPcOVGxgHL+LeT9F8hHMH66h3KyuMSC2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nZaY7Deai4tpR/rgLjbqGYS7aigA0JPmmJorgcbSqPrTHA/1/9bNkB0JV05EwmFOa
	 DjkZ8LKFi2bPpGLWnW+8aikaeu9XDgo2KqQ4oLCP6FjfSUpH/UU445FAkgdvKsfTHX
	 agHS+zvUiw/znMcELG2gYhug/M1YjbqF/7gbW0Bs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbgB0N6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:58:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732026AbgB0N6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:58:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68A182084E;
        Thu, 27 Feb 2020 13:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811930;
        bh=0yK99yL8zKpPcOVGxgHL+LeT9F8hHMH66h3KyuMSC2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eGladwvypEXq5SymvP8oRfJVz9b/szS4qGWFshGAn+IleKnt74f1ILKnzjYaowM/r
         855r7a+3INJMX1Co2eq9smQa3ZNdqTSX5hu9a+/tfCOkBp/lO0xQUUXdo8GDwxazSI
         M1td8qLqg07KNlD+6USUU2cejiTFwqlzErOSbzVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 119/237] drm/vmwgfx: prevent memory leak in vmw_cmdbuf_res_add
Date:   Thu, 27 Feb 2020 14:35:33 +0100
Message-Id: <20200227132305.578646199@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
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
index 36c7b6c839c0d..738ad2fc79a25 100644
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



