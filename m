Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4337C433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 745EF22482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260216;
	bh=IGi0Xef7jbHhMsYfOprqPDNw4VFPWt/swz7U6H8LxOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q+3iox/Eo7Odprmqehfj2BX3ANKB0/vGGebiypQpfCaQkuIxbLwQCTT4Rk38+Y97J
	 fhjKLsqI59a/o+spNj5AwTAt1CE4casIa+dGrjy3exE1+bzWE0qBZLHEI0KO22Wl/R
	 ywEYHfNq4jlz5kWHy+0K48BSEg2dHRBd7uAwH8NE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbgGTPuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731108AbgGTPuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:50:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAE4322B4D;
        Mon, 20 Jul 2020 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260211;
        bh=IGi0Xef7jbHhMsYfOprqPDNw4VFPWt/swz7U6H8LxOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V/EYyjE4KRBWZmwCJX1wMKVZgokQtohQ56wppvPPU7aLpTLF6mQtsV0F7+qHdYYLC
         bGLoyaQ8VQtZe2rs9YAqSbbz3xm8OoBoyuobXVPJ/rZCJMq5W6sjOaoqdMsKa+WCsw
         tyABxV1GjC+b5J4GvuTbMLzL0YlzK6Ls74Wz8SdE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bernard Zhao <bernard@vivo.com>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 020/133] drm/msm: fix potential memleak in error branch
Date:   Mon, 20 Jul 2020 17:36:07 +0200
Message-Id: <20200720152804.704407352@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bernard Zhao <bernard@vivo.com>

[ Upstream commit 177d3819633cd520e3f95df541a04644aab4c657 ]

In function msm_submitqueue_create, the queue is a local
variable, in return -EINVAL branch, queue didn`t add to ctx`s
list yet, and also didn`t kfree, this maybe bring in potential
memleak.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
[trivial commit msg fixup]
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_submitqueue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index 5115f75b5b7f3..325da440264a3 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -78,8 +78,10 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_file_private *ctx,
 	queue->flags = flags;
 
 	if (priv->gpu) {
-		if (prio >= priv->gpu->nr_rings)
+		if (prio >= priv->gpu->nr_rings) {
+			kfree(queue);
 			return -EINVAL;
+		}
 
 		queue->prio = prio;
 	}
-- 
2.25.1



