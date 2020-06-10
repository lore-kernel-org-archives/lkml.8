Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386C5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1226220734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sB8iW6+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgFJGw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:52:58 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:58917 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJGw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591771977; x=1623307977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=jtHJNTFRuP3ZFYup2dq/Rd0J8Rl5Agllf3ZZVbrAhRc=;
  b=sB8iW6+w+C8LFbJSZuWMBvU6gLSjWhVQf7Ku0HH+N00QUitMPZKyZNyp
   IFBy10PmsA4pSr/dPyyBi5nxDs5XuPy8Jifn419swbPTreLHSycrUYdF4
   awXg59J8XSd+YdGaCAyzRYvSMI6bk9OYJQNJloxDVqsGdcGbGtI5MQDsf
   I=;
IronPort-SDR: 2CEnfRcQ6cPukYznrgAzY/Icy5wCJDi63m9JaWltPk8cBOgqAp2WoAck2aXzm1CB6jB3GhroOW
 +KmJcZ/z6arg==
X-IronPort-AV: E=Sophos;i="5.73,495,1583193600"; 
   d="scan'208";a="49856665"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 10 Jun 2020 06:52:55 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id 628B0A3D39;
        Wed, 10 Jun 2020 06:52:53 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Jun 2020 06:52:52 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.65) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Jun 2020 06:52:48 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>, <apw@canonical.com>, <joe@perches.com>
CC:     <colin.king@canonical.com>, <sj38.park@gmail.com>,
        <linux-kernel@vger.kernel.org>, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v3 2/2] scripts/deprecated_terms: Recommend blocklist/allowlist instead of blacklist/whitelist
Date:   Wed, 10 Jun 2020 08:52:23 +0200
Message-ID: <20200610065223.29894-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200610065223.29894-1-sjpark@amazon.com>
References: <20200610065223.29894-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13P01UWB002.ant.amazon.com (10.43.161.191) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit recommends the patches to replace 'blacklist' and
'whitelist' with the 'blocklist' and 'allowlist', because the new
suggestions are incontrovertible, doesn't make people hurt, and more
self-explanatory.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 scripts/deprecated_terms.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/deprecated_terms.txt b/scripts/deprecated_terms.txt
index 6faa06451c3d..102a0c82c6a0 100644
--- a/scripts/deprecated_terms.txt
+++ b/scripts/deprecated_terms.txt
@@ -3,3 +3,5 @@
 # The format of each line is:
 # deprecated||suggested
 #
+blacklist||blocklist
+whitelist||allowlist
-- 
2.17.1

