Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E483C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4292072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jkhAZg0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgHYEW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgHYEW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:22:26 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80DFC061755
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:22:26 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mu14so897838pjb.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JEUp//OgrqIdq4oBTWKdSUH95jBvEG8vdsM1vuPs8Tc=;
        b=jkhAZg0iMscEcFm/RUujA72vXdC5gOQalIMPfd5KOkCgy0trvRgRNN31LwH8axbb7i
         xOLx4FM+xYzv2EGDoGafREwUQoWb2M+/oQkPRZlswGJnaPNb8tdZwjkBj1fnwNhV576/
         R0y80iV4KLLDO566lEoAvw6xLv1BQdZffvioxrcRTOZVQMglHb96tE6o9Xjskbs7rhkf
         ApskSMLxthNLqOY1aRI+2ijCMAJLe5FnQYOcxBmE0yrHJfckDTTYByGE5JXdgtLrQw3I
         nUpd3w8XVA8y4JfSuoVObQcUCdk71hZLCS2c00zANEgCy3TZ0y47FfmqCp4xPp8G1mQo
         iu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JEUp//OgrqIdq4oBTWKdSUH95jBvEG8vdsM1vuPs8Tc=;
        b=V1Jlc54CVYdMFSarp4UCNkXjumNv9VP4BMnyPDwypO2mLPm6t/S22TMzc2JpZCADQU
         qqR80z7jL+wbqCsCRUopQi4qTVFz1gzIZXUmd2pczMuss1xSb28mkA0j+MrK4cvxh5gk
         7gYxug8hwSDwXlvi7L1IVPgeRBN79ltlC9+s7KkbkwLWTY+kFZv5r+I0faoya26+k0IQ
         6AcPA0oPJxHfuN0uFln4BvNxFL6UU18ZeNfGwhxeecOnrOQcOGmZBtKDbRYukESRvk7j
         rdCy2BJtB9iA17Hl8Vmky76cbhJ/pzvwFw+pZOrKaK8vedTgwXdcbjY/fbKGlXCY/VhH
         1cPQ==
X-Gm-Message-State: AOAM530p+cjKWD6oc/JNXNhOuwIrJ/OA/IRmi/D4mgJvC6d7lCVP/MjN
        fcWXmugB1fTMs+cmXNZAcqO2nHb+pxk=
X-Google-Smtp-Source: ABdhPJyqxUn6kmdMRMpi7HMnXOCyU5kHwFBq5l3bMwOsEy7jvpoqAEAyF30GuaZPav1y862SjZOY2YhBsHQ=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a17:90a:bd8a:: with SMTP id
 z10mr72361pjr.12.1598329345209; Mon, 24 Aug 2020 21:22:25 -0700 (PDT)
Date:   Mon, 24 Aug 2020 21:21:57 -0700
In-Reply-To: <20200825042210.300632-1-badhri@google.com>
Message-Id: <20200825042210.300632-2-badhri@google.com>
Mime-Version: 1.0
References: <20200825042210.300632-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 01/14 v1] usb: typec: tcpci: Add register definitions to tcpci
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

Add register definitions to trap extended alerts.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpci.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index 11c36d086c86..fd26ca35814c 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -16,6 +16,7 @@
 #define TCPC_PD_INT_REV			0xa
 
 #define TCPC_ALERT			0x10
+#define TCPC_ALERT_EXTENDED_STATUS	BIT(13)
 #define TCPC_ALERT_VBUS_DISCNCT		BIT(11)
 #define TCPC_ALERT_RX_BUF_OVF		BIT(10)
 #define TCPC_ALERT_FAULT		BIT(9)
@@ -32,6 +33,10 @@
 #define TCPC_ALERT_MASK			0x12
 #define TCPC_POWER_STATUS_MASK		0x14
 #define TCPC_FAULT_STATUS_MASK		0x15
+
+#define TCPC_EXTENDED_STATUS_MASK		0x16
+#define TCPC_EXTENDED_STATUS_MASK_VSAFE0V	BIT(0)
+
 #define TCPC_CONFIG_STD_OUTPUT		0x18
 
 #define TCPC_TCPC_CTRL			0x19
-- 
2.28.0.297.g1956fa8f8d-goog

