Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DDAC2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7CA20787
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759371;
	bh=nSL2VlQVTb3GPKokrRs/RPqS8c005cAw2vMQezf9gH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aJT2UmFh6el+vqkgfhcq2DAhiuRQUjOpJWgkfPjmMyX5LnyTaz2UHnWdS3KcGe4gc
	 FDmNNeLiKepOjPtdVZiw2zA0RctG5fPGcBg+/M4DucTTlM/96KjwokH7BquvQSSMyS
	 xnky1GZiJ9nEO6GqxH5lVFmmO3Tn4dpltM0FRvjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389026AbgDAQmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389549AbgDAQmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:42:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A668120658;
        Wed,  1 Apr 2020 16:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759366;
        bh=nSL2VlQVTb3GPKokrRs/RPqS8c005cAw2vMQezf9gH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j++y4RL1QHywzNAWXE53M6NMweabNQe6cbW/qU8LHG1nOqaXS6QemQoP8gWy3T2J2
         l/VEywtbg5St6In71R2F7bvQ23+FuAOsGmYT6pbHN1G0q9Xv3ceP2IkntUrZq7OcWf
         Zjun5PBE5mQ594CaUOwO6wkR0umJvBH1KzsGo4xc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 057/148] macsec: restrict to ethernet devices
Date:   Wed,  1 Apr 2020 18:17:29 +0200
Message-Id: <20200401161558.433370616@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit b06d072ccc4b1acd0147b17914b7ad1caa1818bb ]

Only attach macsec to ethernet devices.

Syzbot was able to trigger a KMSAN warning in macsec_handle_frame
by attaching to a phonet device.

Macvlan has a similar check in macvlan_port_create.

v1->v2
  - fix commit message typo

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/macsec.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -19,6 +19,7 @@
 #include <net/genetlink.h>
 #include <net/sock.h>
 #include <net/gro_cells.h>
+#include <linux/if_arp.h>
 
 #include <uapi/linux/if_macsec.h>
 
@@ -3219,6 +3220,8 @@ static int macsec_newlink(struct net *ne
 	real_dev = __dev_get_by_index(net, nla_get_u32(tb[IFLA_LINK]));
 	if (!real_dev)
 		return -ENODEV;
+	if (real_dev->type != ARPHRD_ETHER)
+		return -EINVAL;
 
 	dev->priv_flags |= IFF_MACSEC;
 


