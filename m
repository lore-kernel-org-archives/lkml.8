Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B61C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589462177B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387697AbgGaSI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:08:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:9984 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387447AbgGaSI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:08:29 -0400
IronPort-SDR: /HH3Ud5u9C/4qiUAg+SHr2m280Aah0aMfuldRQeOyn48wEolRuV8B4GX43bNF43qAPQHNIXIJy
 /iPyleKZfjzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="149302911"
X-IronPort-AV: E=Sophos;i="5.75,419,1589266800"; 
   d="scan'208";a="149302911"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 11:08:28 -0700
IronPort-SDR: nWzQAVkG6AlxweHrEsSxaiB+Kvmvid+a67xDfrjm2R1Xi+VMJO6Q0x6jLz8ts+VgFBDkh5HLBB
 XfU7PIuZi2dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,419,1589266800"; 
   d="scan'208";a="321467014"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 31 Jul 2020 11:08:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2710A21D; Fri, 31 Jul 2020 21:08:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 3/3] lib/vsprintf: Force type of flags value for gfp_t
Date:   Fri, 31 Jul 2020 21:08:24 +0300
Message-Id: <20200731180825.30575-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200731180825.30575-1-andriy.shevchenko@linux.intel.com>
References: <20200731180825.30575-1-andriy.shevchenko@linux.intel.com>
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

Force type of flags value to make sparse happy.

Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: used explicit type to be forced to (Steven)
 lib/vsprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 182a3e2e1629..c155769559ab 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1937,7 +1937,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
 		names = vmaflag_names;
 		break;
 	case 'g':
-		flags = *(gfp_t *)flags_ptr;
+		flags = (__force unsigned long)(*(gfp_t *)flags_ptr);
 		names = gfpflag_names;
 		break;
 	default:
-- 
2.27.0

