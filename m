Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF88C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75AB62098B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NcyR/6nO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgIADAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgIAC7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:59:43 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AE3C06136D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:59:43 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id y7so6800620qvj.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YmypCvt0GTO9TngCUZyl18kzUPGJakzF+npVltizd4g=;
        b=NcyR/6nOOprsALH1y/XOZ+6IsHBhRUr5VnnI7M1QWjQ0hCt8qAPY8Ww005y8GeLFqZ
         xI50vV/SaK3yrKWUoh6Qnok2Nzbddaq4OoBdWQD1kYy1d5hgiST+wTFls5GkmBanLL+K
         MwaCNi/MozQCxAw2c3/KwcCt727T/RWybnwaMEO8zAqVD1zP/1cFX9FFtLIzCnRrlYur
         0FQf/S7rwT6W/3cETt3prTWU35AiJFUwGWHFpTfPznsNigw4KzHGoMa+4ZkyWx+5Rk9i
         cWniGf0MdgvgKrGU4zCCGcL2JHGLK/m8wA6OUhAqxfaQ1pI3Grs51kBeQVFd4+2ue2rh
         2A9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YmypCvt0GTO9TngCUZyl18kzUPGJakzF+npVltizd4g=;
        b=hfWEk3wDSFshlw0KN4+O4tpbUSNgl4tPHnjulhUA9XrrZqcayV9ZnH99DvzwxpJQ5Q
         ZC5dGn71P/su9NBuhsXqqbVqy9UvtejUzLl2fpc1uaN5ArHFT8nmPcIePW+ICVhyQyHg
         SVJ8wCpWS6/hyhMddrjjGwzLIEGQL1FBcBjHTdKz37zV3JqkfP1H/5wKMJwNTFrqE2I2
         8ijAX2FwTe+Wzz/lZnedtdak97AbmOc4XcMEAjJY9MMquvIakysJh2VOZ/h1cFHI9V/t
         M7+TMg2oqzX6x5aZM7ymxbXrdwHyhcCy3anQJOmMCJbAq5jd17ECxpczKtfF/GKxZ5Tr
         +64A==
X-Gm-Message-State: AOAM531ZYTriM6z23QLcceyWvHz4F/yRwZ8fbFfY03taeEWkMxobVYV0
        koAQL9keHcsQ+Y5wZmIfQrjIe4qPsaA=
X-Google-Smtp-Source: ABdhPJzMEAVY2Ge8dAOHg87wIFAYI34/CLnRne8aY7Zc3SAwXmi3XvqtyPzwSrw5aV+Y2m3kL5UN4SR/VF8=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a0c:b626:: with SMTP id f38mr1400471qve.0.1598929182318;
 Mon, 31 Aug 2020 19:59:42 -0700 (PDT)
Date:   Mon, 31 Aug 2020 19:59:19 -0700
In-Reply-To: <20200901025927.3596190-1-badhri@google.com>
Message-Id: <20200901025927.3596190-7-badhri@google.com>
Mime-Version: 1.0
References: <20200901025927.3596190-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v6 06/14] dt-bindings: usb: Maxim type-c controller device
 tree binding document
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

Add device tree binding document for Maxim TCPCI based Type-C chip driver

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since v1:
- Changing patch version to v6 to fix version number confusion.
---
 .../devicetree/bindings/usb/maxim,tcpci.txt   | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/maxim,tcpci.txt

diff --git a/Documentation/devicetree/bindings/usb/maxim,tcpci.txt b/Documentation/devicetree/bindings/usb/maxim,tcpci.txt
new file mode 100644
index 000000000000..8a5b08e57b2d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/maxim,tcpci.txt
@@ -0,0 +1,44 @@
+Maxim TCPCI Type-C PD controller:
+---------------------------------
+
+Required properties:
+- compatible:       should be set maxim,tcpci:
+
+- reg:              0x25:the i2c slave address of typec port controller device.
+- interrupt-parent: the phandle to the interrupt controller which provides
+                    the interrupt.
+- usbpd,usbpd_int:  interrupt specification for tcpci alert.
+
+Required sub-node:
+- connector: The "usb-c-connector" attached to the tcpci chip, the bindings
+  of connector node are specified in
+  Documentation/devicetree/bindings/connector/usb-connector.txt
+
+maxtcpc: maxtcpc@25 {
+	status = "okay";
+	compatible = "maxim,tcpc";
+	reg = <0x25>;
+	interrupt-parent = <&gpa8>;
+	usbpd,usbpd_int = <&gpa8 2 GPIO_ACTIVE_LOW>;
+
+	connector {
+		compatible = "usb-c-connector";
+		label = "USB-C";
+		data-role = "dual";
+		power-role = "dual";
+		try-power-role = "sink";
+		self-powered;
+		op-sink-microwatt = <2600000>;
+		source-pdos = <PDO_FIXED(5000, 900,
+					 PDO_FIXED_SUSPEND |
+					 PDO_FIXED_USB_COMM |
+					 PDO_FIXED_DATA_SWAP |
+					 PDO_FIXED_DUAL_ROLE)>;
+		sink-pdos = <PDO_FIXED(5000, 3000,
+				       PDO_FIXED_USB_COMM |
+				       PDO_FIXED_DATA_SWAP |
+				       PDO_FIXED_DUAL_ROLE)
+				       PDO_FIXED(9000, 2000, 0)
+		frs-typec-current = <FRS_5V_1P5A>;
+	};
+};
-- 
2.28.0.402.g5ffc5be6b7-goog

