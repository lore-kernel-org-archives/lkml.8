Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E21C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8011A246A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844312;
	bh=cg2as5AkT77EQDRMH1DPFUeJrfDK/wXOqjs5Sf/uJa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aBuxoSGYuEmYdzO5Zl2zvRZCKSDDHjfWCU+kdPRsWZ0dzaBJVClZRjwr8gp7QDIYW
	 0OGo+5QagN+jP/mzM2J671oBbSvNVMym+DTpffmaK6WVwiap8d3Xs1dI6uwE2RJ3QO
	 F1mRbOjkLksQIjOqITQQ36X2AXFOUPFF02TMP0Q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgCJMpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbgCJMpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:45:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16B81246A3;
        Tue, 10 Mar 2020 12:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844306;
        bh=cg2as5AkT77EQDRMH1DPFUeJrfDK/wXOqjs5Sf/uJa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2JZ4GnwNJh0ZvzcBhLMkx/PVCz90aHHwelsFm9QU7SmMsGQmpaUJ4E9tLv33RIfn
         qPZ831E1Sylr+JYDlSJgunTVp5mgP9s44tUFhwNsM3CoIjewA+RzypxiOarnKMF/wI
         Yg0K25n3M+VeshODXAo6LaJfyZwGNSioG6J9PR6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 05/88] ipmi:ssif: Handle a possible NULL pointer reference
Date:   Tue, 10 Mar 2020 13:38:13 +0100
Message-Id: <20200310123608.059439536@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123606.543939933@linuxfoundation.org>
References: <20200310123606.543939933@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 996b9ae154042..a4ef9a6bd3678 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -746,10 +746,14 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
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



