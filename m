Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA8EC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497FD2071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgHaNc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 09:32:26 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55119 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgHaNbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 09:31:22 -0400
X-Originating-IP: 84.44.14.226
Received: from nexussix.ar.arcelik (unknown [84.44.14.226])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 37A4D20005;
        Mon, 31 Aug 2020 13:31:09 +0000 (UTC)
From:   Cengiz Can <cengiz@kernel.wtf>
To:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Cengiz Can <cengiz@kernel.wtf>
Subject: [PATCH] staging: atomisp: Fix fallthrough keyword warning
Date:   Mon, 31 Aug 2020 16:30:12 +0300
Message-Id: <20200831133011.91258-1-cengiz@kernel.wtf>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit df561f6688fe ("treewide: Use fallthrough pseudo-keyword") from
Gustavo A. R. Silva replaced and standardized /* fallthrough */ comments
with 'fallthrough' pseudo-keyword.

However, in one of the switch-case statements, Coverity Static Analyzer
throws a warning that 'fallthrough' is unreachable due to the adjacent
'return false' statement.

Since 'fallthrough' is actually an empty "do {} while(0)" this might be
due to compiler optimizations. But that needs further investigation.

In order to fix the unreachable code warning, make adjacent 'return
false' a part of the previous if statement's else clause.

Reported-by: Coverity Static Analyzer CID 1466511
Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
---
 drivers/staging/media/atomisp/pci/atomisp_compat_css20.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
index 1b2b2c68025b..aaa2d0e0851b 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
@@ -709,8 +709,8 @@ static bool is_pipe_valid_to_current_run_mode(struct atomisp_sub_device *asd,
 		if (pipe_id == IA_CSS_PIPE_ID_CAPTURE ||
 		    pipe_id == IA_CSS_PIPE_ID_PREVIEW)
 			return true;
-
-		return false;
+		else
+			return false;
 		fallthrough;
 	case ATOMISP_RUN_MODE_VIDEO:
 		if (!asd->continuous_mode->val) {
-- 
2.28.0

