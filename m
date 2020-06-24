Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92546C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 758D4206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A3AqzG26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405862AbgFXR6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405377AbgFXR6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:58:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A606C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:58:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so1766174pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bg+1P63VLxUYsu4ENntJNQHEjiQ6uihm5Nk7mXeioVo=;
        b=A3AqzG26sCA4f+KdGaF7CKySAhqu82wsSL/pEiTqkD1fIRlRR6OmLuU+QKP3lA3oQE
         cqLdnKzTw/C/vRvSge7D8Q1ju5lSbrqVgU99U2YlNsdFodq/iULU0ONGuwHZagMUm5q4
         IFUK+OfCrUmNNFofOr4SHNti9rr67bs1xxUbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bg+1P63VLxUYsu4ENntJNQHEjiQ6uihm5Nk7mXeioVo=;
        b=a5nv8UsNPFVAzFLCuouUMpCVU3D9o9BD78Qf67dYIGiJiLoD46qCZZnzk+ogyRqx7I
         HhewG3vhrp0AxL3bt82GC9s8LrigGf7c5PcKJZQND4Taa9WcXSmty1vpWfkRiikcLnDu
         VjoVvwsY12KjtH2Vvol6lTOCmFv2U/KUkqpjgf6psyjkx22DTZeftJxpkAE0augpdqWk
         td2aESXsomDGHRwI9jXkzLCUIshrEFK9A5oGyFdZaoB2TLm5c9yN5c22kl/Vq05n3JrS
         /ZPoR4Hdj7eeNJbqNWkIlEhl6t569mi7GEAjhVLgKYwpvW87H8h6OojpXVjSd2cS3neZ
         2oZA==
X-Gm-Message-State: AOAM5300mYO0uNfjekswdVj+4lDZ88UUiT+zQgifrFfScV5DnIYuXlUm
        x/xDo24aUV2WVNtmuVUDDZP85g==
X-Google-Smtp-Source: ABdhPJxMjymh7nD+4h+MHOeIHifL3w9DH3b6q0GpFMzkPSla1mcQvMmiGmbtJm6MO3cAvuqQMjJtlQ==
X-Received: by 2002:a63:a843:: with SMTP id i3mr23295731pgp.190.1593021497767;
        Wed, 24 Jun 2020 10:58:17 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id r8sm20958635pfq.16.2020.06.24.10.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:58:17 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     rjliao@codeaurora.org, marcel@holtmann.org,
        linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Reset port on cmd timeout
Date:   Wed, 24 Jun 2020 10:58:09 -0700
Message-Id: <20200624105737.1.Ibae403db54245c458d14297f1892c77c5055da41@changeid>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCA_ROME doesn't have support for the reset gpio but sometimes gets into
a state where it is unresponsive to commands. When this happens, reset
the port to attempt to revive the chip.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
On Chromebooks with this chipset, we encountered cmd_timeout after
running suspend stress test for hundreds of iterations. Without
a recovery mechanism, continued cmd_timeout failures eventually caused
the suspend stress test to fail.

This change will just reset the port that the Bluetooth chip is on when
cmd_timeout is encountered. At the very least, the driver will unload
and stop affecting suspend. It doesn't seem to restore the BT controller
to a good state however (this still requires a power cycle).

 drivers/bluetooth/btusb.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e42fdd625eb023..b806a88702328b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -573,6 +573,22 @@ static void btusb_rtl_cmd_timeout(struct hci_dev *hdev)
 	gpiod_set_value_cansleep(reset_gpio, 0);
 }
 
+static void btusb_generic_usb_cmd_timeout(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	int err;
+
+	if (++data->cmd_timeout_cnt < 5)
+		return;
+
+	bt_dev_err(hdev, "Multiple cmd timeouts seen. Resetting usb device.");
+	err = usb_autopm_get_interface(data->intf);
+	if (!err)
+		usb_queue_reset_device(data->intf);
+	else
+		bt_dev_err(hdev, "Failed usb_autopm_get_interface with %d", err);
+}
+
 static inline void btusb_free_frags(struct btusb_data *data)
 {
 	unsigned long flags;
@@ -3964,6 +3980,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_QCA_ROME) {
 		data->setup_on_usb = btusb_setup_qca;
 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
+		hdev->cmd_timeout = btusb_generic_usb_cmd_timeout;
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		btusb_check_needs_reset_resume(intf);
 	}
-- 
2.27.0.111.gc72c7da667-goog

