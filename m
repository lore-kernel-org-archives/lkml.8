Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D868C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74C4120702
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593460310;
	bh=Co7xbSiFhIfo0qFKQUR6nw8frx3R6V7UvN2bCpDu2Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NT0Zz0xt37UE6TDLFqtq7LW3Z6xToc8/qF30h3ivobFwtOSVcLiyyq8UVpZBd5fvM
	 4jkHcBVmR5RwnVeKEofkDxjBne9w3S0ud8Raiv8vOGCnyRnRiit0mBwWHIlKds23dn
	 eBMuPMHEPu7r0DliId1nVAaByo2QTJx2J9nSsjr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbgF2Tvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:51:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387732AbgF2Tkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55819251D8;
        Mon, 29 Jun 2020 15:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444498;
        bh=Co7xbSiFhIfo0qFKQUR6nw8frx3R6V7UvN2bCpDu2Ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uC627F2TEqFXcowpJ9ewdJNSv8UG6iFEHr/irJ7OZfoKsRXkMfOWDOU36/MrfZT+a
         vySR0fbF+i0WpifAMC3dUzPZWb6sR+mq8rj+vkSfQI2Xjs54DayI5cN0bCOiFv1Ya5
         N1mIq+C5L3Ye2RFgKf2PIZB7pdKK3Wq4ndixrlus=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.4 176/178] dm writecache: add cond_resched to loop in persistent_memory_claim()
Date:   Mon, 29 Jun 2020 11:25:21 -0400
Message-Id: <20200629152523.2494198-177-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
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
index 64d75bbefda11..67eb4e972cc36 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -279,6 +279,8 @@ static int persistent_memory_claim(struct dm_writecache *wc)
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

