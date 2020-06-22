Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653B6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D02E25480
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbgFVHyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:54:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:30156 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731412AbgFVHyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:54:12 -0400
IronPort-SDR: 85C0lLCPOWRM6jTI/e44wfqbzgCw5BiCa/qdzAqmGh6Z2uAS98wbm5QdUvU9MGELlY27k45D3k
 GIF0oiQfTzDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="132117252"
X-IronPort-AV: E=Sophos;i="5.75,266,1589266800"; 
   d="scan'208";a="132117252"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 00:54:12 -0700
IronPort-SDR: Xg6Yslcxo7KOSm3oXQ2w0aPWKEwRBA0OmnOEYUdmLUfofTY5zlfyEDRplFdarueAfOVGzugmps
 LjZxpCSTjcMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,266,1589266800"; 
   d="scan'208";a="353364613"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2020 00:54:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1B45D119; Mon, 22 Jun 2020 10:53:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] uuid: Remove unused uuid_le_to_bin() definition
Date:   Mon, 22 Jun 2020 10:53:55 +0300
Message-Id: <20200622075355.55936-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no more user, so remove it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/uuid.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/uuid.h b/include/linux/uuid.h
index d41b0d3e9474..8cdc0d3567cd 100644
--- a/include/linux/uuid.h
+++ b/include/linux/uuid.h
@@ -98,8 +98,6 @@ int guid_parse(const char *uuid, guid_t *u);
 int uuid_parse(const char *uuid, uuid_t *u);
 
 /* backwards compatibility, don't use in new code */
-#define uuid_le_to_bin(guid, u)	guid_parse(guid, u)
-
 static inline int uuid_le_cmp(const guid_t u1, const guid_t u2)
 {
 	return memcmp(&u1, &u2, sizeof(guid_t));
-- 
2.27.0

