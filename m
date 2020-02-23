Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40CDC35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB1F206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582425250;
	bh=16G+r9AkZmKoMHThPkU6o83ScBvSpFl2idhcFxZGbFM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zdAtbq18MBbHxST496K8GhbVsg8HIDdEOKs61vTbgIYRz431In/OTzHzphQQauveN
	 Y/RwarKuBi+uHPAvS46EjD8tzStK1cpMVS9j/EAa38GbCygDzDjLSrvnkw6268+bAm
	 K7VgbFKW3Jz/rWf7L0ss6RduCNN58xTtvhQgcyxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgBWCWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:22:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:51646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgBWCWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:22:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE05C208C3;
        Sun, 23 Feb 2020 02:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424557;
        bh=16G+r9AkZmKoMHThPkU6o83ScBvSpFl2idhcFxZGbFM=;
        h=From:To:Cc:Subject:Date:From;
        b=jvUk1d6A950A6GoVR522WpVuyzfnVFaFFxFMBcWv1OCP08/c2Tp5GSvJC8cAkBXg2
         u5Q7/l+jU/qz0WwSgyjiYkcB7sKN7xB+a/7NI3Yv9io+xHG3JwVdpmom+mCCp0hvSA
         FVpSRDwDGZ6GDWDJC445/PbVwlXTeO8P+SX/VSZg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Corey Minyard <cminyard@mvista.com>,
        kbuild test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.4 01/50] ipmi:ssif: Handle a possible NULL pointer reference
Date:   Sat, 22 Feb 2020 21:21:46 -0500
Message-Id: <20200223022235.1404-1-sashal@kernel.org>
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
index 22c6a2e612360..8ac390c2b5147 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -775,10 +775,14 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
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

