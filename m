Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D13EC352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1C220730
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgBEWTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:19:37 -0500
Received: from nautica.notk.org ([91.121.71.147]:48300 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgBEWTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:19:36 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 63E25C009; Wed,  5 Feb 2020 23:19:35 +0100 (CET)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH] net/9p: remove unused p9_req_t aux field
Date:   Wed,  5 Feb 2020 23:19:12 +0100
Message-Id: <1580941152-12973-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

The p9_req_t field 'aux' has not been used in a very long time,
remove leftover field declaration

Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
---
This has been sitting on my tree for a while, let's get some cleanup
in for next cycle!

 include/net/9p/client.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index acc60d8a3b3b..d32569755138 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -73,7 +73,6 @@ enum p9_req_status_t {
  * @wq: wait_queue for the client to block on for this request
  * @tc: the request fcall structure
  * @rc: the response fcall structure
- * @aux: transport specific data (provided for trans_fd migration)
  * @req_list: link for higher level objects to chain requests
  */
 struct p9_req_t {
@@ -83,7 +82,6 @@ struct p9_req_t {
 	wait_queue_head_t wq;
 	struct p9_fcall tc;
 	struct p9_fcall rc;
-	void *aux;
 	struct list_head req_list;
 };
 
-- 
2.24.1

