Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8017C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9356822D74
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073534;
	bh=HQuKcHKaMPUKXcAswKyAx8FwNMuuuNSyoqwuF+jeTs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EeU/TG0cnEySQbsArZBhReo0FENJU+W5hVBjiMWyP6P12E66EasYv0VuB4iYibYTK
	 4kGERmOfOe/zPOP+c2sAqURVVrJnO9F+ZZYhCISaI6PFA4XelNpndBJ/7S5pEhHMyz
	 uzK7KkBNf5AFn/38yeofxfwe+kYI/D98Tj5kCoco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgHJPax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:30:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729125AbgHJPap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:30:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5CF920791;
        Mon, 10 Aug 2020 15:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073445;
        bh=HQuKcHKaMPUKXcAswKyAx8FwNMuuuNSyoqwuF+jeTs8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CK1Blwm0V3tYI+1np2632NwTYlwDLfrx42T7g8maGYXTlimNOxJMmIYv8cN0XocaZ
         jt5/suA6XV5TuQ/beKRfskrZuWAewfw7zQH5rKjyqLfdWk5KDJIPHoDZoSCSbAQ600
         CguVBjS60wzTxCFiKltvuWBQ2gZmJ/laNmFmbYCs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rustam Kovhaev <rkovhaev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+67b2bd0e34f952d0321e@syzkaller.appspotmail.com
Subject: [PATCH 4.19 24/48] usb: hso: check for return value in hso_serial_common_create()
Date:   Mon, 10 Aug 2020 17:21:46 +0200
Message-Id: <20200810151805.404508512@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151804.199494191@linuxfoundation.org>
References: <20200810151804.199494191@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rustam Kovhaev <rkovhaev@gmail.com>

[ Upstream commit e911e99a0770f760377c263bc7bac1b1593c6147 ]

in case of an error tty_register_device_attr() returns ERR_PTR(),
add IS_ERR() check

Reported-and-tested-by: syzbot+67b2bd0e34f952d0321e@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=67b2bd0e34f952d0321e
Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/hso.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index 61b9d33681484..bff268b4a9a46 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -2274,12 +2274,14 @@ static int hso_serial_common_create(struct hso_serial *serial, int num_urbs,
 
 	minor = get_free_serial_index();
 	if (minor < 0)
-		goto exit;
+		goto exit2;
 
 	/* register our minor number */
 	serial->parent->dev = tty_port_register_device_attr(&serial->port,
 			tty_drv, minor, &serial->parent->interface->dev,
 			serial->parent, hso_serial_dev_groups);
+	if (IS_ERR(serial->parent->dev))
+		goto exit2;
 
 	/* fill in specific data for later use */
 	serial->minor = minor;
@@ -2324,6 +2326,7 @@ static int hso_serial_common_create(struct hso_serial *serial, int num_urbs,
 	return 0;
 exit:
 	hso_serial_tty_unregister(serial);
+exit2:
 	hso_serial_common_free(serial);
 	return -1;
 }
-- 
2.25.1



