Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940C9C10F29
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 17:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7E4206EB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 17:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgCORR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 13:17:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:56486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728887AbgCORRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 13:17:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C9F64ADB5;
        Sun, 15 Mar 2020 17:17:53 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 37E23E0C04; Sun, 15 Mar 2020 18:17:53 +0100 (CET)
Message-Id: <40d6e189e3661dc996f7646c848bfb067ac324cb.1584292182.git.mkubecek@suse.cz>
In-Reply-To: <cover.1584292182.git.mkubecek@suse.cz>
References: <cover.1584292182.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net 3/3] ethtool: reject unrecognized request flags
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Date:   Sun, 15 Mar 2020 18:17:53 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out by Jakub Kicinski, we ethtool netlink code should respond
with an error if request head has flags set which are not recognized by
kernel, either as a mistake or because it expects functionality introduced
in later kernel versions.

To avoid unnecessary roundtrips, use extack cookie to  provide the
information about supported request flags.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 net/ethtool/netlink.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 180c194fab07..fc9e0b806889 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -40,6 +40,7 @@ int ethnl_parse_header(struct ethnl_req_info *req_info,
 	struct nlattr *tb[ETHTOOL_A_HEADER_MAX + 1];
 	const struct nlattr *devname_attr;
 	struct net_device *dev = NULL;
+	u32 flags = 0;
 	int ret;
 
 	if (!header) {
@@ -50,8 +51,17 @@ int ethnl_parse_header(struct ethnl_req_info *req_info,
 			       ethnl_header_policy, extack);
 	if (ret < 0)
 		return ret;
-	devname_attr = tb[ETHTOOL_A_HEADER_DEV_NAME];
+	if (tb[ETHTOOL_A_HEADER_FLAGS]) {
+		flags = nla_get_u32(tb[ETHTOOL_A_HEADER_FLAGS]);
+		if (flags & ~ETHTOOL_FLAG_ALL) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[ETHTOOL_A_HEADER_FLAGS],
+					    "unrecognized request flags");
+			nl_set_extack_cookie_u32(extack, ETHTOOL_FLAG_ALL);
+			return -EOPNOTSUPP;
+		}
+	}
 
+	devname_attr = tb[ETHTOOL_A_HEADER_DEV_NAME];
 	if (tb[ETHTOOL_A_HEADER_DEV_INDEX]) {
 		u32 ifindex = nla_get_u32(tb[ETHTOOL_A_HEADER_DEV_INDEX]);
 
@@ -90,9 +100,7 @@ int ethnl_parse_header(struct ethnl_req_info *req_info,
 	}
 
 	req_info->dev = dev;
-	if (tb[ETHTOOL_A_HEADER_FLAGS])
-		req_info->flags = nla_get_u32(tb[ETHTOOL_A_HEADER_FLAGS]);
-
+	req_info->flags = flags;
 	return 0;
 }
 
-- 
2.25.1

