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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB61C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D29320578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c46Psfp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391369AbgHQSiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391192AbgHQSig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 14:38:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D19C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:38:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e12so19389686ybc.18
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bhDEBLH2zLMBe1pLGOu37r6jSo02gwq/2nQ1HrTTqF8=;
        b=c46Psfp3A06TsHYPQDxrj6HTk77Qo5e9uHOhuCwS2+/PiWfuLzZAAT5aeyYg7EBKRJ
         gQUNht6Q8agUXutMXs2zghPZqD5PkGJAb+1MrBcDGqxvTHqQ8GP4+DVlah9UWhwKYMig
         /KQmMEF4lmAxPXz9lmD1c5PjRZsZCj1/0ZEefEyR5BueKo1BnG+2fShMgMC3nYLZ1i+S
         7eyQ7VEO3SklR5avS/aJY2MUP1f31Yc0nv98UaYlXiDoNdpB6iKL/fmcwyLr5SGTKwd0
         FCsmHn8Jp4EuPX6YO0+yXOjuJ4TZfev9NI4sFHBE4sSUbQoH8318ja55U5A7uIbnKZgq
         K1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bhDEBLH2zLMBe1pLGOu37r6jSo02gwq/2nQ1HrTTqF8=;
        b=dNwmiaC3ccquRD5C/auNlsnY3bcBm2ZIT0UlivGqsWlDXGrpHtctwpAGcxxpInahCM
         gsCnHAo9DGeow3CbAWfhDs5EF9ivr44E85z5A23evQ81s3woUqnjirXmE9ybuvU4Bkyo
         poZpKxVqoe8gCmZPY+VCxvyxAqeTuYgrnh00hhsZJhSJ+Az0soby50Xpf18i70TplhgJ
         p0hdIZi90HRejr6PAObOaY8errekcwIqew5uDesa3x27GADYloIqH19uyuXH7XOvHcyJ
         b5Afpdk31lyRXPPiwUCW+EUJo0XwBQpdp590X0YrWMPsUy7YrgbCIvrYpNeGp2SC4Aw3
         N7RQ==
X-Gm-Message-State: AOAM533gbpJDZteSi0r091A5id5Jxn0PtLGJPyqGFPQo/mzABpjouKov
        3VsXM/qxfJQRXywDBTp7Emq4GmxXV9Q=
X-Google-Smtp-Source: ABdhPJz/rAZPKfdOBjqyngDJSW+wdAEZYbki1trbj21OPfsZyt/sMN27TwHe2POwAolZ6Q0yuVxI48xqJ3I=
X-Received: by 2002:a25:240a:: with SMTP id k10mr21720805ybk.275.1597689513586;
 Mon, 17 Aug 2020 11:38:33 -0700 (PDT)
Date:   Mon, 17 Aug 2020 11:38:27 -0700
Message-Id: <20200817183828.1895015-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 1/2 v4] tcpm: During PR_SWAP, source caps should be sent only
 after tSwapSourceStart
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

The patch addresses the compliance test failures while running
TD.PD.CP.E3, TD.PD.CP.E4, TD.PD.CP.E5 of the "Deterministic PD
Compliance MOI" test plan published in https://www.usb.org/usbc.
For a product to be Type-C compliant, it's expected that these tests
are run on usb.org certified Type-C compliance tester as mentioned in
https://www.usb.org/usbc.

The purpose of the tests TD.PD.CP.E3, TD.PD.CP.E4, TD.PD.CP.E5 is to
verify the PR_SWAP response of the device. While doing so, the test
asserts that Source Capabilities message is NOT received from the test
device within tSwapSourceStart min (20 ms) from the time the last bit
of GoodCRC corresponding to the RS_RDY message sent by the UUT was
sent. If it does then the test fails.

This is in line with the requirements from the USB Power Delivery
Specification Revision 3.0, Version 1.2:
"6.6.8.1 SwapSourceStartTimer
The SwapSourceStartTimer Shall be used by the new Source, after a
Power Role Swap or Fast Role Swap, to ensure that it does not send
Source_Capabilities Message before the new Sink is ready to receive
the
Source_Capabilities Message. The new Source Shall Not send the
Source_Capabilities Message earlier than tSwapSourceStart after the
last bit of the EOP of GoodCRC Message sent in response to the PS_RDY
Message sent by the new Source indicating that its power supply is
ready."

The patch makes sure that TCPM does not send the Source_Capabilities
Message within tSwapSourceStart(20ms) by transitioning into
SRC_STARTUP only after  tSwapSourceStart(20ms).

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes since V1:
- Comment on the permissible values of tSwapSourceStart

Changes since V2:
- Fixing alignment issue pointed out by Guenter.
- Added Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Changes since V3:
- Updated commit description and made it elaborate to address Heikki's
  suggestion.
---
 drivers/usb/typec/tcpm/tcpm.c | 2 +-
 include/linux/usb/pd.h        | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 3ef37202ee37..d38347bd3335 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3555,7 +3555,7 @@ static void run_state_machine(struct tcpm_port *port)
 		 */
 		tcpm_set_pwr_role(port, TYPEC_SOURCE);
 		tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
-		tcpm_set_state(port, SRC_STARTUP, 0);
+		tcpm_set_state(port, SRC_STARTUP, PD_T_SWAP_SRC_START);
 		break;
 
 	case VCONN_SWAP_ACCEPT:
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index b6c233e79bd4..1df895e4680b 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -473,6 +473,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_T_ERROR_RECOVERY	100	/* minimum 25 is insufficient */
 #define PD_T_SRCSWAPSTDBY      625     /* Maximum of 650ms */
 #define PD_T_NEWSRC            250     /* Maximum of 275ms */
+#define PD_T_SWAP_SRC_START	20	/* Minimum of 20ms */
 
 #define PD_T_DRP_TRY		100	/* 75 - 150 ms */
 #define PD_T_DRP_TRYWAIT	600	/* 400 - 800 ms */
-- 
2.28.0.236.gb10cc79966-goog

