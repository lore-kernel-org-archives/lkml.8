Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB22C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D795D20780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+CpJTIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbgF3Nxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388303AbgF3NvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654EEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:18 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so18882588wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zQGzW5dI+CJY57UuhEAmK6g60SBrVTGRjgbtv0HdhAY=;
        b=C+CpJTIvfIGIs4cJkn37fTz6yt1tJ8g3S//jhOe0+456JFng7nB0mqqj4PGt32ZJmI
         tDRat8+PSlcWIaUohMmROjOMTqKh4o69i0aPGeGC9iaPmJ+VBQXjtN520xUgdFw5y1qe
         aTikfzaH5S4VZhoP5avaXsa5X8kDRaYiVfpd006TPFx/WvM9K2NyEZvO9YzZXLicmosA
         B8mxu0a+V+xCiDCGHBypcuNJravucfqU5ksMkrk81b2/2HNiMwr3FY3YGfteMIonfHqO
         0R6A9YAmgrAiEUZXg/cc9bDUny/djVO3rZ8YazswKVTK8SPSO5nDB7TTJVc32ljzgPUw
         Wu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zQGzW5dI+CJY57UuhEAmK6g60SBrVTGRjgbtv0HdhAY=;
        b=VWDNsJTjdBRrDudk3AsMfqn88iFxqlGyagL2SfKynaaqPeRkmvzpzE3e8dOM2OG8FP
         Zg1oiXxEmZAsLoml6Rt7ehWBuwWv3cDSosUbZJnJ1gPiO8l/sbYTWszTDOQ8zDFUxILJ
         D/M58q7Nmmvz+safDfQkSlMKr6+6dhY9mrbD3ZctTJTPOyx/an8HXJFyGIHlGd/DvdC0
         bUeVHmNWT5K/AD+joH05zwo/1mTDKCG+sfsdysOdN1YT2p2FS7bcz4GKElsE/uYC8A9M
         Eey9iAngRKbEokHK+85QcALTvncv3ssW/b5VkY/p3YAREFgkzOOzrIAPWcYVhn8Bu3eL
         kt1g==
X-Gm-Message-State: AOAM532XpkX0P8tgz+JrWEyd6oFNAecY6u93ksimBgncwb689waDZLmY
        botbujbFuVN7bijqnkj3l1VIWw==
X-Google-Smtp-Source: ABdhPJxt1DCJ8adnNm77NquA3B67xrt2gf/9+UcEnIXepE5IwsSQfNR369EHHBetezmvTIajmBYo9A==
X-Received: by 2002:a1c:4804:: with SMTP id v4mr21508966wma.139.1593525077188;
        Tue, 30 Jun 2020 06:51:17 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:16 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Michael Jung <mijung@gmx.net>,
        Michael Ruettger <michael@ibmra.de>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Subject: [PATCH 03/30] misc: genwqe: card_debugfs: Demote file header from kerneldoc
Date:   Tue, 30 Jun 2020 14:50:43 +0100
Message-Id: <20200630135110.2236389-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc does not understand file headers.  There is therefor
no reason for them to use the syntax.

Fixes the following W=1 kernel build warnings:

 drivers/misc/genwqe/card_debugfs.c:30: warning: Function parameter or member 's' not described in 'dbg_uidn_show'
 drivers/misc/genwqe/card_debugfs.c:30: warning: Function parameter or member 'regs' not described in 'dbg_uidn_show'
 drivers/misc/genwqe/card_debugfs.c:30: warning: Function parameter or member 'entries' not described in 'dbg_uidn_show'

Cc: Michael Jung <mijung@gmx.net>
Cc: Michael Ruettger <michael@ibmra.de>
Cc: Frank Haverkamp <haver@linux.ibm.com>
Cc: Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/genwqe/card_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/genwqe/card_debugfs.c b/drivers/misc/genwqe/card_debugfs.c
index 1b5b82e652687..491fb4482da29 100644
--- a/drivers/misc/genwqe/card_debugfs.c
+++ b/drivers/misc/genwqe/card_debugfs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * IBM Accelerator Family 'GenWQE'
  *
  * (C) Copyright IBM Corp. 2013
-- 
2.25.1

