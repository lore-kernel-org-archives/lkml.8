Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607A5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37945206FA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W/10+ZA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgFESq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgFESqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 14:46:23 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0B7C08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 11:46:23 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v24so4063827plo.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 11:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Db/Gm4BeoJW6NqmdsTHnrKmt8poh4eKp40QU8EXC28s=;
        b=W/10+ZA/PhUPpgG2XIwOlVrsgp35BOoaVW2TDVRzf+W7w0UnHTDmw0ieOnWvlN3vdP
         PFj5GknvyJkFXDq/PPl9Jk+ySjCWshsIMbIW2TegEREdo0boT/Ym/nQS8RpmJyH1BxrV
         2IkY/rzZIK/yYybOfCdmK3whjSMgxbpx6yX5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Db/Gm4BeoJW6NqmdsTHnrKmt8poh4eKp40QU8EXC28s=;
        b=aaLJ8VpfCADAjWMGMQ49TR2mKvwPfetjIW1OhIFWy1D0s8TlVIRWPA5lXcwNOcbvwu
         zlH9M79LEXQjV++Wjb6xmw0Jj5yh1h1dDGlc++EtA5HDJqqHKbD2Vuzz+y2/5pPbALmt
         f181XSzvvPX7fbDTMWPBt61JQCmma6S793r7IPtvHJUKo7+fA7KwrJB2lroVMU8U6tvY
         vD0gOVBuxT5RKVvcIqdDQI8C+uwaYvRQ7wH+UVGE5u/d6eKobjjVDuxR9PW1U2VwcKD/
         mFNsKxUCIV7z9qlC1UWdU2Tq48mk1RkilpfVB+42xEz1by7wOIut9zqvMDI9IYL6jGsv
         0E4w==
X-Gm-Message-State: AOAM532fEZHU6+68a2hThxJJ+38CxNrevRfZo93Y1b8dlSY7i5OmcNW4
        +QG2qsCUJdggnIK3JWjAk6Jz+w==
X-Google-Smtp-Source: ABdhPJxgwwx3U8FhEfyBF8XeXfPMutpv4xe50ifCJaUL8ETmcyboqaMCFgbkn1oxbLIBfwVBPzdw0w==
X-Received: by 2002:a17:90b:882:: with SMTP id bj2mr4851194pjb.122.1591382782676;
        Fri, 05 Jun 2020 11:46:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id a20sm268894pff.147.2020.06.05.11.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 11:46:22 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Rocky Liao <rjliao@codeaurora.org>,
        Zijun Hu <zijuhu@codeaurora.org>, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Claire Chang <tientzu@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/3] Bluetooth: hci_qca: Skip serdev wait when no transfer is pending
Date:   Fri,  5 Jun 2020 11:46:10 -0700
Message-Id: <20200605114552.2.I2a095adb2a9a98b15c11d7310db142b27f8cab28@changeid>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
In-Reply-To: <20200605184611.252218-1-mka@chromium.org>
References: <20200605184611.252218-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qca_suspend() calls serdev_device_wait_until_sent() regardless of
whether a transfer is pending. While it does no active harm since
the function should return immediately it makes the code more
confusing. Add a flag to track whether a transfer is pending and
only call serdev_device_wait_until_sent() is needed.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/bluetooth/hci_qca.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index b1d82d32892e9..90ffd8ca1fb0d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2050,6 +2050,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
 	struct hci_uart *hu = &qcadev->serdev_hu;
 	struct qca_data *qca = hu->priv;
 	unsigned long flags;
+	bool tx_pending = false;
 	int ret = 0;
 	u8 cmd;
 
@@ -2083,6 +2084,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
 
 		qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
 		qca->ibs_sent_slps++;
+		tx_pending = true;
 		break;
 
 	case HCI_IBS_TX_ASLEEP:
@@ -2099,8 +2101,10 @@ static int __maybe_unused qca_suspend(struct device *dev)
 	if (ret < 0)
 		goto error;
 
-	serdev_device_wait_until_sent(hu->serdev,
-				      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
+	if (tx_pending) {
+		serdev_device_wait_until_sent(hu->serdev,
+					      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
+	}
 
 	/* Wait for HCI_IBS_SLEEP_IND sent by device to indicate its Tx is going
 	 * to sleep, so that the packet does not wake the system later.
-- 
2.27.0.278.ge193c7cf3a9-goog

