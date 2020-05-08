Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400A2C47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 178A3214D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImULIUI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgEHWCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 18:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726811AbgEHWCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 18:02:44 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3A2C061A0C;
        Fri,  8 May 2020 15:02:43 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a21so3251077ljj.11;
        Fri, 08 May 2020 15:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lhCsaegrOoZCl6vEZUTaZb3RsjsXs48GL1YIxAy2vMI=;
        b=ImULIUI8vS4rl30btrShLAv/odGxPb+iKIwLWS8bpsq8EqlczEXeOHncOPDLih+Px7
         uU9n0bwtBXNBGGJiHNgj2kmCMPOE/IW08jsh+I0AQzL0tbzcGAid1l/wBxL8affWHSaS
         4Yyd5V+/8Lk+UCopi4EWT9m7UrILlhs6fl3GdoOg80g6tMmwJrTnA10sFgEM/glQeJZZ
         59XRifwnZOajpkXY518U5eH1D8yv/L6GtZ/9UMmJ9jx7D0pQUifX0VS5qIK0wHrIcTVz
         Lgpsp5hODw/VsKDu1DTC1gDjGj6Oz5o14hDM8BEMOAB0TeEaReBYn6DELaFqyzEcMscj
         0JtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lhCsaegrOoZCl6vEZUTaZb3RsjsXs48GL1YIxAy2vMI=;
        b=HNMjdSapsWBjhniCHru2aovEIT75DLDUeRkbcxASs77rH35xcvJGds8VHNay3zw5D7
         VYHW484KXnnjGHWnc3uDdBcLHb0vIbT09zPn0BmD2fv5BraJNPoxN6IbtEKePFG7c9wc
         IfhuWJqJ2r4A6uJMnCXfhKdESusOvA3pmWizVETxYdIn68+v+Lv3QhNg/zhqc+BkWrn6
         JPCbSOTbnGonPbav8w9h8ACQSYyJLFYqkUlashD+v3kRNZVsAqKG4jp10Y9P/bASrxBi
         sMyocxj8YZ0ePHsgS50TgupH21VwbY1zM9EDsYTX8cFFCZBP7WKKH8YWKcBJam2yGYSJ
         EoKg==
X-Gm-Message-State: AOAM53107obdlYeBpOE8hBDxn3Rj3dnE6MSJT7GzQzy+w5eYLDBFwAv7
        Fk4ZpuEt9Gu9CaM/+K2TTr4=
X-Google-Smtp-Source: ABdhPJw5V0LEup6lO2Xmzty14DNHX7dQZQi4Pw21Q/XfLitxOcS1zS+lmtgxbzVOiXxhlLAowrwfww==
X-Received: by 2002:a05:651c:505:: with SMTP id o5mr3196487ljp.0.1588975362361;
        Fri, 08 May 2020 15:02:42 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id s11sm2260983lfo.86.2020.05.08.15.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 15:02:41 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, nsaenzjulienne@suse.de,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        eric@anholt.net, wahrenst@gmx.net
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] clk: bcm2835: Constify struct debugfs_reg32
Date:   Sat,  9 May 2020 00:02:38 +0200
Message-Id: <20200508220238.4883-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bcm2835_debugfs_clock_reg32 is never changed and can therefore be made
const.

This allows the compiler to put it in the text section instead of the
data section.

Before:
   text    data     bss     dec     hex filename
  26598   16088      64   42750    a6fe drivers/clk/bcm/clk-bcm2835.o

After:
   text    data     bss     dec     hex filename
  26662   16024      64   42750    a6fe drivers/clk/bcm/clk-bcm2835.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/clk/bcm/clk-bcm2835.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index ded13ccf768e..7da3b1ba1377 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -396,8 +396,8 @@ static unsigned long bcm2835_measure_tcnt_mux(struct bcm2835_cprman *cprman,
 }
 
 static void bcm2835_debugfs_regset(struct bcm2835_cprman *cprman, u32 base,
-				  struct debugfs_reg32 *regs, size_t nregs,
-				  struct dentry *dentry)
+				   const struct debugfs_reg32 *regs,
+				   size_t nregs, struct dentry *dentry)
 {
 	struct debugfs_regset32 *regset;
 
@@ -1240,7 +1240,7 @@ static u8 bcm2835_clock_get_parent(struct clk_hw *hw)
 	return (src & CM_SRC_MASK) >> CM_SRC_SHIFT;
 }
 
-static struct debugfs_reg32 bcm2835_debugfs_clock_reg32[] = {
+static const struct debugfs_reg32 bcm2835_debugfs_clock_reg32[] = {
 	{
 		.name = "ctl",
 		.offset = 0,
-- 
2.26.2

