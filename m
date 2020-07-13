Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF22C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED0A22072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kc5iLI/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgGMHpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgGMHps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:45:48 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4627EC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:45:48 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id s26so5651867pfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+xSpopuz70JG6iQfzM5HgibXAJUo1c/P7qmmEsvws9s=;
        b=Kc5iLI/iQywUAZzcS/x0aAofjXobkcKggku2JP87VotyNaCUPk2Py7OWxK8E9eVaxa
         CahAMnsRsqRjstEh9jYRglZqFJ7nQJNIVORRbfGSzjOG/UdG8t6tQqFc39Acu563iNdX
         74kCvC+jQYgz/0vCK77oVtwe7UbVamVpsCR9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+xSpopuz70JG6iQfzM5HgibXAJUo1c/P7qmmEsvws9s=;
        b=Vr4V/AJGr0iEdiQDhjKK5ymw5TRiQp3Ez+cc0PjnPoTeUC5jPDQEZpNhzTNV1Tk36E
         RUYt+1+rbyLW02xbeqZy6Nflq1RXFtwiAB6OtLMR+gZ44oxrbBTdS3iWjwa5X+AH67rP
         wvW7ifrNllwh90XYFszw7dihmjnmfwLPx1AmkTTKIsgNNoyb/zXxE9kgW+zCnljUDxUG
         HI+U3j2/xg5RJcvan8NMBSZbnQF0xrYf46leJgsC4va7m53uaCUGW3ycB47JXgvEYp9W
         FtAaeKi/k+deOrIOADF2ktz2Ckp1WapsDN5JhO2QNtlPTkrT7KDqAXnjMj14eyvJJS1Q
         KYtQ==
X-Gm-Message-State: AOAM532zQiaA3O3cAXqYvhVh5Q/sW6h4IxU2TPTktATdnRob9R5iCQCt
        NkjGDT5+529ZrMMIVYPjYPSj6w==
X-Google-Smtp-Source: ABdhPJzW69Vm+lK8/pCwW1u4QfMsHRO3SS16AexP6hozF17c7XNzQfwn82/Bxo+zSG+hxNagRn79rQ==
X-Received: by 2002:a65:4bc8:: with SMTP id p8mr67352267pgr.418.1594626347737;
        Mon, 13 Jul 2020 00:45:47 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:de4a:3eff:fe7d:ff5f])
        by smtp.gmail.com with ESMTPSA id g8sm12691498pgr.70.2020.07.13.00.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 00:45:46 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>, alainm@chromium.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btusb: add Realtek 8822CE to usb_device_id table
Date:   Mon, 13 Jul 2020 15:45:29 +0800
Message-Id: <20200713154512.v2.1.I63705bf6abab9cb79c14f7959a59b201af2b8827@changeid>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the Realtek 8822CE controller to the usb_device_id
table to support the wideband speech capability.

Reviewed-by: alainm@chromium.org
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v2:
- Fixed the commit subject and message body.

 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index faa863dd5d0a33..aa0bc9942afda9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -359,6 +359,10 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x8087, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_IGNORE },
 
+	/* Realtek 8822CE Bluetooth devices */
+	{ USB_DEVICE(0x0bda, 0xb00c), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_REALTEK },
-- 
2.27.0.383.g050319c2ae-goog

