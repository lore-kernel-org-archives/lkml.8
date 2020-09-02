Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC630C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C77D72065E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="qyvR/wSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIBDWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 23:22:40 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:39634 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgIBDWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 23:22:39 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4F13784488;
        Wed,  2 Sep 2020 15:22:35 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1599016955;
        bh=TIK2ZarG+pHpksoKlt2pxfkQdePFZ8pjCPM1KihJnMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=qyvR/wSdo8LWAQMGmpnlfiNbDldawPLWtd0IEJBOGroynF+yZcWBCexz9KaR38YCL
         QzE8dcSsnFqaYvgH0tifChRqjWy2GOgDrvEsjtJQ7fRtBIOvHrOe/2eDXCsJzoUBZa
         w3uHzzuu/IHR3XvYrz2KwZrTvXM0OQC61ZdZagJDUqm04qZnvexb+3LYwD0honjLXT
         chWYM2HIphnKYjaxjQ2+zaDXXqjviQ0BU0a1dpx6AJS8dsRbIcRYF4Q4iP7bIRxlVI
         J7LWOf6J1LCSrZlH7otflhdFXYW/7O0yKS+eAHDnfZNR9XiblcByjvX5aDSjM52L+a
         TR4v/GgYPiORw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f4f0ffb0001>; Wed, 02 Sep 2020 15:22:35 +1200
Received: from pauld-dl.ws.atlnz.lc (pauld-dl.ws.atlnz.lc [10.33.23.16])
        by smtp (Postfix) with ESMTP id C448713EED0;
        Wed,  2 Sep 2020 15:22:34 +1200 (NZST)
Received: by pauld-dl.ws.atlnz.lc (Postfix, from userid 1684)
        id 17BBC1E0574; Wed,  2 Sep 2020 15:22:35 +1200 (NZST)
From:   Paul Davey <paul.davey@alliedtelesis.co.nz>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Davey <paul.davey@alliedtelesis.co.nz>
Subject: [PATCH net-next 1/2] ipmr: Add route table ID to netlink cache reports
Date:   Wed,  2 Sep 2020 15:22:21 +1200
Message-Id: <20200902032222.25109-2-paul.davey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902032222.25109-1-paul.davey@alliedtelesis.co.nz>
References: <20200902032222.25109-1-paul.davey@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Insert the multicast route table ID as a Netlink attribute to Netlink
cache report notifications.

When multiple route tables are in use it is necessary to have a way to
determine which route table a given cache report belongs to when
receiving the cache report.

Signed-off-by: Paul Davey <paul.davey@alliedtelesis.co.nz>
---
 include/uapi/linux/mroute.h | 1 +
 net/ipv4/ipmr.c             | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/mroute.h b/include/uapi/linux/mroute.h
index 11c8c1fc1124..918f1ef32ffe 100644
--- a/include/uapi/linux/mroute.h
+++ b/include/uapi/linux/mroute.h
@@ -169,6 +169,7 @@ enum {
 	IPMRA_CREPORT_SRC_ADDR,
 	IPMRA_CREPORT_DST_ADDR,
 	IPMRA_CREPORT_PKT,
+	IPMRA_CREPORT_TABLE,
 	__IPMRA_CREPORT_MAX
 };
 #define IPMRA_CREPORT_MAX (__IPMRA_CREPORT_MAX - 1)
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 876fd6ff1ff9..19b2f586319b 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2396,6 +2396,7 @@ static size_t igmpmsg_netlink_msgsize(size_t payloa=
dlen)
 		+ nla_total_size(4)	/* IPMRA_CREPORT_VIF_ID */
 		+ nla_total_size(4)	/* IPMRA_CREPORT_SRC_ADDR */
 		+ nla_total_size(4)	/* IPMRA_CREPORT_DST_ADDR */
+		+ nla_total_size(4)	/* IPMRA_CREPORT_TABLE */
 					/* IPMRA_CREPORT_PKT */
 		+ nla_total_size(payloadlen)
 		;
@@ -2431,7 +2432,8 @@ static void igmpmsg_netlink_event(struct mr_table *=
mrt, struct sk_buff *pkt)
 	    nla_put_in_addr(skb, IPMRA_CREPORT_SRC_ADDR,
 			    msg->im_src.s_addr) ||
 	    nla_put_in_addr(skb, IPMRA_CREPORT_DST_ADDR,
-			    msg->im_dst.s_addr))
+			    msg->im_dst.s_addr) ||
+	    nla_put_u32(skb, IPMRA_CREPORT_TABLE, mrt->id))
 		goto nla_put_failure;
=20
 	nla =3D nla_reserve(skb, IPMRA_CREPORT_PKT, payloadlen);
--=20
2.28.0

