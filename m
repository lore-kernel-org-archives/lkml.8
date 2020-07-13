Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB004C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 20:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA218206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 20:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEjD8IjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgGMUiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgGMUiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 16:38:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7887AC061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 13:38:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k127so18669824ybk.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 13:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=VaRPD418ICZmuo4SvaU+Y0dC9FFgnGHoJ8TNq0YfGNQ=;
        b=AEjD8IjTY2eWYNj21fRvI03XgcUm1AXq7+rOI0xI5jidgdiZOxUpzRQ5zr7YS8/8zj
         m2sFbC124wzn8zaz7ntnconQsBiYHhEoTOvTucliIgUg8bFQ6ge3KWtm99SMqM/JHd8r
         yWDTbn3Q7S7Fwe59nbPMi+djsVnY+n2oz4KlzxNY0UlmxzLAf93Ms9mQS4cQPzgIDoGC
         yINLGaESNldzKDQIFj0vshZH8F7Afg8norBpKbP0sv9FR5ez4weX2ZghGBcvdbZ+kX9L
         kJaHvv/E6OFzf1lkPvNV7m+M0D+sSDTOjczG1byzvLnizbv7mqBGaXZy/MGU2N1Jp1EY
         xXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=VaRPD418ICZmuo4SvaU+Y0dC9FFgnGHoJ8TNq0YfGNQ=;
        b=AHG4kvUKIF1a1rJ3tUZsxoSmVDuqr0SbyLMLDP+PtGCnxlCiVeXqd9wnC7YDKc3tWf
         2LuGSWf6x7d5TMLTO2S3IySGbduccONOnVJJKB7XWTbb4+2npiQ8cF+fKZUVp7i8uHXR
         jHg6nrkKWkCCk4edSYQHf1MrGHM+fd0Lwq1vUeob15Qh5YTjz/PE6wHOqwMgVXjVRnlT
         lpstPIXr/Xz9F6xoanZJQfflTIfA7fo61VJDsMQaamlURMRphWruB1865aA+uGf4ge6s
         WyezkGBDQLO39/KzCwAhPA/Lu7BIhGDkGSEwXbkK1FU7VNFxhhSrVWvIK+lDcp8flPJf
         ZiFw==
X-Gm-Message-State: AOAM532Us1pAgsi5NkknuYhEb29BpW9lFB9gK4gGuqiuWO9fjptnUxGV
        /NJBefrRgEacIwZkhqR/JIo4JkvdVwY=
X-Google-Smtp-Source: ABdhPJzs+eUF1WANjiYQRMZi3lU1vKc14YuAXAKAvmDhlbdzmW51ENBer6EiiE+wrR7YwTcvs7Q3rfg2vZI=
X-Received: by 2002:a25:2008:: with SMTP id g8mr3085446ybg.17.1594672729626;
 Mon, 13 Jul 2020 13:38:49 -0700 (PDT)
Date:   Mon, 13 Jul 2020 13:38:38 -0700
In-Reply-To: <20200713203838.339297-1-badhri@google.com>
Message-Id: <20200713203838.339297-2-badhri@google.com>
Mime-Version: 1.0
References: <20200713203838.339297-1-badhri@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH 2/2] usb: typec: tcpm: Stay in BIST mode till hardreset or unattached
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        reg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Port starts to toggle when transitioning to unattached state.
This is incorrect while in BIST mode.

6.4.3.1 BIST Carrier Mode
Upon receipt of a BIST Message, with a BIST Carrier Mode BIST Data Object,
the UUT Shall send out a continuous string of BMC encoded alternating "1"s
and =E2=80=9C0=E2=80=9Ds. The UUT Shall exit the Continuous BIST Mode withi=
n
tBISTContMode of this Continuous BIST Mode being enabled(see
Section 6.6.7.2).

6.4.3.2 BIST Test Data
Upon receipt of a BIST Message, with a BIST Test Data BIST Data Object,
the UUT Shall return a GoodCRC Message and Shall enter a test mode in which
it sends no further Messages except for GoodCRC Messages in response to
received Messages. See Section 5.9.2 for the definition of the Test Data
Frame. The test Shall be ended by sending Hard Reset Signaling to reset the
UUT.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 8 ++++++--
 include/linux/usb/pd.h        | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 525379798d6c5c..61d854f16e4eda 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3557,6 +3557,8 @@ static void run_state_machine(struct tcpm_port *port)
 		switch (BDO_MODE_MASK(port->bist_request)) {
 		case BDO_MODE_CARRIER2:
 			tcpm_pd_transmit(port, TCPC_TX_BIST_MODE_2, NULL);
+			tcpm_set_state(port, unattached_state(port),
+				       PD_T_BIST_CONT_MODE);
 			break;
 		case BDO_MODE_TESTDATA:
 			if (port->tcpc->set_bist_data)
@@ -3565,8 +3567,6 @@ static void run_state_machine(struct tcpm_port *port)
 		default:
 			break;
 		}
-		/* Always switch to unattached state */
-		tcpm_set_state(port, unattached_state(port), 0);
 		break;
 	case GET_STATUS_SEND:
 		tcpm_pd_send_control(port, PD_CTRL_GET_STATUS);
@@ -3956,6 +3956,10 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port=
)
 static void _tcpm_pd_hard_reset(struct tcpm_port *port)
 {
 	tcpm_log_force(port, "Received hard reset");
+	if (port->bist_request =3D=3D  BDO_MODE_TESTDATA &&
+	    port->tcpc->set_bist_data)
+		port->tcpc->set_bist_data(port->tcpc, false);
+
 	/*
 	 * If we keep receiving hard reset requests, executing the hard reset
 	 * must have failed. Revert to error recovery if that happens.
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index a665d7f211424d..b420d8d613cd23 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -483,4 +483,5 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_N_CAPS_COUNT		(PD_T_NO_RESPONSE / PD_T_SEND_SOURCE_CAP)
 #define PD_N_HARD_RESET_COUNT	2
=20
+#define PD_T_BIST_CONT_MODE	60 /* 30 - 60 ms */
 #endif /* __LINUX_USB_PD_H */
--=20
2.27.0.383.g050319c2ae-goog

