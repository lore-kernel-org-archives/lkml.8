Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9103C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDBE246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iFV3rVkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgB1Is7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:48:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42937 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgB1Is7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:48:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id 15so1367790pfo.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 00:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5EPoAhuZuphwlWtSWKyhSY+h7h3iivsxV4hMWTAxKUE=;
        b=iFV3rVkvPQnO5aV+1FwyzJXv2sSSkRysESfqak/OMWbI3jNcxqgDZw9qAddYnR6hyQ
         zGRH+b4yzk7kO1CpZLLrwj/s50pOnkCp52v6eYBdmRqm4Z1vPwuqPFwVhaE7ELQyRXrn
         08ZzgWcJHLmfD1BJH0hg3bS062kvW/N4nMi20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5EPoAhuZuphwlWtSWKyhSY+h7h3iivsxV4hMWTAxKUE=;
        b=pmwaCbIf8hG/z/hauhy2QNISjvdPwRhlHGRwITKd6turcoA1n6mEH5xIPMtEU31d6e
         8T02v1CWsitZUJbvxlqh7kOnratNfk8Phb+2xojS8lL6gLg4H4xrEyU4meLD7DImveGR
         AWxEWuxQe6Obz8RJ7Zbv5Vpu8aGuMK14m4SVVfAKcCepNhtyf+YxELzHY15tlPcVrVJT
         AzqDP/vq/gkEp2f7gr4RkRCmbiDnGWcllMG1sSa34bulRBirP8Mld2Ni/NxpOtHkgKlc
         x8pakKHVGP86GBkGaZrRrHm86FdXjrzVsWpO3ISzRLO5YJXSuRbr2XwrLk75XJGaSrnu
         6udg==
X-Gm-Message-State: APjAAAWvaBoBn6iYygL2JjMXrgEALbsebPlXkqfKSkn5eo2FwqsO4oA8
        rqSlRf2pZCC8xbD8JjguhdVmUA==
X-Google-Smtp-Source: APXvYqwQNFMpLHGueqR6+qvmtUW/XKem1Ve1Ni7aNqltZQ2HkbpOaMYtmYLwubk5R7ASlRPHUoNW3A==
X-Received: by 2002:a63:d441:: with SMTP id i1mr3685712pgj.426.1582879737942;
        Fri, 28 Feb 2020 00:48:57 -0800 (PST)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r72sm1496939pjb.18.2020.02.28.00.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 00:48:56 -0800 (PST)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/1] scripts: dtc: mask flags bit when check i2c addr
Date:   Fri, 28 Feb 2020 14:18:42 +0530
Message-Id: <20200228084842.18691-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generally i2c addr should not be greater than 10-bit. The highest 2 bits
are used for I2C_TEN_BIT_ADDRESS and I2C_OWN_SLAVE_ADDRESS. Need to mask
these flags if check slave addr valid.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 scripts/dtc/Makefile | 2 +-
 scripts/dtc/checks.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 3acbb410904c..c5e8d6a9e73c 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -9,7 +9,7 @@ dtc-objs	:= dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
 dtc-objs	+= dtc-lexer.lex.o dtc-parser.tab.o
 
 # Source files need to get at the userspace version of libfdt_env.h to compile
-HOST_EXTRACFLAGS := -I $(srctree)/$(src)/libfdt
+HOST_EXTRACFLAGS := -I $(srctree)/$(src)/libfdt -I$(srctree)/tools/include
 
 ifeq ($(shell pkg-config --exists yaml-0.1 2>/dev/null && echo yes),)
 ifneq ($(CHECK_DTBS),)
diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
index 756f0fa9203f..17c9ed4137b5 100644
--- a/scripts/dtc/checks.c
+++ b/scripts/dtc/checks.c
@@ -3,6 +3,7 @@
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2007.
  */
 
+#include <linux/bits.h>
 #include "dtc.h"
 #include "srcpos.h"
 
@@ -17,6 +18,9 @@
 #define TRACE(c, fmt, ...)	do { } while (0)
 #endif
 
+#define I2C_TEN_BIT_ADDRESS    BIT(31)
+#define I2C_OWN_SLAVE_ADDRESS  BIT(30)
+
 enum checkstatus {
 	UNCHECKED = 0,
 	PREREQ,
@@ -1048,6 +1052,7 @@ static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node
 
 	for (len = prop->val.len; len > 0; len -= 4) {
 		reg = fdt32_to_cpu(*(cells++));
+		reg &= ~(I2C_OWN_SLAVE_ADDRESS | I2C_TEN_BIT_ADDRESS);
 		if (reg > 0x3ff)
 			FAIL_PROP(c, dti, node, prop, "I2C address must be less than 10-bits, got \"0x%x\"",
 				  reg);
-- 
2.17.1

