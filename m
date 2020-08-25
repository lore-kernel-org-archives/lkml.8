Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9552DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741AA2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="iOrrBtpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgHYEXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbgHYEXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:23:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1E9C061755
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:23:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e1so13546801ybk.14
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=q3nSt4wRkjHfPpuinxzh6IcLdnhOBWqWD7BzNcZASGQ=;
        b=iOrrBtpCQqPWL/QlRPN8dY8agdU97ZafJw0zhs2XYhVClb+5t/7QCKvQV8CdwF4Gxo
         PIBqCcgPKqEzUz0aX9V9RT1yhN5WzpJrN6lxoulJ5fJfwUQjPZr2SvpmPI6i8LkeOpyq
         40+qR96cq0/ttPQys9m1tE7if0Nwzhl4xlbYN5rVN0gfPMX0mIPwfzzsoyUwKqJz+ft3
         o9M+fVIUr2mSja1CQR+ycnVxw+WPzADXn9JNm2SHWg40dp+vOXrERTNE8NqIodBgTvUe
         hGmNJ4wIAiTfICfOWOSMoIj8E4GnLgHR7WHYOiHzQlfKQY+fqFH1C2a8JffXyu+KpyuN
         FGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q3nSt4wRkjHfPpuinxzh6IcLdnhOBWqWD7BzNcZASGQ=;
        b=C0xqgiYHUL0NHs526jIw6A+td/CVQNg+484qPGlbt1/LuEXulKetfC/EFArmMh6++N
         zWjKqJaAh1DOyH/btuTATTutbHwpBxSsuoLF9jObiqxGqIH5Sigi/nZPQ/eGZdxYY880
         +8dWOuTPAryooytukM/vO98DRuf49XTvWWFfWKd0UaNP2YU9UcAFmkN2IizIEGZs7Egv
         2ioC5nVzLNhdO4hwwjQFAiR2Pph/Pj8k8EecMZVn2DAk6w3Vn2mW+Gtwq7u8Y7mOP8Po
         ODtdTx1tVXID7yIGxYbL+HMuUJpZ+O9Gh9HKYcfACEvvZMElr46rogZllVU0MFK7wz9R
         Z24g==
X-Gm-Message-State: AOAM530e2Q0mLaByVSzdpqH2wlRb8z2doKEw2NXKpyQUqoe2dabJvUZU
        Dxn+IjZP76UAOm0BQShPKYp4S3pBU04=
X-Google-Smtp-Source: ABdhPJyMPsru/KTYSkksb0IP69mOSU2XoMbDyBkPpREK+vNx8sbowVpDDOakiySCRKujuqH3qC8CgwD7rJs=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a25:c50d:: with SMTP id v13mr12071638ybe.206.1598329380022;
 Mon, 24 Aug 2020 21:23:00 -0700 (PDT)
Date:   Mon, 24 Aug 2020 21:22:10 -0700
In-Reply-To: <20200825042210.300632-1-badhri@google.com>
Message-Id: <20200825042210.300632-15-badhri@google.com>
Mime-Version: 1.0
References: <20200825042210.300632-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 14/14 v1] usb: typec: tcpci_maxim: Implemnent set_auto_vbus_discharge_threshold
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Programs VBUS_SINK_DISCONNECT_THRESHOLD based on the power_role,
voltage requested as sink, mode of operation.

The programmed threshold is based on vSinkDisconnect and
vSinkDisconnectPD values.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpci_maxim.c | 48 ++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index 6ba808ad901a..e35bd995c037 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -137,6 +137,52 @@ static void max_tcpci_init_regs(struct max_tcpci_chip *chip)
 		return;
 }
 
+static int max_tcpci_set_auto_vbus_discharge_threshold(struct tcpci *tcpci, struct tcpci_data *data,
+						       enum typec_role port_role,
+						       enum typec_pwr_opmode mode, bool pps_active,
+						       u32 requested_vbus_voltage_mv)
+{
+	struct max_tcpci_chip *chip = tdata_to_max_tcpci(data);
+	u32 threshold = 0;
+	u8 pwr_ctrl;
+
+	/*
+	 * Indicates that vbus is going to go away due PR_SWAP, hard reset etc.
+	 * Do not discharge vbus here.
+	 */
+	if (requested_vbus_voltage_mv == 0)
+		goto write_thresh;
+
+	if (port_role == TYPEC_SINK) {
+		max_tcpci_read8(chip, TCPC_POWER_CTRL, &pwr_ctrl);
+		if (pwr_ctrl & TCPC_FAST_ROLE_SWAP_EN) {
+			/* To prevent disconnect when the source is fast role swap is capable. */
+			threshold = 3500;
+		} else if (mode == TYPEC_PWR_MODE_PD) {
+			if (pps_active)
+				threshold = (95 * requested_vbus_voltage_mv / 100) - 850;
+			else
+				threshold = (95 * requested_vbus_voltage_mv / 100) - 1250;
+		} else {
+			/* 3.5V for non-pd sink */
+			threshold = 3500;
+		}
+	} else {
+		/* 4V for source */
+		threshold = 4000;
+	}
+
+	threshold = threshold / TCPC_VBUS_SINK_DISCONNECT_THRESH_LSB;
+
+	if (threshold > TCPC_VBUS_SINK_DISCONNECT_THRESH_MAX) {
+		dev_err(chip->dev, "VBUS_SINK_DISCONNECT_THRESH out of range");
+		return -EINVAL;
+	}
+
+write_thresh:
+	return max_tcpci_write16(chip, TCPC_VBUS_SINK_DISCONNECT_THRESH, threshold);
+}
+
 static void process_rx(struct max_tcpci_chip *chip, u16 status)
 {
 	struct pd_message msg;
@@ -454,6 +500,8 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
 	chip->data.start_drp_toggling = max_tcpci_start_toggling;
 	chip->data.TX_BUF_BYTE_x_hidden = true;
 	chip->data.init = tcpci_init;
+	chip->data.set_auto_vbus_discharge_threshold = max_tcpci_set_auto_vbus_discharge_threshold;
+	chip->data.auto_discharge_disconnect = true;
 
 	max_tcpci_init_regs(chip);
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
-- 
2.28.0.297.g1956fa8f8d-goog

