Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870E7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E1AC2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444851;
	bh=Fh3l6Co060xtOLUSOhxLI5YMyHj64IyT1hO8obagLKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zi7O0wB9OIONUclTo/10Rr3mVH4a0gUUZeYRw8sHFJzPCsekGe857COklhCHVQu7c
	 C8oyywhKlQ/qRwMK/7oH+HuUhYkuN9RNYY2AkvTPzi45S/UtpTi9HPgDnkkg/OQ0xV
	 JmAaY6IJ7OmIKJxqmC5TFYW0uWvnJ9kLDQXn26t8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732303AbgFRBr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732044AbgFRB2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:28:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4274F22200;
        Thu, 18 Jun 2020 01:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443691;
        bh=Fh3l6Co060xtOLUSOhxLI5YMyHj64IyT1hO8obagLKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYNRGbppiuQ02NIZYFVBNBojXu7IBGIgwb8H430TMgNMsaNY26QruJufvHS7Z+slK
         x65dHg/vIEuksVWywrfRkNXZqcDdVsyHHp/btnJUYuZR5RrbIWf3ev0qz7o9N4eUo5
         gHVAXw/wCxG+D30U0g/KasYxdcBjgBqH/4s/arLM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 103/108] blktrace: fix endianness for blk_log_remap()
Date:   Wed, 17 Jun 2020 21:25:55 -0400
Message-Id: <20200618012600.608744-103-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012600.608744-1-sashal@kernel.org>
References: <20200618012600.608744-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

[ Upstream commit 5aec598c456fe3c1b71a1202cbb42bdc2a643277 ]

The function blk_log_remap() can be simplified by removing the
call to get_pdu_remap() that copies the values into extra variable to
print the data, which also fixes the endiannness warning reported by
sparse.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/blktrace.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index be97e0b4ae7d..304a164f5e7e 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1289,17 +1289,6 @@ static __u64 get_pdu_int(const struct trace_entry *ent, bool has_cg)
 	return be64_to_cpu(*val);
 }
 
-static void get_pdu_remap(const struct trace_entry *ent,
-			  struct blk_io_trace_remap *r, bool has_cg)
-{
-	const struct blk_io_trace_remap *__r = pdu_start(ent, has_cg);
-	__u64 sector_from = __r->sector_from;
-
-	r->device_from = be32_to_cpu(__r->device_from);
-	r->device_to   = be32_to_cpu(__r->device_to);
-	r->sector_from = be64_to_cpu(sector_from);
-}
-
 typedef void (blk_log_action_t) (struct trace_iterator *iter, const char *act,
 	bool has_cg);
 
@@ -1425,13 +1414,13 @@ static void blk_log_with_error(struct trace_seq *s,
 
 static void blk_log_remap(struct trace_seq *s, const struct trace_entry *ent, bool has_cg)
 {
-	struct blk_io_trace_remap r = { .device_from = 0, };
+	const struct blk_io_trace_remap *__r = pdu_start(ent, has_cg);
 
-	get_pdu_remap(ent, &r, has_cg);
 	trace_seq_printf(s, "%llu + %u <- (%d,%d) %llu\n",
 			 t_sector(ent), t_sec(ent),
-			 MAJOR(r.device_from), MINOR(r.device_from),
-			 (unsigned long long)r.sector_from);
+			 MAJOR(be32_to_cpu(__r->device_from)),
+			 MINOR(be32_to_cpu(__r->device_from)),
+			 be64_to_cpu(__r->sector_from));
 }
 
 static void blk_log_plug(struct trace_seq *s, const struct trace_entry *ent, bool has_cg)
-- 
2.25.1

