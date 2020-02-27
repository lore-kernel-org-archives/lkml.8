Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD02C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6FF24656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814508;
	bh=cTtAzCUPbWALIG3BgIYSOQIv5rypzVCDWUfep5QZfj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RHnBlZR9X3WJjJHdOlXa5e+J4SFuMnsQZhDII9f40OcvghRFpXsH/pHHL8zTGbrc/
	 prSvT1z/DRlU7KiiSU6QtaUPP3QppyhxoxR8qCkcj0sGd9t8POm+RtV3CvNBZsmh8K
	 4x/VmsShw79UbIOCTt63J8kg+MLGcjT+ykfLp8HE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbgB0Olq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:41:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731315AbgB0Nu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:50:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 065162468D;
        Thu, 27 Feb 2020 13:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811458;
        bh=cTtAzCUPbWALIG3BgIYSOQIv5rypzVCDWUfep5QZfj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=exTkS0X4ut5bu7Rg8pPRHY/cVwqohKLewo+v27Bbj3If5R6PutTracrKUnFHf3EyK
         DPdGDwcZ6VBMav1ygM4G8G39SCTYWZXoIBDKZecZmWnDSNz61xJJ1ErAfUqOeRNy8Q
         W3URVbZJ5+GBHVUE8A/qLkaGFXnHwDntrP2arLj4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miles Chen <miles.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 141/165] lib/stackdepot: Fix outdated comments
Date:   Thu, 27 Feb 2020 14:36:55 +0100
Message-Id: <20200227132251.585864029@linuxfoundation.org>
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



