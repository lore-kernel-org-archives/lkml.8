Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEC6C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78D720738
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgDVPD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:03:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:58116 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgDVPDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 86AFBAE68;
        Wed, 22 Apr 2020 15:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 89B5F1E0E61; Wed, 22 Apr 2020 17:03:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 12/23] mm: Use xas_erase() in collapse_file()
Date:   Wed, 22 Apr 2020 17:02:45 +0200
Message-Id: <20200422150256.23473-13-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422150256.23473-1-jack@suse.cz>
References: <20200422150256.23473-1-jack@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When undoing failed collapse of ordinary pages into a huge page, use
xas_erase() to explicitly clear any xarray marks that may have been
added to entries.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 99d77ffb79c2..8da820c02de7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1819,7 +1819,7 @@ static void collapse_file(struct mm_struct *mm,
 					break;
 				nr_none--;
 				/* Put holes back where they were */
-				xas_store(&xas, NULL);
+				xas_erase(&xas);
 				continue;
 			}
 
-- 
2.16.4

