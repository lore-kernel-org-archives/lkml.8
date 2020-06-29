Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A61C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C7C920760
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461687;
	bh=5ScMDTKWM/U7yfgxm06jNQ+5F0fwhk/4g0yJEqvOIng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RNUpl8jlulHFDgXEZCMF/4xpaV3icdpw+qK7zPzpxlQs5z0muGhD0MXMbwFu/RrJs
	 WlLp6JMNeeggrhoB9z9MM66sCdto+dQ6DHaUxjYrXtOHHcXEL1JHa89RMgN/WcgVYj
	 SNIt93nMJC88sBUNrfUJQJ1tLrbIz+5aaKftGk0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732850AbgF2UOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:14:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732846AbgF2TaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29779252BE;
        Mon, 29 Jun 2020 15:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445032;
        bh=5ScMDTKWM/U7yfgxm06jNQ+5F0fwhk/4g0yJEqvOIng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zQ9F+CKWuyzN3i+kZa4chF2r4ZF7rDGmFSGgyJjo70N0IexlT/UPeXVLsjGhnfCaj
         E2MumfUlpkAYqAogCuju5Swa2GGS9IeL9t4MVLH2IjhJ8b1mI8fclcHkmig4f7NVlg
         7XsUBBZ+VuKwFV92PFkmUj8B5qGPaDVZ0vvpy8AM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.19 129/131] dm writecache: add cond_resched to loop in persistent_memory_claim()
Date:   Mon, 29 Jun 2020 11:35:00 -0400
Message-Id: <20200629153502.2494656-130-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153502.2494656-1-sashal@kernel.org>
References: <20200629153502.2494656-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.131-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.131-rc1
X-KernelTest-Deadline: 2020-07-01T15:34+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit d35bd764e6899a7bea71958f08d16cea5bfa1919 upstream.

Add cond_resched() to a loop that fills in the mapper memory area
because the loop can be executed many times.

Fixes: 48debafe4f2fe ("dm: add writecache target")
Cc: stable@vger.kernel.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-writecache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 509552fc55fc7..cc028353f9d55 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -281,6 +281,8 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 			while (daa-- && i < p) {
 				pages[i++] = pfn_t_to_page(pfn);
 				pfn.val++;
+				if (!(i & 15))
+					cond_resched();
 			}
 		} while (i < p);
 		wc->memory_map = vmap(pages, p, VM_MAP, PAGE_KERNEL);
-- 
2.25.1

