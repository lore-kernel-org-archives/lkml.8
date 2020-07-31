Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2C5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6946A206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733296AbgGaMby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:31:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:51730 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733262AbgGaMbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:31:49 -0400
IronPort-SDR: aSCoe/vZ5hTkDdRKteISrBMA5xab3kWSxQsnx5R/uSOt0G2Rw2gPBRp3WKMazQBHBAp/4pyImy
 jl8xcGdixeqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="139748630"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="139748630"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 05:31:48 -0700
IronPort-SDR: G40QK3BiuqeB7HxFknKpW/e2Ha8BN+hM3T2UMaYA3pkcWay+UfX7Bro/dY08NoIhMWXmUQTAZf
 Ysj6Prcz07bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="273192473"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 31 Jul 2020 05:31:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4BDBF359; Fri, 31 Jul 2020 15:31:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] lib/vsprintf: Force type of flags for gfp_t
Date:   Fri, 31 Jul 2020 15:31:45 +0300
Message-Id: <20200731123145.22357-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200731123145.22357-1-andriy.shevchenko@linux.intel.com>
References: <20200731123145.22357-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse is not happy about restricted type being assigned:
  lib/vsprintf.c:1940:23: warning: incorrect type in assignment (different base types)
  lib/vsprintf.c:1940:23:    expected unsigned long [assigned] flags
  lib/vsprintf.c:1940:23:    got restricted gfp_t [usertype]

Force type of flags to make sparse happy.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 90d818ef03c5..118e2727d058 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1937,7 +1937,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
 		names = vmaflag_names;
 		break;
 	case 'g':
-		flags = *(gfp_t *)flags_ptr;
+		flags = (__force typeof(flags))(*(gfp_t *)flags_ptr);
 		names = gfpflag_names;
 		break;
 	default:
-- 
2.27.0

