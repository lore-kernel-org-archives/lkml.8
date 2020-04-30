Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9242AC47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7243020775
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588262698;
	bh=Y41GO6rEfa6gMe2ZRrhdf69OnsyEGPVtS8H/VZVw4d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uw3OqpzlMsvIWEDfmfNAz4OHxltjC7vsshKzQXZslvaMmGqbKnd1lstX160bflQ7v
	 DF0m57+ildxbogctwVaxGOpaEcz7qXd/9sPVGZ8ehe2uiOG8bs/PPTRnT6AzKr+hGN
	 IbrAzxqzygX25lTnPRKVOBtJcBCg9Kc/W+Sm3PUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgD3QEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbgD3QEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:04:38 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09AC524955;
        Thu, 30 Apr 2020 16:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588262676;
        bh=Y41GO6rEfa6gMe2ZRrhdf69OnsyEGPVtS8H/VZVw4d0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b7G34SC9Xglb7EOCw5U+SKqgsW4DsYt3HJ7LNSwR4XKixsmgQ1D8d4YpYwd4T9edJ
         uczCo0AzNicdSodlz8v1lcY9fAZfeLCztT3OrxNZcrGpwiP1udVu5oMsdlpzIgmg6g
         Skf8p2Yk/Ungr3uWBbcHlf0A2kCfFB/9zXBXaR9E=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUBfu-00AxF8-Al; Thu, 30 Apr 2020 18:04:34 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH 13/37] docs: networking: convert nf_flowtable.txt to ReST
Date:   Thu, 30 Apr 2020 18:04:08 +0200
Message-Id: <082c505f4ad07906cc427c1046e64629bd612c47.1588261997.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588261997.git.mchehab+huawei@kernel.org>
References: <cover.1588261997.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- add SPDX header;
- adjust title markup;
- mark code blocks and literals as such;
- add notes markups;
- adjust identation, whitespaces and blank lines;
- add to networking/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/networking/index.rst            |  1 +
 .../{nf_flowtable.txt => nf_flowtable.rst}    | 55 ++++++++++---------
 2 files changed, 31 insertions(+), 25 deletions(-)
 rename Documentation/networking/{nf_flowtable.txt => nf_flowtable.rst} (76%)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index e5128bb7e7df..c4e8a43741be 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -86,6 +86,7 @@ Contents:
    netfilter-sysctl
    netif-msg
    nf_conntrack-sysctl
+   nf_flowtable
 
 .. only::  subproject and html
 
diff --git a/Documentation/networking/nf_flowtable.txt b/Documentation/networking/nf_flowtable.rst
similarity index 76%
rename from Documentation/networking/nf_flowtable.txt
rename to Documentation/networking/nf_flowtable.rst
index 0bf32d1121be..b6e1fa141aae 100644
--- a/Documentation/networking/nf_flowtable.txt
+++ b/Documentation/networking/nf_flowtable.rst
@@ -1,3 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================================
 Netfilter's flowtable infrastructure
 ====================================
 
@@ -31,15 +34,17 @@ to use this new alternative forwarding path via nftables policy.
 This is represented in Fig.1, which describes the classic forwarding path
 including the Netfilter hooks and the flowtable fastpath bypass.
 
-                                         userspace process
-                                          ^              |
-                                          |              |
-                                     _____|____     ____\/___
-                                    /          \   /         \
-                                    |   input   |  |  output  |
-                                    \__________/   \_________/
-                                         ^               |
-                                         |               |
+::
+
+					 userspace process
+					  ^              |
+					  |              |
+				     _____|____     ____\/___
+				    /          \   /         \
+				    |   input   |  |  output  |
+				    \__________/   \_________/
+					 ^               |
+					 |               |
       _________      __________      ---------     _____\/_____
      /         \    /          \     |Routing |   /            \
   -->  ingress  ---> prerouting ---> |decision|   | postrouting |--> neigh_xmit
@@ -59,7 +64,7 @@ including the Netfilter hooks and the flowtable fastpath bypass.
       \ /                                                                 |
        |__yes_________________fastpath bypass ____________________________|
 
-               Fig.1 Netfilter hooks and flowtable interactions
+	       Fig.1 Netfilter hooks and flowtable interactions
 
 The flowtable entry also stores the NAT configuration, so all packets are
 mangled according to the NAT policy that matches the initial packets that went
@@ -72,18 +77,18 @@ Example configuration
 ---------------------
 
 Enabling the flowtable bypass is relatively easy, you only need to create a
-flowtable and add one rule to your forward chain.
+flowtable and add one rule to your forward chain::
 
-        table inet x {
+	table inet x {
 		flowtable f {
 			hook ingress priority 0; devices = { eth0, eth1 };
 		}
-                chain y {
-                        type filter hook forward priority 0; policy accept;
-                        ip protocol tcp flow offload @f
-                        counter packets 0 bytes 0
-                }
-        }
+		chain y {
+			type filter hook forward priority 0; policy accept;
+			ip protocol tcp flow offload @f
+			counter packets 0 bytes 0
+		}
+	}
 
 This example adds the flowtable 'f' to the ingress hook of the eth0 and eth1
 netdevices. You can create as many flowtables as you want in case you need to
@@ -101,12 +106,12 @@ forwarding bypass.
 More reading
 ------------
 
-This documentation is based on the LWN.net articles [1][2]. Rafal Milecki also
-made a very complete and comprehensive summary called "A state of network
+This documentation is based on the LWN.net articles [1]_\ [2]_. Rafal Milecki
+also made a very complete and comprehensive summary called "A state of network
 acceleration" that describes how things were before this infrastructure was
-mailined [3] and it also makes a rough summary of this work [4].
+mailined [3]_ and it also makes a rough summary of this work [4]_.
 
-[1] https://lwn.net/Articles/738214/
-[2] https://lwn.net/Articles/742164/
-[3] http://lists.infradead.org/pipermail/lede-dev/2018-January/010830.html
-[4] http://lists.infradead.org/pipermail/lede-dev/2018-January/010829.html
+.. [1] https://lwn.net/Articles/738214/
+.. [2] https://lwn.net/Articles/742164/
+.. [3] http://lists.infradead.org/pipermail/lede-dev/2018-January/010830.html
+.. [4] http://lists.infradead.org/pipermail/lede-dev/2018-January/010829.html
-- 
2.25.4

