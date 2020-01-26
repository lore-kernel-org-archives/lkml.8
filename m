Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E845EC35242
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 01:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64F12071A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 01:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgAZBPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 20:15:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:56489 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbgAZBPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 20:15:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2020 17:15:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,363,1574150400"; 
   d="scan'208";a="251632878"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jan 2020 17:15:46 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] mm/swap.c: not necessary to export __pagevec_lru_add()
Date:   Sun, 26 Jan 2020 09:14:36 +0800
Message-Id: <20200126011436.22979-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function __pagevec_lru_add() only used in mm directory now.

Remove the export symbol.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/swap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index 0f35f5394c51..e45a10f7f3d6 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -983,7 +983,6 @@ void __pagevec_lru_add(struct pagevec *pvec)
 {
 	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn, NULL);
 }
-EXPORT_SYMBOL(__pagevec_lru_add);
 
 /**
  * pagevec_lookup_entries - gang pagecache lookup
-- 
2.17.1

