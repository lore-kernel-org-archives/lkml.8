Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2C6C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3215E212CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758292;
	bh=rFN2dQwuflHduz4JWiRFToRSx2xwiHorTcHD7D9X/zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y+Vkw6RGMwH9ldFPG8tdd3q39ww/cDJnKmP3ym1KQ71iqxVe+EhhnG3h0AGSxCZEE
	 OyDWAEXF5nyASh9New+eOxuT1xzsgBABNHwp96hc/aKF8bjqxSNhXufwhzKURx0wXh
	 Gg3vDOSHbBpNvmqfCMQ62wIZA5ELf4RWPB1oO65M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732907AbgDAQYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387734AbgDAQYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:24:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2EA1212CC;
        Wed,  1 Apr 2020 16:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758288;
        bh=rFN2dQwuflHduz4JWiRFToRSx2xwiHorTcHD7D9X/zM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dAn9EDcQTf1QVQytUtW0UBr+Wmsg/i5ccGwiP/CrK9qOcawQ8NR0aoSlGIakA0zTe
         fBc4/VjXXvaR9goYNFkl2hc6diuZM+h3Di76G+4xNW+1CnGtBP5DdGlesOkmJscXww
         McefMMQKZbnm01ERsQADIPKwF194g8CBPoB+xX/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 009/116] macsec: restrict to ethernet devices
Date:   Wed,  1 Apr 2020 18:16:25 +0200
Message-Id: <20200401161543.378887711@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
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
@@ -20,6 +20,7 @@
 #include <net/genetlink.h>
 #include <net/sock.h>
 #include <net/gro_cells.h>
+#include <linux/if_arp.h>
 
 #include <uapi/linux/if_macsec.h>
 
@@ -3248,6 +3249,8 @@ static int macsec_newlink(struct net *ne
 	real_dev = __dev_get_by_index(net, nla_get_u32(tb[IFLA_LINK]));
 	if (!real_dev)
 		return -ENODEV;
+	if (real_dev->type != ARPHRD_ETHER)
+		return -EINVAL;
 
 	dev->priv_flags |= IFF_MACSEC;
 


