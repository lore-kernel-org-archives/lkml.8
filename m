Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8B3C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B5D2083E
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="JEYnWOYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgIAC7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 22:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgIAC7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:59:38 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A225C06136D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:59:37 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 196so7601036qkn.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YMdKxgp/ypLtEnd4viDdyZTg0ysmMpLgXStTpt9Ak68=;
        b=JEYnWOYQ3h6zljGhK0HJKcDxcPo4mEIiSjSRZNzxkdndwwuaJWXp0mcXUZDFSQ6in3
         frbp3hEASK2UN01GoP9NvJZdHJeeLBg4c8gjn3dkBfLyTpQhohGDBz4+Ej1SdM4eHzcE
         EDyy+rPstNyttgyHHfjMtEm4g7/mPxZk6QTDWGP6bXFgG/TrW1gSBj/8DhB8ntSHFXEq
         BguM1U5Y2BtHM+PkqzsJ3LxhOw+VxTbRzW66NiwLwFJ5nwWr+L5kY1ywGwGKVNzAoCXP
         1/0a8e1fwQFrHdEgzD2RoeNqXOlGUT2MmkUYQykuUD0jEsZbMEg7R/1lBM+jwPlOQRSp
         FNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YMdKxgp/ypLtEnd4viDdyZTg0ysmMpLgXStTpt9Ak68=;
        b=DobuQn5WRF3Qm2dq22oCD4FG0C9q0ZY6Ycorc0uioea9apqAICGFhk317NUMxwvbT3
         /WQtr6jxvWZTtt91iQbBgQWT5mv7DxtW2/eupH8k10fMVBltmoObsVQWNzayAJttkDdY
         MLh9lj7RluWmI2NycLmu1JnOS9P3KSymadQ3YLwsf266TFcHXRsPp1eK+2UOC69YE8VF
         O1rI7ofPAH9d3E+6i+SJA3xydFFmDAcxD+f4gFtYYubslBsIemq1kPj7tg7Xie5X/08v
         I7ZtYjjbF11kryFh1nrLPy7JNc1jlnmUyhOTWBuwmCKfB38licazH/g1r9TPLJaSZYPt
         5GjQ==
X-Gm-Message-State: AOAM532G4y43BjAlSV9eOwV8xn1iCFNN8KopFwS0oA/DDxijawhCrecV
        ujobFbRDCDRbAzoHIeCj+dqwo1X0Utc=
X-Google-Smtp-Source: ABdhPJypibf5wBpNvtYlxpfMzNAO8uqcLQhPEl8G0KxcPk07KYikGDG1tp3uzefzyH5FK1wHheOuuOejCM0=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a05:6214:2a:: with SMTP id
 b10mr313595qvr.0.1598929176432; Mon, 31 Aug 2020 19:59:36 -0700 (PDT)
Date:   Mon, 31 Aug 2020 19:59:16 -0700
In-Reply-To: <20200901025927.3596190-1-badhri@google.com>
Message-Id: <20200901025927.3596190-4-badhri@google.com>
Mime-Version: 1.0
References: <20200901025927.3596190-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v6 03/14] usb: typec: tcpci: update ROLE_CONTROL for DRP
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

ROLE_CONTROL register would not have the actual CC terminations
unless the port does not set ROLE_CONTROL.DRP. For DRP ports,
CC_STATUS.cc1/cc2 indicates the final terminations applied
when TCPC enters potential_connect_as_source/_sink.
For DRP ports, infer port role from CC_STATUS and set corresponding
CC terminations before setting the orientation.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since v1:
 - Changing patch version to v6 to fix version number confusion.
---
 drivers/usb/typec/tcpm/tcpci.c | 37 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 7d36d5e2d3f7..7d9491ba62fb 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -191,12 +191,47 @@ static int tcpci_set_polarity(struct tcpc_dev *tcpc,
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
 	unsigned int reg;
 	int ret;
+	enum typec_cc_status cc1, cc2;
 
-	/* Keep the disconnect cc line open */
+	/* Obtain Rp setting from role control */
 	ret = regmap_read(tcpci->regmap, TCPC_ROLE_CTRL, &reg);
 	if (ret < 0)
 		return ret;
 
+	ret = tcpci_get_cc(tcpc, &cc1, &cc2);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * When port has drp toggling enabled, ROLE_CONTROL would only have the initial
+	 * terminations for the toggling and does not indicate the final cc
+	 * terminations when ConnectionResult is 0 i.e. drp toggling stops and
+	 * the connection is resolbed. Infer port role from TCPC_CC_STATUS based on the
+	 * terminations seen. The port role is then used to set the cc terminations.
+	 */
+	if (reg & TCPC_ROLE_CTRL_DRP) {
+		/* Disable DRP for the OPEN setting to take effect */
+		reg = reg & ~TCPC_ROLE_CTRL_DRP;
+
+		if (polarity == TYPEC_POLARITY_CC2) {
+			reg &= ~(TCPC_ROLE_CTRL_CC2_MASK << TCPC_ROLE_CTRL_CC2_SHIFT);
+			/* Local port is source */
+			if (cc2 == TYPEC_CC_RD)
+				/* Role control would have the Rp setting when DRP was enabled */
+				reg |= TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC2_SHIFT;
+			else
+				reg |= TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC2_SHIFT;
+		} else {
+			reg &= ~(TCPC_ROLE_CTRL_CC1_MASK << TCPC_ROLE_CTRL_CC1_SHIFT);
+			/* Local port is source */
+			if (cc1 == TYPEC_CC_RD)
+				/* Role control would have the Rp setting when DRP was enabled */
+				reg |= TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC1_SHIFT;
+			else
+				reg |= TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC1_SHIFT;
+		}
+	}
+
 	if (polarity == TYPEC_POLARITY_CC2)
 		reg |= TCPC_ROLE_CTRL_CC_OPEN << TCPC_ROLE_CTRL_CC1_SHIFT;
 	else
-- 
2.28.0.402.g5ffc5be6b7-goog

