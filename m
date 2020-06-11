Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F5EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C8920812
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZVnRlnTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgFKG0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:26:25 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:42456 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgFKG0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 02:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591856783; x=1623392783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=EstdcR37+LnyPrOyd37lZ2Ta0GwcaeERl0JiLvZ6O7M=;
  b=ZVnRlnTBf2/O556/synTXOJLuiorBgRusGKZqPx3EPXxbZ7NXTbZHCr2
   9HqGUbwuCPg3X6NnlOBrOGABJ2ybVAxngFiMFTYDkST59o+/VcMfzYJEM
   0pvVtbUCALuemwwIGmrJj3p7e62GEuf56KfXs3HsKCxxU5CfdOM62g4Mu
   g=;
IronPort-SDR: XLx8ng6MGGHkG+S5hvapkdDTN+TIfLBNoEWbr31pag5ufE8D3Ve/CBzUBWAicTc3+lA86QLovr
 3jZysafr+UMg==
X-IronPort-AV: E=Sophos;i="5.73,498,1583193600"; 
   d="scan'208";a="35690955"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 11 Jun 2020 06:26:22 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id 53E76A2348;
        Thu, 11 Jun 2020 06:26:21 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 11 Jun 2020 06:26:20 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.97) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 11 Jun 2020 06:26:16 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>, <apw@canonical.com>, <joe@perches.com>
CC:     SeongJae Park <sjpark@amazon.de>, <colin.king@canonical.com>,
        <sj38.park@gmail.com>, <jslaby@suse.cz>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/2] scripts/deprecated_terms: Recommend denylist/allowlist instead of blacklist/whitelist
Date:   Thu, 11 Jun 2020 08:25:50 +0200
Message-ID: <20200611062550.20113-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200611062550.20113-1-sjpark@amazon.com>
References: <20200611062550.20113-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.97]
X-ClientProxiedBy: EX13D06UWA001.ant.amazon.com (10.43.160.220) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit recommends the patches to replace 'blacklist' and
'whitelist' with the 'denylist' and 'allowlist', because the new
suggestions are incontrovertible, doesn't make people hurt, and more
self-explanatory.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 scripts/deprecated_terms.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/deprecated_terms.txt b/scripts/deprecated_terms.txt
index 6faa06451c3d..4512ef5d5ffa 100644
--- a/scripts/deprecated_terms.txt
+++ b/scripts/deprecated_terms.txt
@@ -3,3 +3,5 @@
 # The format of each line is:
 # deprecated||suggested
 #
+blacklist||denylist
+whitelist||allowlist
-- 
2.17.1

