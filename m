Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F37FC35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14772218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747680;
	bh=6DmBolbtfr5xFdGIY7cFqc5o5dNUZ0YZKeKqRMpNUGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AN8ePERkJcfhOVAblVZU7f0bKNO3OzpsyyusCl/BMLrAGSxgOcbfoRj7G9mh44bh6
	 1YvaFUeT9vgVGx+lbjY/eQ70zuYSKaU1Z2ouGqZSJ1WUccGPXF596CY7n8VldA/P4J
	 eux22zG2xK6c3sBs/ZmbNck9WGvsMTmVpzaRWUYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgBCQej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:34:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730815AbgBCQef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:34:35 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60E5321775;
        Mon,  3 Feb 2020 16:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747674;
        bh=6DmBolbtfr5xFdGIY7cFqc5o5dNUZ0YZKeKqRMpNUGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y+udwoXChaAsIe6jt/Q/klG+/5shPp3zbj1P3SQazZIKppdUXMWXzBGTi4PU8awYR
         Mss5qtAuk7eSdb65l0GIUs2T7kRnRMxfpZDLYN9yDiho97uyLxLVsvxkPuB0Sg2YUp
         UvODcTfMzBRFWVXCAaJzh6z0LwwDxVWkIJiP/9fA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+6bf9606ee955b646c0e1@syzkaller.appspotmail.com,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.4 15/90] media: digitv: dont continue if remote control state cant be read
Date:   Mon,  3 Feb 2020 16:19:18 +0000
Message-Id: <20200203161919.685182477@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161917.612554987@linuxfoundation.org>
References: <20200203161917.612554987@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Young <sean@mess.org>

commit eecc70d22ae51225de1ef629c1159f7116476b2e upstream.

This results in an uninitialized variable read.

Reported-by: syzbot+6bf9606ee955b646c0e1@syzkaller.appspotmail.com
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/dvb-usb/digitv.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/media/usb/dvb-usb/digitv.c
+++ b/drivers/media/usb/dvb-usb/digitv.c
@@ -230,18 +230,22 @@ static struct rc_map_table rc_map_digitv
 
 static int digitv_rc_query(struct dvb_usb_device *d, u32 *event, int *state)
 {
-	int i;
+	int ret, i;
 	u8 key[5];
 	u8 b[4] = { 0 };
 
 	*event = 0;
 	*state = REMOTE_NO_KEY_PRESSED;
 
-	digitv_ctrl_msg(d,USB_READ_REMOTE,0,NULL,0,&key[1],4);
+	ret = digitv_ctrl_msg(d, USB_READ_REMOTE, 0, NULL, 0, &key[1], 4);
+	if (ret)
+		return ret;
 
 	/* Tell the device we've read the remote. Not sure how necessary
 	   this is, but the Nebula SDK does it. */
-	digitv_ctrl_msg(d,USB_WRITE_REMOTE,0,b,4,NULL,0);
+	ret = digitv_ctrl_msg(d, USB_WRITE_REMOTE, 0, b, 4, NULL, 0);
+	if (ret)
+		return ret;
 
 	/* if something is inside the buffer, simulate key press */
 	if (key[1] != 0)


