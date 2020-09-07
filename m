Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299E1C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3BD821D1A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599496713;
	bh=9JMW1rFvX6tmEe7cAZNVid3sznPv0nEZaepOAHVS73Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n4ut3JK2K7ns0nIGgsi/1MOkXu3DGZe/KoBykzoML76BGJkJQICcHG1yYmz/ObpC2
	 idLw9cLdOYjmUmNLY82MIqffStVwk7RwxG/KYz8IiTNSKjT2fggkn+LsDmSY7xUEhr
	 Q8Hy9XiZiqwTkneiDQiAG9tIALR/oRIWx7KbNveg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbgIGQib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:38:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730499AbgIGQek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:34:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89C6F21D90;
        Mon,  7 Sep 2020 16:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496479;
        bh=9JMW1rFvX6tmEe7cAZNVid3sznPv0nEZaepOAHVS73Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RBuLXEZkWDGorbkvZkyLcsAuXY/F6jEGJVKoe3ijfMwiSn6ElOCnhpAJ3tTnUlaq8
         m0PHh6e2TjFtZcgnedZ0HBYtOLiIryU24ukJGcdDS7rC8xxGumR4tyjpirqgi22Nyu
         9r26WX4zO53SDbE/9apsKYGX/AqDSSxmjTc1vVzo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Himadri Pandya <himadrispandya@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 10/26] net: usb: Fix uninit-was-stored issue in asix_read_phy_addr()
Date:   Mon,  7 Sep 2020 12:34:10 -0400
Message-Id: <20200907163426.1281284-10-sashal@kernel.org>
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

From: Himadri Pandya <himadrispandya@gmail.com>

[ Upstream commit a092b7233f0e000cc6f2c71a49e2ecc6f917a5fc ]

The buffer size is 2 Bytes and we expect to receive the same amount of
data. But sometimes we receive less data and run into uninit-was-stored
issue upon read. Hence modify the error check on the return value to match
with the buffer size as a prevention.

Reported-and-tested by: syzbot+a7e220df5a81d1ab400e@syzkaller.appspotmail.com
Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/asix_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
index 023b8d0bf1754..8d27786acad91 100644
--- a/drivers/net/usb/asix_common.c
+++ b/drivers/net/usb/asix_common.c
@@ -309,7 +309,7 @@ int asix_read_phy_addr(struct usbnet *dev, int internal)
 
 	netdev_dbg(dev->net, "asix_get_phy_addr()\n");
 
-	if (ret < 0) {
+	if (ret < 2) {
 		netdev_err(dev->net, "Error reading PHYID register: %02x\n", ret);
 		goto out;
 	}
-- 
2.25.1

