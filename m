Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04023C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F06206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WZQlmjlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405808AbgFXSLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405601AbgFXSLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:11:51 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51427C061796
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:11:51 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f2so1353776plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=422RvCVMwHIgJq8oJttIGIf/8JjnkP+mRkDXzBdPXT8=;
        b=WZQlmjlWEQ1UkJeisUgXi12IFZ6FlsnfN2wqfWi8/FVPnx/OJBTsDqSDl+FXmzFiyM
         6oBl5B6cOoZ/WjlUjxWskPl5yHIn3rERO++NtLEvpKmIYyhhUX4CiOwXhw7PhBLBIR0s
         lxwGO1QQCRUN+VZdtOEsTPYmlCio5gvwj+m4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=422RvCVMwHIgJq8oJttIGIf/8JjnkP+mRkDXzBdPXT8=;
        b=Nu+y96FDQO4xULBtfsfTh5E9YeattIFIeUx1dQZBGn8G2f4qXAP+rp5QpXbOVLsnqd
         dTWfPt5O5SqO21G8ALybnC3LugHioprZqcC4sGaTvHc8FPbddnaVQDcv+FG6UVZoJECA
         /cNoZdjguXJ4DZgwiztkohwJMRd836m0l1Lne+VOPVRSFEq4tBZB8gqzhvtHHFUNvPCK
         6CnOOBwxxmOy2SlwUaSd5pHYFKG0suP4EuW6G54Jk6IsuzFknOL6zEMWwXhS1hdmGJUl
         J8M5+HfSR8JbJCAHz8iAXSACeFHzmtpm4hW3kXPTYL8v6fmgvgCy+N99dRnrvJ10cv3D
         yPxQ==
X-Gm-Message-State: AOAM533b3tc56oT7ZOTFfCQH/toRSPZ4iv7rBdrXE144Ey6/RPISPjgJ
        HP1/AjiWPYM5PVXF7sGaQIVMrg==
X-Google-Smtp-Source: ABdhPJz+C8v2cqUkkqdWQZydV3m7DEZkJpn2jSEDdMHcd1UHdmHWT6WqILDp+mDGYZS9oz6BpIb3yQ==
X-Received: by 2002:a17:90b:1087:: with SMTP id gj7mr30297077pjb.124.1593022310574;
        Wed, 24 Jun 2020 11:11:50 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id 127sm16139674pgf.5.2020.06.24.11.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 11:11:50 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     rjliao@codeaurora.org, marcel@holtmann.org,
        linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btusb: Reset port on cmd timeout
Date:   Wed, 24 Jun 2020 11:11:44 -0700
Message-Id: <20200624111128.v2.1.Ibae403db54245c458d14297f1892c77c5055da41@changeid>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCA_ROME sometimes gets into a state where it is unresponsive to
commands. Since it doesn't have support for a reset gpio, reset the usb
port when this occurs instead.

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

Changes in v2:
- Renamed btusb_generic_usb_cmd_timeout to btusb_qca_cmd_timeout
- Updated commit note

 drivers/bluetooth/btusb.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e42fdd625eb023..df46b2a34c1803 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -573,6 +573,22 @@ static void btusb_rtl_cmd_timeout(struct hci_dev *hdev)
 	gpiod_set_value_cansleep(reset_gpio, 0);
 }
 
+static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
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
+		hdev->cmd_timeout = btusb_qca_cmd_timeout;
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		btusb_check_needs_reset_resume(intf);
 	}
-- 
2.27.0.111.gc72c7da667-goog

