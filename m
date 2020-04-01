Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B054C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF19D212CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758050;
	bh=QqJtODqh4iafCBejlvKjMTU8UnuGWAdCjG5NA7YuM10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qA+SZcILcoJQ036A4ANI8pngVixJsCHGVJVKCnNj2ahEyQ9gJ7ZfZVvJtc/qG4REW
	 2m3GXH01p99f2PTZALSjpdPNNRhlyVQ6nukRURua6iakRXkLegfzQst1gwRHu0nbg4
	 WQHV4+j6yxqJ2XjrS59zyqAZu9e0zMFHcNCwC4Yc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733187AbgDAQUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733168AbgDAQUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:20:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A8A0212CC;
        Wed,  1 Apr 2020 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758047;
        bh=QqJtODqh4iafCBejlvKjMTU8UnuGWAdCjG5NA7YuM10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TX+vrL2tAI2VtzcxkwxWM3y7m5ir3ZnQw1RZoeRx5M299hbbQ3KNYx0F/RNRTtOTd
         2tmF5mYMa4YdOFioz1Q/gIsXvNx4tG/s0zLdxFxXL+CSGf/7YgwASVx9mBlOIyJGe/
         h/rUMwAK5ZBe8/z7JrjrpShZ94xFFkDGEfks4LPE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Lanqing Liu <liuhhome@gmail.com>
Subject: [PATCH 5.5 04/30] serial: sprd: Fix a dereference warning
Date:   Wed,  1 Apr 2020 18:17:08 +0200
Message-Id: <20200401161417.605801573@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161414.345528747@linuxfoundation.org>
References: <20200401161414.345528747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lanqing Liu <liuhhome@gmail.com>

commit efc176929a3505a30c3993ddd393b40893649bd2 upstream.

We should validate if the 'sup' is NULL or not before freeing DMA
memory, to fix below warning.

"drivers/tty/serial/sprd_serial.c:1141 sprd_remove()
 error: we previously assumed 'sup' could be null (see line 1132)"

Fixes: f4487db58eb7 ("serial: sprd: Add DMA mode support")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lanqing Liu <liuhhome@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/e2bd92691538e95b04a2c2a728f3292e1617018f.1584325957.git.liuhhome@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/sprd_serial.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1136,14 +1136,13 @@ static int sprd_remove(struct platform_d
 	if (sup) {
 		uart_remove_one_port(&sprd_uart_driver, &sup->port);
 		sprd_port[sup->port.line] = NULL;
+		sprd_rx_free_buf(sup);
 		sprd_ports_num--;
 	}
 
 	if (!sprd_ports_num)
 		uart_unregister_driver(&sprd_uart_driver);
 
-	sprd_rx_free_buf(sup);
-
 	return 0;
 }
 


