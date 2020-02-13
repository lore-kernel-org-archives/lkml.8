Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A0AC3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A990206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581610003;
	bh=z9SGixNCT5LqAOs1AaIfPqnNP4XDDLBFKtI3cWOntoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fSc2v5LbmwRhXemih2Gu4ZZfcGZRRhbzSem2xAyaBydS5xpNeKEGu2DBX/vc8d6Zl
	 AV584HWdvtymIIDmmWmvDC5Lz9ycbWcXXV2Ax8A8iE/PWPi3KzDrCkfYQ6fV4KNhbL
	 syMQyaaBczhaWFVObJ4HdPl6Y0KWMjJwRFXEQG5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbgBMQGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:06:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:35014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbgBMPXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:34 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D074F246B3;
        Thu, 13 Feb 2020 15:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607413;
        bh=z9SGixNCT5LqAOs1AaIfPqnNP4XDDLBFKtI3cWOntoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J6EG1zBKzcLpPUrjKSwKDYKHIBGJZGwe+4k8C0WaiCVkZutyNFi7zjQTCqKc1ydqe
         oaoCJSfkzOTNp4sA7LSfXZr5MZ18HUVHqaJ6bO6xdXg728VtscTroVJBQ0itJpmqwL
         dNfL0fG4owh1rJPWda7TEbSeyVpa6cD5JK6clpXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bryan ODonoghue <bryan.odonoghue@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 4.9 019/116] usb: gadget: f_ncm: Use atomic_t to track in-flight request
Date:   Thu, 13 Feb 2020 07:19:23 -0800
Message-Id: <20200213151850.320924673@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

commit 5b24c28cfe136597dc3913e1c00b119307a20c7e upstream.

Currently ncm->notify_req is used to flag when a request is in-flight.
ncm->notify_req is set to NULL and when a request completes it is
subsequently reset.

This is fundamentally buggy in that the unbind logic of the NCM driver will
unconditionally free ncm->notify_req leading to a NULL pointer dereference.

Fixes: 40d133d7f542 ("usb: gadget: f_ncm: convert to new function interface with backward compatibility")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/f_ncm.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -57,6 +57,7 @@ struct f_ncm {
 	struct usb_ep			*notify;
 	struct usb_request		*notify_req;
 	u8				notify_state;
+	atomic_t			notify_count;
 	bool				is_open;
 
 	const struct ndp_parser_opts	*parser_opts;
@@ -552,7 +553,7 @@ static void ncm_do_notify(struct f_ncm *
 	int				status;
 
 	/* notification already in flight? */
-	if (!req)
+	if (atomic_read(&ncm->notify_count))
 		return;
 
 	event = req->buf;
@@ -592,7 +593,8 @@ static void ncm_do_notify(struct f_ncm *
 	event->bmRequestType = 0xA1;
 	event->wIndex = cpu_to_le16(ncm->ctrl_id);
 
-	ncm->notify_req = NULL;
+	atomic_inc(&ncm->notify_count);
+
 	/*
 	 * In double buffering if there is a space in FIFO,
 	 * completion callback can be called right after the call,
@@ -602,7 +604,7 @@ static void ncm_do_notify(struct f_ncm *
 	status = usb_ep_queue(ncm->notify, req, GFP_ATOMIC);
 	spin_lock(&ncm->lock);
 	if (status < 0) {
-		ncm->notify_req = req;
+		atomic_dec(&ncm->notify_count);
 		DBG(cdev, "notify --> %d\n", status);
 	}
 }
@@ -637,17 +639,19 @@ static void ncm_notify_complete(struct u
 	case 0:
 		VDBG(cdev, "Notification %02x sent\n",
 		     event->bNotificationType);
+		atomic_dec(&ncm->notify_count);
 		break;
 	case -ECONNRESET:
 	case -ESHUTDOWN:
+		atomic_set(&ncm->notify_count, 0);
 		ncm->notify_state = NCM_NOTIFY_NONE;
 		break;
 	default:
 		DBG(cdev, "event %02x --> %d\n",
 			event->bNotificationType, req->status);
+		atomic_dec(&ncm->notify_count);
 		break;
 	}
-	ncm->notify_req = req;
 	ncm_do_notify(ncm);
 	spin_unlock(&ncm->lock);
 }
@@ -1639,6 +1643,11 @@ static void ncm_unbind(struct usb_config
 	ncm_string_defs[0].id = 0;
 	usb_free_all_descriptors(f);
 
+	if (atomic_read(&ncm->notify_count)) {
+		usb_ep_dequeue(ncm->notify, ncm->notify_req);
+		atomic_set(&ncm->notify_count, 0);
+	}
+
 	kfree(ncm->notify_req->buf);
 	usb_ep_free_request(ncm->notify, ncm->notify_req);
 }


