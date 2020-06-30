Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA64FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB3AB206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYqNqpj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388312AbgF3NvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388299AbgF3NvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:16 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCC9C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:16 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w3so7222502wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0JG9yfk7UsIlwDFN/XvWcoL4qtnzwNOpXg0C3Lo2gcU=;
        b=wYqNqpj46PQI5CQBcWLOeLqbE5yU0YKgbwQldUAM+2YLSOl0alIcjDAjWxXqItSLVF
         EjicKVJJSbpZ66Us/9K8NPC+lXTwZGycJQZ6n/WkAgH2KMP2mA0qgo11H8zKcSrJ7ra9
         DEolk/J/4SdiODEWHl7mVjseYCplZJ7zPDnNUN0b+L6ZVGNz/NI50ZUYe9c/Lf+9Yknt
         syutilb7MUGTIeMxwtRle9iILSYmYLB2zUoCALw3NNmn0KcrBKoa5V6LegPNh+IWGY3X
         0E/Scjq+fB9Ks/pJeviVQ9EFQ49uwRt0MF172acvJ6l+K3bNG4rMzS2aB0l1cIwn9qlb
         DBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0JG9yfk7UsIlwDFN/XvWcoL4qtnzwNOpXg0C3Lo2gcU=;
        b=B0z++nKeWnDv8LtndvO4v/xjMW6MTtzyZxSTgZhwnaPaKpeH7850oA2rv1Kuz3CViJ
         GADxTdAC4pPsnMzEAK6YnMbhn1tgvsiM8lXh2SKwX0bxToJakNUP9pvXKIGhn8uT6LRx
         AGjplDBcqX7cSE0UPQdQQQhaVIOJvSR3FX1yebK9MrT0aP4wl8bK+8Iyal3P+rS3m3ym
         a4lJM0o3ExkDlCC8wQx43JDj6DbKyRKQn+liyujzz/SYkEbe+IInRURlv6jxNhx+FOLb
         njxAUI7LE0Eg9itYZfgB+z26LJz7+no+7v6L+2gN4QcpM1FZqDW89z0pfgTpCvR2oS2n
         Epnw==
X-Gm-Message-State: AOAM5309fXMBzrFgZjjErLT2JYBIMPpmDXJeeSYASWwEdqeDwShHgS3E
        ddkTx7nAbFtz7v2Bglm6VrnzBTyeIoI=
X-Google-Smtp-Source: ABdhPJzinaVgXzm1+p8rUkcxU0U4zHaoc0tKkatJO/uvJ76C784lzkLQEsHBmfuew/F+rEeqz/RK9Q==
X-Received: by 2002:a7b:cd10:: with SMTP id f16mr22050588wmj.86.1593525075011;
        Tue, 30 Jun 2020 06:51:15 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:14 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Michael Jung <mijung@gmx.net>,
        Michael Ruettger <michael@ibmra.de>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Subject: [PATCH 02/30] misc: genwqe: card_sysfs: Demote function/file headers from kerneldoc
Date:   Tue, 30 Jun 2020 14:50:42 +0100
Message-Id: <20200630135110.2236389-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There has been no attempt to provide documentation for these function's
arguments, so align with the remainder of the file and just treat
them as standards function headers.

Fixes the following W=1 kernel build warnings:

 drivers/misc/genwqe/card_sysfs.c:32: warning: cannot understand function prototype: 'const char * const genwqe_types[] = '
 drivers/misc/genwqe/card_sysfs.c:150: warning: Function parameter or member 'dev' not described in 'curr_bitstream_show'
 drivers/misc/genwqe/card_sysfs.c:150: warning: Function parameter or member 'attr' not described in 'curr_bitstream_show'
 drivers/misc/genwqe/card_sysfs.c:150: warning: Function parameter or member 'buf' not described in 'curr_bitstream_show'
 drivers/misc/genwqe/card_sysfs.c:166: warning: Function parameter or member 'dev' not described in 'next_bitstream_show'
 drivers/misc/genwqe/card_sysfs.c:166: warning: Function parameter or member 'attr' not described in 'next_bitstream_show'
 drivers/misc/genwqe/card_sysfs.c:166: warning: Function parameter or member 'buf' not described in 'next_bitstream_show'
 drivers/misc/genwqe/card_sysfs.c:271: warning: Function parameter or member 'kobj' not described in 'genwqe_is_visible'
 drivers/misc/genwqe/card_sysfs.c:271: warning: Function parameter or member 'attr' not described in 'genwqe_is_visible'
 drivers/misc/genwqe/card_sysfs.c:271: warning: Function parameter or member 'n' not described in 'genwqe_is_visible'

Cc: Michael Jung <mijung@gmx.net>
Cc: Michael Ruettger <michael@ibmra.de>
Cc: Frank Haverkamp <haver@linux.ibm.com>
Cc: Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/genwqe/card_sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/genwqe/card_sysfs.c b/drivers/misc/genwqe/card_sysfs.c
index 28a3fb1533f70..b2f115602523a 100644
--- a/drivers/misc/genwqe/card_sysfs.c
+++ b/drivers/misc/genwqe/card_sysfs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * IBM Accelerator Family 'GenWQE'
  *
  * (C) Copyright IBM Corp. 2013
@@ -129,7 +129,7 @@ static ssize_t base_clock_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(base_clock);
 
-/**
+/*
  * curr_bitstream_show() - Show the current bitstream id
  *
  * There is a bug in some old versions of the CPLD which selects the
@@ -156,7 +156,7 @@ static ssize_t curr_bitstream_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(curr_bitstream);
 
-/**
+/*
  * next_bitstream_show() - Show the next activated bitstream
  *
  * IO_SLC_CFGREG_SOFTRESET: This register can only be accessed by the PF.
@@ -260,7 +260,7 @@ static struct attribute *genwqe_normal_attributes[] = {
 	NULL,
 };
 
-/**
+/*
  * genwqe_is_visible() - Determine if sysfs attribute should be visible or not
  *
  * VFs have restricted mmio capabilities, so not all sysfs entries
-- 
2.25.1

