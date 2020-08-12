Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A08FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18EAA2078B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJnDj1cP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgHLAOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgHLAOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 20:14:43 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEF6C061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 17:14:43 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id m13so383203qth.16
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 17:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hGJKteDFRvmAoB5QUn3ibeow19jlpU6dAFKbgXDL7Hg=;
        b=UJnDj1cP10bDZGsYcpJD/D9ftl4SJoVSzjN5Rctm40imEG+y111Ag8D0wRybxWR973
         MntcgYeJ2sM2a674k2a/GxwlPdbPGmmq7R4cFFoZhecnEtgydi6t1TzZpGUkmZUQp2vv
         aemYzVyjV3BEWIEPsuTadfo92pC0+jGRz/yrf255x2xXSjAiSoLK54k4sh/f7sgYnf3K
         gIJC/a7iwK+3WamIFqnFsqAAQ7wZXJNWS8EChXspXoaALq9J4OFCEZxgO1wjS/3G7X9a
         tnAPZvVseoBoLKPrv+LphFfiqBgYUt2fD+K4DFilcsgwfS+TepVUQ8Wo3tNRFa1i3kXI
         rX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hGJKteDFRvmAoB5QUn3ibeow19jlpU6dAFKbgXDL7Hg=;
        b=jGp8MHRlbQDHrPuef4K+jaIre6IlEDoYRTYeNy8KPXcvNLBou6j+ppYvYsDV97mND4
         ejrqRJAN7ZF5IhahyRipQX28nbbUokG50u+QKisie4urFKKmVx/o6oUKq8t5M7kJiL2g
         cdYD64l9shkOtWkcfVNq9LnsRF4Na67z3AeFoGigiWqM4HyKPNjfG0yHNfdRTuP6PBlX
         hoPxXVaVTPY6fpap1CxSUnFE6GLk+pqIK2pYmtgZYvsUo+Nuh7mwG0rik7vknIujIg6C
         WF73Nyz9ZvU6EkAcMox/6JrPHZyHFYCgrL3kCS4YQIRb6UtMf+2c2bEtoNjhL/JWmPyX
         o3wg==
X-Gm-Message-State: AOAM530Z477E5lmwsbuoTREcgADdWZbbEN+g29iT9Onvc4hoS/B4f4sT
        seDnwW/mZ8gOCA1IM6JapIN1GiRyy9g=
X-Google-Smtp-Source: ABdhPJxKTXpolq6+IqC9ZDR48trH3huTbcnQfxPTsEi34Hb9n6iiXfgtn2elXy46WPCPliLwpOT7384PdFk=
X-Received: by 2002:ad4:46ad:: with SMTP id br13mr4141980qvb.234.1597191282436;
 Tue, 11 Aug 2020 17:14:42 -0700 (PDT)
Date:   Tue, 11 Aug 2020 17:14:39 -0700
Message-Id: <20200812001439.545655-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v2] tcpm: During PR_SWAP, source caps should be sent only
 after tSwapSourceStart
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
"6.6.8.1 SwapSourceStartTimer
The SwapSourceStartTimer Shall be used by the new Source, after a Power
Role Swap or Fast Role Swap, to ensure that it does not send
Source_Capabilities Message before the new Sink is ready to receive the
Source_Capabilities Message. The new Source Shall Not send the
Source_Capabilities Message earlier than tSwapSourceStart after the
last bit of the EOP of GoodCRC Message sent in response to the PS_RDY
Message sent by the new Source indicating that its power supply is
ready."

This fixes TD.PD.CP.E3, TD.PD.CP.E4, TD.PD.CP.E5 failures

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since V1:
- Comment on the permissible values of tSwapSourceStart
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
index b6c233e79bd4..ed5eed73ccf8 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -473,6 +473,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_T_ERROR_RECOVERY	100	/* minimum 25 is insufficient */
 #define PD_T_SRCSWAPSTDBY      625     /* Maximum of 650ms */
 #define PD_T_NEWSRC            250     /* Maximum of 275ms */
+#define PD_T_SWAP_SRC_START	20     /* Minimum of 20ms */
 
 #define PD_T_DRP_TRY		100	/* 75 - 150 ms */
 #define PD_T_DRP_TRYWAIT	600	/* 400 - 800 ms */
-- 
2.28.0.236.gb10cc79966-goog

