Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31544C433EB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02D2D2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+ZDYKXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgGPDlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 23:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgGPDll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 23:41:41 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34B5C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 20:41:41 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id s1so4445751pgq.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 20:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=eyGKIrNpC4d1P/2vRZTid13/ubCOQhtxZ8c/xlJYEpE=;
        b=X+ZDYKXjnyNj5AU7zCSbrpZoHPKZ51Hrfb1LR4pT/3xzCKM9/fUKUUNTWEEkmBN61r
         H9ebfBhG/IjIEUBJyrB+9l+v4rQMqLqi8vjpxM6S8K3uja/zR/oeHraNKLjsEb2Y41Rg
         Qg0v5wHhjIBeqZl8XBah6pM807Jy4VUarcw4gDAk8iUY6ffk+mLqW0vgzy20+mH5QLIX
         345hY6WD0ktT+q0dztB9Y2xrSONOgMwxyHCHOsxL63qCLtNA3hSSUwWv3mCSs/n6nN1p
         /jsSPm6MsS1K9vT7UcT56OVxoU7xF4xqtCO1yBbnVGkUxOtgrxtngHSGmcOMdWg6pkdR
         5RdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=eyGKIrNpC4d1P/2vRZTid13/ubCOQhtxZ8c/xlJYEpE=;
        b=X9XU8O2ti7Rsy3lWLRGL9oFgTpppRSK3Uur+AOrKWNT+xBTuouNPHigA+26QIp08O6
         9ZHg774HPQW7EJoTkA3e281Evg0YRonyMPzPlZlFCcfIWqulURCtfS7e5hGZcEsrHFrL
         qhk0JtAAbC/4jhMSaSsUVIWQa8KLH2DzRFpz7eXqxaeBggLQR7v5tcRc5Yq8QSO1cLbY
         P8RmTQqneTrOA/+HIwj1RGC4e/mKMahhPRvz+Gty9Ksjcfhh7lhVh1tvfyJadKT8HaJC
         4If0jiVM4MgKQqs3KXm6YAgg7QkHVlt8do6NrrpvgekWryTqE8nkHVAU5+0jEZkWTx8W
         Gj3Q==
X-Gm-Message-State: AOAM532BGibfZ4ozST4A+4DlRY6FH+OjGcuJNEOlrmHD8pRvJ/q1XY3v
        VHKYsb8daKk4vJUJ5+hn0jDI3vmmpP0=
X-Google-Smtp-Source: ABdhPJxfUJKtPzUYd517kts5e2ZalfpZFYJNAaqWBnkfCircu0u2gV2Mqp09m/xHeasMDg5A8lCL0f+o63w=
X-Received: by 2002:a17:90a:1fcb:: with SMTP id z11mr1642988pjz.1.1594870900921;
 Wed, 15 Jul 2020 20:41:40 -0700 (PDT)
Date:   Wed, 15 Jul 2020 20:41:28 -0700
In-Reply-To: <20200716034128.1251728-1-badhri@google.com>
Message-Id: <20200716034128.1251728-3-badhri@google.com>
Mime-Version: 1.0
References: <20200716034128.1251728-1-badhri@google.com>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH 3/3 v3] usb: typec: tcpm: Stay in BIST mode till hardreset or unattached
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
Version history:
Changes since V1:
- None

Changes since V2:(Guenter's suggestions)
- Fixed formatting error
- Reduced timeout to 50ms

---
 drivers/usb/typec/tcpm/tcpm.c | 7 +++++--
 include/linux/usb/pd.h        | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 379fcab9dbd973..38b958a9650104 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3559,6 +3559,8 @@ static void run_state_machine(struct tcpm_port *port)
 		switch (BDO_MODE_MASK(port->bist_request)) {
 		case BDO_MODE_CARRIER2:
 			tcpm_pd_transmit(port, TCPC_TX_BIST_MODE_2, NULL);
+			tcpm_set_state(port, unattached_state(port),
+				       PD_T_BIST_CONT_MODE);
 			break;
 		case BDO_MODE_TESTDATA:
 			if (port->tcpc->set_bist_data) {
@@ -3569,8 +3571,6 @@ static void run_state_machine(struct tcpm_port *port)
 		default:
 			break;
 		}
-		/* Always switch to unattached state */
-		tcpm_set_state(port, unattached_state(port), 0);
 		break;
 	case GET_STATUS_SEND:
 		tcpm_pd_send_control(port, PD_CTRL_GET_STATUS);
@@ -3960,6 +3960,9 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
 static void _tcpm_pd_hard_reset(struct tcpm_port *port)
 {
 	tcpm_log_force(port, "Received hard reset");
+	if (port->bist_request =3D=3D BDO_MODE_TESTDATA && port->tcpc->set_bist_d=
ata)
+		port->tcpc->set_bist_data(port->tcpc, false);
+
 	/*
 	 * If we keep receiving hard reset requests, executing the hard reset
 	 * must have failed. Revert to error recovery if that happens.
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index a665d7f211424d..b6c233e79bd457 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -483,4 +483,5 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_N_CAPS_COUNT		(PD_T_NO_RESPONSE / PD_T_SEND_SOURCE_CAP)
 #define PD_N_HARD_RESET_COUNT	2
=20
+#define PD_T_BIST_CONT_MODE	50 /* 30 - 60 ms */
 #endif /* __LINUX_USB_PD_H */
--=20
2.27.0.389.gc38d7665816-goog

