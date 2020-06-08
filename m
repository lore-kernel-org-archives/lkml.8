Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44525C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24AF72072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591661378;
	bh=TbF4JEtB+TcG8WFlAYVFqF05iaPUYZDw/QPUOnnOWos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f1Gl3VX4TiDPovfrqSvWSx+3nJe928KfFne2KW+GXCdswlN3S0mA8SewpN/kBvXqH
	 A+myUifMzr+Zd4UGVrvJ4PNjSRB6Btgl1QVxT2Pqd+jWcZ9/3D5wXDCHIFfTSYkhVQ
	 cbVXLsZQUgrgQ/RMt4756mS301+zEznkeHVjTFAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732146AbgFIAJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:09:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730977AbgFHXU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:20:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 846B72087E;
        Mon,  8 Jun 2020 23:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658428;
        bh=TbF4JEtB+TcG8WFlAYVFqF05iaPUYZDw/QPUOnnOWos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dCOIbUSkq9E9BriV03O6WwnoOrt+xnFOCwRz0Vk0ptpImq8/uEyfK0hAhJ9Q1dHU9
         Fqt045SM3rJF9Jad9HyOUCXCmQjxy3xqPbhOWFbVxJU05XXBARSvGweYsMxU6LVMiI
         C+hN8/7xXijlKWRghmI0cH0Cq6Fg/+3VabvBYIX0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, teroincn@gmail.com,
        Richard Guy Briggs <rgb@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-audit@redhat.com
Subject: [PATCH AUTOSEL 5.4 073/175] audit: fix a net reference leak in audit_send_reply()
Date:   Mon,  8 Jun 2020 19:17:06 -0400
Message-Id: <20200608231848.3366970-73-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Moore <paul@paul-moore.com>

[ Upstream commit a48b284b403a4a073d8beb72d2bb33e54df67fb6 ]

If audit_send_reply() fails when trying to create a new thread to
send the reply it also fails to cleanup properly, leaking a reference
to a net structure.  This patch fixes the error path and makes a
handful of other cleanups that came up while fixing the code.

Reported-by: teroincn@gmail.com
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/audit.c | 50 +++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index fcfbb3476ccd..a4eeece2eecd 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -923,19 +923,30 @@ struct sk_buff *audit_make_reply(int seq, int type, int done,
 	return NULL;
 }
 
+static void audit_free_reply(struct audit_reply *reply)
+{
+	if (!reply)
+		return;
+
+	if (reply->skb)
+		kfree_skb(reply->skb);
+	if (reply->net)
+		put_net(reply->net);
+	kfree(reply);
+}
+
 static int audit_send_reply_thread(void *arg)
 {
 	struct audit_reply *reply = (struct audit_reply *)arg;
-	struct sock *sk = audit_get_sk(reply->net);
 
 	audit_ctl_lock();
 	audit_ctl_unlock();
 
 	/* Ignore failure. It'll only happen if the sender goes away,
 	   because our timeout is set to infinite. */
-	netlink_unicast(sk, reply->skb, reply->portid, 0);
-	put_net(reply->net);
-	kfree(reply);
+	netlink_unicast(audit_get_sk(reply->net), reply->skb, reply->portid, 0);
+	reply->skb = NULL;
+	audit_free_reply(reply);
 	return 0;
 }
 
@@ -949,35 +960,32 @@ static int audit_send_reply_thread(void *arg)
  * @payload: payload data
  * @size: payload size
  *
- * Allocates an skb, builds the netlink message, and sends it to the port id.
- * No failure notifications.
+ * Allocates a skb, builds the netlink message, and sends it to the port id.
  */
 static void audit_send_reply(struct sk_buff *request_skb, int seq, int type, int done,
 			     int multi, const void *payload, int size)
 {
-	struct net *net = sock_net(NETLINK_CB(request_skb).sk);
-	struct sk_buff *skb;
 	struct task_struct *tsk;
-	struct audit_reply *reply = kmalloc(sizeof(struct audit_reply),
-					    GFP_KERNEL);
+	struct audit_reply *reply;
 
+	reply = kzalloc(sizeof(*reply), GFP_KERNEL);
 	if (!reply)
 		return;
 
-	skb = audit_make_reply(seq, type, done, multi, payload, size);
-	if (!skb)
-		goto out;
-
-	reply->net = get_net(net);
+	reply->skb = audit_make_reply(seq, type, done, multi, payload, size);
+	if (!reply->skb)
+		goto err;
+	reply->net = get_net(sock_net(NETLINK_CB(request_skb).sk));
 	reply->portid = NETLINK_CB(request_skb).portid;
-	reply->skb = skb;
 
 	tsk = kthread_run(audit_send_reply_thread, reply, "audit_send_reply");
-	if (!IS_ERR(tsk))
-		return;
-	kfree_skb(skb);
-out:
-	kfree(reply);
+	if (IS_ERR(tsk))
+		goto err;
+
+	return;
+
+err:
+	audit_free_reply(reply);
 }
 
 /*
-- 
2.25.1

