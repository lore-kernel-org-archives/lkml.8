Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D88C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E439F20791
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fhWQFKtl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgGMHTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:19:47 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:10964 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgGMHTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594624787; x=1626160787;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Ixx0i2v1XGSGPm4BYlLqRcGUCDbRxhS+XN/zlfYuLiw=;
  b=fhWQFKtl18cD9MsrQx9nddYDZN6ldyltVJOE8TfwtWVbeYJV3WGVbkGP
   ALfh/k+0aeAzG2BQZ596zJmpNEFCKZchDnzBThcVFwi3CS6BGAFQvG2fX
   WlF8NpzlPI5pasLresupEpHnLijUikVOgUaW96anJDMyR1VRe5Qd4SGAP
   8=;
IronPort-SDR: mkdtB6j/rztUCycRmWqpxb91ysPalTxxUvVCCmBBP4z978IGXVIToRqeGeZeiwHxx1ckTLfCpd
 GABsFgLzqa0w==
X-IronPort-AV: E=Sophos;i="5.75,346,1589241600"; 
   d="scan'208";a="59256909"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 13 Jul 2020 07:19:42 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id 5503B285E37;
        Mon, 13 Jul 2020 07:19:38 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 13 Jul 2020 07:19:37 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.34) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 13 Jul 2020 07:19:30 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <dan.j.williams@intel.com>,
        <apw@canonical.com>, <joe@perches.com>, <colin.king@canonical.com>,
        <sj38.park@gmail.com>, <jslaby@suse.cz>, <corbet@lwn.net>,
        <gregkh@linuxfoundation.org>, <mishi@linux.com>,
        <skhan@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] scripts/deprecated_terms: Sync with inclusive terms
Date:   Mon, 13 Jul 2020 09:19:12 +0200
Message-ID: <20200713071912.24432-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D22UWC003.ant.amazon.com (10.43.162.250) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

# NOTE: this patch is based on next/master, as this is a followup of
# commit 0d8b43e5876a ("scripts/deprecated_terms: recommend
# denylist/allowlist instead of blacklist/whitelist"), which merged in
# next tree only.

Commit a5f526ecb075 ("CodingStyle: Inclusive Terminology") introduced
more terms to be deprecated with more alternatives.  This commit updates
'deprecated_terms.txt' to sync with it.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 scripts/deprecated_terms.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/deprecated_terms.txt b/scripts/deprecated_terms.txt
index 4512ef5d5ffa..1be27a24187b 100644
--- a/scripts/deprecated_terms.txt
+++ b/scripts/deprecated_terms.txt
@@ -3,5 +3,8 @@
 # The format of each line is:
 # deprecated||suggested
 #
-blacklist||denylist
-whitelist||allowlist
+blacklist||(denylist|blocklist)
+# For other alternatives of 'slave', Please refer to
+# Documentation/process/coding-style.rst
+slave||(secondary|target|...)
+whitelist||(allowlist|passlist)
-- 
2.17.1

