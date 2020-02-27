Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAC0C52D39
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A0820801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812070;
	bh=cTtAzCUPbWALIG3BgIYSOQIv5rypzVCDWUfep5QZfj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RRDLLCeYjZXbcdyoX3L6ew8T5ywQ74e5pHz0fNzDzSmn26TN8clGWJICdAvBVGw/+
	 EqclRSBwDd70Lhttmz3d5k2uh04EpdZ2Z5EIBUYOVM/SzETx//taEJRzIlgs7k93Wy
	 zkpqqpi5MvC4Zn/d8FnihPAf17mYqJ+RDxxVgAvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbgB0OBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:01:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732843AbgB0OBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:01:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B94224697;
        Thu, 27 Feb 2020 14:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812062;
        bh=cTtAzCUPbWALIG3BgIYSOQIv5rypzVCDWUfep5QZfj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p1zQq3ZT2XzHxqPW7sNJXWw5LN9gadIqAkZy+D8YzGjIN7LEX3Dx+DOBZSKnsSXl5
         BlQIGhS9iKmmp35zldBErfpBHgj3xNqq6nEOowzJh80lRatJVfoBBZYgS59cKDqeJQ
         MYHqzjE1sLx5QIA8s6Ud+Y9Umq6LOiePnMyWJ7DY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miles Chen <miles.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 208/237] lib/stackdepot: Fix outdated comments
Date:   Thu, 27 Feb 2020 14:37:02 +0100
Message-Id: <20200227132311.534503146@linuxfoundation.org>
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

From: Miles Chen <miles.chen@mediatek.com>

[ Upstream commit ee050dc83bc326ad5ef8ee93bca344819371e7a5 ]

Replace "depot_save_stack" with "stack_depot_save" in code comments because
depot_save_stack() was replaced in commit c0cfc337264c ("lib/stackdepot:
Provide functions which operate on plain storage arrays") and removed in
commit 56d8f079c51a ("lib/stackdepot: Remove obsolete functions")

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190815113246.18478-1-miles.chen@mediatek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/stackdepot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index f87d138e96724..1724cb0d6283f 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -96,7 +96,7 @@ static bool init_stack_slab(void **prealloc)
 		stack_slabs[depot_index + 1] = *prealloc;
 		/*
 		 * This smp_store_release pairs with smp_load_acquire() from
-		 * |next_slab_inited| above and in depot_save_stack().
+		 * |next_slab_inited| above and in stack_depot_save().
 		 */
 		smp_store_release(&next_slab_inited, 1);
 	}
@@ -123,7 +123,7 @@ static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
 		depot_offset = 0;
 		/*
 		 * smp_store_release() here pairs with smp_load_acquire() from
-		 * |next_slab_inited| in depot_save_stack() and
+		 * |next_slab_inited| in stack_depot_save() and
 		 * init_stack_slab().
 		 */
 		if (depot_index + 1 < STACK_ALLOC_MAX_SLABS)
-- 
2.20.1



