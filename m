Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A69C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 300CF2083E
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="E/9+iKxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgIADAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgIAC7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:59:41 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CA1C061379
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:59:40 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id cp13so4504029plb.16
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Yh60bZiNGZOc6tQmxndGlvfAxn8JuzncJI3aBSV8EoY=;
        b=E/9+iKxP4Os7jwiIYc3rotS8dGcNiNtYwvKk+8ZDeBMp1d8/CH4ofA0oj+UZ3XCpPz
         cfG0DNZEAaOMlRwzmh3cEixzcpJr8ft7sOdRVchESWS7Pn5ZIEX/aZUgcI8jZByjJBWR
         bOZ5CvWvG3Qr+WQBqglexl2FnjtwFsGi6i8wwURyU71HQ19QkiGCB1eePYUzXd7u4umn
         E7ud3CDzios8WHEHHnvbnbfLM2L1TXJ4h24eTD8kffHPgnvd3Dfcfv+dotCETio+RNHk
         Tdz6a1KJf5zUVEfC7uDHgTxnMaLDY3jLpbHgFgwrED6qx0A7tZr6qGalEABmVTZc3UWD
         o8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Yh60bZiNGZOc6tQmxndGlvfAxn8JuzncJI3aBSV8EoY=;
        b=tKSlotTVSeGb2Guy5Tg5ibzAGm1juYAtFuS7JqKxgiy9glqrdcw6EuynJl4aeUXy76
         blI3meIWCaB9mj2vmfNaLfMiYWhrI4yF8wCPLCkFhmZDooQ1L+U/DhvHI3F2saGF+6UD
         Vd0reQSogerQw/ytWSX3xLzJvFJVMhoqzKKQHAorSjioWLUe2Aw7bPvoPFYJmLMituva
         11FeyDycVcbOEPBSyk1qNZtXl/fYWAzQ/rw9UvH4GULNKL16JnF5KCNAMScb01iB9Y2O
         aGjkC4AclsLFPocLzsYRS/b45ZimVyykR4mdxoC0CDPDq/YuwEZwvp4swo9iSdAspC55
         +iWQ==
X-Gm-Message-State: AOAM531pgJqomceEXDowjFYDSyK/d556bKgF8D8XhCYB3DuJAf00ZINa
        EXvmLn5otVrObnZoaoQt1Q7+G+9PGYI=
X-Google-Smtp-Source: ABdhPJx2p8nBPH0VHIF0A2JGccic6C05ANWW5kVbeqZiWcdXnz3TnvAIjroB4b0QcEePrRgfD0JuzZYrUKI=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a17:90a:fb91:: with SMTP id
 cp17mr2215983pjb.141.1598929180360; Mon, 31 Aug 2020 19:59:40 -0700 (PDT)
Date:   Mon, 31 Aug 2020 19:59:18 -0700
In-Reply-To: <20200901025927.3596190-1-badhri@google.com>
Message-Id: <20200901025927.3596190-6-badhri@google.com>
Mime-Version: 1.0
References: <20200901025927.3596190-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v6 05/14] usb: typec: tcpci: Add set_vbus tcpci callback
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
Changes since v1:
- Changing patch version to v6 to fix version number confusion.
---
 drivers/usb/typec/tcpm/tcpci.c | 7 +++++++
 drivers/usb/typec/tcpm/tcpci.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index b960fe5a0f28..d6a6fac82d48 100644
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
2.28.0.402.g5ffc5be6b7-goog

