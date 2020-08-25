Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267EDC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07AC720737
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="n72OI6Mo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgHYEWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgHYEWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:22:34 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E8AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:22:34 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id n1so4680258pgi.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=F8R7yB/uW413X5BedlVvfs1XP30S/Fpzu0dI0Wqxoxc=;
        b=n72OI6MoEkQhfKUwJdHzWFQo0b8hAvkNDSD1jmWoyZQ0V8OJBU2zf9TYkIjQYpXtCo
         dUStaSep5gflMaYcmcL10S6XR/DnqRv7amQsr9GxaBe2MnDAxILEhPQWW3VG5ABPS2vh
         gDTLW7GGp0hfHW1TCkZJkfAAwPALmBk/VDLkGb6JSOt8XzTD1AjuqshMjX8wseVt5E8S
         RY6f27PWDyrpbj01THKYTfJ5h+K5UhMQJSGDLhuErTYtZvRFeFQGkDh7vmu1PbxIrVWT
         SBPc9z1H4Ln+WHTzwN1F8WXvd1I+1D7wnSbQtdxyTo2Gbffbf9SRmBA2yLbXStxxNNxR
         C0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F8R7yB/uW413X5BedlVvfs1XP30S/Fpzu0dI0Wqxoxc=;
        b=BH5CuoHowXlqiHetnZeqQhUXwzQC+U/9CrE1FFkFoWIAsgsBRfFKKWL07BYEPJMFuf
         MNrCqQquZlZGJFS/lRh0cVyxMtpuXtzpXq5rELoAgFLafJBSW1H+4ej7FaZQVxkoIxgL
         nvitSUDmaD3h2lwbWgqt/J3m8RNz8abhwc/Gu9gVu/b0rWhQGf4cymDjgmsUgKr1iZnY
         A/7m+0IO/5TwUv6/dDV+bNg44POjr2dBKfF1NhKv9O+htRtyrO/vZ1V8zGtjfGtg67V/
         +Ik4MZTxCp7ciUFo1sx+slaxuRncqFkx9BaaKtdm3QWH+YDY0KF5Bs2/NkvEEDOidnSK
         BqLQ==
X-Gm-Message-State: AOAM5321duvWrRjQlNZU0OyzX5TuDuubRehoIzLJz75suD7hzZH0ceOM
        sdY8AYO9SglwuJ8sH/GATsQiGFGiP6s=
X-Google-Smtp-Source: ABdhPJzj5NrEqS6R/E/pway38JrzWHE+PYmAiWI5fTlEcegdm6POulaQfy5AaYM7tiD79DhVVquGuO7tQkA=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a17:90a:638c:: with SMTP id
 f12mr249425pjj.1.1598329353549; Mon, 24 Aug 2020 21:22:33 -0700 (PDT)
Date:   Mon, 24 Aug 2020 21:21:59 -0700
In-Reply-To: <20200825042210.300632-1-badhri@google.com>
Message-Id: <20200825042210.300632-4-badhri@google.com>
Mime-Version: 1.0
References: <20200825042210.300632-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 03/14 v1] usb: typec: tcpci: update ROLE_CONTROL for DRP
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
 drivers/usb/typec/tcpm/tcpci.c | 37 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 90d348caa6a8..9e814d454d14 100644
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
2.28.0.297.g1956fa8f8d-goog

