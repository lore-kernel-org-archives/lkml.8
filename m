Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5956CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 325F920734
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592585622;
	bh=IWwugB8J0T2HwlfDvqTqvYRdo+b31C/P+vvrxhblFWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=svvsdWB5XvIHNp2IWHjsnCTIsQiDZ8jQRpzP10VPQW8dcoioA8KrY3IIP1oZiHW5m
	 +WOy3scVPCKO/CWeyRSYhRyKFZ3M6RvA+7XaY3u5YGnaIN/ehJ4hzoKR/K/Uvp36ta
	 rw3wCZhYcXTnI3Zol2hS5YsnisVsz6dpfQ9YcfEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbgFSQxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387623AbgFSOhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:37:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C32F021582;
        Fri, 19 Jun 2020 14:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577422;
        bh=IWwugB8J0T2HwlfDvqTqvYRdo+b31C/P+vvrxhblFWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fU4DzqB0vLuabe/Qz8mZb5nG3pfXSfkH7p1sT5QpB1mxBSfM8Dq+L7Rky5ZPprnmN
         etQJ8ypvIkDg8ReVYRRtWsXZidCiSdStMMMHMnHc0x4AZUe5uZKgWkJMd37nPZSzF4
         InnnjYVP5aQibMq91B4c3hGRNtyrAW+3CpsuJYr0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Xiaolong Huang <butterflyhuangxx@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 045/101] can: kvaser_usb: kvaser_usb_leaf: Fix some info-leaks to USB devices
Date:   Fri, 19 Jun 2020 16:32:34 +0200
Message-Id: <20200619141616.459095266@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141614.001544111@linuxfoundation.org>
References: <20200619141614.001544111@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaolong Huang <butterflyhuangxx@gmail.com>

commit da2311a6385c3b499da2ed5d9be59ce331fa93e9 upstream.

Uninitialized Kernel memory can leak to USB devices.

Fix this by using kzalloc() instead of kmalloc().

Signed-off-by: Xiaolong Huang <butterflyhuangxx@gmail.com>
Fixes: 7259124eac7d ("can: kvaser_usb: Split driver into kvaser_usb_core.c and kvaser_usb_leaf.c")
Cc: linux-stable <stable@vger.kernel.org> # >= v4.19
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[bwh: Backported to 4.9: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/usb/kvaser_usb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -787,7 +787,7 @@ static int kvaser_usb_simple_msg_async(s
 		return -ENOMEM;
 	}
 
-	buf = kmalloc(sizeof(struct kvaser_msg), GFP_ATOMIC);
+	buf = kzalloc(sizeof(struct kvaser_msg), GFP_ATOMIC);
 	if (!buf) {
 		usb_free_urb(urb);
 		return -ENOMEM;
@@ -1457,7 +1457,7 @@ static int kvaser_usb_set_opt_mode(const
 	struct kvaser_msg *msg;
 	int rc;
 
-	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
+	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
@@ -1590,7 +1590,7 @@ static int kvaser_usb_flush_queue(struct
 	struct kvaser_msg *msg;
 	int rc;
 
-	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
+	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 


