Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103B5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE82206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nb5YEwRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgFJNyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:54:37 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:64836 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgFJNyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591797276; x=1623333276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=y3uoS3vtPPW6TAvUK0hk1JX0cDjoO5vQU6N8mWfeMNE=;
  b=nb5YEwRlePkfkgZ5IU1YV6B475eNKSObrTa71Onfeai4+A31vibXo7Vd
   9sQkW7Ve+Mct+RQ5CUUWnr/iJGB6ChVFgGNnvg631QMZNLx9S0TLFxi5t
   p3Axn8np3JiYN0JR4Kon6zuVSDGm8zTCxeA+niYZZEvQ3fm3uyfp9iJpM
   8=;
IronPort-SDR: hmXg5RC6pJzmncT0RzPVAwL4E8gOpKGclSaNQ8/08vfdWnIxHu2d0OW0LqN3jZJr65mqSUYDm9
 260usWImkgVw==
X-IronPort-AV: E=Sophos;i="5.73,496,1583193600"; 
   d="scan'208";a="36876012"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 10 Jun 2020 13:54:34 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 35D6FA248B;
        Wed, 10 Jun 2020 13:54:33 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Jun 2020 13:54:32 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.34) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Jun 2020 13:54:26 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, <apw@canonical.com>,
        <joe@perches.com>, <jslaby@suse.cz>, <colin.king@canonical.com>,
        <sj38.park@gmail.com>, <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v3 2/2] scripts/deprecated_terms: Recommend blocklist/allowlist instead of blacklist/whitelist
Date:   Wed, 10 Jun 2020 15:54:11 +0200
Message-ID: <20200610135411.23786-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200610065223.29894-3-sjpark@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D27UWB003.ant.amazon.com (10.43.161.195) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on Jiri's feedback[1], I'm updating the replacement suggestion of blacklist
from blocklist to denylist, as the previous one might be confused to block
layer people.  Also, the new recommendation is more short ;)

[1] https://lore.kernel.org/lkml/20200610091655.4682-1-sjpark@amazon.com/

================================== >8 =========================================
From 1376e327de8316ef30c393507b29d70d38bffd05 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sjpark@amazon.de>
Date: Wed, 10 Jun 2020 07:23:33 +0200
Subject: [PATCH v3.1] scripts/deprecated_terms: Recommend denylist/allowlist
 instead of blacklist/whitelist

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

