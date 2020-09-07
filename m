Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18938C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D6F208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599497291;
	bh=RVxEar8vD0mPwWMghOaEsGuVyW2pF6wXmGmSCVwUICY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pIBpIc3EBShGTZu9OsFliB0Suu0g6TiO1qiPKBOCg9EOnHA5Vzn4M6c1ngPMZ/zbh
	 lkg2AezHVW+UFARILo5P0R1wKAGqR9nuPXIYME2q46/hKQBTO1RliF7ZrWLQpR6JJV
	 aoNmu7OPP6LOFSBw6mb/t9Itg2T8M1zcxe7i++lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbgIGQsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730775AbgIGQfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:35:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A86421D80;
        Mon,  7 Sep 2020 16:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496513;
        bh=RVxEar8vD0mPwWMghOaEsGuVyW2pF6wXmGmSCVwUICY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yUeLWVY0p26iz4jUflNlfh1HtsPKsJRvlPZH5iBUzvCR/f3MPfTrtd2pnWxUceQZb
         ZpFSrO8IdNKalz+dSFyArawISueFeC6s/2Be6Lr5YiRcbwh22amV92c7ScW34ggjJ/
         EnUglzJcU3A2U37WJjGEkSDuHTauSotHTipTMlIs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Himadri Pandya <himadrispandya@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 09/17] net: usb: Fix uninit-was-stored issue in asix_read_phy_addr()
Date:   Mon,  7 Sep 2020 12:34:52 -0400
Message-Id: <20200907163500.1281543-9-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163500.1281543-1-sashal@kernel.org>
References: <20200907163500.1281543-1-sashal@kernel.org>
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
index e9fcf6ef716a8..9bf18127e63a1 100644
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

