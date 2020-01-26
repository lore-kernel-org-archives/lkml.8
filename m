Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C425C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 22:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C95B20716
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 22:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgAZWLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 17:11:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:43586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728708AbgAZWLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 17:11:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CD3B2AC91;
        Sun, 26 Jan 2020 22:11:01 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 7FFFAE06B1; Sun, 26 Jan 2020 23:11:01 +0100 (CET)
Message-Id: <b9210583c01f2ea1689feb64aa2595394082d57f.1580075977.git.mkubecek@suse.cz>
In-Reply-To: <cover.1580075977.git.mkubecek@suse.cz>
References: <cover.1580075977.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next 1/7] ethtool: fix kernel-doc descriptions
To:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Date:   Sun, 26 Jan 2020 23:11:01 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix missing or incorrect function argument and struct member descriptions.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 net/ethtool/netlink.c | 26 ++++++++++++++------------
 net/ethtool/strset.c  |  1 +
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 86b79f9bc08d..0af43bbdb9b2 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -134,11 +134,12 @@ int ethnl_fill_reply_header(struct sk_buff *skb, struct net_device *dev,
 
 /**
  * ethnl_reply_init() - Create skb for a reply and fill device identification
- * @payload: payload length (without netlink and genetlink header)
- * @dev:     device the reply is about (may be null)
- * @cmd:     ETHTOOL_MSG_* message type for reply
- * @info:    genetlink info of the received packet we respond to
- * @ehdrp:   place to store payload pointer returned by genlmsg_new()
+ * @payload:      payload length (without netlink and genetlink header)
+ * @dev:          device the reply is about (may be null)
+ * @cmd:          ETHTOOL_MSG_* message type for reply
+ * @hdr_attrtype: attribute type for common header
+ * @info:         genetlink info of the received packet we respond to
+ * @ehdrp:        place to store payload pointer returned by genlmsg_new()
  *
  * Return: pointer to allocated skb on success, NULL on error
  */
@@ -188,10 +189,11 @@ static int ethnl_multicast(struct sk_buff *skb, struct net_device *dev)
 
 /**
  * struct ethnl_dump_ctx - context structure for generic dumpit() callback
- * @ops:      request ops of currently processed message type
- * @req_info: parsed request header of processed request
- * @pos_hash: saved iteration position - hashbucket
- * @pos_idx:  saved iteration position - index
+ * @ops:        request ops of currently processed message type
+ * @req_info:   parsed request header of processed request
+ * @reply_data: data needed to compose the reply
+ * @pos_hash:   saved iteration position - hashbucket
+ * @pos_idx:    saved iteration position - index
  *
  * These parameters are kept in struct netlink_callback as context preserved
  * between iterations. They are initialized by ethnl_default_start() and used
@@ -268,9 +270,9 @@ static int ethnl_default_parse(struct ethnl_req_info *req_info,
 
 /**
  * ethnl_init_reply_data() - Initialize reply data for GET request
- * @req_info: pointer to embedded struct ethnl_req_info
- * @ops:      instance of struct ethnl_request_ops describing the layout
- * @dev:      network device to initialize the reply for
+ * @reply_data: pointer to embedded struct ethnl_reply_data
+ * @ops:        instance of struct ethnl_request_ops describing the layout
+ * @dev:        network device to initialize the reply for
  *
  * Fills the reply data part with zeros and sets the dev member. Must be called
  * before calling the ->fill_reply() callback (for each iteration when handling
diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index 82a059c13c1c..948d967f1eca 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -85,6 +85,7 @@ get_stringset_policy[ETHTOOL_A_STRINGSET_MAX + 1] = {
 
 /**
  * strset_include() - test if a string set should be included in reply
+ * @info: parsed client request
  * @data: pointer to request data structure
  * @id:   id of string set to check (ETH_SS_* constants)
  */
-- 
2.25.0

