Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DFEC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4A220724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azdFh3uC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgCSPuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:50:23 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37293 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgCSPuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:50:23 -0400
Received: by mail-oi1-f194.google.com with SMTP id w13so3175881oih.4;
        Thu, 19 Mar 2020 08:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SsY4+F5GJ4EvVNWkxXVl7mfH/MboxKRMJRKZw22fCwo=;
        b=azdFh3uCkn0JbXNNN3+6JCxQI7PFpbutSU7b1Nq16cYd/7MJ3wfz6xYJ4Fgw6E14/E
         i7WHkfBR94E3TN38yGloyPjWz4puJKAQo6N9fAjJGS24Ue886ZIuWmRcLBBKyIIJTiFo
         MgBuwyi9GVQWHQ3Ip2Ahbu2SVi6w3W7xhewDC/3VJ9DiVjMdueuAkwkYulXV1YNdQOuW
         6F9KI8XMkqgl3f4/PVPCuV9COM3jsy6YHdFUta2L06D6g4PJo5KHWVWHnMBDeBzp+ndw
         K1h8MzMhfp3e4f+zHcunQ4VgbfbmlCHQUCj4YzJUbgf3Z/lCCLzJYwzW9ek0gn/Cbqe0
         Tp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SsY4+F5GJ4EvVNWkxXVl7mfH/MboxKRMJRKZw22fCwo=;
        b=TS3Qb5nNJVwF1jV9t7XxD4L6Sun8wxulyKU84qApSge04fIKYFaVpB1m+QBFRVpdJv
         1OA9IZfwMtkNX4zGwhhrwu/ozbtfwt5Cz3VHHbxRq1jgAiTYqna0zs1cn9ubWbZK3GJJ
         Io0LbYrDH38GLuINC1ik7VVtUuZou0r3dnnH7wdxiOJYt9ylVP3DymB7bcLSqTOrXplL
         5I2xwwNJ1NPCuREEtJZmO9kjW0rEddnHUXZuMo5DSvIMq/jtgr1EC4QfOvhdYDTOmrD7
         uLCQOZ9jUffGY6xJAOoyFuYsVzQC1ZJPi3IlQm4RMHMO+gBxFyx2OwaVWLfw89mBMnOD
         dO9Q==
X-Gm-Message-State: ANhLgQ20qRe5AdTWpiymWx7O0S1i9KHaHB0pvhncL1MsjPQheEICzKHC
        EbTFoWLIn2jEKbFjjjUCdoYH1lhz
X-Google-Smtp-Source: ADFU+vtOjASVvBtdbViJtKKmcM5EKpu00DfrJ31wkBCgHmSA9r9b5HxYYaH5kRGa2tJmoz5zxrk2Uw==
X-Received: by 2002:aca:bfc2:: with SMTP id p185mr2958159oif.57.1584633020346;
        Thu, 19 Mar 2020 08:50:20 -0700 (PDT)
Received: from raspberrypi (99-189-78-97.lightspeed.austtx.sbcglobal.net. [99.189.78.97])
        by smtp.gmail.com with ESMTPSA id d3sm938287oib.15.2020.03.19.08.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 08:50:19 -0700 (PDT)
Date:   Thu, 19 Mar 2020 10:50:18 -0500
From:   Grant Peltier <grantpeltier93@gmail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     adam.vaughn.xh@renesas.com
Subject: [PATCH v2 2/2] docs: hwmon: Update documentation for isl68137 pmbus
 driver
Message-ID: <619d5d430b80fbf33a7e19e9910a0cf049203f59.1584568073.git.grantpeltier93@gmail.com>
References: <cover.1584568073.git.grantpeltier93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584568073.git.grantpeltier93@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation to include reference information for newly
supported 2nd generation Renesas digital multiphase voltage regulators.
Also update branding from Intersil to Renesas.

Signed-off-by: Grant Peltier <grantpeltier93@gmail.com>
---
 Documentation/hwmon/isl68137.rst | 541 ++++++++++++++++++++++++++++++-
 1 file changed, 533 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/isl68137.rst b/Documentation/hwmon/isl68137.rst
index a5a7c8545c9e..787b89a889dd 100644
--- a/Documentation/hwmon/isl68137.rst
+++ b/Documentation/hwmon/isl68137.rst
@@ -3,7 +3,7 @@ Kernel driver isl68137
 
 Supported chips:
 
-  * Intersil ISL68137
+  * Renesas ISL68137
 
     Prefix: 'isl68137'
 
@@ -11,19 +11,405 @@ Supported chips:
 
     Datasheet:
 
-      Publicly available at the Intersil website
-      https://www.intersil.com/content/dam/Intersil/documents/isl6/isl68137.pdf
+      Publicly available at the Renesas website
+      https://www.renesas.com/us/en/www/doc/datasheet/isl68137.pdf
+
+  * Renesas ISL68220
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL68221
+
+    Prefix: 'raa_dmpvr2_3rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL68222
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL68223
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL68224
+
+    Prefix: 'raa_dmpvr2_3rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL68225
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL68226
+
+    Prefix: 'raa_dmpvr2_3rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL68227
+
+    Prefix: 'raa_dmpvr2_1rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL68229
+
+    Prefix: 'raa_dmpvr2_3rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL68233
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL68239
+
+    Prefix: 'raa_dmpvr2_3rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69222
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69223
+
+    Prefix: 'raa_dmpvr2_3rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69224
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69225
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69227
+
+    Prefix: 'raa_dmpvr2_3rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69228
+
+    Prefix: 'raa_dmpvr2_3rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69234
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69236
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69239
+
+    Prefix: 'raa_dmpvr2_3rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69242
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69243
+
+    Prefix: 'raa_dmpvr2_1rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69247
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69248
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69254
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69255
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69256
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69259
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69260
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69268
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69269
+
+    Prefix: 'raa_dmpvr2_3rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas ISL69298
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas RAA228000
+
+    Prefix: 'raa_dmpvr2_hv'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas RAA228004
+
+    Prefix: 'raa_dmpvr2_hv'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas RAA228006
+
+    Prefix: 'raa_dmpvr2_hv'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas RAA228228
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas RAA229001
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
+
+  * Renesas RAA229004
+
+    Prefix: 'raa_dmpvr2_2rail'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Publicly available (after August 2020 launch) at the Renesas website
 
 Authors:
       - Maxim Sloyko <maxims@google.com>
       - Robert Lippert <rlippert@google.com>
       - Patrick Venture <venture@google.com>
+      - Grant Peltier <grant.peltier.jg@renesas.com>
 
 Description
 -----------
 
-Intersil ISL68137 is a digital output 7-phase configurable PWM
-controller with an AVSBus interface.
+This driver supports the Renesas ISL68137 and all 2nd generation Renesas
+digital multiphase voltage regulators (raa_dmpvr2). The ISL68137 is a digital
+output 7-phase configurable PWM controller with an AVSBus interface. 2nd
+generation devices are grouped into 4 distinct configurations: '1rail' for
+single-rail devices, '2rail' for dual-rail devices, '3rail' for 3-rail devices,
+and 'hv' for high voltage single-rail devices. Consult the individual datasheets
+for more information.
 
 Usage Notes
 -----------
@@ -33,10 +419,14 @@ devices explicitly.
 
 The ISL68137 AVS operation mode must be enabled/disabled at runtime.
 
-Beyond the normal sysfs pmbus attributes, the driver exposes a control attribute.
+Beyond the normal sysfs pmbus attributes, the driver exposes a control attribute
+for the ISL68137.
+
+For 2nd generation Renesas digital multiphase voltage regulators, only the
+normal sysfs pmbus attributes are supported.
 
-Additional Sysfs attributes
----------------------------
+ISL68137 sysfs attributes
+-------------------------
 
 ======================= ====================================
 avs(0|1)_enable		Controls the AVS state of each rail.
@@ -78,3 +468,138 @@ temp[1-3]_crit_alarm	Chip temperature critical high alarm
 temp[1-3]_max		Maximum temperature
 temp[1-3]_max_alarm	Chip temperature high alarm
 ======================= ====================================
+
+raa_dmpvr2_1rail/hv sysfs attributes
+------------------------------------
+
+======================= ====================================
+curr1_label		"iin"
+curr1_input		Measured input current
+curr1_crit		Critical maximum current
+curr1_crit_alarm	Current critical high alarm
+
+curr2_label		"iout"
+curr2_input		Measured output current
+curr2_crit		Critical maximum current
+curr2_crit_alarm	Current critical high alarm
+
+in1_label		"vin"
+in1_input		Measured input voltage
+in1_lcrit		Critical minimum input voltage
+in1_lcrit_alarm		Input voltage critical low alarm
+in1_crit		Critical maximum input voltage
+in1_crit_alarm		Input voltage critical high alarm
+
+in2_label		"vmon"
+in2_input		Scaled VMON voltage read from the VMON pin
+
+in3_label		"vout"
+in3_input		Measured output voltage
+in3_lcrit		Critical minimum output voltage
+in3_lcrit_alarm	Output voltage critical low alarm
+in3_crit		Critical maximum output voltage
+in3_crit_alarm	Output voltage critical high alarm
+
+power1_label		"pin"
+power1_input		Measured input power
+power1_alarm		Input power high alarm
+
+power2_label	"pout"
+power2_input	Measured output power
+
+temp[1-3]_input		Measured temperature
+temp[1-3]_crit		Critical high temperature
+temp[1-3]_crit_alarm	Chip temperature critical high alarm
+temp[1-3]_max		Maximum temperature
+temp[1-3]_max_alarm	Chip temperature high alarm
+======================= ====================================
+
+raa_dmpvr2_2rail sysfs attributes
+---------------------------------
+
+======================= ====================================
+curr[1-2]_label		"iin[1-2]"
+curr[1-2]_input		Measured input current
+curr[1-2]_crit		Critical maximum current
+curr[1-2]_crit_alarm	Current critical high alarm
+
+curr[3-4]_label		"iout[1-2]"
+curr[3-4]_input		Measured output current
+curr[3-4]_crit		Critical maximum current
+curr[3-4]_crit_alarm	Current critical high alarm
+
+in1_label		"vin"
+in1_input		Measured input voltage
+in1_lcrit		Critical minimum input voltage
+in1_lcrit_alarm		Input voltage critical low alarm
+in1_crit		Critical maximum input voltage
+in1_crit_alarm		Input voltage critical high alarm
+
+in2_label		"vmon"
+in2_input		Scaled VMON voltage read from the VMON pin
+
+in[3-4]_label		"vout[1-2]"
+in[3-4]_input		Measured output voltage
+in[3-4]_lcrit		Critical minimum output voltage
+in[3-4]_lcrit_alarm	Output voltage critical low alarm
+in[3-4]_crit		Critical maximum output voltage
+in[3-4]_crit_alarm	Output voltage critical high alarm
+
+power[1-2]_label		"pin[1-2]"
+power[1-2]_input		Measured input power
+power[1-2]_alarm		Input power high alarm
+
+power[3-4]_label	"pout[1-2]"
+power[3-4]_input	Measured output power
+
+temp[1-5]_input		Measured temperature
+temp[1-5]_crit		Critical high temperature
+temp[1-5]_crit_alarm	Chip temperature critical high alarm
+temp[1-5]_max		Maximum temperature
+temp[1-5]_max_alarm	Chip temperature high alarm
+======================= ====================================
+
+raa_dmpvr2_3rail sysfs attributes
+---------------------------------
+
+======================= ====================================
+curr[1-3]_label		"iin[1-3]"
+curr[1-3]_input		Measured input current
+curr[1-3]_crit		Critical maximum current
+curr[1-3]_crit_alarm	Current critical high alarm
+
+curr[4-6]_label		"iout[1-3]"
+curr[4-6]_input		Measured output current
+curr[4-6]_crit		Critical maximum current
+curr[4-6]_crit_alarm	Current critical high alarm
+
+in1_label		"vin"
+in1_input		Measured input voltage
+in1_lcrit		Critical minimum input voltage
+in1_lcrit_alarm		Input voltage critical low alarm
+in1_crit		Critical maximum input voltage
+in1_crit_alarm		Input voltage critical high alarm
+
+in2_label		"vmon"
+in2_input		Scaled VMON voltage read from the VMON pin
+
+in[3-5]_label		"vout[1-3]"
+in[3-5]_input		Measured output voltage
+in[3-5]_lcrit		Critical minimum output voltage
+in[3-5]_lcrit_alarm	Output voltage critical low alarm
+in[3-5]_crit		Critical maximum output voltage
+in[3-5]_crit_alarm	Output voltage critical high alarm
+
+power[1-3]_label		"pin[1-3]"
+power[1-3]_input		Measured input power
+power[1-3]_alarm		Input power high alarm
+
+power[4-6]_label	"pout[1-3]"
+power[4-6]_input	Measured output power
+
+temp[1-7]_input		Measured temperature
+temp[1-7]_crit		Critical high temperature
+temp[1-7]_crit_alarm	Chip temperature critical high alarm
+temp[1-7]_max		Maximum temperature
+temp[1-7]_max_alarm	Chip temperature high alarm
+======================= ====================================
-- 
2.20.1

