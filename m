Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B387C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A5BB22CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259814;
	bh=m681DT4o3aG8++UII+u8CSlUWPO3GIpQI3OqZ06SJLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ICx0uT82DjYOhrBsBLRV9niH6zWr4G11QzuiRr4BfNeHb+sEaFbxStD31XiJ7jyj/
	 s+qMLKYovwd3a9uiNRzxo/Bf2Qa3CL99nRga9EjAFNAi6u4ggrNxDyz2SJmQk9gw91
	 K1esK7UO9oxw3syMOqYARfR2UvaSAT9vj4a8cb/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgGTPnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:43:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729711AbgGTPn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:43:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C882176B;
        Mon, 20 Jul 2020 15:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259808;
        bh=m681DT4o3aG8++UII+u8CSlUWPO3GIpQI3OqZ06SJLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b0D1jjLxW2KCkClIhdCLfFLhIoLigBUW4W5puaCPfJvtMTr/V5zz4IRZvdKSSoGkB
         fdxS84grpX2Ef6GA5dWQDU11h/UC2grwCMUdzMuFk8hLHcbHmyyOja7fFCDHFSqh4t
         iGNj5Y9pGvgegb+2sqnhPyLtAW1PavpbM2ERZFFI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 4.9 66/86] usb: chipidea: core: add wakeup support for extcon
Date:   Mon, 20 Jul 2020 17:37:02 +0200
Message-Id: <20200720152756.491357480@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152753.138974850@linuxfoundation.org>
References: <20200720152753.138974850@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Chen <peter.chen@nxp.com>

commit 876d4e1e8298ad1f94d9e9392fc90486755437b4 upstream.

If wakeup event occurred by extcon event, it needs to call
ci_irq again since the first ci_irq calling at extcon notifier
only wakes up controller, but do noop for event handling,
it causes the extcon use case can't work well from low power mode.

Cc: <stable@vger.kernel.org>
Fixes: 3ecb3e09b042 ("usb: chipidea: Use extcon framework for VBUS and ID detect")
Reported-by: Philippe Schenker <philippe.schenker@toradex.com>
Tested-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Link: https://lore.kernel.org/r/20200707060601.31907-2-peter.chen@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/chipidea/core.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -1110,6 +1110,29 @@ static void ci_controller_suspend(struct
 	enable_irq(ci->irq);
 }
 
+/*
+ * Handle the wakeup interrupt triggered by extcon connector
+ * We need to call ci_irq again for extcon since the first
+ * interrupt (wakeup int) only let the controller be out of
+ * low power mode, but not handle any interrupts.
+ */
+static void ci_extcon_wakeup_int(struct ci_hdrc *ci)
+{
+	struct ci_hdrc_cable *cable_id, *cable_vbus;
+	u32 otgsc = hw_read_otgsc(ci, ~0);
+
+	cable_id = &ci->platdata->id_extcon;
+	cable_vbus = &ci->platdata->vbus_extcon;
+
+	if (!IS_ERR(cable_id->edev) && ci->is_otg &&
+		(otgsc & OTGSC_IDIE) && (otgsc & OTGSC_IDIS))
+		ci_irq(ci->irq, ci);
+
+	if (!IS_ERR(cable_vbus->edev) && ci->is_otg &&
+		(otgsc & OTGSC_BSVIE) && (otgsc & OTGSC_BSVIS))
+		ci_irq(ci->irq, ci);
+}
+
 static int ci_controller_resume(struct device *dev)
 {
 	struct ci_hdrc *ci = dev_get_drvdata(dev);
@@ -1136,6 +1159,7 @@ static int ci_controller_resume(struct d
 		enable_irq(ci->irq);
 		if (ci_otg_is_fsm_mode(ci))
 			ci_otg_fsm_wakeup_by_srp(ci);
+		ci_extcon_wakeup_int(ci);
 	}
 
 	return 0;


