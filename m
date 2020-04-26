Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE883C55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 09:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A772080C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 09:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bk4mcskw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgDZJBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 05:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgDZJBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 05:01:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A065C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 02:01:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k13so16814900wrw.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 02:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=lofCixorE1bp5llJD+FvSikURJhRCNWg0J3fJX4vNDM=;
        b=Bk4mcskwFHsT1BmbuQgaiutJtFhGwIoRjaWAEgImHaQM01JegOkcDCclIZ9rT4llDc
         tsdrw038OsZwtSLxdgt3OgdMysZ50619/sHkEdZK/u0dJERv7AqbLYYLCnSC53LG0pZY
         EH3EGmKYTpEI2S3k89x0/eLZQKzu+fLcHIW2ltAOIRsMShHgx4wshungQ8BDHEuoe1hG
         Ndg833dWgoALduxIIvyYiTEEnY6DiFTZQ+pLzAEGn4zbzOQciQaDkgv4C5VpAtplMh8c
         ewIC26hDiBUTbIZiGO+s7Gg0hl3EevB0EI2FHHoSN2ZYkjMM4I86OCSBrUJKcjOzqMq5
         SdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=lofCixorE1bp5llJD+FvSikURJhRCNWg0J3fJX4vNDM=;
        b=gr831nM/R1kVmhJlyIA2DIjQcTho5RAYodQpajxl/aJq6t/lzeeaI7M+UueN97RdYl
         PZ5ksC/s4yCA4lU/g+g414Qlv2YKOj7pGHOHWlyLsJ1vTO9Ozd/hZyWxSbyzoensCAPc
         497HvIXteQLQJW+oxdK5NdOnQI7zO46GETrOwDC1NkDZ7XXfkTmKYVChqDTBVWPy/B0Y
         mg0vnWbeRrL6FzvkBNAorqzWQfdcqmPgb8VWQbQZ7oU5D80cPC/iNCQMS09IHPUNz3TI
         z1jpwEOznDma2Zd+ULAC0/N1zMmC5AZcvsnKBYq9mstliEVI3X8TacOFRFBFJS75eFaB
         xppQ==
X-Gm-Message-State: AGi0PuaN8AmYvWR6Y8dZpJETKwRkgms2CY4OaSsAg7RqCNFZhxIx/fXw
        9whxK639ydcWMCQk2AHoS34kcso=
X-Google-Smtp-Source: APiQypI71HGTs54P/TxnneGNFp8lga5qawL7mlRMWUO5Ukrqh5CMfENlf7RhT1RVMrv+kaGESvjciQ==
X-Received: by 2002:adf:f343:: with SMTP id e3mr20544863wrp.51.1587891663751;
        Sun, 26 Apr 2020 02:01:03 -0700 (PDT)
Received: from localhost (catv-176-63-31-101.catv.broadband.hu. [176.63.31.101])
        by smtp.gmail.com with ESMTPSA id m14sm15871089wrs.76.2020.04.26.02.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 02:01:02 -0700 (PDT)
Date:   Sun, 26 Apr 2020 11:00:18 +0200
From:   =?UTF-8?B?TcOhdHnDoXMgSsOhbm9z?= <mjanos5@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: [PATCH] TIMER Refactoring: avoid unnecessary recalculation of cpu
 skew and remove duplication
Message-ID: <20200426110018.7bb67f03@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 2a31a3b1db7898cf2360b628fa8717d85aac3e22
Author: Matyas Janos <mjanos5@gmail.com>
Date:   Tue Oct 18 21:20:31 2016 +0200

Refactoring: avoid unnecessary recalculation of cpu skew and remove duplication

Signed-off-by: Matyas Janos <mjanos5@gmail.com>
---
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a5221abb4594..f6de4d68e652 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -275,6 +275,7 @@ static unsigned long round_jiffies_common(unsigned long j, int cpu,
 {
 	int rem;
 	unsigned long original = j;
+	unsigned long cpu_skew = cpu * 3;
 
 	/*
 	 * We don't want all cpus firing their timers at once hitting the
@@ -284,7 +285,7 @@ static unsigned long round_jiffies_common(unsigned long j, int cpu,
 	 * The skew is done by adding 3*cpunr, then round, then subtract this
 	 * extra offset again.
 	 */
-	j += cpu * 3;
+	j += cpu_skew;
 
 	rem = j % HZ;
 
@@ -295,13 +296,13 @@ static unsigned long round_jiffies_common(unsigned long j, int cpu,
 	 * as cutoff for this rounding as an extreme upper bound for this.
 	 * But never round down if @force_up is set.
 	 */
-	if (rem < HZ/4 && !force_up) /* round down */
-		j = j - rem;
-	else /* round up */
-		j = j - rem + HZ;
+	j -= rem; /* round down by default */
+
+	if (rem >= HZ / 4 || force_up)
+		j += HZ; /* round up */
 
 	/* now that we have rounded, subtract the extra skew again */
-	j -= cpu * 3;
+	j -= cpu_skew;
 
 	/*
 	 * Make sure j is still in the future. Otherwise return the
