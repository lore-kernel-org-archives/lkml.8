Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6D4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 231B620678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgHCIfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:35:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:64326 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgHCIfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:35:23 -0400
IronPort-SDR: PCIwu31a99ZIPZAfAQrKMn6/zDoFnUCrz+MrJXwtZUmAXqVLOqGVb8i//2raihwebfFnJKlT7z
 CKM2ziEnqk8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="170167413"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="170167413"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 01:35:23 -0700
IronPort-SDR: psk96n0WJY41Q6O4dadqgbryzw4GsfAdJLGAg0LvXvkUUWmIA8ZU86MB4BGQsrPPs9/05iCNhX
 AsyirfIe2sVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="273861647"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 03 Aug 2020 01:35:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1F2CB130; Mon,  3 Aug 2020 11:35:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] kobject: Drop unneeded conditional in __kobject_del()
Date:   Mon,  3 Aug 2020 11:35:20 +0300
Message-Id: <20200803083520.5460-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__kobject_del() is called from two places, in one where kobj is dereferenced
before and thus can't be NULL, and in the other the NULL check is done before
call. Drop unneeded conditional in __kobject_del().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

It is possible after refactoring kobject_del(). Though I decided to do it in
a separate change (no need to backport) for better test coverage.

 lib/kobject.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 9dce68c378e6..ea53b30cf483 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -604,9 +604,6 @@ static void __kobject_del(struct kobject *kobj)
 	struct kernfs_node *sd;
 	const struct kobj_type *ktype;
 
-	if (!kobj)
-		return;
-
 	sd = kobj->sd;
 	ktype = get_ktype(kobj);
 
-- 
2.27.0

