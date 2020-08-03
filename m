Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865BBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 07:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 644882068F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 07:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgHCHjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 03:39:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:42699 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgHCHjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 03:39:03 -0400
IronPort-SDR: oDQgT4ftQIQcZrVMgrZawjt3FU+pw+nru3Qzh8NKVKRYs7TUSLKgpl4Bq1RAjWgx6Fv0+v/bi4
 ljdJjzavJb2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="132119042"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="132119042"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 00:39:02 -0700
IronPort-SDR: sRn8YPHQGXW0yOEBBTt8qqgg4d8e+r39AI12m2c75yHXA7t36ehtFt5xAObiGkhZqVpn3QZkBz
 SSjBOtXpWWkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="491734962"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2020 00:39:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 484CF130; Mon,  3 Aug 2020 10:39:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v1] kobject: Restore old behaviour of kobject_del(NULL)
Date:   Mon,  3 Aug 2020 10:38:59 +0300
Message-Id: <20200803073859.43664-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 079ad2fb4bf9 ("kobject: Avoid premature parent object freeing in
kobject_cleanup()") inadvertently dropped a possibility to call kobject_del()
with NULL pointer. Restore the old behaviour.

Fixes: 079ad2fb4bf9 ("kobject: Avoid premature parent object freeing in kobject_cleanup()")
Reported-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/kobject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 3afb939f2a1c..f5f5273031d2 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -637,7 +637,7 @@ static void __kobject_del(struct kobject *kobj)
  */
 void kobject_del(struct kobject *kobj)
 {
-	struct kobject *parent = kobj->parent;
+	struct kobject *parent = kobj ? kobj->parent : NULL;
 
 	__kobject_del(kobj);
 	kobject_put(parent);
-- 
2.27.0

