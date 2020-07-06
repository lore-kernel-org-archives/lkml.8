Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA323C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976B92070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pIQ9uuVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgGFNee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729390AbgGFNeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:34:24 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A732C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:34:23 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so39364800wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fYphPHtOnqXpEOjqEtrG2eQ5inMeigGW8H35HCVLb4A=;
        b=pIQ9uuVnn+fW6hJfQP519yESrX2DO/yRDUtbTlObfQ7JiXoQk1gUB8izw+sRf4uiP8
         0qRPMoy8V3fOjyBkwCzS9AG6yUdgQccA81mMdgPqR8VCUf9uNV6P4+i3drgluWiyuTmT
         MQEXMjrNdksYTFKqr2MlVEY2y1S2VnIj7ZkoLfXk5UAfT4JD5GUm5dHUV+1okA6gW4No
         9O2oZmH1/5mtvpALvC7xYtm7gHR72y8RzKnIJ29P1F/sxS16DaKnI1wHAtggBbdw+i3T
         am7aikxGnPnMayMpGLeH64fpGjUAHyfWf/ZsNROTefX8AI4c+3cIjlt2iV9Amf5+79BV
         DbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fYphPHtOnqXpEOjqEtrG2eQ5inMeigGW8H35HCVLb4A=;
        b=KMrmFnoLYyOHAbY+OKR/h1j6wTu/jy0KwLW9tTfuuK7TrJ+CkmXx/uXsJAkwAbbrK1
         YHWFEY3EJIbfD6d8fTb4pEa364cgyeMPKF0wfqSpdMlo6fG2zRv+oExYOGJLg8GQ2twF
         SwRZWtPWcOraKlG/evYss01gKhA5PdoKgf/1iYSNn5ZrJzKTwl9B4dUv09Bji57s/TqR
         +VIEfJMLvYFM2xxRSC8M2s23lnlJ1sjnjPpTfY+p7fKQHOO7FPVzZ4oSGxdKhFLOU1XR
         Tz9qPlWoby+uP2KJdfy7Opqt9K4bbHIucH8SZEZSQwmC/gh8OOTQ+30PgNxnfXP96PsB
         5h0w==
X-Gm-Message-State: AOAM532mV6NR227BgTVm/fh5brn4i2PGMkgKpaclS5a0YM1yfEO7Fatg
        HgZqrizpthjDk/eqsKIJegAsPA==
X-Google-Smtp-Source: ABdhPJxX/0H3QT2+4IGeuZMzXZfirJMCquWrp7wTX/H7qNjAS315WxUrQkgO2PIZ78d0/7Tv01PEFA==
X-Received: by 2002:a05:600c:2219:: with SMTP id z25mr6860737wml.154.1594042462367;
        Mon, 06 Jul 2020 06:34:22 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:34:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Shlomi Gridish <gridish@freescale.com>,
        Jerry Huang <Chang-Ming.Huang@freescale.com>,
        Peter Barada <peterb@logicpd.com>,
        Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 31/32] usb: host: fhci-sched: Remove unused variable 'td'
Date:   Mon,  6 Jul 2020 14:33:40 +0100
Message-Id: <20200706133341.476881-32-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706133341.476881-1-lee.jones@linaro.org>
References: <20200706133341.476881-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'td' has been completely unused since the driver's inception in 2009.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/host/fhci-sched.c: In function ‘fhci_queue_urb’:
 drivers/usb/host/fhci-sched.c:704:13: warning: variable ‘td’ set but not used [-Wunused-but-set-variable]
 704 | struct td *td;
 | ^~

Cc: Shlomi Gridish <gridish@freescale.com>
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>
Cc: Peter Barada <peterb@logicpd.com>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/fhci-sched.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/fhci-sched.c b/drivers/usb/host/fhci-sched.c
index 3235d53074038..63c646c8f7d62 100644
--- a/drivers/usb/host/fhci-sched.c
+++ b/drivers/usb/host/fhci-sched.c
@@ -701,7 +701,6 @@ void fhci_queue_urb(struct fhci_hcd *fhci, struct urb *urb)
 	u32 data_len = urb->transfer_buffer_length;
 	int urb_state = 0;
 	int toggle = 0;
-	struct td *td;
 	u8 *data;
 	u16 cnt = 0;
 
@@ -770,7 +769,7 @@ void fhci_queue_urb(struct fhci_hcd *fhci, struct urb *urb)
 				usb_endpoint_maxp(&urb->ep->desc)) == 0))
 			urb_state = US_BULK0;
 		while (data_len > 4096) {
-			td = fhci_td_fill(fhci, urb, urb_priv, ed, cnt,
+			fhci_td_fill(fhci, urb, urb_priv, ed, cnt,
 				usb_pipeout(urb->pipe) ? FHCI_TA_OUT :
 							 FHCI_TA_IN,
 				cnt ? USB_TD_TOGGLE_CARRY :
@@ -781,7 +780,7 @@ void fhci_queue_urb(struct fhci_hcd *fhci, struct urb *urb)
 			cnt++;
 		}
 
-		td = fhci_td_fill(fhci, urb, urb_priv, ed, cnt,
+		fhci_td_fill(fhci, urb, urb_priv, ed, cnt,
 			usb_pipeout(urb->pipe) ? FHCI_TA_OUT : FHCI_TA_IN,
 			cnt ? USB_TD_TOGGLE_CARRY : toggle,
 			data, data_len, 0, 0, true);
@@ -789,7 +788,7 @@ void fhci_queue_urb(struct fhci_hcd *fhci, struct urb *urb)
 
 		if (urb->transfer_flags & URB_ZERO_PACKET &&
 				cnt < urb_priv->num_of_tds) {
-			td = fhci_td_fill(fhci, urb, urb_priv, ed, cnt,
+			fhci_td_fill(fhci, urb, urb_priv, ed, cnt,
 				usb_pipeout(urb->pipe) ? FHCI_TA_OUT :
 							 FHCI_TA_IN,
 				USB_TD_TOGGLE_CARRY, NULL, 0, 0, 0, true);
@@ -798,7 +797,7 @@ void fhci_queue_urb(struct fhci_hcd *fhci, struct urb *urb)
 		break;
 	case FHCI_TF_INTR:
 		urb->start_frame = get_frame_num(fhci) + 1;
-		td = fhci_td_fill(fhci, urb, urb_priv, ed, cnt++,
+		fhci_td_fill(fhci, urb, urb_priv, ed, cnt++,
 			usb_pipeout(urb->pipe) ? FHCI_TA_OUT : FHCI_TA_IN,
 			USB_TD_TOGGLE_DATA0, data, data_len,
 			urb->interval, urb->start_frame, true);
@@ -808,12 +807,12 @@ void fhci_queue_urb(struct fhci_hcd *fhci, struct urb *urb)
 		ed->max_pkt_size = usb_endpoint_maxp(&urb->ep->desc);
 
 		/* setup stage */
-		td = fhci_td_fill(fhci, urb, urb_priv, ed, cnt++, FHCI_TA_SETUP,
+		fhci_td_fill(fhci, urb, urb_priv, ed, cnt++, FHCI_TA_SETUP,
 			USB_TD_TOGGLE_DATA0, urb->setup_packet, 8, 0, 0, true);
 
 		/* data stage */
 		if (data_len > 0) {
-			td = fhci_td_fill(fhci, urb, urb_priv, ed, cnt++,
+			fhci_td_fill(fhci, urb, urb_priv, ed, cnt++,
 				usb_pipeout(urb->pipe) ? FHCI_TA_OUT :
 							 FHCI_TA_IN,
 				USB_TD_TOGGLE_DATA1, data, data_len, 0, 0,
@@ -822,12 +821,12 @@ void fhci_queue_urb(struct fhci_hcd *fhci, struct urb *urb)
 
 		/* status stage */
 		if (data_len > 0)
-			td = fhci_td_fill(fhci, urb, urb_priv, ed, cnt++,
+			fhci_td_fill(fhci, urb, urb_priv, ed, cnt++,
 				(usb_pipeout(urb->pipe) ? FHCI_TA_IN :
 							  FHCI_TA_OUT),
 				USB_TD_TOGGLE_DATA1, data, 0, 0, 0, true);
 		else
-			 td = fhci_td_fill(fhci, urb, urb_priv, ed, cnt++,
+			 fhci_td_fill(fhci, urb, urb_priv, ed, cnt++,
 				FHCI_TA_IN,
 				USB_TD_TOGGLE_DATA1, data, 0, 0, 0, true);
 
@@ -844,7 +843,7 @@ void fhci_queue_urb(struct fhci_hcd *fhci, struct urb *urb)
 			 */
 			frame += cnt * urb->interval;
 			frame &= 0x07ff;
-			td = fhci_td_fill(fhci, urb, urb_priv, ed, cnt,
+			fhci_td_fill(fhci, urb, urb_priv, ed, cnt,
 				usb_pipeout(urb->pipe) ? FHCI_TA_OUT :
 							 FHCI_TA_IN,
 				USB_TD_TOGGLE_DATA0,
-- 
2.25.1

