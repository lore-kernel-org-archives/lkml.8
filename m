Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E0DC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 05:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B80A206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 05:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgDUFsw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 01:48:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:38092 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgDUFsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 01:48:51 -0400
IronPort-SDR: bkhuFw1im6FFfVjAHtrWZc4+4CxXmkV+avtUl4neYaq3gp9L7tBc/TS3HUjtMpeIpm2i/USQJ0
 MLqDE/TR4daQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 22:48:51 -0700
IronPort-SDR: Pjbwqoqp+nzpCN/9HOJkzILLbwaYZ2ma16BNEuKVYIogj2NxTTGuNaFk5t/WP4AWGWq21Z7aQI
 9jroOh0fvL6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,409,1580803200"; 
   d="scan'208,223";a="273413806"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga002.jf.intel.com with ESMTP; 20 Apr 2020 22:48:51 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Apr 2020 22:48:51 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Apr 2020 22:48:50 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.129]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.209]) with mapi id 14.03.0439.000;
 Tue, 21 Apr 2020 13:48:47 +0800
From:   "Ma, Jianpeng" <jianpeng.ma@intel.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: block: remove unused header
Thread-Topic: block: remove unused header
Thread-Index: AdYXnf3uKjeYARGJQAmjAgUvtEsVyA==
Date:   Tue, 21 Apr 2020 05:48:46 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C73C546B1@SHSMSX101.ccr.corp.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 95218bc1d79f2bcbdd8819be26efa698868a34ca Mon Sep 17 00:00:00 2001
From: Jianpeng Ma <jianpeng.ma@intel.com>
Date: Tue, 21 Apr 2020 01:15:24 -0400
Subject: [PATCH] block: remove unused header.

Dax related code already removed from this file.

Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
---
 fs/block_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 52b6f646cdbd..4163435dc231 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -19,7 +19,6 @@
 #include <linux/module.h>
 #include <linux/blkpg.h>
 #include <linux/magic.h>
-#include <linux/dax.h>
 #include <linux/buffer_head.h>
 #include <linux/swap.h>
 #include <linux/pagevec.h>
-- 
2.17.1

