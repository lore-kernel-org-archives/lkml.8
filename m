Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DFBCA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F3F205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgELRTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 13:19:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43977 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgELRTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 13:19:39 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jYYZ2-0002Sf-8n; Tue, 12 May 2020 17:19:32 +0000
From:   Colin King <colin.king@canonical.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] pstore/zone: fix dereference of pointer before it has been null checked
Date:   Tue, 12 May 2020 18:19:32 +0100
Message-Id: <20200512171932.222102-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the assignment of cnt dereferences pointer 'record' before
the pointer has been null checked. Fix this by only making this
dereference after it has been null checked close to the point cnt
is to be used.

Addresses-Coverity: ("Dereference before null check")
Fixes: 637ce64e7f57 ("pstore/zone,blk: Add support for pmsg frontend")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/pstore/zone.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index c5bf3b9f644f..3cf7d6762c76 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -825,7 +825,7 @@ static int notrace psz_record_write(struct pstore_zone *zone,
 		struct pstore_record *record)
 {
 	size_t start, rem;
-	int cnt = record->size;
+	int cnt;
 	bool is_full_data = false;
 	char *buf = record->buf;
 
@@ -835,6 +835,7 @@ static int notrace psz_record_write(struct pstore_zone *zone,
 	if (atomic_read(&zone->buffer->datalen) >= zone->buffer_size)
 		is_full_data = true;
 
+	cnt = record->size;
 	if (unlikely(cnt > zone->buffer_size)) {
 		buf += cnt - zone->buffer_size;
 		cnt = zone->buffer_size;
-- 
2.25.1

