Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0CCC54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8D420672
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ0kP2h5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgDTTES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725896AbgDTTES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:04:18 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332D4C061A0C;
        Mon, 20 Apr 2020 12:04:18 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k9so9794588oia.8;
        Mon, 20 Apr 2020 12:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p7Df55Nm93D6znad/ezCzItS2C5Wj62A07HIVImwYiw=;
        b=dZ0kP2h5rvu6VkHf6jQdeqlecfClWNhanlZhMmHQ8J4giOrNGCwyjyknuQIrOOFi5Z
         D4C4kwla6NIOEAmFn5E+ePE3JgLhpLk51IDcxx2VkAP3uQi5XKbJuA+C4/BEm8WiKjyr
         8klVyfuqJOSeO4W51nVsco8Q+jTttHk0g56KKA0dwf+hhoXFpcnG+tiO84nT205SUnBi
         42e+kmfPUBvCiYCBFbZ5LHZojnHjXSnGJGeFoW0uVGVEbb542FdqzlktKzIG2EelnuOW
         4L5VACp2VIkJtpDpn1LDEv8qRC1BEKpJXGLNVBqhb+sUxkxDtqmdZOjwG/0Kcd+Btp0Y
         hv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p7Df55Nm93D6znad/ezCzItS2C5Wj62A07HIVImwYiw=;
        b=mE9AnsQOk9EJZBSJN1PTJ6kbhsxXDeJ2KiOJB21bzR2vGU2Mif52i/9lLOVWEjlzmU
         dAG5RYKwPO3InV6bpbA4oVhhq1YZvTNYLqbBbcnFLY60CjERYN3YFqHXAbLyOtlMWDQ/
         XGFhK8AxhPAwUB+zfRpnBD4pn9x1vPe9ha5WD6XKA2OnXnvE65tGFgxBRQbVipbwD8wR
         l+yMPNlVExtk2tgzjykQuIwcmkG9bOetwfmDxiRxWB2qnH3jAVg0D6ifaakl7vGnWto8
         ZDqKVV7KNze+K19O54NRIjlefNGutKvwJZTC7VyFOG7mfcts90p3sB52XXuSdtJok3IC
         +kcw==
X-Gm-Message-State: AGi0PuZ3Ee63homxE1pw5Iir0+n4GK+VbGGdxdorBT7WFCGyeshOX0Ew
        OyzMokNylGrJV4NsV5+eARDfUWZPKvbQ4g==
X-Google-Smtp-Source: APiQypJx9Iv6LcOVa/nQidWSmEECnNjxBW9OpcCfvyjJPibOPCgsxOKe/T32OXebghVyWc9p98y0jg==
X-Received: by 2002:aca:7286:: with SMTP id p128mr671468oic.158.1587409457328;
        Mon, 20 Apr 2020 12:04:17 -0700 (PDT)
Received: from raspberrypi (99-189-78-97.lightspeed.austtx.sbcglobal.net. [99.189.78.97])
        by smtp.gmail.com with ESMTPSA id t9sm64739oie.24.2020.04.20.12.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:04:16 -0700 (PDT)
Date:   Mon, 20 Apr 2020 14:04:15 -0500
From:   Grant Peltier <grantpeltier93@gmail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     adam.vaughn.xh@renesas.com, grant.peltier.jg@renesas.com
Subject: [PATCH 2/2] docs: hwmon: Update driver documentation for debugfs
Message-ID: <e3c47c1877d2f94351b020a4ce1309390075e88f.1587408025.git.grantpeltier93@gmail.com>
References: <cover.1587408025.git.grantpeltier93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1587408025.git.grantpeltier93@gmail.com>
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

