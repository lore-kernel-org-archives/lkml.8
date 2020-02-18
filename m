Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A1BC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D0F20659
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaFbYSbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgBRT6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:58:16 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52019 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgBRT6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:58:14 -0500
Received: by mail-pj1-f68.google.com with SMTP id fa20so1495177pjb.1;
        Tue, 18 Feb 2020 11:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZVaa80uyP+XZfhhhWT99/ZXFbqKi9cNUzihG4oAdlOc=;
        b=XaFbYSbq7VSZh//HL+vvxQWPtsyeqB5gQ4P0KM0hmriCA5ji4kWEWtRsLF8+YJJaW/
         q86DBbJKueEg9mAyc94VyX4Npqiwi97xuEOvWFSylQ4njEqET32RP/fQ1Rb/j42zeF8E
         fbOarrrBcnX7YKJLzSpVGwm+nx06OwsvoMdcyRrev2F1f9kaStE38X0CTRcMc6jUR4w5
         fODfPNzXaTm4a+cUbv2EPAev+zvmleSEx0+04/vBfda64JxTEijfyv5qsJ/FxDK/gyoQ
         AMIrE/96R+7rPYXgs6Lw10c9MRcCyj62XqVoGN69GD0i2vA0PQTlc8AIEZ7lXFINdvq/
         mulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZVaa80uyP+XZfhhhWT99/ZXFbqKi9cNUzihG4oAdlOc=;
        b=qXhNC55IcSNRyW2hmR/HPQmMhyR0TBhgEkvpuAIHtxE9KbILJQdUURuxzOhNBTw6sX
         jYPG7byPqoq5XHL/Ch/uf7kbLxKaLzb5AQbkdj9AMEWku/wr6QZ0MIe5/bex8WsJVPbd
         iHwE8EbpUzCeHwDzWZkgnYBnrgY32UyVoURgxku4xiOG7Io+iEnlcbNTceuRj577S0jQ
         egH/Aql+tNWMDFdh46MbaiWTP7xGuYCLK3Pay9KjZphi2rioV1s5Z0kt6kgORKCgvJ4w
         pgc4ioGunnAe6B2RZaXpFYjAspmZ2AUoQIPA+QAJJ3XkQT8pD6Nj5Bbqjb3s9JN3P9g2
         xIBg==
X-Gm-Message-State: APjAAAUPlh1na/EKxpF0MMw/zBtX3oOE7p+Vo34J/CFskBdbrdK00cwI
        AADe9mU8vhyV0cN7fsLaeFa2wM4=
X-Google-Smtp-Source: APXvYqxzdkyS57C03yGJaG/36hN7DxqwFGCS6tWj6O9YmFwyOpxHVxiIjXkr6u95wRoOLZOl9InRTA==
X-Received: by 2002:a17:90a:5d85:: with SMTP id t5mr4608220pji.126.1582055893495;
        Tue, 18 Feb 2020 11:58:13 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee3:ff08:f869:e1e5:121e:cdbf])
        by smtp.gmail.com with ESMTPSA id g19sm5046770pfh.134.2020.02.18.11.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 11:58:12 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     pshelar@ovn.org, davem@davemloft.net
Cc:     netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH 3/4] datapath.c: Use built-in RCU list checking
Date:   Wed, 19 Feb 2020 01:28:02 +0530
Message-Id: <20200218195802.2702-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

hlist_for_each_entry_rcu() has built-in RCU and lock checking.

Pass cond argument to list_for_each_entry_rcu() to silence
false lockdep warning when CONFIG_PROVE_RCU_LIST is enabled
by default.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 net/openvswitch/datapath.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 1047e8043084..2b7a348ad167 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -179,7 +179,8 @@ struct vport *ovs_lookup_vport(const struct datapath *dp, u16 port_no)
 	struct hlist_head *head;
 
 	head = vport_hash_bucket(dp, port_no);
-	hlist_for_each_entry_rcu(vport, head, dp_hash_node) {
+	hlist_for_each_entry_rcu(vport, head, dp_hash_node,
+				lockdep_ovsl_is_held()) {
 		if (vport->port_no == port_no)
 			return vport;
 	}
@@ -2045,7 +2046,8 @@ static unsigned int ovs_get_max_headroom(struct datapath *dp)
 	int i;
 
 	for (i = 0; i < DP_VPORT_HASH_BUCKETS; i++) {
-		hlist_for_each_entry_rcu(vport, &dp->ports[i], dp_hash_node) {
+		hlist_for_each_entry_rcu(vport, &dp->ports[i], dp_hash_node,
+					lockdep_ovsl_is_held()) {
 			dev = vport->dev;
 			dev_headroom = netdev_get_fwd_headroom(dev);
 			if (dev_headroom > max_headroom)
@@ -2064,7 +2066,8 @@ static void ovs_update_headroom(struct datapath *dp, unsigned int new_headroom)
 
 	dp->max_headroom = new_headroom;
 	for (i = 0; i < DP_VPORT_HASH_BUCKETS; i++)
-		hlist_for_each_entry_rcu(vport, &dp->ports[i], dp_hash_node)
+		hlist_for_each_entry_rcu(vport, &dp->ports[i], dp_hash_node,
+					lockdep_ovsl_is_held())
 			netdev_set_rx_headroom(vport->dev, new_headroom);
 }
 
-- 
2.17.1

