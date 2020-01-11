Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C634C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718432077C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578736827;
	bh=J5k4I5PjDOISQmUJ+K3wvYYqJ/TLF/0wPiYvQi9KZAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MYghJ910Qsou2njiBbtgVS+ZyXAwqvO981NeTe+7cm6qCpmPREE2ZY9acL+2iqZPH
	 zxpg/IpslUMCdZIdECjb/gmiI8SLPugWwY/jdRFGk1hZDINNRoB+2NDXSMCYbK2P8B
	 zeb7xA6xu0e7vZlcPB+T+MvvSSAD3mQLlnzCBDAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgAKKA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:00:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728991AbgAKKAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:00:21 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E26222077C;
        Sat, 11 Jan 2020 10:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578736820;
        bh=J5k4I5PjDOISQmUJ+K3wvYYqJ/TLF/0wPiYvQi9KZAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EizOxTpT1H3WTSyMQKaCyEPKQBqaKYYFr4/dvtC72Qg9PdJKQ7P0Y0d1IlIQm17Lq
         a/Fnhd+5Z3//bYMnOygNuSrQcUh+6yj3s+9alecWMc+X5ajJlajchCRoeYQpMOsMfH
         7bFrjniYLmtHx4Shak0Czp/texS0tUuARYMGPr+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea Righi <andrea.righi@canonical.com>,
        Andy Whitcroft <apw@canonical.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 14/91] PM / hibernate: memory_bm_find_bit(): Tighten node optimisation
Date:   Sat, 11 Jan 2020 10:49:07 +0100
Message-Id: <20200111094848.319826655@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094844.748507863@linuxfoundation.org>
References: <20200111094844.748507863@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Whitcroft <apw@canonical.com>

[ Upstream commit da6043fe85eb5ec621e34a92540735dcebbea134 ]

When looking for a bit by number we make use of the cached result from the
preceding lookup to speed up operation.  Firstly we check if the requested
pfn is within the cached zone and if not lookup the new zone.  We then
check if the offset for that pfn falls within the existing cached node.
This happens regardless of whether the node is within the zone we are
now scanning.  With certain memory layouts it is possible for this to
false trigger creating a temporary alias for the pfn to a different bit.
This leads the hibernation code to free memory which it was never allocated
with the expected fallout.

Ensure the zone we are scanning matches the cached zone before considering
the cached node.

Deep thanks go to Andrea for many, many, many hours of hacking and testing
that went into cornering this bug.

Reported-by: Andrea Righi <andrea.righi@canonical.com>
Tested-by: Andrea Righi <andrea.righi@canonical.com>
Signed-off-by: Andy Whitcroft <apw@canonical.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/power/snapshot.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 4f0f0604f1c4..5dfac92521fa 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -732,8 +732,15 @@ static int memory_bm_find_bit(struct memory_bitmap *bm, unsigned long pfn,
 	 * We have found the zone. Now walk the radix tree to find the leaf node
 	 * for our PFN.
 	 */
+
+	/*
+	 * If the zone we wish to scan is the the current zone and the
+	 * pfn falls into the current node then we do not need to walk
+	 * the tree.
+	 */
 	node = bm->cur.node;
-	if (((pfn - zone->start_pfn) & ~BM_BLOCK_MASK) == bm->cur.node_pfn)
+	if (zone == bm->cur.zone &&
+	    ((pfn - zone->start_pfn) & ~BM_BLOCK_MASK) == bm->cur.node_pfn)
 		goto node_found;
 
 	node      = zone->rtree;
-- 
2.20.1



