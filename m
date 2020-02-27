Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96795C3F350
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1D720578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811465;
	bh=FOoqKnrn4qOTHfbpPkiMYn5/tbWYlDqVW6aM+YvjngA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yc+8Qibv7knz3FpXzax1fPxb5UgF1I8i3pZzAu5ZbUvndhqPkGQJaRzBPgoMqofdV
	 RMRBisEA8ecNMPHXP08aRIAvLmoU/HTiUcgYPyb5tUn5I9qtOfqPXRrWgReSGQBJ3k
	 frNL/DVchvLzEx0SGRaQsE1ldLAgr59dlKkn/4vY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbgB0NvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:51:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730883AbgB0NvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:51:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B030920801;
        Thu, 27 Feb 2020 13:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811461;
        bh=FOoqKnrn4qOTHfbpPkiMYn5/tbWYlDqVW6aM+YvjngA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YzfTcdDB+Upq9gxCGsp2VPGkefZxm0vZ4haC86LWFFgeeLsx/Pdbm8M3/qKpjBsMx
         WmHHP+lEE5d0rSbhsCCtdg2PFG/vJ2I3PzhAEI/0aSWl+/lZ/5IHN+sCGT0W4YJrnJ
         NCgoh4DXeUV1DGxrABJ31dExAOlL5zHpeyL/SWac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Potapenko <glider@google.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 142/165] lib/stackdepot.c: fix global out-of-bounds in stack_slabs
Date:   Thu, 27 Feb 2020 14:36:56 +0100
Message-Id: <20200227132251.709838993@linuxfoundation.org>
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

From: Alexander Potapenko <glider@google.com>

[ Upstream commit 305e519ce48e935702c32241f07d393c3c8fed3e ]

Walter Wu has reported a potential case in which init_stack_slab() is
called after stack_slabs[STACK_ALLOC_MAX_SLABS - 1] has already been
initialized.  In that case init_stack_slab() will overwrite
stack_slabs[STACK_ALLOC_MAX_SLABS], which may result in a memory
corruption.

Link: http://lkml.kernel.org/r/20200218102950.260263-1-glider@google.com
Fixes: cd11016e5f521 ("mm, kasan: stackdepot implementation. Enable stackdepot for SLAB")
Signed-off-by: Alexander Potapenko <glider@google.com>
Reported-by: Walter Wu <walter-zh.wu@mediatek.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/stackdepot.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 1724cb0d6283f..54fe55b6bbc0a 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -92,15 +92,19 @@ static bool init_stack_slab(void **prealloc)
 		return true;
 	if (stack_slabs[depot_index] == NULL) {
 		stack_slabs[depot_index] = *prealloc;
+		*prealloc = NULL;
 	} else {
-		stack_slabs[depot_index + 1] = *prealloc;
+		/* If this is the last depot slab, do not touch the next one. */
+		if (depot_index + 1 < STACK_ALLOC_MAX_SLABS) {
+			stack_slabs[depot_index + 1] = *prealloc;
+			*prealloc = NULL;
+		}
 		/*
 		 * This smp_store_release pairs with smp_load_acquire() from
 		 * |next_slab_inited| above and in stack_depot_save().
 		 */
 		smp_store_release(&next_slab_inited, 1);
 	}
-	*prealloc = NULL;
 	return true;
 }
 
-- 
2.20.1



