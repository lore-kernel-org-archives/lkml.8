Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBFEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A772074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SeBQMb6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgFKG0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:26:17 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:42439 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgFKG0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 02:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591856775; x=1623392775;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=VpT5s6xg8q/UO7hLykrWt7A7epnNUGqfikXs17DJ+5c=;
  b=SeBQMb6hIHHGo5Ohzu27WSrEdgwmGStTvimcviUZ5gAnrBOzbWAbbsjQ
   DxVJHvcrPyyIDcZUHx9kJha1K+zlIlReXHgxPepTx4HJ0UqGCNm+jXjJ6
   A0iskLlj8ltldkJoJuTrZqjzL5m0wka+WYZJfbMAeVXMABgobZlI6Gt6Q
   E=;
IronPort-SDR: ojCvipmza7GjCtVlAIjaaodV+KDOw/dhG1E9vDBY9KssZ17W+VnL0GOiKCNCONJR+P/w9k2+1u
 DcC7lU7t4IFw==
X-IronPort-AV: E=Sophos;i="5.73,498,1583193600"; 
   d="scan'208";a="35690942"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 11 Jun 2020 06:26:14 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id EDAC9A1CD5;
        Thu, 11 Jun 2020 06:26:12 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 11 Jun 2020 06:26:12 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.97) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 11 Jun 2020 06:26:07 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>, <apw@canonical.com>, <joe@perches.com>
CC:     SeongJae Park <sjpark@amazon.de>, <colin.king@canonical.com>,
        <sj38.park@gmail.com>, <jslaby@suse.cz>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/2] Recommend denylist/allowlist instead of blacklist/whitelist
Date:   Thu, 11 Jun 2020 08:25:48 +0200
Message-ID: <20200611062550.20113-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
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

This patchset 1) adds support of deprecated terms in the 'checkpatch.pl'
and 2) set the 'blacklist' and 'whitelist' as deprecated with
replacement suggestion of 'denylist' and 'allowlist', because the
suggestions are incontrovertible, doesn't make people hurt, and more
self-explanatory.

The patches are based on latest 'next/master'.  You can get the complete
git tree at:

https://github.com/sjp38/linux/tree/patches/checkpatch/deprecate_blacklist_whitelist_on_next_v4


Patch History
=============

Changes from v3
(https://lore.kernel.org/lkml/20200610065223.29894-1-sjpark@amazon.com/)
 - Reuse the file read code for 'spelling.txt' (Joe Perches)
 - Suggest 'denylist' rather than 'blocklist' (Jiri Slaby)
 - Rebased on today's next/master

Changes from v2
(https://lore.kernel.org/lkml/20200609122549.26304-1-sjpark@amazon.com/)
 - Implement and use deprecated terms check

Changes from v1
(https://lore.kernel.org/lkml/20200609121843.24147-1-sjpark@amazon.com/)
 - Remove unnecessary commit message

SeongJae Park (2):
  checkpatch: support deprecated terms checking
  scripts/deprecated_terms: Recommend denylist/allowlist instead of
    blacklist/whitelist

 scripts/checkpatch.pl        | 60 +++++++++++++++++++++++++++---------
 scripts/deprecated_terms.txt |  7 +++++
 2 files changed, 52 insertions(+), 15 deletions(-)
 create mode 100644 scripts/deprecated_terms.txt

-- 
2.17.1

