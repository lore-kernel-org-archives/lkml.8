Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968C1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 689092086A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519447;
	bh=LLXXh+1O6AIqTNd8uyV8uLzzENl3ZajJSYiSEFE1DtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=StuZ34Xzb+cCITdqoBq9O95ApgOnbUFP2tzn0xh5ytbiXngNGHv4JdUld6q1Wtzrl
	 RJuxykwzD84e+1FVmrY5VF6vZbRfA9bq2izrkso2dSvzLm/5LJDLRJfMsn229acV9x
	 qKKYp+aLAFTCuRwWOxMZhVBh5HePu7wusz42F+Wo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390092AbgEZS50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390076AbgEZS5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:57:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 539352086A;
        Tue, 26 May 2020 18:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519441;
        bh=LLXXh+1O6AIqTNd8uyV8uLzzENl3ZajJSYiSEFE1DtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZdFxOmBZYq+L3OoLlpjhv2P2sN2g/u+gioHJpHAXgP9vDjJdXc9arfctunRZP8WI
         5IsCE2eBxhZUGPuJnrl2zd+vPg8mvK5xttj2E1KZppMI2rv3w50sAPbVr40mwM3J53
         lVitta8gKSHfs6hucmPe/yDlXZX+FQrTINCNOT6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, greg@kroah.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Nault <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Giuliano Procida <gprocida@google.com>
Subject: [PATCH 4.4 52/65] l2tp: hold tunnel while handling genl TUNNEL_GET commands
Date:   Tue, 26 May 2020 20:53:11 +0200
Message-Id: <20200526183924.473324114@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183905.988782958@linuxfoundation.org>
References: <20200526183905.988782958@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume Nault <g.nault@alphalink.fr>

commit 4e4b21da3acc68a7ea55f850cacc13706b7480e9 upstream.

Use l2tp_tunnel_get() instead of l2tp_tunnel_find() so that we get
a reference on the tunnel, preventing l2tp_tunnel_destruct() from
freeing it from under us.

Also move l2tp_tunnel_get() below nlmsg_new() so that we only take
the reference when needed.

Fixes: 309795f4bec2 ("l2tp: Add netlink control API for L2TP")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Giuliano Procida <gprocida@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_netlink.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -428,34 +428,37 @@ static int l2tp_nl_cmd_tunnel_get(struct
 
 	if (!info->attrs[L2TP_ATTR_CONN_ID]) {
 		ret = -EINVAL;
-		goto out;
+		goto err;
 	}
 
 	tunnel_id = nla_get_u32(info->attrs[L2TP_ATTR_CONN_ID]);
 
-	tunnel = l2tp_tunnel_find(net, tunnel_id);
-	if (tunnel == NULL) {
-		ret = -ENODEV;
-		goto out;
-	}
-
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg) {
 		ret = -ENOMEM;
-		goto out;
+		goto err;
+	}
+
+	tunnel = l2tp_tunnel_get(net, tunnel_id);
+	if (!tunnel) {
+		ret = -ENODEV;
+		goto err_nlmsg;
 	}
 
 	ret = l2tp_nl_tunnel_send(msg, info->snd_portid, info->snd_seq,
 				  NLM_F_ACK, tunnel, L2TP_CMD_TUNNEL_GET);
 	if (ret < 0)
-		goto err_out;
+		goto err_nlmsg_tunnel;
+
+	l2tp_tunnel_dec_refcount(tunnel);
 
 	return genlmsg_unicast(net, msg, info->snd_portid);
 
-err_out:
+err_nlmsg_tunnel:
+	l2tp_tunnel_dec_refcount(tunnel);
+err_nlmsg:
 	nlmsg_free(msg);
-
-out:
+err:
 	return ret;
 }
 


