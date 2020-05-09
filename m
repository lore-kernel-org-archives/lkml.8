Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01F7C47255
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 967D4208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLAMveMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgEIX7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726026AbgEIX7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:59:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1563FC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 16:59:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id m24so4349531wml.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 16:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gMjyelcUa17ZXRQz6po6soqnBpCw2RIYhupLPe5/7JU=;
        b=CLAMveMs5NlP/U7wz73IdH7vxu6ws1yutQA600ESxJ60zqW3IYyNwqGoqFZGoyGC3x
         ftNhHgBJhEKW/i96AcRnw/OSCjrKZAwSGVhvTzgDHo+C2VXQznwFNv+RhGwbDRnMv0i9
         ARGNE6UDjJ9m02AajB5duVsev3hToxuJECAXqE95Nax4eWvqDwAoHPgmr5qA51I9bFC+
         KeB4UKBc51P7g3msSh5bdBJf9rgflmT8y8iwpNrS69RcWoyLP2LVysepERpJY5QI3KDw
         m22y9P5vxvjkE/hzcmWxAXCvHW2bEnpIrz+PlcRKGMpZuknus+YjiZjnof69qqlkYkry
         uoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gMjyelcUa17ZXRQz6po6soqnBpCw2RIYhupLPe5/7JU=;
        b=PBCMHOp6irwPWE5zLwtCV18o7THMCgAvJzf7I2WYT+324S5T7BHgiI+Rkrmmdlr24n
         R8OFDwu4+3B8jwZyKWRbJMcPXnHTHjSlEaxnepCKyG7KxcISTK2JBYaPp6/u9NA8OKnM
         eUKiJ9clrGh0r0LskQhkg793O38eJzwe1Ba6zI/JTPv8EmxK5KPNsfgS+QgHVTVTQBTq
         UinxtNtYyCUJV2qblkAbkP7eCTfK3pY7hG+kasAVFVC14nuj+wSkBBADNou9i/0HHBNN
         P8fP1LoSzObtZZjhyeSlhuCzmWxd+s/wtTGeiDZIYlrWtjwBIfeFSLGDmQG/PkC3yOOx
         tRJQ==
X-Gm-Message-State: AGi0PuZrSjiD59zXQlQaQM2YpVPjkJol05Ykvlx9Zg8nzv/J5H2lKzOM
        iqlq8NCoj1i16G1/dXEjTUU=
X-Google-Smtp-Source: APiQypKa78vDcYoTow3w+9u1z4Yl892btyK0kiJ7dqXbzhcBVRRw4Y8ffNgeurEhOiyeBxHhw4aCAg==
X-Received: by 2002:a7b:c8d4:: with SMTP id f20mr1733677wml.72.1589068760847;
        Sat, 09 May 2020 16:59:20 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:48ff:3af:e1d8:fd19])
        by smtp.googlemail.com with ESMTPSA id a67sm21070365wmc.30.2020.05.09.16.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 16:59:20 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v5 3/9] w1_therm: adding sysfs-driver-w1_therm doc
Date:   Sun, 10 May 2020 01:59:07 +0200
Message-Id: <20200509235907.423444-1-akira215corp@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a sysfs-driver-w1_therm documentation file in
Documentation/ABI/testing. It describe the onlys sysfs entry of w1_therm
module, based on Documentation/w1/slaves/w1_therm.rst

Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
---
Changes in v5:
- All patch serie in one .c file
- Correcting some comments
- adding <linux/string.h> include

 Documentation/ABI/testing/sysfs-driver-w1_therm | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-w1_therm

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
new file mode 100644
index 0000000..4a85663
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -0,0 +1,17 @@
+What:		/sys/bus/w1/devices/.../w1_slave
+Date:		May 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(RW) return the temperature in 1/1000 degC.
+		*read*: return 2 lines with the hexa output data sent on the
+		bus, return the CRC check and temperature in 1/1000 degC
+		*write* :
+			* '0' : save the 2 or 3 bytes to the device EEPROM
+			(i.e. TH, TL and config register)
+			* '9..12' : set the device resolution in RAM
+			(if supported)
+			* Anything else: do nothing
+		refer to Documentation/w1/slaves/w1_therm.rst for detailed
+		information.
+Users:		any user space application which wants to communicate with
+		w1_term device
\ No newline at end of file
-- 
2.26.2

