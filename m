Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9752C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8D520661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="ex8fNHPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgBLIne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:43:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37886 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728457AbgBLIne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:43:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so1140783wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fGdSUfQkLfF9DHdMDJ60li9faldkILwXEkxG3rbMJHU=;
        b=ex8fNHPDp1r+bWrBKR0esR9qfcYVyA5glEE7UMwCBgPwjATziesFGlYx0DxioyRJYZ
         dPWRNvswyEl7UkeGN87c4FKCWNfh09bJMNiG62/RHoU7A/ETKml7KPHU34POrzFwNt52
         48B5WIVvgl3LaxY2IWtXFPCWNEEv6E1QGchGoBPP2h0uQ0c7KwQKYQs1ag2e4RnCCoUY
         VnEeMhxymeqTBVrq1dDt30+TNrEuDAJTyJoGoF4ggxK+xzKoriEuWdkGlvke9yX7C+S0
         jwdOQ6eCnJwLrflFglAClPwML1MiuvVgkKf+JdNddxa5BKMLhu9v7+6Qfg4Z1nkqeHix
         l32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=fGdSUfQkLfF9DHdMDJ60li9faldkILwXEkxG3rbMJHU=;
        b=gq4uCeIDI/qKnNjrcOFwPlTjibbbUeLM2462fbZez4GGnPqALoJU6uM2MKKkTCpDOZ
         BroJI/kK0P8tdZMU2wJ6zzcgrQDh8zBLh27UbROEZ+WoFHrwpZT9X6OaRNL5ef5LxA2K
         xqWMNkgPuSFiOruSsQQsei1vWhCEwNXXSCktqAXkhtQCncJUInxrbYHZzyeMe/fmhDmn
         T3VY9qDrG0Xqe2fQ6+sP9j3N97RMFpYKFdKezf5mRrLKshI+Jcl7UG1mSuwo5N1erSyn
         wA3D++UXZtKWRbqlJQmbavHHLfAq34SLy4s1qieA/xgN7qG2jwK6uzO0+YZAgdmwEkrp
         qklg==
X-Gm-Message-State: APjAAAWpnum9zIOy2vdewvAW7jxWmtZ/QseKsAFMABI6otlrcIV/Junp
        Rh3XsCfjCL5apiHd4QslowOmWf2UeD0Pbg==
X-Google-Smtp-Source: APXvYqxgoPwHQJmB9TPvdAU8TKfypqitKOvk7OPqb3X+I31fSJGcGIKDmQNob8tkfVJ1c0OC7naEDg==
X-Received: by 2002:a5d:54c1:: with SMTP id x1mr13514491wrv.240.1581497011545;
        Wed, 12 Feb 2020 00:43:31 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id x6sm9023725wrr.6.2020.02.12.00.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:43:30 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH] microblaze: Fix _reset() function
Date:   Wed, 12 Feb 2020 09:43:29 +0100
Message-Id: <ce58b2e6d0fbc8bf94d3cd986c068fbc4fda4d04.1581497006.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a need to disable VM before jump to zero reset vector.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
---

 arch/microblaze/kernel/entry.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
index f6ded356394a..b179f8f6d287 100644
--- a/arch/microblaze/kernel/entry.S
+++ b/arch/microblaze/kernel/entry.S
@@ -958,6 +958,7 @@ ENTRY(_switch_to)
 	nop
 
 ENTRY(_reset)
+	VM_OFF
 	brai	0; /* Jump to reset vector */
 
 	/* These are compiled and loaded into high memory, then
-- 
2.25.0

