Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554E7C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E28120714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="zZXNM0dY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgBLI63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:58:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33639 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbgBLI60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:58:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id u6so1216375wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PbPM+IFIv10EDyvULs9OlFwo1yj0tKaQ85CzafFBjwk=;
        b=zZXNM0dYGW7Znea8Gw9/B3wlfsH1LC/HedoZf5DlseriHMnA5bh7R5UjtuxUSkGVGL
         s50bzjS0iKOUMjVM0pnMs2IOIvM9j6binbeGCOF2f/w383kJWcCfCaDsUil+X4wFRYOQ
         DWqN1Lw6QxQvPoejpNSHByEodgJpzeem5k+EztSflE+5n7CbSnIAkgvSSLKIoFFpXltS
         76iwoxDy4+TfvXswUpTO66A74szY1M9TySL2stCmKVhUEzZjWiFY3A6/FvydyTbPKAD+
         Y2dGAT+Yxu1e9AbldCUM/UC/LIgGgajmnUKaFk5SWMbZf/a6fszg2vPtaaXYis+pSQ7s
         N+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PbPM+IFIv10EDyvULs9OlFwo1yj0tKaQ85CzafFBjwk=;
        b=Xzrn7lpAQHpUMu9V7eQq5FccGpfjtmVEw76vE/GRxq+KeL+QtIlWLJGNUYokMiRtYO
         OHLcFvV4MAqRN5SKHBx91+GnPRDZYQ4E8RuBwPshZPrSrjISjwr88ChEyi3bnYPmvO5w
         Qdlli8qt74W24fDMhzkOnELlBocwOZ5L8yFR2C29RBMR80fFkfwabMS/YMYzSdv+Rcl3
         kEF4pImjZRrDe+bhauqJXLp5MrES8prsTbfKP6V73H08pM19YcyuPGE3Zng0k/+C6X+C
         WGhbHiy32PTp+1C4lnDvXzvaLqo+OqnxdO2pxhusxiEA0OsC+Lk92EoRn6pvJORqym6y
         iMcA==
X-Gm-Message-State: APjAAAWfzBZYXJMVFOz9j/sGGK0saLfdaNlL8uXEo1C/JhG7/NYu6b3T
        oEQ6UmDhCgoz+m8L457wSjVOmNZRB7PTZQ==
X-Google-Smtp-Source: APXvYqy8AArVJd0v7iAp1VwlYWnjCfUnUd8JqsSiNMR90W7DDrXOHzxYBneaXTtGlPm9cMF7Wwrijw==
X-Received: by 2002:adf:ffc5:: with SMTP id x5mr14481864wrs.92.1581497902930;
        Wed, 12 Feb 2020 00:58:22 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id p26sm7019262wmc.24.2020.02.12.00.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:58:22 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 08/10] microblaze: Remove unused boot_cpuid variable
Date:   Wed, 12 Feb 2020 09:58:05 +0100
Message-Id: <658d8948b81137b205b02032bda43d2ea6998fe7.1581497860.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1581497860.git.michal.simek@xilinx.com>
References: <cover.1581497860.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

boot_cpuid is not used on uni processor system that's why can be removed.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
---

 arch/microblaze/include/asm/setup.h | 2 --
 arch/microblaze/kernel/setup.c      | 1 -
 2 files changed, 3 deletions(-)

diff --git a/arch/microblaze/include/asm/setup.h b/arch/microblaze/include/asm/setup.h
index c209d5297029..be10da9d87cb 100644
--- a/arch/microblaze/include/asm/setup.h
+++ b/arch/microblaze/include/asm/setup.h
@@ -10,8 +10,6 @@
 #include <uapi/asm/setup.h>
 
 # ifndef __ASSEMBLY__
-extern unsigned int boot_cpuid; /* move to smp.h */
-
 extern char cmd_line[COMMAND_LINE_SIZE];
 
 extern char *klimit;
diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
index a8fc15ac4291..dd121e33b8e3 100644
--- a/arch/microblaze/kernel/setup.c
+++ b/arch/microblaze/kernel/setup.c
@@ -41,7 +41,6 @@ DEFINE_PER_CPU(unsigned int, ENTRY_SP);	/* Saved SP on kernel entry */
 DEFINE_PER_CPU(unsigned int, R11_SAVE);	/* Temp variable for entry */
 DEFINE_PER_CPU(unsigned int, CURRENT_SAVE);	/* Saved current pointer */
 
-unsigned int boot_cpuid;
 /*
  * Placed cmd_line to .data section because can be initialized from
  * ASM code. Default position is BSS section which is cleared
-- 
2.25.0

