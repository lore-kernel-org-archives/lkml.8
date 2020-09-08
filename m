Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71AFC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8613B2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599589603;
	bh=OTh/b5DSp/Cu3k1D/l/21uMUst7u9uIT1VOgoac0tF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PYxyI1Uxa6Ze9BaW3ZZSTfAaHpVzFEBD5mgC4WRKFASvX/7KMdNP1MUXjyxm5o92O
	 1/P5c0UAqEqdlr94x0MiQM7mn9q/p9/CAIkilrlGuljEaSY8CmvwbV4gw9LC7h6qJz
	 i5czajnUedB6MNQNPtZFsFpUOfbirPmvdlWvklrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbgIHS0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731440AbgIHQKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:10:35 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F8842470C;
        Tue,  8 Sep 2020 15:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579636;
        bh=OTh/b5DSp/Cu3k1D/l/21uMUst7u9uIT1VOgoac0tF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GMb1AC2e6ZOaFxIMBJa3Fzas2Q5tQtBCS1pydY3RyQOP61DV8dACicz1563871jDD
         oEH1nn6SvCTF3ng/514qv60zyYZUc/PVqJw6+WTHbXQdWji+k6axyFuogOVKtW1iuE
         aodrRrtLdHnVLncM2XvgWwiGfGvgToN7oyl3xLFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.8 159/186] blk-iocost: ioc_pd_free() shouldnt assume irq disabled
Date:   Tue,  8 Sep 2020 17:25:01 +0200
Message-Id: <20200908152249.370435259@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

commit 5aeac7c4b16069aae49005f0a8d4526baa83341b upstream.

ioc_pd_free() grabs irq-safe ioc->lock without ensuring that irq is disabled
when it can be called with irq disabled or enabled. This has a small chance
of causing A-A deadlocks and triggers lockdep splats. Use irqsave operations
instead.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-iocost.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2094,14 +2094,15 @@ static void ioc_pd_free(struct blkg_poli
 {
 	struct ioc_gq *iocg = pd_to_iocg(pd);
 	struct ioc *ioc = iocg->ioc;
+	unsigned long flags;
 
 	if (ioc) {
-		spin_lock(&ioc->lock);
+		spin_lock_irqsave(&ioc->lock, flags);
 		if (!list_empty(&iocg->active_list)) {
 			propagate_active_weight(iocg, 0, 0);
 			list_del_init(&iocg->active_list);
 		}
-		spin_unlock(&ioc->lock);
+		spin_unlock_irqrestore(&ioc->lock, flags);
 
 		hrtimer_cancel(&iocg->waitq_timer);
 		hrtimer_cancel(&iocg->delay_timer);


