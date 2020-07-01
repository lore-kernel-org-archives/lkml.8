Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B4DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786662074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SzoFhdpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgGAIdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgGAIb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:28 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47557C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:28 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z2so621518wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0JG9yfk7UsIlwDFN/XvWcoL4qtnzwNOpXg0C3Lo2gcU=;
        b=SzoFhdpLOAfa+dq6nAlH2oIjixe1LjRVlgsE9YP5IUq1LTn1Wg3758lP7ziz4wGQsA
         lPXC/oDkOzunW/jveIUlQ0NQTvteC9Tqnvrwi4d173D8K/EWQJChGnESf7SM83C68EpX
         whIgtkS56BqF4BgPgmxocXPxGOBH+JDiGOlGhP+jzvFiTDpnzbBbGg5VHjrdQVUm5Je2
         0Hs+7oX3+y/FWNx9YqWczI8KijaFF6tJlzN4n3l0I/qAPdZbVRwcdNuPvWxiVKH3DTfb
         4kbO1a8zCOs8QfoIrus2+2ZkuUsUcq736NZQibfCiOhA1wL/zs3wx75Way+YIOH2vp7o
         FEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0JG9yfk7UsIlwDFN/XvWcoL4qtnzwNOpXg0C3Lo2gcU=;
        b=jZano3WCjTYCJy+cpJy7KY4JrJULi7dccGDDWxOsRPC8pJ8gvSVb46IXY+hflCJwSY
         RqKzqVs2LOw7TdzeRuxi7HuQZ8oU51cmVSQUJZi08UH3ShAcgrQHwUJSmY9yETOisBV8
         MHagec1ACEyv0qXs5yLrr1PnI5Cphq26ly5pnZjEz3a3YblgLeIvmXBg62/HjCLcFDrk
         JRIwpzhxofUWIcJT4n550BWYkiDOZbWoxx5RDAozXFq1G54748b3ezDJOEpScNsiyjXK
         5Mngc9zmuTzv0Hjllv4woOAduqdZ+X45RB9BBhyH6hTglDRBD9JxyssalhTpW8q2hoi1
         5oHg==
X-Gm-Message-State: AOAM530whUc95EKdxfvx9LyHY+0o2pcUKABvCuMDMxUUlTyz00Qk5rPN
        ipR5OXcdR+UKETRbJu8D1Rv/+A==
X-Google-Smtp-Source: ABdhPJw61Z0MEpUm/aZ4J5rbUdsdfOg65yroMNdYQg0nttjPu2TeFqFVE9C6tX31r/UqSt7IaudK5g==
X-Received: by 2002:adf:f452:: with SMTP id f18mr25483694wrp.78.1593592286991;
        Wed, 01 Jul 2020 01:31:26 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:26 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Jung <mijung@gmx.net>,
        Michael Ruettger <michael@ibmra.de>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Subject: [PATCH v2 02/30] misc: genwqe: card_sysfs: Demote function/file headers from kerneldoc
Date:   Wed,  1 Jul 2020 09:30:50 +0100
Message-Id: <20200701083118.45744-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
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

