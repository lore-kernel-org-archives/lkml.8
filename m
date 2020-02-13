Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BD2C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468D320656
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581610302;
	bh=kt0Bz0bPpo/l/zqQOhZV+pT2pslamunyf4gkPOCt2Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ILZ1sIVSCBbcWaFYTzYBkPEMidgMRfESEPQloxxphh/BLU+SArKlFUPj2qyZBINP0
	 Rug5J9kJFkozpwfOfuQfnirZ2M4/V1C739OOouQN9t8AIKwQRlWMaanf6UBE4pFgyd
	 l6hQUHZLf1iDe2M7p5HuHBp9WBP3D/G7P1XHpWUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgBMQLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:11:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:59170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbgBMPWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:22:21 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6391C20848;
        Thu, 13 Feb 2020 15:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607340;
        bh=kt0Bz0bPpo/l/zqQOhZV+pT2pslamunyf4gkPOCt2Pw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G1NuQu7Cp6iRd+kAkGS5r3cW+pGU+eq0MVEb1ntO6loR33VXgFtL1lKVV0eTdPrmZ
         uvUT5uLaI6X9lP9uArEwa9vkwnH5eNvxFDuYuhswMD7Yy9ZRhkxmTE0DC4lpVBmyco
         BVie+ZDyHLK3gC7FclCFQ8mlPEfBtT7TJqPl95OI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bryan ODonoghue <bryan.odonoghue@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 4.4 15/91] usb: gadget: f_ecm: Use atomic_t to track in-flight request
Date:   Thu, 13 Feb 2020 07:19:32 -0800
Message-Id: <20200213151827.713921191@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151821.384445454@linuxfoundation.org>
References: <20200213151821.384445454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

commit d710562e01c48d59be3f60d58b7a85958b39aeda upstream.

Currently ecm->notify_req is used to flag when a request is in-flight.
ecm->notify_req is set to NULL and when a request completes it is
subsequently reset.

This is fundamentally buggy in that the unbind logic of the ECM driver will
unconditionally free ecm->notify_req leading to a NULL pointer dereference.

Fixes: da741b8c56d6 ("usb ethernet gadget: split CDC Ethernet function")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/f_ecm.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/usb/gadget/function/f_ecm.c
+++ b/drivers/usb/gadget/function/f_ecm.c
@@ -56,6 +56,7 @@ struct f_ecm {
 	struct usb_ep			*notify;
 	struct usb_request		*notify_req;
 	u8				notify_state;
+	atomic_t			notify_count;
 	bool				is_open;
 
 	/* FIXME is_open needs some irq-ish locking
@@ -384,7 +385,7 @@ static void ecm_do_notify(struct f_ecm *
 	int				status;
 
 	/* notification already in flight? */
-	if (!req)
+	if (atomic_read(&ecm->notify_count))
 		return;
 
 	event = req->buf;
@@ -424,10 +425,10 @@ static void ecm_do_notify(struct f_ecm *
 	event->bmRequestType = 0xA1;
 	event->wIndex = cpu_to_le16(ecm->ctrl_id);
 
-	ecm->notify_req = NULL;
+	atomic_inc(&ecm->notify_count);
 	status = usb_ep_queue(ecm->notify, req, GFP_ATOMIC);
 	if (status < 0) {
-		ecm->notify_req = req;
+		atomic_dec(&ecm->notify_count);
 		DBG(cdev, "notify --> %d\n", status);
 	}
 }
@@ -452,17 +453,19 @@ static void ecm_notify_complete(struct u
 	switch (req->status) {
 	case 0:
 		/* no fault */
+		atomic_dec(&ecm->notify_count);
 		break;
 	case -ECONNRESET:
 	case -ESHUTDOWN:
+		atomic_set(&ecm->notify_count, 0);
 		ecm->notify_state = ECM_NOTIFY_NONE;
 		break;
 	default:
 		DBG(cdev, "event %02x --> %d\n",
 			event->bNotificationType, req->status);
+		atomic_dec(&ecm->notify_count);
 		break;
 	}
-	ecm->notify_req = req;
 	ecm_do_notify(ecm);
 }
 
@@ -909,6 +912,11 @@ static void ecm_unbind(struct usb_config
 
 	usb_free_all_descriptors(f);
 
+	if (atomic_read(&ecm->notify_count)) {
+		usb_ep_dequeue(ecm->notify, ecm->notify_req);
+		atomic_set(&ecm->notify_count, 0);
+	}
+
 	kfree(ecm->notify_req->buf);
 	usb_ep_free_request(ecm->notify, ecm->notify_req);
 }


