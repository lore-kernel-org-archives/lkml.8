Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD99C11D3D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC2420732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFWvr7kz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgBXX1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:27:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38875 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbgBXX1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:27:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id a9so1184883wmj.3;
        Mon, 24 Feb 2020 15:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=23TD4aokwkLA4YFL/RMSToVR/ZyFznaziCp8vM8V51U=;
        b=LFWvr7kzjAVeBtnezK13os3rubmVM//bzWCe/YZhk/nB1g+w3D3bnzUzu45G3UeqTZ
         65/jXVXYXxYaSlVVlZsWvgkdvzTQj51rUXSBJdzX4YHea4jZ5k9I9YSPG45yvpK7Orug
         6pUsDAolp43uT07L9SjIpflDX6SG9HkVRxCl+aWTS3ExQ2X1J+raRPiyyGO5RDIv4oxR
         xwW/673j3cXzLku45QdQXWMLf0dPBKJNviKrqkYGHqDKvf9eOemvuM4+m45Drsu1CDUt
         7EYfIt6u1+PR/mnY+iXYFVrfjYeLYnM95crd0TxrOzRi1zTvMecwIPiqjtth2eo3sj5Z
         bwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=23TD4aokwkLA4YFL/RMSToVR/ZyFznaziCp8vM8V51U=;
        b=VdqpDUzfL3VjADeJ9LZwRn+HhLqnvplLPkcGAKgaMS3g1JraEQfWRj+ntiTrjTgv+2
         o49bEFraN7VG/e2a5RtCTh1ZjWqrnZlgJRdhIubjBhY6ZBoAzo5kT43iibvW5n5QHgDw
         OApLrPN8u8WAKy/ii3Wc+o4FfZgtFruIMxpH2pTnJnQPTX5MFVRO/LjasLfC0WRb8QQh
         GmXedtNvWgGytHEa/7zbk6iVpBlLUz/gWXdcHEmTrHATECam8XpzqrB3EmkqMT5s6CZ7
         dMfAW5xlkr/3fKIMJFVelVF7zWCRA9PNlVc5NHblgGNfRsK8t5ie3Wuxl/SZ8cOIEWsA
         GYaw==
X-Gm-Message-State: APjAAAXHAJhWZk4KjSafMxI4qKmxAcFu8A9g7J1/VOMpmAZmAJbKbYHC
        bA372jSNo0YNkB6YfGzFD2s=
X-Google-Smtp-Source: APXvYqz39UvdMoJ4Twe4n+7DfqpGUdBg03hSNF+vDC/9/q8YLSO8JHEWd3T0uUjWaPGilVQyh+evog==
X-Received: by 2002:a1c:7205:: with SMTP id n5mr1390088wmc.9.1582586822341;
        Mon, 24 Feb 2020 15:27:02 -0800 (PST)
Received: from buildbot.home (217-149-167-12.nat.highway.telekom.at. [217.149.167.12])
        by smtp.googlemail.com with ESMTPSA id g25sm1971099wmh.3.2020.02.24.15.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 15:27:01 -0800 (PST)
From:   Franz Forstmayr <forstmayr.franz@gmail.com>
To:     forstmayr.franz@gmail.com
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 2/3] docs: hwmon: Add support for ina2xx
Date:   Tue, 25 Feb 2020 00:26:46 +0100
Message-Id: <20200224232647.29213-2-forstmayr.franz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224232647.29213-1-forstmayr.franz@gmail.com>
References: <20200224232647.29213-1-forstmayr.franz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for INA260, power/current monitor with I2C interface.

Signed-off-by: Franz Forstmayr <forstmayr.franz@gmail.com>
---
 Documentation/hwmon/ina2xx.rst | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/ina2xx.rst b/Documentation/hwmon/ina2xx.rst
index 94b9a260c518..74267dd433dd 100644
--- a/Documentation/hwmon/ina2xx.rst
+++ b/Documentation/hwmon/ina2xx.rst
@@ -53,6 +53,16 @@ Supported chips:
 
 	       http://www.ti.com/
 
+  * Texas Instruments INA260
+
+    Prefix: 'ina260'
+
+    Addresses: I2C 0x40 - 0x4f
+
+    Datasheet: Publicly available at the Texas Instruments website
+
+         http://www.ti.com/
+
 Author: Lothar Felten <lothar.felten@gmail.com>
 
 Description
@@ -72,14 +82,17 @@ INA230 and INA231 are high or low side current shunt and power monitors
 with an I2C interface. The chips monitor both a shunt voltage drop and
 bus supply voltage.
 
+INA260 is a high or low side current and power monitor with an integrated
+shunt and I2C interface.
+
 The shunt value in micro-ohms can be set via platform data or device tree at
 compile-time or via the shunt_resistor attribute in sysfs at run-time. Please
 refer to the Documentation/devicetree/bindings/hwmon/ina2xx.txt for bindings
 if the device tree is used.
 
-Additionally ina226 supports update_interval attribute as described in
-Documentation/hwmon/sysfs-interface.rst. Internally the interval is the sum of
-bus and shunt voltage conversion times multiplied by the averaging rate. We
+Additionally ina226 and ina260 supports update_interval attribute as described
+in Documentation/hwmon/sysfs-interface.rst. Internally the interval is the sum
+of bus and shunt voltage conversion times multiplied by the averaging rate. We
 don't touch the conversion times and only modify the number of averages. The
 lower limit of the update_interval is 2 ms, the upper limit is 2253 ms.
 The actual programmed interval may vary from the desired value.
-- 
2.17.1

