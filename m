Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E90C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E5BB2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kLvgRy07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgHYEWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgHYEWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:22:30 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178F6C061755
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:22:30 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id p2so6879170pge.20
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=uNM7HP/LHsK3vi9PvtdHxJ86dOAfeYqmzrZ0qZRLxlA=;
        b=kLvgRy07hQY2lFzW8fHlfXXMd+Cdx+25eTP3d2GAQaRmvrpEvr0iAFVsIyM6tdQzUG
         fEUK0gzn46C7cz3lOCBOpJEG17FJ/QjLLf1910ETwwZs1q9K767pm1R1eH6rypa3PQEp
         a0r1Sys7b8s83UyKlk8Gq4MWl2gJQVX8QPRPxlghpMYrA6BiO8cB4uolJpWH4hx036mY
         +mKRGeRc8gRUBQhgtQP7i1Bp8UK+GWO0/69lxHNwRpsvcRrom/zeJLCKBTCnADIxDPF+
         rm/iLdkxbk2V2xnx5aaRVvF8mZ2p9pwsE+LP5fRI1EHlZYZqbL9MDeALfyugt3HmeRTa
         rKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uNM7HP/LHsK3vi9PvtdHxJ86dOAfeYqmzrZ0qZRLxlA=;
        b=rnmSMwWfKHS9p1pqaULcWtNCp8doy2p41Yitl+snFSggNzzhMtyRGDaMlp0/vSxwRR
         bQlkVhUj6BDfnAyovlc8fLfRsgZRwmvfnLItgIYrsgB8v3MklhTKElymTTHX88xx8fwW
         H3TAaYkaJEvOiS+VMchM/AV9sWwkLZ16NG8NtwUxAU/oaoAQrXBtRsSWVFHGJNloTnsT
         Ash1gKoM3sTYQqD5+kkGPswyktNhIUhv36Aeh4tyklAaJicFqee8yHXJAqA0wpDxASlA
         QJ53FxlvEULSeEjS3DuKeHshviXDwsCzuDOjAm0KQLslTNbiIUdecORR//v+/MZmxbU9
         mN2Q==
X-Gm-Message-State: AOAM531ki2OZli9bx3gUGSCYrTdV+7Th736RVb+JBAZcsowZQ/2fRJND
        cqz4/7NjwENikAREDTzBdmFQR4jXbrE=
X-Google-Smtp-Source: ABdhPJwgrbZbyUxmLVv4z18yXQbs+H+ZgJyhIt2GSckwXachV3QFr36xqqieA4TJVkGjje0KVF56fSqFqOQ=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a63:cd54:: with SMTP id a20mr5362196pgj.228.1598329349509;
 Mon, 24 Aug 2020 21:22:29 -0700 (PDT)
Date:   Mon, 24 Aug 2020 21:21:58 -0700
In-Reply-To: <20200825042210.300632-1-badhri@google.com>
Message-Id: <20200825042210.300632-3-badhri@google.com>
Mime-Version: 1.0
References: <20200825042210.300632-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 02/14 v2] usb: typec: tcpci: Add support when hidden tx
 registers are inaccessible
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

TCPCI spec forbids direct access of TX_BUF_BYTE_x register.
The existing version of tcpci driver assumes that those registers
are directly addressible. Add support for tcpci chips which do
not support direct access to TX_BUF_BYTE_x registers. TX_BUF_BYTE_x
can only be accessed by I2C_WRITE_BYTE_COUNT.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpci.c | 49 +++++++++++++++++++++++++---------
 drivers/usb/typec/tcpm/tcpci.h |  8 ++++++
 2 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index f57d91fd0e09..90d348caa6a8 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -320,8 +320,7 @@ static int tcpci_set_vbus(struct tcpc_dev *tcpc, bool source, bool sink)
 	return 0;
 }
 
-static int tcpci_pd_transmit(struct tcpc_dev *tcpc,
-			     enum tcpm_transmit_type type,
+static int tcpci_pd_transmit(struct tcpc_dev *tcpc, enum tcpm_transmit_type type,
 			     const struct pd_message *msg)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
@@ -330,23 +329,47 @@ static int tcpci_pd_transmit(struct tcpc_dev *tcpc,
 	int ret;
 
 	cnt = msg ? pd_header_cnt(header) * 4 : 0;
-	ret = regmap_write(tcpci->regmap, TCPC_TX_BYTE_CNT, cnt + 2);
-	if (ret < 0)
-		return ret;
+	/**
+	 * TCPCI spec forbids direct access of TCPC_TX_DATA.
+	 * But, since some of the chipsets offer this capability,
+	 * it's fair to support both.
+	 */
+	if (!tcpci->data->TX_BUF_BYTE_x_hidden) {
+		ret = regmap_write(tcpci->regmap, TCPC_TX_BYTE_CNT, cnt + 2);
+		if (ret < 0)
+			return ret;
 
-	ret = tcpci_write16(tcpci, TCPC_TX_HDR, header);
-	if (ret < 0)
-		return ret;
+		ret = tcpci_write16(tcpci, TCPC_TX_HDR, header);
+		if (ret < 0)
+			return ret;
+
+		if (cnt > 0) {
+			ret = regmap_raw_write(tcpci->regmap, TCPC_TX_DATA, &msg->payload, cnt);
+			if (ret < 0)
+				return ret;
+		}
+	} else {
+		u8 buf[TCPC_TRANSMIT_BUFFER_MAX_LEN] = {0,};
+		u8 pos = 0;
+
+		/* Payload + header + TCPC_TX_BYTE_CNT */
+		buf[pos++] = cnt + 2;
+
+		if (msg)
+			memcpy(&buf[pos], &msg->header, sizeof(msg->header));
+
+		pos += sizeof(header);
+
+		if (cnt > 0)
+			memcpy(&buf[pos], msg->payload, cnt);
 
-	if (cnt > 0) {
-		ret = regmap_raw_write(tcpci->regmap, TCPC_TX_DATA,
-				       &msg->payload, cnt);
+		pos += cnt;
+		ret = regmap_raw_write(tcpci->regmap, TCPC_TX_BYTE_CNT, buf, pos);
 		if (ret < 0)
 			return ret;
 	}
 
-	reg = (PD_RETRY_COUNT << TCPC_TRANSMIT_RETRY_SHIFT) |
-		(type << TCPC_TRANSMIT_TYPE_SHIFT);
+	reg = (PD_RETRY_COUNT << TCPC_TRANSMIT_RETRY_SHIFT) | (type << TCPC_TRANSMIT_TYPE_SHIFT);
 	ret = regmap_write(tcpci->regmap, TCPC_TRANSMIT, reg);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index fd26ca35814c..cf9d8b63adcb 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -128,9 +128,17 @@
 #define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG		0x76
 #define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG		0x78
 
+/* I2C_WRITE_BYTE_COUNT + 1 when TX_BUF_BYTE_x is only accessible I2C_WRITE_BYTE_COUNT */
+#define TCPC_TRANSMIT_BUFFER_MAX_LEN		31
+
+/*
+ * @TX_BUF_BYTE_x_hidden
+ *		optional; Set when TX_BUF_BYTE_x can only be accessed through I2C_WRITE_BYTE_COUNT.
+ */
 struct tcpci;
 struct tcpci_data {
 	struct regmap *regmap;
+	unsigned char TX_BUF_BYTE_x_hidden:1;
 	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
 	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
 			 bool enable);
-- 
2.28.0.297.g1956fa8f8d-goog

