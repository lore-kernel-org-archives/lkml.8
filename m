Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16013C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC4D12074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgFBPfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 11:35:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42396 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFBPfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:35:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jg8wU-0004wo-Ar; Tue, 02 Jun 2020 15:35:06 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH][next] afs: fix double kfree on cell_name on error exit path
Date:   Tue,  2 Jun 2020 16:35:05 +0100
Message-Id: <20200602153505.64714-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The error exit path is currently kfree'ing cell_name for a second time,
the previous kfree of this object occurred a statement earlier. Fix this
by removing it.

Addresses-Coverity: ("Double free")
Fixes: 6147fe6b7f8c ("afs: Detect cell aliases 3 - YFS Cells with a canonical cell name op")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/afs/vl_alias.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index 6c1cf702478e..093895c49c21 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -315,10 +315,8 @@ static int yfs_check_canonical_cell_name(struct afs_cell *cell, struct key *key)
 	master = afs_lookup_cell(cell->net, cell_name, strlen(cell_name),
 				 NULL, false);
 	kfree(cell_name);
-	if (IS_ERR(master)) {
-		kfree(cell_name);
+	if (IS_ERR(master))
 		return PTR_ERR(master);
-	}
 
 	cell->alias_of = master; /* Transfer our ref */
 	return 1;
-- 
2.25.1

