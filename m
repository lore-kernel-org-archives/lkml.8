Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4110EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0378620772
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591197156;
	bh=KWFBsll9HGUfZ4R12kYQEDC71yH0LO07oDOecGGX1gE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ap6QfoiJEQiQArvE2nOTKsvxUwZESFIjZ+jCxhYxjsT9xK8DRzbseyAAzMdqy1LYi
	 6GikLym7+ti236uXb1+iD7KPJAnH6++3VhGLziKww1z2mz2/WPhWUxLuvXgH/HdDRe
	 dP6oZ2bfTMELolJR2a3zGjBmINgRPLRvEjMWG4LU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgFCPMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbgFCPMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:12:34 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3026F206E6;
        Wed,  3 Jun 2020 15:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591197154;
        bh=KWFBsll9HGUfZ4R12kYQEDC71yH0LO07oDOecGGX1gE=;
        h=From:To:Cc:Subject:Date:From;
        b=sKH5G5sLHMI6gplPsIj90aUd4PNiT4FOwaZhFsikRBearsdJn+bm0O3vONgGxMLrI
         yfoYiCBhUmnRmGkB/S000V/TDuTh13QlKMnof6Zv6ExIcUIN7x6HsjcVE/EELQx5an
         C9SfJlbEHDFfOUbsKIVSjWA7n+rNHr+AdS7xIiVg=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH] scs: Report SCS usage in bytes rather than number of entries
Date:   Wed,  3 Jun 2020 16:12:17 +0100
Message-Id: <20200603151218.11659-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the SCS debug usage check so that we report the number of bytes
usedm, rather than the number of entries.

Fixes: 5bbaf9d1fcb9 ("scs: Add support for stack usage debugging")
Reported-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/scs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/scs.c b/kernel/scs.c
index 222a7a9ad543..5d4d9bbdec36 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -74,7 +74,7 @@ static void scs_check_usage(struct task_struct *tsk)
 	for (p = task_scs(tsk); p < __scs_magic(tsk); ++p) {
 		if (!READ_ONCE_NOCHECK(*p))
 			break;
-		used++;
+		used += sizeof(*p);
 	}
 
 	while (used > curr) {
-- 
2.27.0.rc2.251.g90737beb825-goog

