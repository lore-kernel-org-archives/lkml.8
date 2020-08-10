Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59885C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22DA320855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073102;
	bh=Ug02kqfPGJ0/IdfnyY4yzw4nqwciixxjTmDNOcu3TVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lqL2LtCSgYoDFDVFcyxnFryUIPHtls65QDGYCSYwcSIquZ4Mq4Xtb+hUANMc+c79W
	 dz/2xm8u1WW/gWyZbPfU+9vVoiTc+Ch38lRWoAeF5Wi1OisnKunAryQgaaPdYq9KDw
	 6h1VkyHXYMihpmXFNhV3wNu8uBodmOY82XSR05M4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgHJPY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbgHJPYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:24:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D05121775;
        Mon, 10 Aug 2020 15:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073088;
        bh=Ug02kqfPGJ0/IdfnyY4yzw4nqwciixxjTmDNOcu3TVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wHYfNHj9w9o/iFAS0/uYGC10j7tW4T+cswi0DpDMxcSpNXq8dy7ZXjG68zSHorNca
         o8MqI/xd23a82ENa12DEiCTTS8UijYr0PV40DTjkbXHu5GIqg8tz08Bj440RFAYx7Q
         5ILgvZfCXSyl2h4ojhs7fNQIs4Qrm2AmjC4/zkrs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 62/79] devlink: ignore -EOPNOTSUPP errors on dumpit
Date:   Mon, 10 Aug 2020 17:21:21 +0200
Message-Id: <20200810151815.301734997@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151812.114485777@linuxfoundation.org>
References: <20200810151812.114485777@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 82274d075536322368ce710b211c41c37c4740b9 ]

Number of .dumpit functions try to ignore -EOPNOTSUPP errors.
Recent change missed that, and started reporting all errors
but -EMSGSIZE back from dumps. This leads to situation like
this:

$ devlink dev info
devlink answers: Operation not supported

Dump should not report an error just because the last device
to be queried could not provide an answer.

To fix this and avoid similar confusion make sure we clear
err properly, and not leave it set to an error if we don't
terminate the iteration.

Fixes: c62c2cfb801b ("net: devlink: don't ignore errors during dumpit")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/devlink.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -1065,7 +1065,9 @@ static int devlink_nl_cmd_sb_pool_get_du
 						   devlink_sb,
 						   NETLINK_CB(cb->skb).portid,
 						   cb->nlh->nlmsg_seq);
-			if (err && err != -EOPNOTSUPP) {
+			if (err == -EOPNOTSUPP) {
+				err = 0;
+			} else if (err) {
 				mutex_unlock(&devlink->lock);
 				goto out;
 			}
@@ -1266,7 +1268,9 @@ static int devlink_nl_cmd_sb_port_pool_g
 							devlink, devlink_sb,
 							NETLINK_CB(cb->skb).portid,
 							cb->nlh->nlmsg_seq);
-			if (err && err != -EOPNOTSUPP) {
+			if (err == -EOPNOTSUPP) {
+				err = 0;
+			} else if (err) {
 				mutex_unlock(&devlink->lock);
 				goto out;
 			}
@@ -1498,7 +1502,9 @@ devlink_nl_cmd_sb_tc_pool_bind_get_dumpi
 							   devlink_sb,
 							   NETLINK_CB(cb->skb).portid,
 							   cb->nlh->nlmsg_seq);
-			if (err && err != -EOPNOTSUPP) {
+			if (err == -EOPNOTSUPP) {
+				err = 0;
+			} else if (err) {
 				mutex_unlock(&devlink->lock);
 				goto out;
 			}
@@ -3299,7 +3305,9 @@ static int devlink_nl_cmd_param_get_dump
 						    NETLINK_CB(cb->skb).portid,
 						    cb->nlh->nlmsg_seq,
 						    NLM_F_MULTI);
-			if (err && err != -EOPNOTSUPP) {
+			if (err == -EOPNOTSUPP) {
+				err = 0;
+			} else if (err) {
 				mutex_unlock(&devlink->lock);
 				goto out;
 			}
@@ -3569,7 +3577,9 @@ static int devlink_nl_cmd_port_param_get
 						NETLINK_CB(cb->skb).portid,
 						cb->nlh->nlmsg_seq,
 						NLM_F_MULTI);
-				if (err && err != -EOPNOTSUPP) {
+				if (err == -EOPNOTSUPP) {
+					err = 0;
+				} else if (err) {
 					mutex_unlock(&devlink->lock);
 					goto out;
 				}
@@ -4479,7 +4489,9 @@ static int devlink_nl_cmd_info_get_dumpi
 					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
 					   cb->extack);
 		mutex_unlock(&devlink->lock);
-		if (err && err != -EOPNOTSUPP)
+		if (err == -EOPNOTSUPP)
+			err = 0;
+		else if (err)
 			break;
 		idx++;
 	}


