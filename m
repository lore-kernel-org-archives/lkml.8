Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D229DC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8B1120731
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eD+XnfD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgEJOQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 10:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726085AbgEJOQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 10:16:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC65C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 07:16:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w7so7549632wre.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 07:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=myKkIL8Io7d1AQISW4YDYz95HqbEVvSclwrsMEk7Ibk=;
        b=eD+XnfD7Kl7SYS6iegvXaQoZxqJJODwR9zc46He+VJBL6D107KPTCrTlQ5lbp7Txti
         enOBObSVHFZjhlSTL92kP8+g0zVWkbx71hEEF6lRa0VemFwx2PkG1UnBsPiaTsPKeVvk
         I3Bb20QSxM4tgIMXAJPHqUaD2xqjou/SQ4358+RDg0KMGIG/absYchMH2dBDB1QR3vRG
         739d2HUgjEruyXRVNrDaEbI4PLrd72JEIO7+pbzfBmBmp5vCq7tU1LVq1nVWg/lbnBMp
         dJq4nIjg2ZWHU79J/S4Cc6qp/HwfKJf7HmVge176GXp23i3xAgFNXFRY6rXz7n55wW46
         82/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=myKkIL8Io7d1AQISW4YDYz95HqbEVvSclwrsMEk7Ibk=;
        b=LbB+0tMGHERyW1zieD0t49EYQ+AK1fgcBD13nyjwtCCh9jUgkwvAWzw8q8ixzcbv6f
         wtNJ5yV1RYsNk18y4hH0N2944o7MJNOefBAtK+y45fMdxWBME3psQJZtd72+bQ6A4sv7
         qcJ/H0qt9/4GDyWTyTHLWre3lUozzDiRMf/9/Ljd2tdwjMMFwcx0Jivrms8vPIVVJoIt
         hVu7rvD2PxZ8KuPe4CjvFlxx6MwG3MsGXsmvm5jOvhaIPo+x6k9c4pHrbSxD2v+ARtgL
         dqUNwcWc8HcHWPJXYE2OXcZmcCLOic2wgFIAYj+A7NnK0uXPJqzlwMzJfSv6/oIKb6C6
         Cwyw==
X-Gm-Message-State: AGi0PubBP9udJl1GdVh4ggEadUSaPB2KYAl949OBGEGmawD8aK5IVDxK
        TuuKjaTlW8++6V5A0tChFbM=
X-Google-Smtp-Source: APiQypKyxMvlsXum8I+LmmZsCHh8Fud8quUXJ96Hyhx4teOk+bCqAHYWzwjNCkCqK7VahaiuUJvLHw==
X-Received: by 2002:adf:c381:: with SMTP id p1mr14037249wrf.148.1589120200718;
        Sun, 10 May 2020 07:16:40 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:48ff:3af:e1d8:fd19])
        by smtp.googlemail.com with ESMTPSA id s11sm12929657wrp.79.2020.05.10.07.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 07:16:40 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com, rdunlap@infradead.org
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v6 3/9] w1_therm: adding sysfs-driver-w1_therm doc
Date:   Sun, 10 May 2020 16:16:33 +0200
Message-Id: <20200510141633.172861-1-akira215corp@gmail.com>
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

