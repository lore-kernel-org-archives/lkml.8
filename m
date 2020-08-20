Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFC0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 972B822B4D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597924937;
	bh=CF0K9DLAiVFuQL24PrDR4QPlTU3LUPidNE+WG6IEwVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b48zb9q4+XnJQ1YiXU6yLhjECjPt3McXVQpFsd4ETc1Qlamd4zQa/3iTEejtfGpDX
	 IhpeCTT2mWmH/Cel9/uiv2AdGJ8RtPZv269mv0lrKkwiKs0YNkIh4qLiBbkMNjecwy
	 GoyGiibicecE9mL0LNpXClz2K/l+FiL249FAQgt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbgHTJ7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:59:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbgHTJ71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:59:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C0A0208DB;
        Thu, 20 Aug 2020 09:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917567;
        bh=CF0K9DLAiVFuQL24PrDR4QPlTU3LUPidNE+WG6IEwVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Er9F4klMwCOghosXy4whnjEjUBXYuKhDyC8Bp/ESsEaljzivw6fzdcQJY4j+elx9b
         +iVeU5Eh6bbMu0Uzm1BWhI/toLvqA8i4TkPrWrM8pOewbUKfv8XWnAAyUpaG/JUJPz
         Ypbv5dF/Fc3qVqqDJNXkFCiCxoCz5NWtlWRsJHhA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rustam Kovhaev <rkovhaev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+67b2bd0e34f952d0321e@syzkaller.appspotmail.com
Subject: [PATCH 4.9 077/212] usb: hso: check for return value in hso_serial_common_create()
Date:   Thu, 20 Aug 2020 11:20:50 +0200
Message-Id: <20200820091606.255659045@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/hso.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -2274,12 +2274,14 @@ static int hso_serial_common_create(stru
 
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
 	dev = serial->parent->dev;
 
 	/* fill in specific data for later use */
@@ -2325,6 +2327,7 @@ static int hso_serial_common_create(stru
 	return 0;
 exit:
 	hso_serial_tty_unregister(serial);
+exit2:
 	hso_serial_common_free(serial);
 	return -1;
 }


