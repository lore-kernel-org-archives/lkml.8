Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6749C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 23:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 793712065E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 23:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dEQTueqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgGNXMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 19:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgGNXML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 19:12:11 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5588FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 16:12:11 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id p6so258164plo.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 16:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=chN9U6tpxCfckDUNNU18y7SVrqm9xZV0m+x825P3r0o=;
        b=dEQTueqRLSny57pwj434YuhnitD6MKepF+k1g6zl5SccL/wliNZK35pU17wTKGZl+j
         7YNJukf1Ffmk/9riYWiPrvdzer0KYDYH2ObrySyZ2alp8Jxy6jgZ5FhS54AQaVkcoA7l
         EML2B3izEEB4Q9pWOIq0WsP103zgPyt5JE4zt5NYC0ojboe4C+Xapw2BCfL8tJ7tuTmp
         P2Ad8NyAhM+Q+KRGiLIhZeCNO7GbPErNSfze8uBzXizn1WQWYhyvwGRDZ52moAdYllrG
         sVHckxf8iEfJkwoHuh6szlclO2FqkKE6ZO+krfyQ4u3WI25bPgxtfKmCC1BTjpawh+lW
         UxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=chN9U6tpxCfckDUNNU18y7SVrqm9xZV0m+x825P3r0o=;
        b=pGYGR+8O6nSBN2uQWWqIRwKoUogeG5MVaMJrOsvEFInJcc2HhtUvHeS47WNqJX5EkU
         XP6CyXQ0WiOLQnYJctbf1mjvvbkyyhsI3o2QpcnxgOE5INdZ1+jxreFoKkEQo6zznv4h
         ftSa/NaBe88oefJFy6S4y+MB2G8KfEBMxRLPxxCwj2OqZyZNModefRRTIhjzJqqOSmHA
         cQNY9hRodSs6ojrBFygs8aGhFRP5Rzl7qnKHvjVJYNGEqioRS7jgFbIFsMDcOToJ2lx7
         VsdeSjWvpTW1suIqluOP4OP1oDDgAM2Wz7m9kDQtokKdP5CnvnXKr6a4Cl00HyG4Q895
         2I0g==
X-Gm-Message-State: AOAM533LipBqJuU6GPayqTVR/5XjlOfqdFQ3CcfrCaeknFC7FWfQMRNS
        aSThq9GBikP2JZXnp5sn5TuXQznl5bw=
X-Google-Smtp-Source: ABdhPJwjKijxN9AEMbvNsFbXib2bpwfc/x2S5LPdWpmUNtz+/3/rae6cm2l4J9odI9jJ6aUcEV2DzyC+fV0=
X-Received: by 2002:a17:90b:1292:: with SMTP id fw18mr6945316pjb.3.1594768330671;
 Tue, 14 Jul 2020 16:12:10 -0700 (PDT)
Date:   Tue, 14 Jul 2020 16:12:05 -0700
Message-Id: <20200714231207.866838-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH 1/3 v2] usb: typec: tcpci: Support BIST test data mode for compliance.
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        reg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting from TCPCI spec:
"Setting this bit to 1 is intended to be used only when a USB compliance
tester is using USB BIST Test Data to test the PHY layer of the TCPC. The
TCPM should clear this bit when a disconnect is detected.
0: Normal Operation. Incoming messages enabled by RECEIVE_DETECT
passed to TCPM via Alert.
1: BIST Test Mode. Incoming messages enabled by RECEIVE_DETECT
result in GoodCRC response but may not be passed to the TCPM via
Alert."

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Version history:
Changes since V1:(Guenter's suggestions)
- Split the change into two: TCPM and TCPCI
- Move BIST log to TCPM log
- Alignment and column count changes
---
 drivers/usb/typec/tcpm/tcpci.c | 9 +++++++++
 drivers/usb/typec/tcpm/tcpci.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 753645bb25273a..f57d91fd0e0924 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -227,6 +227,14 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
 				enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);
 }
 
+static int tcpci_set_bist_data(struct tcpc_dev *tcpc, bool enable)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
+
+	return regmap_update_bits(tcpci->regmap, TCPC_TCPC_CTRL, TCPC_TCPC_CTRL_BIST_TM,
+				 enable ? TCPC_TCPC_CTRL_BIST_TM : 0);
+}
+
 static int tcpci_set_roles(struct tcpc_dev *tcpc, bool attached,
 			   enum typec_role role, enum typec_data_role data)
 {
@@ -530,6 +538,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	tcpci->tcpc.set_pd_rx = tcpci_set_pd_rx;
 	tcpci->tcpc.set_roles = tcpci_set_roles;
 	tcpci->tcpc.pd_transmit = tcpci_pd_transmit;
+	tcpci->tcpc.set_bist_data = tcpci_set_bist_data;
 
 	err = tcpci_parse_config(tcpci);
 	if (err < 0)
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index 303ebde265465c..11c36d086c8608 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -36,6 +36,7 @@
 
 #define TCPC_TCPC_CTRL			0x19
 #define TCPC_TCPC_CTRL_ORIENTATION	BIT(0)
+#define TCPC_TCPC_CTRL_BIST_TM		BIT(1)
 
 #define TCPC_ROLE_CTRL			0x1a
 #define TCPC_ROLE_CTRL_DRP		BIT(6)
-- 
2.27.0.389.gc38d7665816-goog

