Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE720C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7AE22063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597686659;
	bh=Vb6XrHNEh1tX/vKcn/Oyb4t1op2H8I9GgS3BvgKwxaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X/8jlG2GIRQJxeKjGSe6QHFkF+312ctrU97d8NP3rUNLLqoYRlM9JlyNANEj4mZNI
	 t+qp44PnRi5avFXRzlsTC3+bH1nSYB0KfKjdUnlWfUUL3o9+SovgJ9NCozMjA86ByE
	 s9LfXNbKerPvfFz1LyFiY+vm0/6UZOxFEsExucYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390187AbgHQRu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388659AbgHQQMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:12:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 114DC20578;
        Mon, 17 Aug 2020 16:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680722;
        bh=Vb6XrHNEh1tX/vKcn/Oyb4t1op2H8I9GgS3BvgKwxaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZgL5CXWLzCU6bOZ+RGHCO5Sk3SSXnbIceVlrNEb+LAP1424PKyWxWnAOxJALdzo6W
         +BSVmu28O05hmKUtHktuQQwH/xb122dR3mDNpc9cbfI+lPRTq07rZxdsY/kl9FcZA4
         AfBw8WU3hTj5YfeYeCEsMWu8XDdXscxohSO5UuBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 003/168] cgroup: add missing skcd->no_refcnt check in cgroup_sk_clone()
Date:   Mon, 17 Aug 2020 17:15:34 +0200
Message-Id: <20200817143733.883796814@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

Add skcd->no_refcnt check which is missed when backporting
ad0f75e5f57c ("cgroup: fix cgroup_sk_alloc() for sk_clone_lock()").

This patch is needed in stable-4.9, stable-4.14 and stable-4.19.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6ae98c714edd6..2a879d34bbe58 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5957,6 +5957,8 @@ void cgroup_sk_clone(struct sock_cgroup_data *skcd)
 {
 	/* Socket clone path */
 	if (skcd->val) {
+		if (skcd->no_refcnt)
+			return;
 		/*
 		 * We might be cloning a socket which is left in an empty
 		 * cgroup and the cgroup might have already been rmdir'd.
-- 
2.25.1



