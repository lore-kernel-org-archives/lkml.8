Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30557C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BE3A2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgFVPf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:35:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42931 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729224AbgFVPf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:35:58 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jnOU6-00034z-Ab; Mon, 22 Jun 2020 15:35:46 +0000
From:   Colin King <colin.king@canonical.com>
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] mm/zswap: fix a couple of memory leaks and rework kzalloc failure check
Date:   Mon, 22 Jun 2020 16:35:46 +0100
Message-Id: <20200622153546.49880-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

kzalloc failures return NULL on out of memory errors, so replace the
IS_ERR_OR_NULL check with the usual null pointer check.  Fix two memory
leaks with on acomp and acomp_ctx by ensuring these objects are free'd
on the error return path.

Addresses-Coverity: ("Resource leak")
Fixes: d4f86abd6e35 ("mm/zswap: move to use crypto_acomp API for hardware acceleration")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 mm/zswap.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 0d914ba6b4a0..14839cbac7ff 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -433,23 +433,23 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 		return 0;
 
 	acomp_ctx = kzalloc(sizeof(*acomp_ctx), GFP_KERNEL);
-	if (IS_ERR_OR_NULL(acomp_ctx)) {
+	if (!acomp_ctx) {
 		pr_err("Could not initialize acomp_ctx\n");
 		return -ENOMEM;
 	}
 	acomp = crypto_alloc_acomp(pool->tfm_name, 0, 0);
-	if (IS_ERR_OR_NULL(acomp)) {
+	if (!acomp) {
 		pr_err("could not alloc crypto acomp %s : %ld\n",
 				pool->tfm_name, PTR_ERR(acomp));
-		return -ENOMEM;
+		goto free_acomp_ctx;
 	}
 	acomp_ctx->acomp = acomp;
 
 	req = acomp_request_alloc(acomp_ctx->acomp);
-	if (IS_ERR_OR_NULL(req)) {
+	if (!req) {
 		pr_err("could not alloc crypto acomp %s : %ld\n",
 		       pool->tfm_name, PTR_ERR(acomp));
-		return -ENOMEM;
+		goto free_acomp;
 	}
 	acomp_ctx->req = req;
 
@@ -462,6 +462,12 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 	*per_cpu_ptr(pool->acomp_ctx, cpu) = acomp_ctx;
 
 	return 0;
+
+free_acomp:
+	kfree(acomp);
+free_acomp_ctx:
+	kfree(acomp_ctx);
+	return -ENOMEM;
 }
 
 static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
-- 
2.27.0

