Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD64C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA9D2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598257963;
	bh=t8QFWqTolVo7c1qLgcmQjDz0wNlZ8unAbXNGpquMF7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EgWlDIIyIBvGZdJjzCSrjfTbsAlfn5DTa/EQpN8WPL8nWz/TwOAKZMR09UB5P7XG/
	 L6Uql5eSH+6xkYMRikLOM+dI1l6b4NXkqGeA1mtJ0m9WtI4fCKY4O31GXI66dnnboV
	 9V2PKHkZASTprse405Ihveco0RQBmgWShAI33fHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgHXIcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbgHXIcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:32:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14228206F0;
        Mon, 24 Aug 2020 08:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598257955;
        bh=t8QFWqTolVo7c1qLgcmQjDz0wNlZ8unAbXNGpquMF7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9qrY1E/L8ae2sNuqRomQfOzugotw0vUhHd7xBdG6mtoywRKMLKsMD4ZcvVm5VgGF
         5a0jq3Jl+lu7GMGxNtVc5R/aqjs/W+jnbLoOLsTBReSp5a+FBvhTIFizp9Ta/xFMBE
         FxQe/dxh8Irq6PXyV618On3TKmtvaz+69kzT6UN0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        "Y.C. Chen" <yc_chen@aspeedtech.com>,
        Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 004/148] drm/ast: Initialize DRAM type before posting GPU
Date:   Mon, 24 Aug 2020 10:28:22 +0200
Message-Id: <20200824082414.156735452@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 244d012801dae30c91983b360457c78d481584b0 ]

Posting the GPU requires the correct DRAM type to be stored in
struct ast_private. Therefore first initialize the DRAM info and
then post the GPU. This restores the original order of instructions
in this function.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Fixes: bad09da6deab ("drm/ast: Fixed vram size incorrect issue on POWER")
Cc: Joel Stanley <joel@jms.id.au>
Cc: Y.C. Chen <yc_chen@aspeedtech.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Emil Velikov <emil.l.velikov@gmail.com>
Cc: "Y.C. Chen" <yc_chen@aspeedtech.com>
Cc: <stable@vger.kernel.org> # v4.11+
Link: https://patchwork.freedesktop.org/patch/msgid/20200716125353.31512-6-tzimmermann@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ast/ast_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
index f48a9f62368c0..99c11b51f0207 100644
--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -458,9 +458,6 @@ int ast_driver_load(struct drm_device *dev, unsigned long flags)
 
 	ast_detect_chip(dev, &need_post);
 
-	if (need_post)
-		ast_post_gpu(dev);
-
 	ret = ast_get_dram_info(dev);
 	if (ret)
 		goto out_free;
@@ -469,6 +466,9 @@ int ast_driver_load(struct drm_device *dev, unsigned long flags)
 		 ast->mclk, ast->dram_type,
 		 ast->dram_bus_width, ast->vram_size);
 
+	if (need_post)
+		ast_post_gpu(dev);
+
 	ret = ast_mm_init(ast);
 	if (ret)
 		goto out_free;
-- 
2.25.1



