Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42665C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D2B20848
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578693939;
	bh=sbJuOVYWCWIIvdsQx1NUlA1lZjJEaLDjyV8r9P7NAXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vgXA6IakiY8yw+DFWNoPQry9UvUQGtUjksHLbh60CQknOc432kbiwAN1NXHSpcLOM
	 thFqtWzoZtWxRgisDIc/RhrS+SY2RC2GqpZcTwWFNr9oX8DXYfZP1K4CFzrMQ5l7oC
	 /fSbsrUI9leGXjX5HIsZUlDJxazn6ypDm/npiDso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgAJWFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 17:05:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbgAJWFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 17:05:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C79F20848;
        Fri, 10 Jan 2020 22:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578693934;
        bh=sbJuOVYWCWIIvdsQx1NUlA1lZjJEaLDjyV8r9P7NAXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iyl0M/92/zCKjYJqHIAzcHYqsvtwZlqIF3qDIPIqZhlQO/jzZsXEkgak85IWxgG8b
         Ukhl4fBcf5fNsQ+vdLvoMM7ORDLwQJcUgs5/mZ7NVcDi3NiwTSVkVcgtme5TstJfUK
         Wp0HlV9yIxvdUf2UhdfftVUcbf7Csx+rU+zu86Ec=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Taehee Yoo <ap420073@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 17/26] hsr: rename debugfs file when interface name is changed
Date:   Fri, 10 Jan 2020 17:05:10 -0500
Message-Id: <20200110220519.28250-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110220519.28250-1-sashal@kernel.org>
References: <20200110220519.28250-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 4c2d5e33dcd3a6333a7895be3b542ff3d373177c ]

hsr interface has own debugfs file, which name is same with interface name.
So, interface name is changed, debugfs file name should be changed too.

Fixes: fc4ecaeebd26 ("net: hsr: add debugfs support for display node list")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_debugfs.c | 13 +++++++++++++
 net/hsr/hsr_main.c    |  3 +++
 net/hsr/hsr_main.h    |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/net/hsr/hsr_debugfs.c b/net/hsr/hsr_debugfs.c
index a7462a718e7b..d5f709b940ff 100644
--- a/net/hsr/hsr_debugfs.c
+++ b/net/hsr/hsr_debugfs.c
@@ -65,6 +65,19 @@ hsr_node_table_open(struct inode *inode, struct file *filp)
 	return single_open(filp, hsr_node_table_show, inode->i_private);
 }
 
+void hsr_debugfs_rename(struct net_device *dev)
+{
+	struct hsr_priv *priv = netdev_priv(dev);
+	struct dentry *d;
+
+	d = debugfs_rename(hsr_debugfs_root_dir, priv->node_tbl_root,
+			   hsr_debugfs_root_dir, dev->name);
+	if (IS_ERR(d))
+		netdev_warn(dev, "failed to rename\n");
+	else
+		priv->node_tbl_root = d;
+}
+
 static const struct file_operations hsr_fops = {
 	.open	= hsr_node_table_open,
 	.read	= seq_read,
diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index e28c975520ec..d2ee7125a7f1 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -45,6 +45,9 @@ static int hsr_netdev_notify(struct notifier_block *nb, unsigned long event,
 	case NETDEV_CHANGE:	/* Link (carrier) state changes */
 		hsr_check_carrier_and_operstate(hsr);
 		break;
+	case NETDEV_CHANGENAME:
+		hsr_debugfs_rename(dev);
+		break;
 	case NETDEV_CHANGEADDR:
 		if (port->type == HSR_PT_MASTER) {
 			/* This should not happen since there's no
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 6696923fd4bd..d40de84a637f 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -185,11 +185,15 @@ static inline u16 hsr_get_skb_sequence_nr(struct sk_buff *skb)
 }
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
+void hsr_debugfs_rename(struct net_device *dev);
 void hsr_debugfs_init(struct hsr_priv *priv, struct net_device *hsr_dev);
 void hsr_debugfs_term(struct hsr_priv *priv);
 void hsr_debugfs_create_root(void);
 void hsr_debugfs_remove_root(void);
 #else
+static inline void void hsr_debugfs_rename(struct net_device *dev)
+{
+}
 static inline void hsr_debugfs_init(struct hsr_priv *priv,
 				    struct net_device *hsr_dev)
 {}
-- 
2.20.1

