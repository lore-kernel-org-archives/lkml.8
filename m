Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7D5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 289982177B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387718AbgGaSIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:08:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:31216 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387690AbgGaSI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:08:29 -0400
IronPort-SDR: zAOD4gw6wIUBuyRuomjN95LumTCDlEMfPsC/3zhly3zjJvCzGZEQSKXXGwaJgoqfgFAO2AmFbf
 TEdMyBdI/kNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="151048006"
X-IronPort-AV: E=Sophos;i="5.75,419,1589266800"; 
   d="scan'208";a="151048006"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 11:08:29 -0700
IronPort-SDR: FBVUdylZNpHG3CvMCmgQ5D6Pp2m+kCZnULRedL0TwZK11jjyNFLZU2gMDphYv8DyWzy/o3ZRen
 n0wqNkLGpc8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,419,1589266800"; 
   d="scan'208";a="491079848"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jul 2020 11:08:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1CD7195; Fri, 31 Jul 2020 21:08:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh@kernel.org>, Joe Perches <joe@perches.com>,
        Grant Likely <grant.likely@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 2/3] lib/vsprintf: Replace custom spec to print decimals with generic one
Date:   Fri, 31 Jul 2020 21:08:23 +0300
Message-Id: <20200731180825.30575-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200731180825.30575-1-andriy.shevchenko@linux.intel.com>
References: <20200731180825.30575-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When printing phandle via %pOFp the custom spec is used. First of all,
it has a SMALL flag which makes no sense for decimal numbers. Second,
we have already default spec for decimal numbers. Use the latter in
the %pOFp case as well.

Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Joe Perches <joe@perches.com>
Cc: Grant Likely <grant.likely@arm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
v2: added people, updated commit message to reflect %pOFp, added tag (Steven)
 lib/vsprintf.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index f90f09682977..182a3e2e1629 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1979,12 +1979,6 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	char *buf_start = buf;
 	struct property *prop;
 	bool has_mult, pass;
-	static const struct printf_spec num_spec = {
-		.flags = SMALL,
-		.field_width = -1,
-		.precision = -1,
-		.base = 10,
-	};
 
 	struct printf_spec str_spec = spec;
 	str_spec.field_width = -1;
@@ -2024,7 +2018,7 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 			str_spec.precision = precision;
 			break;
 		case 'p':	/* phandle */
-			buf = number(buf, end, (unsigned int)dn->phandle, num_spec);
+			buf = number(buf, end, (unsigned int)dn->phandle, default_dec_spec);
 			break;
 		case 'P':	/* path-spec */
 			p = fwnode_get_name(of_fwnode_handle(dn));
-- 
2.27.0

