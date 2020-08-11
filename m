Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D47C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A42542075D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XHm0e4TR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgHKBLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 21:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgHKBLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:11:31 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B816C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 18:11:31 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id h2so7729096pgc.19
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 18:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hZlSontx+TLwHcuOl3hzbTHUYgf3jf+x/xXiXRfowoA=;
        b=XHm0e4TRpae8mWNjQYrTYKPVSJRU+t/VHQMdxFHwdS6jWGfXUm3yKc9g9CjmB+yuO2
         evHZa5O+BSv5/MfifDnhN61AY2lafaEm678cEZVvvZY1hqy+qwy3NkptIjuchWaaFXKA
         duzLUUATH4nBhGJpDkmwICsHOPSaCZJ1nHuPfni2htZQ6OhDwfANXdJeyw/quhNrpjbe
         5Wdga7j44i7JMffxqHkt2+v+YBRzU5gKXr1J58iABmh3uBf3R1TR4ALkjrL1nkkLUNx6
         QkuzMNCI2D5Z+PlYl+LUbwjnZRDR7dgoYYyDR4oRn/w/Bs6JP0rwxD1b5PeAyr/18+nl
         WLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hZlSontx+TLwHcuOl3hzbTHUYgf3jf+x/xXiXRfowoA=;
        b=lMOsDav7fJnVz4XN57u4m2ZCnWYIwHZCaLNGFDU0bw8RFnE7InLVSsaq0ow81aO58u
         y28DN8EhTC1FRA5woITwQrAUjAm/riSLJqvlBSkI4eHv4rpNnfSthlSlLZVrBd8kCI2C
         pnI6jQ9fCtxtEU2OXeCSBuRYXzx8VwR6SzNZAXkIqwLu5myHW9DrSCZuUC5ung/7eVC4
         pPkwJeIQYXDDQ/B2D8qjW7FBezD+NxbkViDzU9HDYCyrKV6pBqPTF9vZTODQPSzoX80t
         4qAghsWxVrZt6wn8XMHHFB7TNvFOaMI5zbXsFTyN4OFV1RVvEFGrsp+qKP6CnGGEj5Bo
         SdYA==
X-Gm-Message-State: AOAM531aTYHqqbe/jA56JRxXEgGzdJQUVGk6DlYcZzDeo9dg8por/F5f
        qGwy10svWWCsYsqCM7V7jD272xqbmEg=
X-Google-Smtp-Source: ABdhPJyzlY66TrseG9waiU2ZAVrGPhiEYGh+I2M3yOj2nUtO8v/0Ao5ce1AXeibXrLLro5kg4Hv6JMIF1ns=
X-Received: by 2002:a63:5b65:: with SMTP id l37mr23190683pgm.72.1597108290020;
 Mon, 10 Aug 2020 18:11:30 -0700 (PDT)
Date:   Mon, 10 Aug 2020 18:11:26 -0700
Message-Id: <20200811011126.130297-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v1] usb: typec: tcpm: Fix TDA 2.2.1.1 and TDA 2.2.1.2 failures
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
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
 drivers/usb/typec/tcpm/tcpm.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 3ef37202ee37..e41c4e5d3c71 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3372,13 +3372,19 @@ static void run_state_machine(struct tcpm_port *port)
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
 		break;
 	case SRC_HARD_RESET_VBUS_ON:
+		tcpm_set_vconn(port, true);
 		tcpm_set_vbus(port, true);
 		port->tcpc->set_pd_rx(port->tcpc, true);
 		tcpm_set_attached_state(port, true);
@@ -3944,7 +3950,11 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
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

