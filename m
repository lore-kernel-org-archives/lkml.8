Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3827BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0945920734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HWakAfbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgFJGwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:52:47 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:9400 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJGwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591771966; x=1623307966;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=xCz6sZwamSXhx0k/DGtHpU2qwvYefGFxqkGuv5R9PA4=;
  b=HWakAfbBYr3nnvg1sVIPMUm/5CnyQg9tnKp0SZuBJx/4WY5SuYchQe04
   hHwsJ3VRjg3uRccI+TcJVksPx0zB+bAhtzGdj8HLIKtlEx+7mSVdZ/c7/
   vipXCJtIoAydj192PVmiKRHu40Gvmy5nBhD344L7dGs39entEBmBdwdiz
   I=;
IronPort-SDR: BAUq2FaNu5ZPLR9gkrF3YnTLQXwb/bykb9OhtfwMggOe/CwLtbeb3ezl8SddA39TIDfKNk+Q1p
 02s5vKmlrNvw==
X-IronPort-AV: E=Sophos;i="5.73,495,1583193600"; 
   d="scan'208";a="42921914"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 10 Jun 2020 06:52:44 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com (Postfix) with ESMTPS id 2C745A1C91;
        Wed, 10 Jun 2020 06:52:43 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Jun 2020 06:52:42 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.65) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Jun 2020 06:52:38 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>, <apw@canonical.com>, <joe@perches.com>
CC:     <colin.king@canonical.com>, <sj38.park@gmail.com>,
        <linux-kernel@vger.kernel.org>, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v3 0/2] Recommend blocklist/allowlist instead of blacklist/whitelist
Date:   Wed, 10 Jun 2020 08:52:21 +0200
Message-ID: <20200610065223.29894-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
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

This patchset 1) adds support of deprecated terms in the 'checkpatch.pl'
and 2) set the 'blacklist' and 'whitelist' as deprecated with
replacement suggestion of 'blocklist' and 'allowlist', because the
suggestions are incontrovertible, doesn't make people hurt, and more
self-explanatory.

The patches are based on latest 'next/master'.  You can get the complete
git tree at:

https://github.com/sjp38/linux/tree/patches/checkpatch/deprecate_blacklist_whitelist_on_next


Patch History
=============

Changes from v2
(https://lore.kernel.org/lkml/20200609122549.26304-1-sjpark@amazon.com/)
 - Implement and use deprecated terms check

Changes from v1
(https://lore.kernel.org/lkml/20200609121843.24147-1-sjpark@amazon.com/)
 - Remove unnecessary commit message

SeongJae Park (2):
  checkpatch: support deprecated terms checking
  scripts/deprecated_terms: Recommend blocklist/allowlist instead of
    blacklist/whitelist

 scripts/checkpatch.pl        | 44 ++++++++++++++++++++++++++++++++++++
 scripts/deprecated_terms.txt |  7 ++++++
 2 files changed, 51 insertions(+)
 create mode 100644 scripts/deprecated_terms.txt

-- 
2.17.1

