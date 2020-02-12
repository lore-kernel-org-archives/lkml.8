Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAC8C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FCD206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="QS0q6vs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgBLPmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:42:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40272 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgBLPmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:42:35 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so3030339wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 07:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cACQsJWwFiJ//Fu4o4mSWW0Y1rR0wMyJpy57QHPtjPY=;
        b=QS0q6vs54hVcocgFUFeK+4LINB+ftiuYx3YaH2ZUQloL2B9Ib6fut8o1VorSdq6RLI
         XQmW3qkpXYvzFVgyr+OQhPEC12Z9VYPkpnli3/9QlzOlfUMcRK+0roA1weQzHRnKPxdS
         wklsQhODuG87Ynos/740IvX1K9ia/mPkB6duJi9kmoqMMbgQ3krmWauUBpwizoNd56Y2
         tsdPX6kXueM/IJLDmLify8bKrHeD/+H1dQfInoUtMWejcfKtSrNnCZJMD3OYzfDXhi6G
         9x/yQCNQ1AU+iN7QzG0TlHrDYUx1p+UJcHA2nBiC0Sn4XjtrWQRDT4khMUSgubfy3NEG
         IKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cACQsJWwFiJ//Fu4o4mSWW0Y1rR0wMyJpy57QHPtjPY=;
        b=W5CKpS267W5v0okWBGChPlqeWN0fOfmDYH8mCQ5jpiYs/b6y6udb3IGyAJY5zwWwcF
         Nz4jzel53Dxmv1waVqxFppFSs9uvlzyrmBsNrJbBJGUqLM3H2dOakYYVT8bb5eTxYgE/
         W02uvqGjGlAGHAd6r90BYM8hiL+PIdBjSBjQPyUCDMKo2+kKfAaLpB0rCHLt4eypaDMv
         hIU4iX9IluyX8HlOIZTTlEC0fhx+fTtNT2Hg2Bu66zkS00f9/3PebLG4sPI0blKsC+3z
         I4gw56UppUWhfRO2/HMLB5t1zFj/Qhr57tI1sYaFoIO8e1mKVLqDh7MjTmtVnhI8+Rz5
         b9aA==
X-Gm-Message-State: APjAAAUku3nRB/fler2cz1nHOH+d4HAc732Cs/w36FC98Ok3sluWmelm
        nBIvptK+1//JxSQXtHMuVC25gusdlGrK6xlA
X-Google-Smtp-Source: APXvYqxqVa0cdlyOfL7M1L5U+eix9NH2dA5/fQUbNwnzifAbMCYZ7uRxDTerFKfXVwijAwK3IYu9+g==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr14021469wmi.25.1581522152442;
        Wed, 12 Feb 2020 07:42:32 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id 16sm1226250wmi.0.2020.02.12.07.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 07:42:31 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>
Subject: [PATCH 1/7] microblaze: timer: Don't use cpu timer setting
Date:   Wed, 12 Feb 2020 16:42:23 +0100
Message-Id: <8e3b6647c57de3f6a65e1f46f852f019985fa893.1581522136.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1581522136.git.michal.simek@xilinx.com>
References: <cover.1581522136.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no longer valid that timer runs at the same frequency as cpu.
That's why don't use cpuinfo setup for timer clock base. Better is to error
out instead of using incorrect frequency.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
---

 arch/microblaze/kernel/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
index a6683484b3a1..65bce785e6ed 100644
--- a/arch/microblaze/kernel/timer.c
+++ b/arch/microblaze/kernel/timer.c
@@ -304,7 +304,7 @@ static int __init xilinx_timer_init(struct device_node *timer)
 
 	if (!timer_clock_freq) {
 		pr_err("ERROR: Using CPU clock frequency\n");
-		timer_clock_freq = cpuinfo.cpu_clock_freq;
+		return -EINVAL;
 	}
 
 	freq_div_hz = timer_clock_freq / HZ;
-- 
2.25.0

