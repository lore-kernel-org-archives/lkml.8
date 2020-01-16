Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37BDC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723082064C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218468;
	bh=pVCoXfBSiL480IzIU2sa5TrHuUq87yI0YACdHQTuD2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q24gvzr6RWvv662/haHo2xfSJ8R9dgPnFuwJOim9aeoaYj0lVzbjr9ai+gtNJZGaP
	 eqokazqM76f8mjj6Lq0nCUkEaraL9N6d4dsGkVu2vqwi/6zyo77L5PDHeSJOfII2ox
	 2dPWxfiDRSgBuWMJ8xdy4GF2Io97PN3K3DqNPvm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391961AbgAPXrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:47:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390666AbgAPXUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:20:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 571132082F;
        Thu, 16 Jan 2020 23:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216833;
        bh=pVCoXfBSiL480IzIU2sa5TrHuUq87yI0YACdHQTuD2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BcC5NjvYCeOXS9V5dLiRQL+ssOxOA1wCk+Bo9ftn2UEdj8YRVrKg1Fi/Lq/OxtvS7
         JxVEzX+VQVrHvGwMHBsDV5DPePxBnM7xWyWrOaoMKBGLBYo0U/rQgdOlzP1KsUfLvs
         BsA8vwYFTLKS/5VNATxehj0/9ZoESIZhOXJ4i3mM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 030/203] hsr: add hsr root debugfs directory
Date:   Fri, 17 Jan 2020 00:15:47 +0100
Message-Id: <20200116231746.949422665@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

commit c6c4ccd7f96993e106dfea7ef18127f972f2db5e upstream.

In current hsr code, when hsr interface is created, it creates debugfs
directory /sys/kernel/debug/<interface name>.
If there is same directory or file name in there, it fails.
In order to reduce possibility of failure of creation of debugfs,
this patch adds root directory.

Test commands:
    ip link add dummy0 type dummy
    ip link add dummy1 type dummy
    ip link add hsr0 type hsr slave1 dummy0 slave2 dummy1

Before this patch:
    /sys/kernel/debug/hsr0/node_table

After this patch:
    /sys/kernel/debug/hsr/hsr0/node_table

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/hsr/hsr_debugfs.c |   23 ++++++++++++++++++++---
 net/hsr/hsr_main.c    |    1 +
 net/hsr/hsr_main.h    |    6 ++++++
 net/hsr/hsr_netlink.c |    1 +
 4 files changed, 28 insertions(+), 3 deletions(-)

--- a/net/hsr/hsr_debugfs.c
+++ b/net/hsr/hsr_debugfs.c
@@ -20,6 +20,8 @@
 #include "hsr_main.h"
 #include "hsr_framereg.h"
 
+static struct dentry *hsr_debugfs_root_dir;
+
 static void print_mac_address(struct seq_file *sfp, unsigned char *mac)
 {
 	seq_printf(sfp, "%02x:%02x:%02x:%02x:%02x:%02x:",
@@ -81,9 +83,9 @@ void hsr_debugfs_init(struct hsr_priv *p
 {
 	struct dentry *de = NULL;
 
-	de = debugfs_create_dir(hsr_dev->name, NULL);
+	de = debugfs_create_dir(hsr_dev->name, hsr_debugfs_root_dir);
 	if (IS_ERR(de)) {
-		pr_err("Cannot create hsr debugfs root\n");
+		pr_err("Cannot create hsr debugfs directory\n");
 		return;
 	}
 
@@ -93,7 +95,7 @@ void hsr_debugfs_init(struct hsr_priv *p
 				 priv->node_tbl_root, priv,
 				 &hsr_fops);
 	if (IS_ERR(de)) {
-		pr_err("Cannot create hsr node_table directory\n");
+		pr_err("Cannot create hsr node_table file\n");
 		debugfs_remove(priv->node_tbl_root);
 		priv->node_tbl_root = NULL;
 		return;
@@ -115,3 +117,18 @@ hsr_debugfs_term(struct hsr_priv *priv)
 	debugfs_remove(priv->node_tbl_root);
 	priv->node_tbl_root = NULL;
 }
+
+void hsr_debugfs_create_root(void)
+{
+	hsr_debugfs_root_dir = debugfs_create_dir("hsr", NULL);
+	if (IS_ERR(hsr_debugfs_root_dir)) {
+		pr_err("Cannot create hsr debugfs root directory\n");
+		hsr_debugfs_root_dir = NULL;
+	}
+}
+
+void hsr_debugfs_remove_root(void)
+{
+	/* debugfs_remove() internally checks NULL and ERROR */
+	debugfs_remove(hsr_debugfs_root_dir);
+}
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -123,6 +123,7 @@ static void __exit hsr_exit(void)
 {
 	unregister_netdevice_notifier(&hsr_nb);
 	hsr_netlink_exit();
+	hsr_debugfs_remove_root();
 }
 
 module_init(hsr_init);
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -187,12 +187,18 @@ static inline u16 hsr_get_skb_sequence_n
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 void hsr_debugfs_init(struct hsr_priv *priv, struct net_device *hsr_dev);
 void hsr_debugfs_term(struct hsr_priv *priv);
+void hsr_debugfs_create_root(void);
+void hsr_debugfs_remove_root(void);
 #else
 static inline void hsr_debugfs_init(struct hsr_priv *priv,
 				    struct net_device *hsr_dev)
 {}
 static inline void hsr_debugfs_term(struct hsr_priv *priv)
 {}
+static inline void hsr_debugfs_create_root(void)
+{}
+static inline void hsr_debugfs_remove_root(void)
+{}
 #endif
 
 #endif /*  __HSR_PRIVATE_H */
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -476,6 +476,7 @@ int __init hsr_netlink_init(void)
 	if (rc)
 		goto fail_genl_register_family;
 
+	hsr_debugfs_create_root();
 	return 0;
 
 fail_genl_register_family:


