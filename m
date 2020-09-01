Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF54C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D3A2083E
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NGF/ymve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgIADAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgIAC7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:59:52 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79888C06123B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:59:50 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id z4so1867983pgv.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ywomHyBbrkh1CUGUn9oIS/1bKG05YgBtSywxfZ4E0FU=;
        b=NGF/ymveLM/4A4XA7qnfcFeufdfbdnU2PGxDYCFrQnFvUePWGMC4t6nZbpEoC7BKMq
         e67VyMZKd9+g8355Ql0ZkZGVYpy9xm4WCItPFujlPgBROfaX6yJ9Xgy2gXmWr51X8zrT
         ZTOAVq4sOdFGCUJkgFbwGFw03RKY/V6KzJ9fjrm3SZ8526Kt2FJXpWSzaunuTXX823Eg
         PzoxgqRcyMbl6neNPzTcxInNlLFTos6DG/3T5WGJn641agMM6QHjiK6M1L6NjvwrcypE
         cOl/rLTtrBvAqDZv2LTnb8APc/9rJj5mmXuLwcGdV7PpWPHcE2bgsx7p5pJEB/Juek0P
         bplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ywomHyBbrkh1CUGUn9oIS/1bKG05YgBtSywxfZ4E0FU=;
        b=l5Rq2m/ug4O84cWXV+bGmEm1fhIUy6ji7V+o4mE9h+YVLBAiEyrXnEZfPkLWkuFpL5
         X2cPoV9lGoPGjuouSIJP6DxFRmxs8GrChyllHI378S93KKsRvkm52G8lUnK33D06/5Pq
         k3DsDq4vUEzY9MoRKi+7aLG9xgwuB88cKcdomKWxn3VM73NsOhgS++0BytWneYPRGL+1
         Qs4LO1ugGQFciLIk0nExeLSgCk2CKQotUURdkUm+QmfQ4uvnVBjRpaYRUliv6+KTZcG2
         5upgeHWgcnP+/aqr/zqw+NdhZGxwjtkqdTsCILmfk76N5EJJnPJnxtYvibBy277zAcbL
         TatA==
X-Gm-Message-State: AOAM532rcCT3xbJap3MJFMkIB24QOGU//VNh9zWkZDzvHbyIHnpD5cuE
        yNLWxfbafFmReaLxRTWaRjbEtYDw62c=
X-Google-Smtp-Source: ABdhPJw5hvDf0Qoiz6yGzcMpcMw9AoxMsh74++ApyWLXQUGEk6RjEjMayv9xhXlZKjXazxsiNMdxSSFltGE=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a17:90b:4ad1:: with SMTP id
 mh17mr2290334pjb.54.1598929190046; Mon, 31 Aug 2020 19:59:50 -0700 (PDT)
Date:   Mon, 31 Aug 2020 19:59:23 -0700
In-Reply-To: <20200901025927.3596190-1-badhri@google.com>
Message-Id: <20200901025927.3596190-11-badhri@google.com>
Mime-Version: 1.0
References: <20200901025927.3596190-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v6 10/14] usb: typec: tcpci: Implement callbacks for FRS
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

Implement tcpc.enable_frs to enable TCPC to receive
Fast role swap signal.

Additionally set the sink disconnect threshold to 4v
to prevent disconnect during Fast Role swap.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since v1:
- Changing patch version to v6 to fix version number confusion.
---
 drivers/usb/typec/tcpm/tcpci.c | 17 +++++++++++++++++
 drivers/usb/typec/tcpm/tcpci.h |  8 ++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index d6a6fac82d48..f9f0af64da5f 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -268,6 +268,22 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
 				enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);
 }
 
+static int tcpci_enable_frs(struct tcpc_dev *dev, bool enable)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(dev);
+	int ret;
+
+	/* To prevent disconnect during FRS, set disconnect threshold to 3.5V */
+	ret = tcpci_write16(tcpci, TCPC_VBUS_SINK_DISCONNECT_THRESH, enable ? 0 : 0x8c);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_FAST_ROLE_SWAP_EN, enable ?
+				 TCPC_FAST_ROLE_SWAP_EN : 0);
+
+	return ret;
+}
+
 static int tcpci_set_bist_data(struct tcpc_dev *tcpc, bool enable)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
@@ -611,6 +627,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	tcpci->tcpc.set_roles = tcpci_set_roles;
 	tcpci->tcpc.pd_transmit = tcpci_pd_transmit;
 	tcpci->tcpc.set_bist_data = tcpci_set_bist_data;
+	tcpci->tcpc.enable_frs = tcpci_enable_frs;
 
 	err = tcpci_parse_config(tcpci);
 	if (err < 0)
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index 82f021a82456..5ef07a56d67a 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -16,6 +16,7 @@
 #define TCPC_PD_INT_REV			0xa
 
 #define TCPC_ALERT			0x10
+#define TCPC_ALERT_EXTND		BIT(14)
 #define TCPC_ALERT_EXTENDED_STATUS	BIT(13)
 #define TCPC_ALERT_VBUS_DISCNCT		BIT(11)
 #define TCPC_ALERT_RX_BUF_OVF		BIT(10)
@@ -37,6 +38,9 @@
 #define TCPC_EXTENDED_STATUS_MASK		0x16
 #define TCPC_EXTENDED_STATUS_MASK_VSAFE0V	BIT(0)
 
+#define TCPC_ALERT_EXTENDED_MASK	0x17
+#define TCPC_SINK_FAST_ROLE_SWAP	BIT(0)
+
 #define TCPC_CONFIG_STD_OUTPUT		0x18
 
 #define TCPC_TCPC_CTRL			0x19
@@ -63,6 +67,7 @@
 
 #define TCPC_POWER_CTRL			0x1c
 #define TCPC_POWER_CTRL_VCONN_ENABLE	BIT(0)
+#define TCPC_FAST_ROLE_SWAP_EN		BIT(7)
 
 #define TCPC_CC_STATUS			0x1d
 #define TCPC_CC_STATUS_TOGGLING		BIT(5)
@@ -74,11 +79,14 @@
 
 #define TCPC_POWER_STATUS		0x1e
 #define TCPC_POWER_STATUS_UNINIT	BIT(6)
+#define TCPC_POWER_STATUS_SOURCING_VBUS	BIT(4)
 #define TCPC_POWER_STATUS_VBUS_DET	BIT(3)
 #define TCPC_POWER_STATUS_VBUS_PRES	BIT(2)
 
 #define TCPC_FAULT_STATUS		0x1f
 
+#define TCPC_ALERT_EXTENDED		0x21
+
 #define TCPC_COMMAND			0x23
 #define TCPC_CMD_WAKE_I2C		0x11
 #define TCPC_CMD_DISABLE_VBUS_DETECT	0x22
-- 
2.28.0.402.g5ffc5be6b7-goog

