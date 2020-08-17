Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9740C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A7F20738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693204;
	bh=8thRGMa9HAsMNS+bjxZvdNHUOnx+8B3XqlO1Ya55qq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YeHem1rHJZLHAiNBOGr33e9wU2YnHsrOL45ghCZF2vJioq+9ydkDaMC9UMGxAbePX
	 je5ECVIgcjZT0F5zNzuNYUOCqExPXz95ZKVsOGkI2GTPwCNj51OpKbqFwrLXdjX7Nt
	 NpGb3MCzaaWhzve9cBpXV3cPBRB+Hc1RmoIyOgS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbgHQTkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729779AbgHQP0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:26:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC33B20885;
        Mon, 17 Aug 2020 15:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677961;
        bh=8thRGMa9HAsMNS+bjxZvdNHUOnx+8B3XqlO1Ya55qq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VckAg48urQwlwOgJGgIUabLt79x4wTWV9d9fjSWZFjKidnENOAZYJ1OsxF5CzftSe
         txnwOxzpBKamZz7KZq3Bpqw4x6mh3MJn1bSnyCFZDQ1CfB+SgzGb761h25nk9ouwwi
         uDSw8zHXdPofzID1UQXujLHRBbNm5wE8RQX5B5i8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nirmoy Das <nirmoy.das@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 153/464] drm/mm: fix hole size comparison
Date:   Mon, 17 Aug 2020 17:11:46 +0200
Message-Id: <20200817143841.142266377@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nirmoy Das <nirmoy.aiemd@gmail.com>

[ Upstream commit 18ece75d7d74eb108f6a7325cf247077a666cba8 ]

Fixes: 0cdea4455acd350a ("drm/mm: optimize rb_hole_addr rbtree search")

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
Reported-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Link: https://patchwork.freedesktop.org/patch/367726/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_mm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_mm.c b/drivers/gpu/drm/drm_mm.c
index f4ca1ff80af9f..60e9a9c91e9d9 100644
--- a/drivers/gpu/drm/drm_mm.c
+++ b/drivers/gpu/drm/drm_mm.c
@@ -407,7 +407,7 @@ next_hole_high_addr(struct drm_mm_node *entry, u64 size)
 		left_node = rb_entry(left_rb_node,
 				     struct drm_mm_node, rb_hole_addr);
 		if ((left_node->subtree_max_hole < size ||
-		     entry->size == entry->subtree_max_hole) &&
+		     HOLE_SIZE(entry) == entry->subtree_max_hole) &&
 		    parent_rb_node && parent_rb_node->rb_left != rb_node)
 			return rb_hole_addr_to_node(parent_rb_node);
 	}
@@ -447,7 +447,7 @@ next_hole_low_addr(struct drm_mm_node *entry, u64 size)
 		right_node = rb_entry(right_rb_node,
 				      struct drm_mm_node, rb_hole_addr);
 		if ((right_node->subtree_max_hole < size ||
-		     entry->size == entry->subtree_max_hole) &&
+		     HOLE_SIZE(entry) == entry->subtree_max_hole) &&
 		    parent_rb_node && parent_rb_node->rb_right != rb_node)
 			return rb_hole_addr_to_node(parent_rb_node);
 	}
-- 
2.25.1



