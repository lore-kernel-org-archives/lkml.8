Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7B7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFEC920706
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="otsFRC0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgHRMsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgHRMsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:48:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C8DC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 05:48:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u10so9162698plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 05:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KWn2a6wUAxzQeIq4NFtMTmknoSynjzag0OTUIJgkTrQ=;
        b=otsFRC0ABvWrlCGVgbkn9AaB6eQqJdQr0Dv4EK9tpT01AHWE46YGh7x1KddBxFs0f6
         SK2nqnnWcoMWb7zkwAfsdLcVpSG6nSWyk3vs944Z8F77eUlVXE9rMXXv5aSg6P4Lvz1F
         dFN/Iw4Vkuccl9lSTMRKINovJlpF/F+Sww9sGbioCTtv58gR+215IfZfoG8O3dS8GRhe
         va7+Xz3pjCkKlIKeDr8t8nGTqb7L4iHdCBDsLXxDiG6VeU9nt+ZQ3xS1tOHJ6azWP89I
         bLFvELJHx1p2MyT38nE/2cL9SwJJEFT5A6S/PvJMq5Ad1I4awyvIRtQ1I6ZNCZwa0lVB
         Fspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KWn2a6wUAxzQeIq4NFtMTmknoSynjzag0OTUIJgkTrQ=;
        b=moFu7s7tFufHuXFj5CU2ZovX6NuKAvhlhrVDkC+7FztXjk9eDUWkcj/So5ipd+ct4j
         OUvwAAuJ8IlvML6zOq+/sFy26Vssem1bRD3bsPLKfM+odj9lwPlOBEGj7EJOU5ZrMl/9
         VKUnDCV3V0tssy9v1doHmKQ4JZMJTp1yUQbdv2ZI3DbdK520YuoNeZ2wASlmelsahuVQ
         5uaEhWRqBot8cUZ1DdEPXLDIV8JzrqkzVuiBMkxB17ikELcA0O32+xUbhB7gKg2sjGpV
         6G92d/hy1U3dl9Pg0fCoL1okQPde/MMo2pVKVqGkLE82/dSnaNy/s+mEleivn+QR+lM/
         q0Fw==
X-Gm-Message-State: AOAM530PSEEPFiZXKMRQ/bHmvk4bimvlD++2FTi6WC03S8MVGrqpsFJ5
        /UeGmBMEni6aYXN0VZ74LCxU
X-Google-Smtp-Source: ABdhPJyc6T610ljbDUn5debOLMdl/xg0cxa0srsGVrN6G+hkcmuzstJu3MMzepgUzsxucaHrl+fJ7A==
X-Received: by 2002:a17:902:264:: with SMTP id 91mr15477464plc.88.1597754923210;
        Tue, 18 Aug 2020 05:48:43 -0700 (PDT)
Received: from localhost.localdomain ([116.68.79.111])
        by smtp.gmail.com with ESMTPSA id e4sm24264221pfd.204.2020.08.18.05.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 05:48:42 -0700 (PDT)
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, johan@kernel.org,
        elder@kernel.org
Cc:     Vaishnav M A <vaishnav@beagleboard.org>, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com,
        chrisfriedt@gmail.com, zoran.stojsavljevic@gmail.com
Subject: [RFC PATCH v2 1/3] add mikrobus descriptors to greybus_manifest
Date:   Tue, 18 Aug 2020 18:18:13 +0530
Message-Id: <20200818124815.11029-2-vaishnav@beagleboard.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200818124815.11029-1-vaishnav@beagleboard.org>
References: <20200818124815.11029-1-vaishnav@beagleboard.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new descriptors used in the manifest parsing inside
the mikrobus driver, the device descriptor help to describe the
devices on a mikroBUS port, mikrobus descriptor is used to set up
the mikrobus port pinmux and GPIO states and property descriptor
to pass named properties to device drivers through the Unified
Properties API under linux/property.h

The corresponding pull request for manifesto is updated
at : https://github.com/projectara/manifesto/pull/2

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
 include/linux/greybus/greybus_manifest.h | 47 ++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/include/linux/greybus/greybus_manifest.h b/include/linux/greybus/greybus_manifest.h
index 6e62fe478712..821661ea7f01 100644
--- a/include/linux/greybus/greybus_manifest.h
+++ b/include/linux/greybus/greybus_manifest.h
@@ -23,6 +23,9 @@ enum greybus_descriptor_type {
 	GREYBUS_TYPE_STRING		= 0x02,
 	GREYBUS_TYPE_BUNDLE		= 0x03,
 	GREYBUS_TYPE_CPORT		= 0x04,
+	GREYBUS_TYPE_MIKROBUS		= 0x05,
+	GREYBUS_TYPE_PROPERTY		= 0x06,
+	GREYBUS_TYPE_DEVICE		= 0x07,
 };
 
 enum greybus_protocol {
@@ -151,6 +154,47 @@ struct greybus_descriptor_cport {
 	__u8	protocol_id;	/* enum greybus_protocol */
 } __packed;
 
+/*
+ * A mikrobus descriptor is used to describe the details
+ * about the bus ocnfiguration for the add-on board
+ * connected to the mikrobus port.
+ */
+struct greybus_descriptor_mikrobus {
+	__u8 pin_state[12];
+} __packed;
+
+/*
+ * A property descriptor is used to pass named properties
+ * to device drivers through the unified device properties
+ * interface under linux/property.h
+ */
+struct greybus_descriptor_property {
+	__u8 length;
+	__u8 id;
+	__u8 propname_stringid;
+	__u8 type;
+	__u8 value[0];
+} __packed;
+
+/*
+ * A device descriptor is used to describe the
+ * details required by a add-on board device
+ * driver.
+ */
+struct greybus_descriptor_device {
+	__u8 id;
+	__u8 driver_stringid;
+	__u8 protocol;
+	__u8 reg;
+	__le32 max_speed_hz;
+	__u8 irq;
+	__u8 irq_type;
+	__u8 mode;
+	__u8 prop_link;
+	__u8 gpio_link;
+	__u8 pad[3];
+} __packed;
+
 struct greybus_descriptor_header {
 	__le16	size;
 	__u8	type;		/* enum greybus_descriptor_type */
@@ -164,6 +208,9 @@ struct greybus_descriptor {
 		struct greybus_descriptor_interface	interface;
 		struct greybus_descriptor_bundle	bundle;
 		struct greybus_descriptor_cport		cport;
+		struct greybus_descriptor_mikrobus	mikrobus;
+		struct greybus_descriptor_property	property;
+		struct greybus_descriptor_device	device;
 	};
 } __packed;
 
-- 
2.25.1

