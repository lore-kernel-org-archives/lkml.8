Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912F2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59CC420748
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653384;
	bh=LH6KfOFAuiAo8bo2kq2zE0/ec7aS2WUgR/NPwDfufoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iQp4kJ5D6/VkPktd0zMXKlOWS00wGfNkcXKNCALcQ26bCJBs9X1Ss3YheEPDNhAiH
	 G0nFUgUeArPxXOdZJsZXsH/i7rqPrP+7xkIgMGyqjRCHCCSu2xPx/JTIenXzD8ifN4
	 Fc1BCs/ZmlAXTxieJSWktfS41eLm4LaTxatJzlXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgGBB1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729218AbgGBB0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:26:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC94720884;
        Thu,  2 Jul 2020 01:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593653196;
        bh=LH6KfOFAuiAo8bo2kq2zE0/ec7aS2WUgR/NPwDfufoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JVa5RAB/9BmAAL/0G85uD9KurQzTeIfG0iR+BkLhFijGel385ooxtYnTMrrVyTBme
         lyEvCHvBnP6jjK55P37DqMfkmg03yZ3jRVREb3ImXW3GdGH+eWUgvKpeLSy+9qWTnt
         /CHOVe3VXWk0TzdoIRY0wSEXHBrQt2mn4BG44fs4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 17/27] s390/debug: avoid kernel warning on too large number of pages
Date:   Wed,  1 Jul 2020 21:26:05 -0400
Message-Id: <20200702012615.2701532-17-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012615.2701532-1-sashal@kernel.org>
References: <20200702012615.2701532-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

[ Upstream commit 827c4913923e0b441ba07ba4cc41e01181102303 ]

When specifying insanely large debug buffers a kernel warning is
printed. The debug code does handle the error gracefully, though.
Instead of duplicating the check let us silence the warning to
avoid crashes when panic_on_warn is used.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index d374f9b218b4c..04bbf7e97fea7 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -198,9 +198,10 @@ static debug_entry_t ***debug_areas_alloc(int pages_per_area, int nr_areas)
 	if (!areas)
 		goto fail_malloc_areas;
 	for (i = 0; i < nr_areas; i++) {
+		/* GFP_NOWARN to avoid user triggerable WARN, we handle fails */
 		areas[i] = kmalloc_array(pages_per_area,
 					 sizeof(debug_entry_t *),
-					 GFP_KERNEL);
+					 GFP_KERNEL | __GFP_NOWARN);
 		if (!areas[i])
 			goto fail_malloc_areas2;
 		for (j = 0; j < pages_per_area; j++) {
-- 
2.25.1

