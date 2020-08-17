Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7367C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860F6204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ozgk4zeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391579AbgHQSqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391574AbgHQSqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 14:46:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46770C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:46:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l67so19361930ybb.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=igT/RD9FT1ivose8vpyW6Gac8BmP5bq8bPpgK8m+2+g=;
        b=ozgk4zeXGpEOM0vogzWavGLtVee/RFWUK1605vb0xBwCiLZscZBKV7Rp0ZfB3/SLEn
         f4r7/6UG4Y5HVXlrEwFtspU9tBM82zU3NLruST6SXT3DZ9hJh0+k9fVECeL/0TFoExjh
         JBe/y5jBFJ9x8uefEgjA3/dO9tNYEboI/QullwuawPVHFEWUPJwojGgBkMVCDB/oL1qt
         0ZaB38EqoganL4yLIENeVn2AxGrmpQ+sO+zf0LgeGyuyCK/XWWtqZ89rJskhuDITlHhY
         47hZQHAGOlLYZDOzM6QV9hyY7oWjqA5NebHu2tF7OpSTo0nys3GSQsYpWQ/Tig2zG4fr
         nhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=igT/RD9FT1ivose8vpyW6Gac8BmP5bq8bPpgK8m+2+g=;
        b=HcqdE2ZACuHOfsrG4+8Zf0J8W4QRQzqQCQ4j199y+Sk4hJWMi/AvpSmbs/5pfdy9+w
         ow3qPHNLBEsC6oIAQZIHdrIn8AlyHCRGno1NsfnVnRL+DCW7AiW22fw9j5JJtd+5VQH4
         Ka24tBdj59yXaZ7aURyqNtR4YhqEdOwDQaVNTgOaA08QnvwW0TB27fVJ2NmNQ0GDOsKF
         2Bh7rzMy7hhNeyY7edK8JCSmqO0dEEy6ycfDmkUZfyfCmKDtZgiMc2kjSvN9NLMRLnNi
         /mCR8Ia0ZKRo1MfOVMpkUSeMQovI57S10eXlCyMfA79Q1xY9LGevydtY9raRnvnCfLeQ
         iJqQ==
X-Gm-Message-State: AOAM532psHSmwmVaO9Y4z+/6+d8EOa9NIIwrIUshgbczsw4KjpCdgie1
        4EFstZ2BelBQEJS/j2W9c0Yr4naX4q4=
X-Google-Smtp-Source: ABdhPJzU15GDqDIPxE31kDhCLqGnXGoArAO2hXGgaJ9qSIM6VaWG+kl2cZgt/Nua1Y4Ts6PAmCOggtuMQ5Q=
X-Received: by 2002:a25:2644:: with SMTP id m65mr21943616ybm.94.1597689965184;
 Mon, 17 Aug 2020 11:46:05 -0700 (PDT)
Date:   Mon, 17 Aug 2020 11:46:01 -0700
Message-Id: <20200817184601.1899929-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v4] usb: typec: tcpm: Fix Fix source hard reset response for
 TDA 2.3.1.1 and TDA 2.3.1.2 failures
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

The patch addresses the compliance test failures while running  TDA
2.3.1.1 and  TDA 2.3.1.2 of the "PD Communications Engine USB PD
Compliance MOI" test plan published in https://www.usb.org/usbc.
For a product to be Type-C compliant, it's expected that these tests
are run on usb.org certified Type-C compliance tester as mentioned in
https://www.usb.org/usbc.

While the purpose of TDA 2.3.1.1 and  TDA 2.3.1.2 is to verify that
the static and dynamic electrical capabilities of a Source meet the
requirements for each PDO offered,  while doing so, the tests also
monitor that the timing of the VBUS waveform versus the messages meets
the requirements for Hard Reset defined in PROT-PROC-HR-TSTR as
mentioned in step 11 of TDA.2.3.1.1 and step 15 of TDA.2.3.1.2.

TDB.2.2.13.1: PROT-PROC-HR-TSTR Procedure and Checks for Tester
Originated Hard Reset
Purpose: To perform the appropriate protocol checks relating to any
circumstance in which the Hard Reset signal is sent by the Tester.

UUT is behaving as source:
The Tester sends a Hard Reset signal.
1. Check VBUS stays within present valid voltage range for
tPSHardReset min (25ms) after last bit of Hard Reset signal.
[PROT_PROC_HR_TSTR_1]
2. Check that VBUS starts to fall below present valid voltage range by
tPSHardReset max (35ms). [PROT_PROC_HR_TSTR_2]
3. Check that VBUS reaches vSafe0V within tSafe0v max (650 ms).
[PROT_PROC_HR_TSTR_3]
4. Check that VBUS starts rising to vSafe5V after a delay of
tSrcRecover (0.66s - 1s) from reaching vSafe0V. [PROT_PROC_HR_TSTR_4]
5. Check that VBUS reaches vSafe5V within tSrcTurnOn max (275ms) of
rising above vSafe0v max (0.8V). [PROT_PROC_HR_TSTR_5] Power Delivery
Compliance Plan 139 6. Check that Source Capabilities are finished
sending within tFirstSourceCap max (250ms) of VBUS reaching vSafe5v
min. [PROT_PROC_HR_TSTR_6].

This is in line with 7.1.5 Response to Hard Resets of the USB Power
Delivery Specification Revision 3.0, Version 1.2,
"Hard Reset Signaling indicates a communication failure has occurred
and the Source Shall stop driving VCONN, Shall remove Rp from the
VCONN pin and Shall drive VBUS to vSafe0V as shown in Figure 7-9. The
USB connection May reset during a Hard Reset since the VBUS voltage
will be less than vSafe5V for an extended period of time. After
establishing the vSafe0V voltage condition on VBUS, the Source Shall
wait tSrcRecover before re-applying VCONN and restoring VBUS to
vSafe5V. A Source Shall conform to the VCONN timing as specified in
[USB Type-C 1.3]."

With the above guidelines from the spec in mind, TCPM does not turn
off VCONN while entering SRC_HARD_RESET_VBUS_OFF. The patch makes TCPM
turn off VCONN while entering SRC_HARD_RESET_VBUS_OFF and turn it back
on while entering SRC_HARD_RESET_VBUS_ON along with vbus instead of
having VCONN on through hardreset.

Also, the spec clearly states that "After establishing the vSafe0V
voltage condition on VBUS",  the Source Shall wait tSrcRecover before
re-applying VCONN and restoring VBUS to vSafe5V.
TCPM does not conform to this requirement. If the TCPC driver calls
tcpm_vbus_change with vbus off signal, TCPM right away enters
SRC_HARD_RESET_VBUS_ON without waiting for tSrcRecover.
For TCPC's which are buggy/does not call tcpm_vbus_change, TCPM
assumes that the vsafe0v is instantaneous as TCPM only waits
tSrcRecover instead of waiting for tSafe0v + tSrcRecover.
This patch also fixes this behavior by making sure that TCPM waits for
tSrcRecover before transitioning into SRC_HARD_RESET_VBUS_ON when
tcpm_vbus_change is called by TCPC.
When TCPC does not call tcpm_vbus_change, TCPM assumes the worst case
i.e.  tSafe0v + tSrcRecover before transitioning into
SRC_HARD_RESET_VBUS_ON.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes since V1 (Guenter's suggestion):
- Bound SRC_HARD_RESET_VBUS_ON to accommodate tcpc drivers which doesn't
  update the vbus status.

Changes since V2:
- Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Changes since V3:
- Fixed compliance test numbers and updated commit description and made
  in more elaborate to address Heikki's suggestion.
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

