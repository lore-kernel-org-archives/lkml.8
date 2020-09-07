Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A5BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B2D207DE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599497529;
	bh=wuwVLdXX2n13+HfWQm1zOODVzzKlPBYPTWU70RzIDXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F1tJf8p3FmC3NhgCoM0TojmHMiXFdsmoZa/sFJNVQehqunMnyHt82LoekJ1BRLinm
	 ZJOCbW533a9kxA0y2PKJJwG0O+aJODiZXAqSfngxysmnmhHMlYpLkwi+mzNH/GECx8
	 kaghsN6oyZPrOVHLvFL0/ZRDiqE+A/3S6HBafG2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbgIGQwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:52:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730767AbgIGQeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:34:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CA1C21D95;
        Mon,  7 Sep 2020 16:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496488;
        bh=wuwVLdXX2n13+HfWQm1zOODVzzKlPBYPTWU70RzIDXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s7w9tvr3TKUQMy8i1+Mj5mqlMz40mDisGtwLWgXntWJjZfyZAApL/WKYs0dlvL+/F
         3/0ObwZyeCqZO9LjNImrEImvqa9p153vBg7S8gAPowuuI9pyeuKfvZtqxDcIIk/M4V
         7gZnrRAqjeVpXE144nCy5+/Mu9jtXUwTsj2iSjeQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xie He <xie.he.0141@gmail.com>, Martin Schiller <ms@dev.tdt.de>,
        Krzysztof Halasa <khc@pm.waw.pl>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 17/26] drivers/net/wan/hdlc_cisco: Add hard_header_len
Date:   Mon,  7 Sep 2020 12:34:17 -0400
Message-Id: <20200907163426.1281284-17-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163426.1281284-1-sashal@kernel.org>
References: <20200907163426.1281284-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xie He <xie.he.0141@gmail.com>

[ Upstream commit 1a545ebe380bf4c1433e3c136e35a77764fda5ad ]

This driver didn't set hard_header_len. This patch sets hard_header_len
for it according to its header_ops->create function.

This driver's header_ops->create function (cisco_hard_header) creates
a header of (struct hdlc_header), so hard_header_len should be set to
sizeof(struct hdlc_header).

Cc: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Xie He <xie.he.0141@gmail.com>
Acked-by: Krzysztof Halasa <khc@pm.waw.pl>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wan/hdlc_cisco.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wan/hdlc_cisco.c b/drivers/net/wan/hdlc_cisco.c
index 320039d329c7d..c169a26e5359a 100644
--- a/drivers/net/wan/hdlc_cisco.c
+++ b/drivers/net/wan/hdlc_cisco.c
@@ -374,6 +374,7 @@ static int cisco_ioctl(struct net_device *dev, struct ifreq *ifr)
 		memcpy(&state(hdlc)->settings, &new_settings, size);
 		spin_lock_init(&state(hdlc)->lock);
 		dev->header_ops = &cisco_header_ops;
+		dev->hard_header_len = sizeof(struct hdlc_header);
 		dev->type = ARPHRD_CISCO;
 		call_netdevice_notifiers(NETDEV_POST_TYPE_CHANGE, dev);
 		netif_dormant_on(dev);
-- 
2.25.1

