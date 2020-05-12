Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA2FCA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16BA2206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgELRH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 13:07:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43412 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELRH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 13:07:27 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jYYND-0001Xv-Me; Tue, 12 May 2020 17:07:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] pstore/zone,blk: fix dereference of pointer before it has been null checked
Date:   Tue, 12 May 2020 18:07:19 +0100
Message-Id: <20200512170719.221514-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the assignment of ctx dereferences pointer 'record' before
the pointer has been null checked. Fix this by only making this
dereference after it has been null checked close to the point ctx
is to be used.

Addresses-Coverity: ("Dereference before null check")
Fixes: bb4ccd1e6f56 ("pstore/zone,blk: Add ftrace frontend support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/pstore/zone.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index bd8e194110fc..c5bf3b9f644f 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -998,7 +998,7 @@ static ssize_t psz_kmsg_read(struct pstore_zone *zone,
 static ssize_t psz_ftrace_read(struct pstore_zone *zone,
 		struct pstore_record *record)
 {
-	struct psz_context *cxt = record->psi->data;
+	struct psz_context *cxt;
 	struct psz_buffer *buf;
 	int ret;
 
@@ -1018,6 +1018,7 @@ static ssize_t psz_ftrace_read(struct pstore_zone *zone,
 		return ret;
 
 out:
+	cxt = record->psi->data;
 	if (cxt->ftrace_read_cnt < cxt->ftrace_max_cnt)
 		/* then, read next ftrace zone */
 		return -ENOMSG;
-- 
2.25.1

