Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40D2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A412D204EF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591660175;
	bh=UUwxL5xLHGXldFQX6wmblQgeNowCOvhWYxiVUwwxI3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EVaaKTk9qXY+isGMgo29IBQj3yxBdImKJrZJ0ZXnyHT/Ss5G9Yk5y7SBScVa0H1T9
	 mgZwssMlpTDeEcvPfhrV7E+3mhFE2TbYQ083OkRhrlJQK7Evan5NNmWc/GijbPYz31
	 a8t0FZF/qmTbewzmMirv7IkzrNUgh1DCtbhj+gYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732166AbgFHXte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731815AbgFHXZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:25:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 814452076C;
        Mon,  8 Jun 2020 23:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658732;
        bh=UUwxL5xLHGXldFQX6wmblQgeNowCOvhWYxiVUwwxI3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ye0AnFzmSmzGAv/Xxq5s2KZLqiJ8623EZ87sWa3JkftEYzmIM2XGVlrXg1FpVmmZF
         e5QDlDF5K7PkwsN3KPJ0mDz50bTGjKDKj1KpBhnaEca/KCPMvVe4gFqTl2j3I3DuaT
         IiFHrWeTGfEJnPZlqwU7/Qm4SUMIHgd8CiyO3ZyE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Gao Xiang <xiang@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Wei Liu <wei.liu@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH AUTOSEL 4.14 22/72] staging: android: ion: use vmap instead of vm_map_ram
Date:   Mon,  8 Jun 2020 19:24:10 -0400
Message-Id: <20200608232500.3369581-22-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232500.3369581-1-sashal@kernel.org>
References: <20200608232500.3369581-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 5bf9917452112694b2c774465ee4dbe441c84b77 ]

vm_map_ram can keep mappings around after the vm_unmap_ram.  Using that
with non-PAGE_KERNEL mappings can lead to all kinds of aliasing issues.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>
Cc: Gao Xiang <xiang@kernel.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Kelley <mikelley@microsoft.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Will Deacon <will@kernel.org>
Link: http://lkml.kernel.org/r/20200414131348.444715-4-hch@lst.de
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/android/ion/ion_heap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/android/ion/ion_heap.c b/drivers/staging/android/ion/ion_heap.c
index babbd94c32d9..33a9777e7a99 100644
--- a/drivers/staging/android/ion/ion_heap.c
+++ b/drivers/staging/android/ion/ion_heap.c
@@ -105,12 +105,12 @@ int ion_heap_map_user(struct ion_heap *heap, struct ion_buffer *buffer,
 
 static int ion_heap_clear_pages(struct page **pages, int num, pgprot_t pgprot)
 {
-	void *addr = vm_map_ram(pages, num, -1, pgprot);
+	void *addr = vmap(pages, num, VM_MAP, pgprot);
 
 	if (!addr)
 		return -ENOMEM;
 	memset(addr, 0, PAGE_SIZE * num);
-	vm_unmap_ram(addr, num);
+	vunmap(addr);
 
 	return 0;
 }
-- 
2.25.1

