Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9927AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E877204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592585174;
	bh=WBZd16pwTulkHYMylZodT11SrG1VWJ124t45szSRlhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hdK+B8/2NtoZ7E5APJHgEOZdEojnBZGIcqw6teuKSiMhFrmzw4u38O4rj1aMIjJZC
	 O9ROIenw8okrPBG50zcwjroDHSRlzE8/vUL1naulT4xvS/cdgMsSp+NPWccrHiL4gz
	 O1y3jzBjOhhpiOms3HNmFS5i36T9etGDP+IpaUvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405101AbgFSQqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387469AbgFSOlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:41:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 415E821527;
        Fri, 19 Jun 2020 14:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577700;
        bh=WBZd16pwTulkHYMylZodT11SrG1VWJ124t45szSRlhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TOrtXKeT3VHRObuh9aQl9buAOb2VDx0WX2U3Ld2oxjD0Ehz+ao6mmNSZ/bcUK6byu
         PoCn+BmugWXDqY0J/QrsNIGxtjXyeJzzU3cxDgdwCwHeiHIkYUa4lrU9ww7zuMApge
         i87v1hqD+H3njlaEUW/Aghl5YMnTfJBi1sT15P8Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Xiaolong Huang <butterflyhuangxx@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.9 052/128] can: kvaser_usb: kvaser_usb_leaf: Fix some info-leaks to USB devices
Date:   Fri, 19 Jun 2020 16:32:26 +0200
Message-Id: <20200619141622.946789972@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141620.148019466@linuxfoundation.org>
References: <20200619141620.148019466@linuxfoundation.org>
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
@@ -791,7 +791,7 @@ static int kvaser_usb_simple_msg_async(s
 	if (!urb)
 		return -ENOMEM;
 
-	buf = kmalloc(sizeof(struct kvaser_msg), GFP_ATOMIC);
+	buf = kzalloc(sizeof(struct kvaser_msg), GFP_ATOMIC);
 	if (!buf) {
 		usb_free_urb(urb);
 		return -ENOMEM;
@@ -1459,7 +1459,7 @@ static int kvaser_usb_set_opt_mode(const
 	struct kvaser_msg *msg;
 	int rc;
 
-	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
+	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
@@ -1592,7 +1592,7 @@ static int kvaser_usb_flush_queue(struct
 	struct kvaser_msg *msg;
 	int rc;
 
-	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
+	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 


