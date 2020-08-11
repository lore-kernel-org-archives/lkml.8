Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB5BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 303CE20756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdVUT7Dc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHKUCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKUCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:02:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7775AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:02:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g127so130530ybf.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dE1KJMhEJ/N1GLpqUOXdinarT5Tbr6fdBCIanhYXlGA=;
        b=hdVUT7Dc6ec+MiBDjkDdVF4wjfMtz3L6DCNZRsCt3L4CLXj4q/7koog/Wg3Suhd1Xm
         dRXpg1ViPLkVKE4sF+xfAq9IllzhccmWBIyQVnrZI/hhY5vms672AXUeBFaIwJp+VPWE
         2OekIB9nfTWEGSrHmHUYQxibgHAjxJyHv4iRwLppJutitwb2x7LcOq7vzOgbMSOJtYxq
         /ekZ5r6NCWGuiMkARklSEfLHv+/4fR8ak4qjkVfJHkq2ElMayX9o8AuJchABNML5mBMH
         M5o695TJXjz0VIt3E+k3nZoekrSDK74WgsESY+tRBIq0hL2f6DU/zJ6AXOFGF848Q6D5
         oWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dE1KJMhEJ/N1GLpqUOXdinarT5Tbr6fdBCIanhYXlGA=;
        b=KZd8G/SfMHnr84mjmDPkeC8/eyqh/kLQuoQ3wy0JAqQ0NFXED2VenIQ63AG27XFe2D
         vqdzq6eAJxmLHiPVz05z9gTlJSVxCZHw1l6qbOjepkAKVntds91kcF4dvGaomtoHj3tS
         pATLgmwvc7CJpZup4oz3DsoPAQutsCyR4yrThsUqGZtNmhxP6MlG8DFyzyv7tEInF0VB
         wEN+Pem5W24Kqzr4bP4GC/dAN0hrYI7ubrbv5codjrfK6Vg4lMSKiyNksr8AGSfXhEsQ
         ekuc+cWmHUVZNqwCJhxa89PrPqoDbt0d89xbuJT0gLECW8QGvufPWsCaW9F5J9GdPUQ3
         VCMg==
X-Gm-Message-State: AOAM533BiZCYG4IKANdkJy2e4SYccHDckzS0fA9PxUJrGPkBeg6f8lnA
        lkIL53hV0NaA9odsiUEleyqoDghyqzE=
X-Google-Smtp-Source: ABdhPJxPNRETv2cb8Rnwqa3wBAmd0IBOL4/zayQQrU2NTJV5OrRWBXLjXoNfNmdvgxiwoKFK7zlWCIz9cXk=
X-Received: by 2002:a25:ef4e:: with SMTP id w14mr27424676ybm.225.1597176153320;
 Tue, 11 Aug 2020 13:02:33 -0700 (PDT)
Date:   Tue, 11 Aug 2020 13:02:28 -0700
Message-Id: <20200811200228.433264-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v2] usb: typec: tcpm: Fix TDA 2.2.1.1 and TDA 2.2.1.2 failures
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the spec:
"7.1.5 Response to Hard Resets
Hard Reset Signaling indicates a communication failure has occurred and
the Source Shall stop driving VCONN, Shall remove Rp from the VCONN pin
and Shall drive VBUS to vSafe0V as shown in Figure 7-9. The USB connection
May reset during a Hard Reset since the VBUS voltage will be less than
vSafe5V for an extended period of time. After establishing the vSafe0V
voltage condition on VBUS, the Source Shall wait tSrcRecover before
re-applying VCONN and restoring VBUS to vSafe5V. A Source Shall conform
to the VCONN timing as specified in [USB Type-C 1.3]."

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since V1 (Guenter's suggestion):
- Bound SRC_HARD_RESET_VBUS_ON to accommodate tcpc drivers which doesn't
  update the vbus status.
---
 drivers/usb/typec/tcpm/tcpm.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 3ef37202ee37..a48e3f90d196 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3372,13 +3372,31 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, SNK_HARD_RESET_SINK_OFF, 0);
 		break;
 	case SRC_HARD_RESET_VBUS_OFF:
-		tcpm_set_vconn(port, true);
+		/*
+		 * 7.1.5 Response to Hard Resets
+		 * Hard Reset Signaling indicates a communication failure has occurred and the
+		 * Source Shall stop driving VCONN, Shall remove Rp from the VCONN pin and Shall
+		 * drive VBUS to vSafe0V as shown in Figure 7-9.
+		 */
+		tcpm_set_vconn(port, false);
 		tcpm_set_vbus(port, false);
 		tcpm_set_roles(port, port->self_powered, TYPEC_SOURCE,
 			       tcpm_data_role_for_source(port));
-		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
+		/*
+		 * If tcpc fails to notify vbus off, TCPM will wait for PD_T_SAFE_0V +
+		 * PD_T_SRC_RECOVER before turning vbus back on.
+		 * From Table 7-12 Sequence Description for a Source Initiated Hard Reset:
+		 * 4. Policy Engine waits tPSHardReset after sending Hard Reset Signaling and then
+		 * tells the Device Policy Manager to instruct the power supply to perform a
+		 * Hard Reset. The transition to vSafe0V Shall occur within tSafe0V (t2).
+		 * 5. After tSrcRecover the Source applies power to VBUS in an attempt to
+		 * re-establish communication with the Sink and resume USB Default Operation.
+		 * The transition to vSafe5V Shall occur within tSrcTurnOn(t4).
+		 */
+		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SAFE_0V + PD_T_SRC_RECOVER);
 		break;
 	case SRC_HARD_RESET_VBUS_ON:
+		tcpm_set_vconn(port, true);
 		tcpm_set_vbus(port, true);
 		port->tcpc->set_pd_rx(port->tcpc, true);
 		tcpm_set_attached_state(port, true);
@@ -3944,7 +3962,11 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
 		tcpm_set_state(port, SNK_HARD_RESET_WAIT_VBUS, 0);
 		break;
 	case SRC_HARD_RESET_VBUS_OFF:
-		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, 0);
+		/*
+		 * After establishing the vSafe0V voltage condition on VBUS, the Source Shall wait
+		 * tSrcRecover before re-applying VCONN and restoring VBUS to vSafe5V.
+		 */
+		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
 		break;
 	case HARD_RESET_SEND:
 		break;
-- 
2.28.0.236.gb10cc79966-goog

