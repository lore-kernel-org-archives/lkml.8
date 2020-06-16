Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AAFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85DE6207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592329831;
	bh=vo4tH3JRZUJ1nQkMWCc000fvUfJXx5ueaLCb1PSk8uU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=KRQwD8Ajbn83CjvFYOm7Jw7cWf+Ryiz61P6j2G83VSWEdX7cDRnrakNtvqcFgQxZ9
	 65NdhzTdfkKf+RFaRXlf8GQ/9TuXHaJ8WjEzcac5YfidNAdWdOy6+XW/Ty8Fa4a/qN
	 9ZWEGVG7NaCsk5kudQYJoV7g2pvVmsbdgbPk4j2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbgFPRu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728785AbgFPRu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 13:50:26 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1CA620776;
        Tue, 16 Jun 2020 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592329826;
        bh=vo4tH3JRZUJ1nQkMWCc000fvUfJXx5ueaLCb1PSk8uU=;
        h=Date:From:To:Cc:Subject:From;
        b=mPhNysb5XINMVXSr+gdSMOxrCo3cC6siFgnYxaBDyt/nZDVNnIc5bME+WsgB/Pkcl
         VVH+gv14j50XOdzX16v/Bmyu9Flzt1BhcVpAou1II35xr4uaaI1/0HcbJe+LeBBuN9
         I0cdk3Y+ZY0el0rGWWOemreqb/YEGASJy4jsh9WQ=
Date:   Tue, 16 Jun 2020 12:55:43 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2][next] staging: rts5208: Use array_size() helper in
 vmalloc() and memset()
Message-ID: <20200616175543.GA28687@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vmalloc() function has no 2-factor argument form, so multiplication
factors need to be wrapped in array_size(). Also, while there, use
array_size() in memset().

This issue was found with the help of Coccinelle and, audited and fixed
manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Fix subject line and commit message. Previously, part of the subject
   line, unintentionally, sneaked into the commit message.

 drivers/staging/rts5208/ms.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
index d53dd138a356..9001570a8c94 100644
--- a/drivers/staging/rts5208/ms.c
+++ b/drivers/staging/rts5208/ms.c
@@ -2306,14 +2306,14 @@ static int ms_build_l2p_tbl(struct rtsx_chip *chip, int seg_no)
 		if (!segment->l2p_table)
 			goto BUILD_FAIL;
 	}
-	memset((u8 *)(segment->l2p_table), 0xff, table_size * 2);
+	memset((u8 *)(segment->l2p_table), 0xff, array_size(table_size, 2));
 
 	if (!segment->free_table) {
-		segment->free_table = vmalloc(MS_FREE_TABLE_CNT * 2);
+		segment->free_table = vmalloc(array_size(MS_FREE_TABLE_CNT, 2));
 		if (!segment->free_table)
 			goto BUILD_FAIL;
 	}
-	memset((u8 *)(segment->free_table), 0xff, MS_FREE_TABLE_CNT * 2);
+	memset((u8 *)(segment->free_table), 0xff, array_size(MS_FREE_TABLE_CNT, 2));
 
 	start = (u16)seg_no << 9;
 	end = (u16)(seg_no + 1) << 9;
-- 
2.27.0

