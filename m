Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528B3C35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212F82467A
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582424628;
	bh=fbzw3Pn7cP5CyCmMaoGnl/JxtaOazCYdtc8rjGGmI2Q=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZYKokSgkZmSAbaA/Ar9JhRUQgTGCG9MtGF0AswMCO6I4majdkcqJgPyOzIDikiphs
	 ZPRQzf9cmViJZD6xwK8GA+8RcLEGTBf18URw1fyDyY/9/2u/WF3zXGbOOdGhrwSppe
	 KYKYnEUSaVKHaO1e39ibeTYA8xQ8HBaJ3BfNdOug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgBWCXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:23:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:53270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbgBWCXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:23:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5E1321D56;
        Sun, 23 Feb 2020 02:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424621;
        bh=fbzw3Pn7cP5CyCmMaoGnl/JxtaOazCYdtc8rjGGmI2Q=;
        h=From:To:Cc:Subject:Date:From;
        b=axV38PrC2+2s+DjWJXXPwfcRx8WFq+rQ2qxC/SFWbtcy+gRaCEoWR3Pz0z5AdZR2R
         sTg3bxeEdGO1OCCOgdVSAoSkkmKNrKrUVwJtQ/ErNI5lQbkuGtMkpMtDX5YLi/O1Wx
         UdbOVi3FcRCu214alfI1cL6LDE9Iy9ldn0aEeaI4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Corey Minyard <cminyard@mvista.com>,
        kbuild test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 01/25] ipmi:ssif: Handle a possible NULL pointer reference
Date:   Sat, 22 Feb 2020 21:23:15 -0500
Message-Id: <20200223022339.1885-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

[ Upstream commit 6b8526d3abc02c08a2f888e8c20b7ac9e5776dfe ]

In error cases a NULL can be passed to memcpy.  The length will always
be zero, so it doesn't really matter, but go ahead and check for NULL,
anyway, to be more precise and avoid static analysis errors.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmi_ssif.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index af44db2dfb68a..fec679433f72d 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -735,10 +735,14 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 	flags = ipmi_ssif_lock_cond(ssif_info, &oflags);
 	msg = ssif_info->curr_msg;
 	if (msg) {
+		if (data) {
+			if (len > IPMI_MAX_MSG_LENGTH)
+				len = IPMI_MAX_MSG_LENGTH;
+			memcpy(msg->rsp, data, len);
+		} else {
+			len = 0;
+		}
 		msg->rsp_size = len;
-		if (msg->rsp_size > IPMI_MAX_MSG_LENGTH)
-			msg->rsp_size = IPMI_MAX_MSG_LENGTH;
-		memcpy(msg->rsp, data, msg->rsp_size);
 		ssif_info->curr_msg = NULL;
 	}
 
-- 
2.20.1

