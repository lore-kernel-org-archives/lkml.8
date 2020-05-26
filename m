Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C921C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21CEC2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519612;
	bh=KM+T7rK8LxTAusvClFFwqtI7Ma/8JjMwgBpdJRCQE5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nWTNiBH8F8LVWmMNzVFpS1YziddirIFMWVABXmYa+EWrBu9UG46E0KOnO+LX+ZznB
	 n20Wr1Ulp8skL4bzeBNTlGDZ9UtsiKlHQTLivmNBDSGhHP+mAQq0GwnMG1I1zhB/gZ
	 ajZIdzzewOESALznBaeJ1YI78tKp1t0khUz4R4/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390650AbgEZTAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389977AbgEZTAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:00:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9293620849;
        Tue, 26 May 2020 19:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519601;
        bh=KM+T7rK8LxTAusvClFFwqtI7Ma/8JjMwgBpdJRCQE5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nIqQuH+h1FMp+Bm7tf9ST2Zme3C+XlxCf3EflTvZ2RKB30cIfszf+90JCG0L8kVn7
         iHZR+XMnME5Yif+I11B/4j4wRNjMBcYZYLmgT9+Og2OvZzudHPqW2lz+GhfACyu64H
         FPDTEjyX0KW4DbjpZMCYBj5eUW3+DWBhLIYuKk98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, greg@kroah.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Nault <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Giuliano Procida <gprocida@google.com>
Subject: [PATCH 4.9 39/64] l2tp: hold tunnel while handling genl tunnel updates
Date:   Tue, 26 May 2020 20:53:08 +0200
Message-Id: <20200526183926.219021493@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183913.064413230@linuxfoundation.org>
References: <20200526183913.064413230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume Nault <g.nault@alphalink.fr>

commit 8c0e421525c9eb50d68e8f633f703ca31680b746 upstream.

We need to make sure the tunnel is not going to be destroyed by
l2tp_tunnel_destruct() concurrently.

Fixes: 309795f4bec2 ("l2tp: Add netlink control API for L2TP")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Giuliano Procida <gprocida@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_netlink.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -310,8 +310,8 @@ static int l2tp_nl_cmd_tunnel_modify(str
 	}
 	tunnel_id = nla_get_u32(info->attrs[L2TP_ATTR_CONN_ID]);
 
-	tunnel = l2tp_tunnel_find(net, tunnel_id);
-	if (tunnel == NULL) {
+	tunnel = l2tp_tunnel_get(net, tunnel_id);
+	if (!tunnel) {
 		ret = -ENODEV;
 		goto out;
 	}
@@ -322,6 +322,8 @@ static int l2tp_nl_cmd_tunnel_modify(str
 	ret = l2tp_tunnel_notify(&l2tp_nl_family, info,
 				 tunnel, L2TP_CMD_TUNNEL_MODIFY);
 
+	l2tp_tunnel_dec_refcount(tunnel);
+
 out:
 	return ret;
 }


