Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECBCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75742207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="oBMhXsi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgE0C0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 22:26:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:49233 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgE0C0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 22:26:30 -0400
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 May 2020 22:26:28 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590546389; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=hiWqnMh4e/b60m6l+Rli4gyEkCZHAr24/SZOnCCR4Z4=; b=oBMhXsi9uChiN2g0y8mK69OZGR1MbDX4I4Wh+bBy26luFwj0A5wdjiKXe3rc5qnTA+oSRRqL
 ESUTEUX0ogLwRYuy4EBNYCy+8PjxLWSx3Wk7hu3fjpoU+wayo5SmrjlcFbXkKdthOxEamDWe
 VxyMHM98dZgjFHbni7oz6ebbR2g=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ecdce992c549984751cb2a2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 May 2020 02:21:13
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 91823C433C9; Wed, 27 May 2020 02:21:12 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36215C433C9;
        Wed, 27 May 2020 02:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36215C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: fix retry logic in f2fs_write_cache_pages()
Date:   Wed, 27 May 2020 07:50:56 +0530
Message-Id: <1590546056-17871-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case a compressed file is getting overwritten, the current retry
logic doesn't include the current page to be retried now as it sets
the new start index as 0 and new end index as writeback_index - 1.
This causes the corresponding cluster to be uncompressed and written
as normal pages without compression. Fix this by allowing writeback to
be retried for the current page as well (in case of compressed page
getting retried due to index mismatch with cluster index). So that
this cluster can be written compressed in case of overwrite.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4af5fcd..bfd1df4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3024,7 +3024,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	if ((!cycled && !done) || retry) {
 		cycled = 1;
 		index = 0;
-		end = writeback_index - 1;
+		end = retry ? -1 : writeback_index - 1;
 		goto retry;
 	}
 	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

