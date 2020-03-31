Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F527C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363B22080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="1HPT3qPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbgCaW3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:29:07 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36607 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731498AbgCaW3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:29:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id d11so25005267qko.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 15:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EIvjO3useBmli2uM/TiwQHJ2Nhnb37wdo2/REgTIMZs=;
        b=1HPT3qPKF4EF9BC3fvNrOGqBGrIGMEw/N6QnTXx2h0iMrwZt1fxApFa5I2f+PnrHpq
         IFOQRd9KYU4U3crhwvG1Tv69ZX4X/ZSZfkcJB0F/4LmS404Ny9okaNvOZWH6Vx//JCcY
         HXFOuJmYWOJoNc69bF/N4pTLr6dU68Uq8znrzmBf9088qdZKMOTeMrpsQuK1c0b79KE0
         7fOcHlBBEqJlkIZ8VWS5DKaCbAPERXmQHVwiNZbB+mCv5DcWUQOfAYyt6Rp8hnkGCwkE
         4F5beE/fL1IhefnVEvRBmFGs2ldU4cFy5nOwJElFwcyiXtXfote4mRslLOF0AdgaHynN
         YqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EIvjO3useBmli2uM/TiwQHJ2Nhnb37wdo2/REgTIMZs=;
        b=TBOlkStVC7YSXxsMCDVYnjSq1SARwSQTWbbnyR0xShsz6+1cYhox/Kn1JJD6Efw/cu
         1UMQnHQV6ULea1msE6Ehu66RtRpspethC8AlQgYpQ0OZqjXxiVqs9Ql/oH+RVLKX8ckL
         DOodv0ec082LVn8buHZDxynu+UDBi+k+JdfOfZDxfqkUQeyZBrOhLmLo9BGMhaFdJyQ9
         nVBhANtUFuK4DIJ9T/WHLzp0p/BfPeU3P+wOXZZeVD3zAbb1uprYPx3693ganWroxJSo
         AfgihhNb0PohuNMi3/pzJP83m+LWpXiKaO4xyB6auPXTdecPBMQ6ctnE2LmdthaKiK4u
         cV1w==
X-Gm-Message-State: ANhLgQ00lQW0zC0Cx+4uqxQRm8Yi2Wi9b7AUol9evtFAByRzx7IqLkxk
        DEFGVw6m4C1sye0IdG7PUiQ4DiM92UXVKg==
X-Google-Smtp-Source: ADFU+vsB9OsLCigCjj1qUXSQG2YbPmxN3ALbi3VoPNxdq8ur1BeKVGK6sYWWNssgVP13PjbMrTT47w==
X-Received: by 2002:a37:a397:: with SMTP id m145mr6970037qke.411.1585693743617;
        Tue, 31 Mar 2020 15:29:03 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id 206sm238659qkn.36.2020.03.31.15.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:29:03 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 1/2] Documentation: filesystems: Convert sysfs-pci to ReST
Date:   Tue, 31 Mar 2020 19:28:56 -0300
Message-Id: <637c0379a76fcf4eb6cdde0de3cc727203fd942f.1585693146.git.vitor@massaru.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1585693146.git.vitor@massaru.org>
References: <cover.1585693146.git.vitor@massaru.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 .../{sysfs-pci.txt => sysfs-pci.rst}          | 40 ++++++++++---------
 1 file changed, 22 insertions(+), 18 deletions(-)
 rename Documentation/filesystems/{sysfs-pci.txt => sysfs-pci.rst} (82%)

diff --git a/Documentation/filesystems/sysfs-pci.txt b/Documentation/filesystems/sysfs-pci.rst
similarity index 82%
rename from Documentation/filesystems/sysfs-pci.txt
rename to Documentation/filesystems/sysfs-pci.rst
index 06f1d64c6f70..9b93e7444b15 100644
--- a/Documentation/filesystems/sysfs-pci.txt
+++ b/Documentation/filesystems/sysfs-pci.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================================
 Accessing PCI device resources through sysfs
---------------------------------------------
+============================================
 
 sysfs, usually mounted at /sys, provides access to PCI resources on platforms
 that support it.  For example, a given bus might look like this:
@@ -30,23 +33,24 @@ This bus contains a single function device in slot 0.  The domain and bus
 numbers are reproduced for convenience.  Under the device directory are several
 files, each with their own function.
 
-       file		   function
-       ----		   --------
-       class		   PCI class (ascii, ro)
-       config		   PCI config space (binary, rw)
-       device		   PCI device (ascii, ro)
-       enable	           Whether the device is enabled (ascii, rw)
-       irq		   IRQ number (ascii, ro)
-       local_cpus	   nearby CPU mask (cpumask, ro)
-       remove		   remove device from kernel's list (ascii, wo)
-       resource		   PCI resource host addresses (ascii, ro)
-       resource0..N	   PCI resource N, if present (binary, mmap, rw[1])
-       resource0_wc..N_wc  PCI WC map resource N, if prefetchable (binary, mmap)
-       revision		   PCI revision (ascii, ro)
-       rom		   PCI ROM resource, if present (binary, ro)
-       subsystem_device	   PCI subsystem device (ascii, ro)
-       subsystem_vendor	   PCI subsystem vendor (ascii, ro)
-       vendor		   PCI vendor (ascii, ro)
+	file		    function
+	=================== ======================================================
+	class		    PCI class (ascii, ro)
+	config		    PCI config space (binary, rw)
+	device		    PCI device (ascii, ro)
+	enable		    Whether the device is enabled (ascii, rw)
+	irq		    IRQ number (ascii, ro)
+	local_cpus	    nearby CPU mask (cpumask, ro)
+	remove		    remove device from kernel's list (ascii, wo)
+	resource	    PCI resource host addresses (ascii, ro)
+	resource0..N	    PCI resource N, if present (binary, mmap, rw[1])
+	resource0_wc..N_wc  PCI WC map resource N, if prefetchable (binary, mmap)
+	revision	    PCI revision (ascii, ro)
+	rom		    PCI ROM resource, if present (binary, ro)
+	subsystem_device    PCI subsystem device (ascii, ro)
+	subsystem_vendor    PCI subsystem vendor (ascii, ro)
+	vendor		    PCI vendor (ascii, ro)
+	=================== ======================================================
 
   ro - read only file
   rw - file is readable and writable
-- 
2.21.1

