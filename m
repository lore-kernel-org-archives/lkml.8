Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC35C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA3ED208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NB1Dzy95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgD2XAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726164AbgD2XAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 19:00:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0A1C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:00:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x25so3860919wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQgNsWbw8szIbmS2++p4t/GdyBsMwn2AlbFs69b1AsE=;
        b=NB1Dzy95GWXMCfo6AMISYiGAu1dyOt6crGJ4S09ZW3/ICqkzy6q+lrMGDZPRPKoypN
         49NkK7Oa402PxjGCvethZt8qJb694UPf5mfS6+5Q5ts0zpOPKTWa2jBK70DpDePaYZwb
         aZemhxkvH+VYS4GtE037Z912VDbLd1eUgsMZdHy4/b+KI9K40H7VeToaXmJSpZeSuphS
         XpbR4QOaCkohvJ87BwRX7n7ljsiVV8mxadyZ8ElwKmYdZSNkechWdw9XHZptFFbbqBSt
         ft2PyOcr+5PQQLKXecMWQqEoOSXPqqazogOK7yS03hM1GPk3eOQlvvpp4rG0P8xoEZtM
         nfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQgNsWbw8szIbmS2++p4t/GdyBsMwn2AlbFs69b1AsE=;
        b=s6vowa9jNX/XWfnREny8bD8ZfCOHAbimOen2q05qMTDlOVcgWx7bWwKuGvMsGaN87B
         fdb2byQ+w6nek66S+IjTQCrPIvoCFurjtbO00YffWcm8n91asMHdpj51a7JtvbVMRvqZ
         MIxzp8j4R2VVbe3j5TsP3/mpp+Kjb6T5vP7stMAap+e8QXANwGeNlJeOuzJg+bNjUmFO
         yzWa7vZ/dfSO1mjzIR9pCZNTVx4G4+jnvKybRsFeYYdo5ygBkwGA9pH6IEK2hNxfkfKe
         eFGk3apZFHEXqO3HY3qDTUcPDP+uzgcAPy9oH1qZukpurbpmrOZkfdscMeb1BOSg3Fka
         HbeQ==
X-Gm-Message-State: AGi0Pua6KdjhAnDjEDkhOlvGgPz9oYptyIGqAHGT0s5u0J9NN4iSB7i+
        3ahoxlwSM7RTtbeCyFIK9p0=
X-Google-Smtp-Source: APiQypKoO0SKTdesmb1qa3AJ/bxOZBdUymF9IdhA/Xh/idMxBTHhorlgOLFyxjFcbFRLL/0LDuspfg==
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr140597wmh.107.1588201223208;
        Wed, 29 Apr 2020 16:00:23 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.googlemail.com with ESMTPSA id o28sm1089501wra.84.2020.04.29.16.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 16:00:22 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v4 3/9] w1_therm: adding sysfs-driver-w1_therm documentation
Date:   Thu, 30 Apr 2020 01:00:08 +0200
Message-Id: <20200429230008.199513-1-akira215corp@gmail.com>
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
 Documentation/ABI/testing/sysfs-driver-w1_therm | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-w1_therm

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
new file mode 100644
index 0000000..4108f4c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -0,0 +1,17 @@
+What:		/sys/bus/w1/devices/.../w1_slave
+Date:		Apr 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(RW) return the temperature in 1/1000 degC.
+		*read*: return 2 lines with the hexa output data sent on the
+		bus, return the CRC check and temperature in 1/1000 degC
+		*write* :
+			* `0` : save the 2 or 3 bytes to the device EEPROM
+			(i.e. TH, TL and config register)
+			* `9..12` : set the device resolution in RAM
+			(if supported)
+			* Anything else: do nothing
+		refer to Documentation/w1/slaves/w1_therm.rst for detailed
+		information.
+Users:		any user space application which wants to communicate with
+		w1_term device
\ No newline at end of file
-- 
2.26.2

