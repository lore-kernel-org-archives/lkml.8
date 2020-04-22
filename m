Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19A9C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C343720776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtPD3itZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgDVR1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726060AbgDVR1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:27:51 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDB6C03C1A9;
        Wed, 22 Apr 2020 10:27:51 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id d21so685898ook.10;
        Wed, 22 Apr 2020 10:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p7Df55Nm93D6znad/ezCzItS2C5Wj62A07HIVImwYiw=;
        b=EtPD3itZnd2KH80rGd++3dqLboGzkgs9XFd1y/eVIhlWpzn2S4Xmd2QPETqt3RwIet
         cVOul3tlkCRH/L0YhWVU2sovKc1GRma0GDGbyNydkJDvL8WxUDyOVTxEKBZagetwFKJS
         +IXHy9mSQCG6hTB/qZ5F79HYFHMhz7gXGt74yOpHZY5yqiUzjNm8VidkNiN3/a1uXv3O
         /G9j9LYCT3oS7iuwEj/sfe/3EbSrldTmBOAWDT7twdp88n0m0AUHmynuHj9fFEDhpVYn
         d1gKZ2Czdtp+WS4k7AH04DDG45SNgL1kBlbGWpvhk2HGkZeHStI/I9sJAll+7154bvUW
         5nVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p7Df55Nm93D6znad/ezCzItS2C5Wj62A07HIVImwYiw=;
        b=hjXduG1w0pEg5TvoHwLIHd3Z3rSqO/eZ90XD3sEzX6B+gFY5cS1qYqftC489poXW1X
         nwaVK2f9EwVlx/W4axVjgSgWQCpOZzRfhemP6PM3N6YDNnyEyzE9XCOWJ5KzYMndnKK5
         YnDR6qICbiXa9ffY//0x6T3iy6OWb33KM2QCj66RUt9GvdXd34YrFNJAwqXdL8FWw99A
         I/EToR7pdP1ec5uPzfM0gEvykSl1CWjKvAkCaYwjQUp0DdEe430juu9+eHK3E2C9I9Ju
         +V0QCcQ4lkR4j/R37SKxKnBa8Rz3tbDR0mvWznQc5+dHALKrwuAvL7PZ2oUvRAVaZy38
         1lLw==
X-Gm-Message-State: AGi0PuZZRxyoZZmWMxPoeE9uf75awgyhOWMUG4FcySo6p4nOVbI+kuY5
        DjXw1RsxOEwqG+lnGpbKBuA=
X-Google-Smtp-Source: APiQypLQ7f7BnTHlvfZhLbQUImuhHUNWrGq5ycTBCVOcj3wdWLzyrt7GuILKIlGM1MYOnDUnOu9Q6g==
X-Received: by 2002:a4a:9605:: with SMTP id q5mr22075604ooi.16.1587576470624;
        Wed, 22 Apr 2020 10:27:50 -0700 (PDT)
Received: from raspberrypi (99-189-78-97.lightspeed.austtx.sbcglobal.net. [99.189.78.97])
        by smtp.gmail.com with ESMTPSA id x4sm366432otp.74.2020.04.22.10.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 10:27:50 -0700 (PDT)
Date:   Wed, 22 Apr 2020 12:27:48 -0500
From:   Grant Peltier <grantpeltier93@gmail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     adam.vaughn.xh@renesas.com, grant.peltier.jg@renesas.com
Subject: [PATCH v2 2/2] docs: hwmon: Update driver documentation for debugfs
Message-ID: <32d05b2ebecd03cac7a704088c70a20e5a81d59f.1587572415.git.grantpeltier93@gmail.com>
References: <cover.1587572415.git.grantpeltier93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1587572415.git.grantpeltier93@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usage details for the two new debugfs endpoints for 2nd Gen devices:
read_black_box and write_config

Signed-off-by: Grant Peltier <grantpeltier93@gmail.com>
---
 Documentation/hwmon/isl68137.rst | 34 +++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/isl68137.rst b/Documentation/hwmon/isl68137.rst
index 0e71b22047f8..c5f7b2981db6 100644
--- a/Documentation/hwmon/isl68137.rst
+++ b/Documentation/hwmon/isl68137.rst
@@ -423,7 +423,8 @@ Beyond the normal sysfs pmbus attributes, the driver exposes a control attribute
 for the ISL68137.
 
 For 2nd generation Renesas digital multiphase voltage regulators, only the
-normal sysfs pmbus attributes are supported.
+normal sysfs pmbus attributes are supported. However, 2nd generation devices do
+have additional debugfs features which are detailed below.
 
 ISL68137 sysfs attributes
 -------------------------
@@ -603,3 +604,34 @@ temp[1-7]_crit_alarm	Chip temperature critical high alarm
 temp[1-7]_max		Maximum temperature
 temp[1-7]_max_alarm	Chip temperature high alarm
 ======================= ==========================================
+
+debugfs features (Gen 2 ONLY)
+-----------------------------
+
+If you have debugfs enabled, two file endpoints will be created under
+`/sys/kernel/debug/pmbus/<device-id>` when you instantiate a 2nd generation
+device: `read_black_box` and `write_config`.
+
+`read_black_box` is a read-only file. When read, the driver will attempt to read
+the contents of the device's fault recording RAM segment called "Black Box". The
+RAM segment is then printed to the file as hex formatted strings. For easier
+consumption, the 128-byte segment is broken up into 32 4-byte little-endian
+lines (i.e. each line starts with the least significant byte). See your device's
+datasheet for information regarding how to parse the data.
+
+.. warning::
+    When using `write_config`, only use hex files as they are exported from the
+    Renesas Power Navigator application:
+    https://www.renesas.com/us/en/products/power-management/digital-power/powernavigator.html
+
+`write_config` is a write-only file. This endpoint expects the contents of a
+configuration hex file specific to your device exactly as it is exported from
+the Renesas Power Navigator application. When this endpoint is written to, the
+driver will attempt to write the contents of the file down to one or more of the
+device's NVM slots and will return a standard error code if any part of the
+process fails. Be careful when using this feature as writing an unstable
+configuration to your device may may cause it to misbehave. Each device also has
+a fixed number of NVM writes allowed. Consult the datasheet for your device for
+more information about NVM configuration options. Finally, note that you will
+have to power cycle your device in order for NVM configuration changes to take
+effect.
-- 
2.20.1

