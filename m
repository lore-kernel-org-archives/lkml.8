Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C19C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DC720752
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7QddB7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbgEKUgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKUgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:36:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9950C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:36:41 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d207so4806734wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Vemf8DfGFVhJ4jbqvRLe6zQd8MyyJEc24yCrsnSaX4=;
        b=p7QddB7RB5e2Xr5qT7qZJ7/B63MiNPFsHC+nzEKXy7gbBpPlxjhGdpJLhGDjR2O+6T
         I+MTpIDiyTs+sB011zv4sM5W3UM8sbACRUr2z6zJyDN3keAQuILS8zlcf5xMFvKh18VP
         nCrJdsNE0z96Ibigi1D74HJEBu4sNSKBAzTMgu3A+7kNYXLpdvBJgF405IGy28U0gU6n
         3wisrdnrcHg06zIcPQ0CwS+1/lT9R71bXIGBA5iNYjRIwuz0WUad2utNI0LuF/z09uxw
         yp2ZB9zGaKEqE3xc8+hEpAryEdT1MaW/nPxIPTt3lwId6e7CNHoHRY3VzhctD5z2zqfR
         DTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Vemf8DfGFVhJ4jbqvRLe6zQd8MyyJEc24yCrsnSaX4=;
        b=lznNiIOriqjef2SybF5qYsADVZVHWcPqB02jWx4Cy2az02XZ8cUyAEvnBD6/p77AxP
         VMqr1QMDf7Tg1hmM2a+N/3sbD19h/iyU1naXXhrC38bpFn0lf5PO0/LHSNOU97LmBWL0
         FRnXhTOSTdO43bh+z+NmNbp3NWprEdl3tnfwVg0jOBjcCpr44K50+vw6ieuI1bNVJV1M
         PD0O1wU698yL8Hc1IFvWE9uATfvdDQLpZ+LR4kITDjRGPMr7BgiwLVCUHK9BZjpX5p6H
         G5PLcYtRSEpgL1KLLyvgYuxVOELVcRAib0swo1gghobabjGV3ULvbFKZ314BBc4hmN25
         rQSA==
X-Gm-Message-State: AGi0PuatJ7GXphw35gqVUKdTAlkh+5rZp1PBZneheS+DsA8ekUFePO30
        FSn4/22B161KHgptQ7L4/LlnV0eb
X-Google-Smtp-Source: APiQypKUmEjimMNoX77VCKVlJwzNwJ+ORui0Lu2v9DG0CQPN4cQAUvef5xkBzRcULW5t0rDY25CLMQ==
X-Received: by 2002:a05:600c:280b:: with SMTP id m11mr5864159wmb.115.1589229400721;
        Mon, 11 May 2020 13:36:40 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.googlemail.com with ESMTPSA id c83sm29604157wmd.23.2020.05.11.13.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 13:36:39 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com, rdunlap@infradead.org
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v7 3/9] w1_therm: adding sysfs-driver-w1_therm doc
Date:   Mon, 11 May 2020 22:36:31 +0200
Message-Id: <20200511203631.410227-1-akira215corp@gmail.com>
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
Changes in v6:
- Formatting code comments according to kernel-doc requirements
Changes in v7:
- Formatting code comments and correcting comments mistakes

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

