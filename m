Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E86C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D16822075F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgG2Dos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:44:48 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:52800 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726245AbgG2Dos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 23:44:48 -0400
X-IronPort-AV: E=Sophos;i="5.75,408,1589212800"; 
   d="scan'208";a="97041138"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Jul 2020 11:44:42 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 0B1834CE38CB;
        Wed, 29 Jul 2020 11:44:38 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 29 Jul 2020 11:44:37 +0800
Received: from localhost.localdomain (10.167.225.206) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Wed, 29 Jul 2020 11:44:37 +0800
From:   Hao Li <lihao2018.fnst@cn.fujitsu.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
        <linux-fsdevel@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-kernel@vger.kernel.org>, <lihao2018.fnst@cn.fujitsu.com>
Subject: [PATCH] dax: Fix wrong error-number passed into xas_set_err()
Date:   Wed, 29 Jul 2020 11:44:36 +0800
Message-ID: <20200729034436.24267-1-lihao2018.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 0B1834CE38CB.A1DB9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lihao2018.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error-number passed into xas_set_err() should be negative. Otherwise,
the xas_error() will return 0, and grab_mapping_entry() will return the
found entry instead of a SIGBUS error when the entry is not a value.
And then, the subsequent code path would be wrong.

Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 11b16729b86f..acac675fe7a6 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -488,7 +488,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 		if (dax_is_conflict(entry))
 			goto fallback;
 		if (!xa_is_value(entry)) {
-			xas_set_err(xas, EIO);
+			xas_set_err(xas, -EIO);
 			goto out_unlock;
 		}
 
-- 
2.28.0



