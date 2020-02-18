Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB9EC34049
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4427B2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ+9pXbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgBRT6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:58:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35893 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgBRT5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:57:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id d9so11474644pgu.3;
        Tue, 18 Feb 2020 11:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=93cUwvRz5DcbF2nQaz+gagk6IvPBCJp98CU5NTDjQMY=;
        b=UQ+9pXbDMmbdwA6F96Qv1VTxfWIz+JpDgMRfBgEwsI2/DxQA8d1YYv3LhqeSWvFyG3
         KySMupXsPLTKR8WIfSgIj374RP/tpNY6rn9kI85B2bdUZKNIAI4bBtweOJJkv+UufbfL
         OsHJC1WfHbmkTo4aTz0APkZDFAdFavuyyZd6ZXl1OwPo93zeo/bz8FthImtkeCMnvSFS
         vLhtX0zbw3wAuwNmOtJU6nw6SWTGmqPVqAubM0XpVuoS5kogsoQOXzF6YzD7MGj+PfLU
         FaP2WqUchlHEnqt0TtGb4plEPa9QcyJBK/mJcXAwrN+vzxkqCENzHeZu0Lh3Yb+lIkhs
         cIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=93cUwvRz5DcbF2nQaz+gagk6IvPBCJp98CU5NTDjQMY=;
        b=cYlMuMhrcfgSz2BGEQzzP4rIBh/JWzSMJWAFl2NOwz5cFro5p8S9qevRLJkz4RCloF
         fNkvN+BH2TlZZXNlE6eluVKuhT+9TOflH9vBzMs/4tJi5z1x/ZxAPRuFH0r1SrUzptSu
         DPx04XDFfW2bP2m6TXditXD9K4JbOf+oW3pfNdMweybhWXwyh9rRdoSI1Ki1MO2TpRgd
         mMZSlgpzF0NoxjAq0Ex3qvcIIkE2DYg00MwGFxQb/3JN3KEwWa8Gk5niJDuW14zD9QZ9
         5XYxqLzwWxIPdrzRusJmAdY8kA2tFV4NVPsynM3vGKBzmtVecSFj3/EB44yYtvE8hnKR
         TgOw==
X-Gm-Message-State: APjAAAXcKQwQP8a4ZfLFuQbaTJFZA17la3xeGg/oQycnPzo+BT2V/pGC
        Y1JXOcZ/hFw6r3KmLtplaQ==
X-Google-Smtp-Source: APXvYqzmmai+702KiOlcfbcc3ZFX7jmIWdGXi8fVhYaR8Nc3GJgeHndI1Pldb3SlGbLRf31qGdaxsA==
X-Received: by 2002:a63:4525:: with SMTP id s37mr24073227pga.418.1582055875098;
        Tue, 18 Feb 2020 11:57:55 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee3:ff08:f869:e1e5:121e:cdbf])
        by smtp.gmail.com with ESMTPSA id d4sm4038413pjz.12.2020.02.18.11.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 11:57:54 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     pshelar@ovn.org, davem@davemloft.net
Cc:     netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH 2/4] vport.c: Use built-in RCU list checking
Date:   Wed, 19 Feb 2020 01:27:42 +0530
Message-Id: <20200218195742.2636-1-madhuparnabhowmik10@gmail.com>
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
 net/openvswitch/vport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 5da9392b03d6..47febb4504f0 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -96,7 +96,8 @@ struct vport *ovs_vport_locate(const struct net *net, const char *name)
 	struct hlist_head *bucket = hash_bucket(net, name);
 	struct vport *vport;
 
-	hlist_for_each_entry_rcu(vport, bucket, hash_node)
+	hlist_for_each_entry_rcu(vport, bucket, hash_node,
+				lockdep_ovsl_is_held())
 		if (!strcmp(name, ovs_vport_name(vport)) &&
 		    net_eq(ovs_dp_get_net(vport->dp), net))
 			return vport;
-- 
2.17.1

