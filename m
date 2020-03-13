Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06C5C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74E3206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgCMQvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:51:16 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:62171 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCMQvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:51:16 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.227])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 3789F26148A;
        Sat, 14 Mar 2020 00:51:08 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org, kernel@vivo.com,
        Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH] rpmsg: fix a comment typo for rpmsg_device_match()
Date:   Fri, 13 Mar 2020 09:50:49 -0700
Message-Id: <20200313165049.62907-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VIQ0xLS0tLQ0hCSUhIT1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OD46Iyo5AjgyTzAuLEkSIjAK
        C0IKCS1VSlVKTkNPSkpDSUxKTkpCVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlMWVdZCAFZQUpNS003Bg++
X-HM-Tid: 0a70d4ce84469375kuws3789f26148a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should be 'a' rather than 'an'.

Signed-off-by: WANG Wenhu <wenhu.wang@vivo.com>
---
 drivers/rpmsg/rpmsg_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index e330ec4dfc33..a6361cad608b 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -284,7 +284,7 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
 EXPORT_SYMBOL(rpmsg_trysend_offchannel);
 
 /*
- * match an rpmsg channel with a channel info struct.
+ * match a rpmsg channel with a channel info struct.
  * this is used to make sure we're not creating rpmsg devices for channels
  * that already exist.
  */
-- 
2.17.1

