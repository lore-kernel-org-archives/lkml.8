Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B203DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F1A2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="SR8bV9aH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgHYEXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgHYEWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:22:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16BBC061795
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:22:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x6so13374927ybp.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0dZapQdAtC5VdVTKkYzxbs06O/e7miNf9pUPYlnZYxc=;
        b=SR8bV9aHZi3LpVJCd3ZaaayHE1IvEYoeHSSh+5U7zZema8WmAIRsED0y24i357zAh3
         x9UEJGz4n1Yl85yVLI/oPIO3LA2OhftrkwEpxD0blcFkHq/dCnxoCGWGoC0Cski5gPrM
         waJUe+sZQGL/9Azz8RVGiN0xhrrONi/jqrjlLdolRNlLm97fSkeEmyXU/7MvoQ1kjRon
         UPFjJ9068cz656Xzr92H71s/XfRmEE2rs2YpZNQv5xzVlPM9HzhmMe+1HnnpB21shOqQ
         vj4FQzKODvOCbt0UifK7Qmt1EN7PRVwkVVBh5DEuou/Dm6e6DZWKTWEtIKzeEwkWiI+r
         L01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0dZapQdAtC5VdVTKkYzxbs06O/e7miNf9pUPYlnZYxc=;
        b=p6yg1j1UPy4kVArBO+Jv4KHlQrG9udZHgulD4MPrGca8MvtI9a+gI20C6K5EtRWpDf
         EMnVcL7iO85eBXrHxyjI5eSkhQ0AyGJ14I33yKz5J+u7J7gdO5FZAcV72jghJSyH86Os
         KKlYI0DUx7XGwumISt2ocNP1+3BuLiHuTwnggkx0UesdBw8aoiU7Ep1cRN6qE2tl8BBg
         uonbk97ZWCdSzGvkRcAVcfonsDr6D4LT1fHXMY6tHGO+XT8pMblpitCOTg4HXPsYJiZS
         YV6K3hE0MX52eEU3kNgGgtIKghA55IqWpAVqxxZKHD3BAkFA/PB72TKIl6AuvBQKFnQJ
         bUhQ==
X-Gm-Message-State: AOAM533RrE/RCAPyDBSXBiTzqABhmQTCNNmjvd8l1IXxtVI0EyoiXVqC
        tv/BMAXhppxlNmKH/vvwKwWf7foNyeM=
X-Google-Smtp-Source: ABdhPJxEJTTEQnr7/U15XqRjhIF5ahbOmYBlRNAKXqXmejuNOHs/wA6XsbCZhbPFLzBLltmwJQRygS4SHho=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a25:d8d4:: with SMTP id p203mr11208201ybg.289.1598329360044;
 Mon, 24 Aug 2020 21:22:40 -0700 (PDT)
Date:   Mon, 24 Aug 2020 21:22:01 -0700
In-Reply-To: <20200825042210.300632-1-badhri@google.com>
Message-Id: <20200825042210.300632-6-badhri@google.com>
Mime-Version: 1.0
References: <20200825042210.300632-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 05/14 v5] usb: typec: tcpci: Add set_vbus tcpci callback
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

set_vbus callback allows TCPC which are TCPCI based, however,
does not support turning on sink and source mode through
Command.SinkVbus and Command.SourceVbusDefaultVoltage.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpci.c | 7 +++++++
 drivers/usb/typec/tcpm/tcpci.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 7b7991c8ac87..89d28e3fbee8 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -328,6 +328,13 @@ static int tcpci_set_vbus(struct tcpc_dev *tcpc, bool source, bool sink)
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
 	int ret;
 
+	if (tcpci->data->set_vbus) {
+		ret = tcpci->data->set_vbus(tcpci, tcpci->data, source, sink);
+		/* Bypass when ret > 0 */
+		if (ret != 0)
+			return ret < 0 ? ret : 0;
+	}
+
 	/* Disable both source and sink first before enabling anything */
 
 	if (!source) {
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index 04c49a0b0368..4d441bdf24d5 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -144,6 +144,7 @@ struct tcpci_data {
 			 bool enable);
 	int (*start_drp_toggling)(struct tcpci *tcpci, struct tcpci_data *data,
 				  enum typec_cc_status cc);
+	int (*set_vbus)(struct tcpci *tcpci, struct tcpci_data *data, bool source, bool sink);
 };
 
 struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
-- 
2.28.0.297.g1956fa8f8d-goog

