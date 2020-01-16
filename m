Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AAFC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B522051A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198995;
	bh=UT/9yJA7WLAXr38wzBDo6dD4fF4s8HfezFiBEZcbVJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NRe+d0Q+LlUve2UKRMf0vihxaXtomgQMTTX4rmonJtNQkwOSlT05K26q5VNc1Y56A
	 U3frWHGw/S98Dosn9iU7dGnpwShfErFVnxyJL9fia+bgqnwCvMY5ENXkLvTtcBK3W0
	 hCuG8P49Zd+BXwppm27AX+0ftlG8A5TU/TIJQtC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436561AbgAPSXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:23:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392452AbgAPR1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:27:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C79F1246D4;
        Thu, 16 Jan 2020 17:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195639;
        bh=UT/9yJA7WLAXr38wzBDo6dD4fF4s8HfezFiBEZcbVJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QvPpsz6TUPwGlGkpBCy5L9SWncGjKQhNZtBmIvhwE8+n7SLtpzDJkGXjBePR4PgSX
         79jrS71IEG1vIV5s7HFds1IqebdHbnly7S2ak88lEHbeL9IN8xQxC24sv2R/vSni3c
         JRb6he95dfMtrMWFphe0itOKcg8XhA74JrQTNbxo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Robert Richter <rrichter@marvell.com>,
        Borislav Petkov <bp@suse.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 204/371] EDAC/mc: Fix edac_mc_find() in case no device is found
Date:   Thu, 16 Jan 2020 12:21:16 -0500
Message-Id: <20200116172403.18149-147-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Richter <rrichter@marvell.com>

[ Upstream commit 29a0c843973bc385918158c6976e4dbe891df969 ]

The function should return NULL in case no device is found, but it
always returns the last checked mc device from the list even if the
index did not match. Fix that.

I did some analysis why this did not raise any issues for about 3 years
and the reason is that edac_mc_find() is mostly used to search for
existing devices. Thus, the bug is not triggered.

 [ bp: Drop the if (mci->mc_idx > idx) test in favor of readability. ]

Fixes: c73e8833bec5 ("EDAC, mc: Fix locking around mc_devices list")
Signed-off-by: Robert Richter <rrichter@marvell.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Link: https://lkml.kernel.org/r/20190514104838.15065-1-rrichter@marvell.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/edac_mc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index f7fa05fee45a..329021189c38 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -680,22 +680,18 @@ static int del_mc_from_global_list(struct mem_ctl_info *mci)
 
 struct mem_ctl_info *edac_mc_find(int idx)
 {
-	struct mem_ctl_info *mci = NULL;
+	struct mem_ctl_info *mci;
 	struct list_head *item;
 
 	mutex_lock(&mem_ctls_mutex);
 
 	list_for_each(item, &mc_devices) {
 		mci = list_entry(item, struct mem_ctl_info, link);
-
-		if (mci->mc_idx >= idx) {
-			if (mci->mc_idx == idx) {
-				goto unlock;
-			}
-			break;
-		}
+		if (mci->mc_idx == idx)
+			goto unlock;
 	}
 
+	mci = NULL;
 unlock:
 	mutex_unlock(&mem_ctls_mutex);
 	return mci;
-- 
2.20.1

