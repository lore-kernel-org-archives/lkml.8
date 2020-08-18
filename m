Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB6CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B9D92065D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="dMbi2fS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgHRKKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 06:10:50 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:51858 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726474AbgHRKKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:10:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597745449; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ZqdfiOl3V2XHQ+7fvDCyYwpDqR8H0z0A3Kkm9UxBNwU=; b=dMbi2fS1D5HAysYnA5srjnu6u4KeGtux5OZE+ag81LKifUBIK/YPnLAlNR7BJcWCjyFJJES/
 U7FleqKAqm5nmiHVQ59GAK0fFcgNYBGC6jruRb4zQStkBHjbO9LIjEZR0DpZP0gXO9HLaIvy
 lHWPXJt05HXLBU9gQ+PGRXYzpI4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f3ba92591f8def8b264eaa4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 10:10:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EE80BC43395; Tue, 18 Aug 2020 10:10:43 +0000 (UTC)
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CE0ADC433CB;
        Tue, 18 Aug 2020 10:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE0ADC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] f2fs: fix indefinite loop scanning for free nid
Date:   Tue, 18 Aug 2020 15:40:14 +0530
Message-Id: <1597745414-13135-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the sbi->ckpt->next_free_nid is not NAT block aligned and if there
are free nids in that NAT block between the start of the block and
next_free_nid, then those free nids will not be scanned in scan_nat_page().
This results into mismatch between nm_i->available_nids and the sum of
nm_i->free_nid_count of all NAT blocks scanned. And nm_i->available_nids
will always be greater than the sum of free nids in all the blocks.
Under this condition, if we use all the currently scanned free nids,
then it will loop forever in f2fs_alloc_nid() as nm_i->available_nids
is still not zero but nm_i->free_nid_count of that partially scanned
NAT block is zero.

Fix this to align the nm_i->next_scan_nid to the first nid of the
corresponding NAT block.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
v2:
- address Chao's comments to move the check to beginning of function
and to add unlikely 

 fs/f2fs/node.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9bbaa26..a2ddca1 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2373,6 +2373,9 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
 	if (unlikely(nid >= nm_i->max_nid))
 		nid = 0;
 
+	if (unlikely(nid % NAT_ENTRY_PER_BLOCK))
+		nid = NAT_BLOCK_OFFSET(nid) * NAT_ENTRY_PER_BLOCK;
+
 	/* Enough entries */
 	if (nm_i->nid_cnt[FREE_NID] >= NAT_ENTRY_PER_BLOCK)
 		return 0;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

