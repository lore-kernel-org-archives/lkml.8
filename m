Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA367C11D43
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BC124656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JKxOV9Am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgBTGXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:23:15 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32796 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgBTGXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:23:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay11so1142126plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BVbUzx4OtLJL33n3gcVzeyzzu3sZRJkzVIJtmTNV+t8=;
        b=JKxOV9AmdvytuXIbHOqsVPLiEQIr2s/zJTnOGnJ0C9/B4mRzi71p9CyGQLE0WiyZG1
         uCoBI9KY7JgQEXDxAxLhJ78/rqt7frpx3WhF7xrFGNEN/+3jrK/vKvgeYkdw9Tuf/+qv
         SIP2lN2ClGaLU7i6KOgMBvHHUFhTWKwQ6Xy5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BVbUzx4OtLJL33n3gcVzeyzzu3sZRJkzVIJtmTNV+t8=;
        b=C9ffaB+TrRBuMgn/TfSNNJ5HrLWksXxsXVsh5EpXWaU7NFS/vEvEeEPuFKRCoF5xw0
         o2q9BS6jkgdbg933g8a6r42hvFJ6S00BwYzSWY9V6U6yRqqtvg5i/Uq020+K2QB29zzM
         zXyYue49dENyqBKEJ6J9NlHLJrjTlDM2lEDtg1w3vfvdAxWbD0hledatKKnzA62KnRkK
         FSpyFULM+o6OmdYr9PJtaCKHZ7NZxbTOtw4G7Dp06GwuP4+XV0Gma9H1Xae0ApxnTT/u
         zCrDFwGJwWYujdO4RqHtPQJ4960FOZGDAnRvMNsNxtCSzVPGMG9xxooKkbhugaUpyBZ7
         ScEg==
X-Gm-Message-State: APjAAAXUepQ5bZ1j90YouTmcoRf7xjm1A3CkzXwROZBvIga+qmn9c6sx
        yByE9t4VKqpLyeVTx0ZECFC3zw==
X-Google-Smtp-Source: APXvYqzXN0ax5Db2wRJdkMHnt8sHgkOkIWDQT9FiYaQD9pDs6MV//rTXASYUMAmxULw00aCV9LuFzA==
X-Received: by 2002:a17:90a:6c26:: with SMTP id x35mr1732741pjj.126.1582179792813;
        Wed, 19 Feb 2020 22:23:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x21sm1755020pfq.76.2020.02.19.22.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 22:23:11 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Pravin B Shelar <pshelar@ovn.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
        dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: [PATCH] openvswitch: Distribute switch variables for initialization
Date:   Wed, 19 Feb 2020 22:23:09 -0800
Message-Id: <20200220062309.69077-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables declared in a switch statement before any case statements
cannot be automatically initialized with compiler instrumentation (as
they are not part of any execution flow). With GCC's proposed automatic
stack variable initialization feature, this triggers a warning (and they
don't get initialized). Clang's automatic stack variable initialization
(via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
doesn't initialize such variables[1]. Note that these warnings (or silent
skipping) happen before the dead-store elimination optimization phase,
so even when the automatic initializations are later elided in favor of
direct initializations, the warnings remain.

To avoid these problems, move such variables into the "case" where
they're used or lift them up into the main function body.

net/openvswitch/flow_netlink.c: In function ‘validate_set’:
net/openvswitch/flow_netlink.c:2711:29: warning: statement will never be executed [-Wswitch-unreachable]
 2711 |  const struct ovs_key_ipv4 *ipv4_key;
      |                             ^~~~~~~~

[1] https://bugs.llvm.org/show_bug.cgi?id=44916

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/openvswitch/flow_netlink.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 7da4230627f5..288122eec7c8 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2708,10 +2708,6 @@ static int validate_set(const struct nlattr *a,
 		return -EINVAL;
 
 	switch (key_type) {
-	const struct ovs_key_ipv4 *ipv4_key;
-	const struct ovs_key_ipv6 *ipv6_key;
-	int err;
-
 	case OVS_KEY_ATTR_PRIORITY:
 	case OVS_KEY_ATTR_SKB_MARK:
 	case OVS_KEY_ATTR_CT_MARK:
@@ -2723,7 +2719,9 @@ static int validate_set(const struct nlattr *a,
 			return -EINVAL;
 		break;
 
-	case OVS_KEY_ATTR_TUNNEL:
+	case OVS_KEY_ATTR_TUNNEL: {
+		int err;
+
 		if (masked)
 			return -EINVAL; /* Masked tunnel set not supported. */
 
@@ -2732,8 +2730,10 @@ static int validate_set(const struct nlattr *a,
 		if (err)
 			return err;
 		break;
+	}
+	case OVS_KEY_ATTR_IPV4: {
+		const struct ovs_key_ipv4 *ipv4_key;
 
-	case OVS_KEY_ATTR_IPV4:
 		if (eth_type != htons(ETH_P_IP))
 			return -EINVAL;
 
@@ -2753,8 +2753,10 @@ static int validate_set(const struct nlattr *a,
 				return -EINVAL;
 		}
 		break;
+	}
+	case OVS_KEY_ATTR_IPV6: {
+		const struct ovs_key_ipv6 *ipv6_key;
 
-	case OVS_KEY_ATTR_IPV6:
 		if (eth_type != htons(ETH_P_IPV6))
 			return -EINVAL;
 
@@ -2781,7 +2783,7 @@ static int validate_set(const struct nlattr *a,
 			return -EINVAL;
 
 		break;
-
+	}
 	case OVS_KEY_ATTR_TCP:
 		if ((eth_type != htons(ETH_P_IP) &&
 		     eth_type != htons(ETH_P_IPV6)) ||
-- 
2.20.1


