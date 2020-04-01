Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F325C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C0A20857
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585757971;
	bh=/9QYk9OVbzZY26ScvUwzpIZOv2gxgJRWE1IW8g7lRxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W3PfNYzoABR1fVNLbxKwS/u+ihLy46Kj94P1UqWPrHTosrtVtv50eDsLmMtinczLa
	 SBfOMzkGQNF+cE8A2oNrW+BEDf1Pl+C4xfaeyxOpxYGxW2uDrI128w4wIAldd6YrBZ
	 QuR3LAhHPgchqOMC3ptozUKNqgzchPsZ5rYdQUNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbgDAQTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgDAQT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:19:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F30A620B1F;
        Wed,  1 Apr 2020 16:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585757968;
        bh=/9QYk9OVbzZY26ScvUwzpIZOv2gxgJRWE1IW8g7lRxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fp3ox+aA7B4zIgJll+56saBYJ2y03J0J8S9XVXIPGy+GKpSy9SHBNx/O+Xl2WbPxb
         HwW3/wikN19f054d+oemJ3ahFWztzJNywN+eakxugoOLGeAJnMrFSb9bvdhvprySwc
         pyIj1MwkNqJmR9vJXs1mxxuVKFTnzg2ksC5fgruY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Lanqing Liu <liuhhome@gmail.com>
Subject: [PATCH 5.6 03/10] serial: sprd: Fix a dereference warning
Date:   Wed,  1 Apr 2020 18:17:19 +0200
Message-Id: <20200401161417.039813573@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161413.974936041@linuxfoundation.org>
References: <20200401161413.974936041@linuxfoundation.org>
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
@@ -1132,14 +1132,13 @@ static int sprd_remove(struct platform_d
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
 


