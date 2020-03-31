Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939FDC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC5F20675
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645853;
	bh=G19ygq6fSFuM9CneHTe6LevYWq0Om8ZQbtCSGqMYeus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=adAtW7N/eMaKnwW/0uAmsBJRZ5ruyxW/NUoywA2a1N9pQkEy2NIQRFF3rHVbVsExs
	 i3+npuTprFW0Fg6n83nEqvDQJBOJLFjVb9JsprUIHYo/LsvK+AXFlgdM0FgBBEkDh6
	 PqMEmQiio+HvM0jmzsSt0VM6FyNb0CbUpEWQxBso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbgCaJKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731619AbgCaJKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:10:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9A9E20772;
        Tue, 31 Mar 2020 09:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645845;
        bh=G19ygq6fSFuM9CneHTe6LevYWq0Om8ZQbtCSGqMYeus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K69qRdHYFBbN7CEQHnilQdZ3WZKzGHOcdD+sNAz9oClkLIvKgAbk4uCgizb3/5Mz9
         w2AI0qBA0fvWeYZI2YJDWiFv1CJcQavDEnAv37EOCQ47bAwJ1CzAjTjFxXTkiw21ZB
         ZLzMLb1/4kvFggGSNNdvsnf5b+9hc0wPPBSG95nE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 012/155] macsec: restrict to ethernet devices
Date:   Tue, 31 Mar 2020 10:57:32 +0200
Message-Id: <20200331085419.748783954@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
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
@@ -16,6 +16,7 @@
 #include <net/genetlink.h>
 #include <net/sock.h>
 #include <net/gro_cells.h>
+#include <linux/if_arp.h>
 
 #include <uapi/linux/if_macsec.h>
 
@@ -3236,6 +3237,8 @@ static int macsec_newlink(struct net *ne
 	real_dev = __dev_get_by_index(net, nla_get_u32(tb[IFLA_LINK]));
 	if (!real_dev)
 		return -ENODEV;
+	if (real_dev->type != ARPHRD_ETHER)
+		return -EINVAL;
 
 	dev->priv_flags |= IFF_MACSEC;
 


