Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C5AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF34208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JPAWHp88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbgFRUCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:02:41 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16855 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgFRUCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592510561; x=1624046561;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2kmMXn71z1aHaErHJz+a+5Rckm6j69eZzhgRB1l7j0Y=;
  b=JPAWHp88i+B+8LaBocgA9OYg3v8nleV2cQ6IDVsbr0CQExdRescL0C95
   HmVLhe9fMHq4yJ7SsPh/atdsvP5T+SuTiYBpSs7DRJbCAN50kR81TmCL2
   JR22ThasVPH5W958F7kWOwoOGczh5JbtzGFeuawgfxIEJ0f6Ry7fLX0YB
   SvDe2D06vt07iPHOt9z+LBgAnvR7hItPxubTrmevOvDm6j+E2atHzmsZj
   bwIOwhXeT9xUX1jlLGRAkYhwLBbUuzzbO21ClZLy8mmJX8mftGZIYapSK
   l3Y9hlzM+LqggfzYgc3SIDxiDDsrdbUdaJXfPYuBwDQAV/cKcW6jq7LRF
   g==;
IronPort-SDR: rFa77vFWCh8XfvxgQA1BSJ0pAXyyqDu16jtWCc3pgfvPzyOW8nyIx9Y7+yyaJI20tqVk6JGAD/
 kSctG14tGyBlEhc0i4gdLlHFgUweNzK5rYjcLDKkLsId0XBot5OQMxm4bc1XBy9mHry8TMLgBM
 r17df+rx0hypZSbSLAJr8Qf1MEcUePNVEHV2wHOpUKmNKBIM8si4KRRL7BmOI5+iqrlbcdmrkB
 WHQgdA8/lpqJ9Tg5v+SEWYHEcmwKQnzOm4T3cdY2JIqr4wUATCNlmcptFdagwvkcUDFmJIHm13
 r14=
X-IronPort-AV: E=Sophos;i="5.75,252,1589212800"; 
   d="scan'208";a="140608364"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 04:02:41 +0800
IronPort-SDR: DMygmfIDZdSi9iKFbc1QNUUMHkCC+l93bxLp9S6siMvXLs3lATDXGAbKHfnw5XHDBS/WNtWPJj
 +M8kVAI8eVgX05bWhVq+v0mYpcRLJ5bdA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 12:51:19 -0700
IronPort-SDR: lSS9MdC0lT01x7YZEJMxSdooO7aOZJmx5J4yxQcctGElNPf6cUg5eI6/ZpCBeeciO/sUzmfkZp
 yi8Dic1t1FAQ==
WDCIronportException: Internal
Received: from usa001298.ad.shared (HELO localhost.hgst.com) ([10.86.58.149])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 13:02:38 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] remove workarounds for gcc bug wrt unnamed fields in initializers
Date:   Thu, 18 Jun 2020 22:02:32 +0200
Message-Id: <20200618200235.1104587-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the nvme code more uniform by initializing struct members at
declaration time. This change is done both in drivers/nvme/host/ and
drivers/nvme/target/.

This is how the design pattern was in nvme, before workarounds for a gcc
bug were introduced in commit e44ac588cd61 ("drivers/block/nvme-core.c:
fix build with gcc-4.4.4").

Since the minimum gcc version needed to build the kernel is now gcc 4.8.0,
which does not have this bug, revert to the previous design pattern,
which matches how the rest of the nvme code handles initialization
of struct members (excluding the cases where anonymous unions were
involved).

If, for some reason, we want to allow builds with gcc < 4.6.0
even though the minimum gcc version is now 4.8.0,
there is another less intrusive workaround where you add an extra pair of
curly braces, see e.g. commit 6cc65be4f6f2 ("locking/qspinlock: Fix build
for anonymous union in older GCC compilers").

Changes since v1:
-Fixed RDMA build error.

Niklas Cassel (2):
  nvme: remove workarounds for gcc bug wrt unnamed fields in
    initializers
  nvmet: remove workarounds for gcc bug wrt unnamed fields in
    initializers

 drivers/nvme/host/core.c     | 59 ++++++++++++++++++------------------
 drivers/nvme/host/lightnvm.c | 32 +++++++++----------
 drivers/nvme/host/rdma.c     | 28 ++++++++---------
 drivers/nvme/target/rdma.c   | 23 +++++++-------
 4 files changed, 71 insertions(+), 71 deletions(-)

-- 
2.26.2

