Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D308FC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEDE5206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EE8ROhQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgDWO0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726068AbgDWO0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:26:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8C2C08E934;
        Thu, 23 Apr 2020 07:26:34 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d184so3025337pfd.4;
        Thu, 23 Apr 2020 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aneiRCA50vAzubtGKmjmJT4bwgD2W0Rx0hNrzKdvMIM=;
        b=EE8ROhQrsKp+SKKeVgB/oHc2SdkZpZcZfqh9PqeRwgXpzp4CEgiXyQWVYLo1Hany6G
         zhLRXT2RT3nDcfC+Q7xFV5TaEAhThEOILMB+GC7NoOpOd16X1J9vkMtHJdyJjNJCbegA
         XjfCllKqA1U0XCdDPvSXrKpZPE5RDXkz3wSk2uuhOk2iX7V/DF/f6qY8EB1OJwAsPtfQ
         VYrCc7D3ZiyUSXPf15Ed6TtttZkeh5fKR99xvHDGd5Ii9WUYk/S1gRPH8LhlA3IrJ006
         VJXSnUFUj+I4EHCwXWGbDsxmR7qtBIUJnLyx4uOyJTDocmmeCkOnkqgzQH5HahsEeJb5
         e+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aneiRCA50vAzubtGKmjmJT4bwgD2W0Rx0hNrzKdvMIM=;
        b=tN0BG0U9b2PcireFvkPiIFrsyPVw4A4uW89/pUdMPiLm66ysaggtJRaFSN4PgJGYWA
         rzuUN0wtbvrKhXgLo6Fx7/0s2dVcc4pEcbKHI+CjGQ8l4Iy0rk18uyHpLpapDTXw5STl
         RlsTzV7eML/f4vNKgpDUFd28DXB1L9FAMOZ9sR+jY/FFnH5F0pyD0TrNx0+SPuCNV2tL
         ekGVZTILbUtxZjUqKXs+5pTmJ2idw1lw/dTm6Hzl6Kj8Z2WO1nx6Y4V0/U26miy7eSKk
         T2EWJBMxaHxlYC53dRmFHAF5F+XOWq3TqsJbD2in+3pX8zRj7oE0/hCO7mJgtzcfr6eL
         gGXw==
X-Gm-Message-State: AGi0PuYjG4Dwvczx+8N3i1oowPBgj1Auf1BCTPIgFAG0Wvj8mlA2A7d5
        CkCYsmqpw7Z1fwuqw+3JU0U=
X-Google-Smtp-Source: APiQypK/lVoX0fg8UENl82mCz0W+dZgsUBwikvkecQKoTS04dwfuTust7mIKAAoyNfsXzkBnUI9Rsw==
X-Received: by 2002:a63:48a:: with SMTP id 132mr4255931pge.380.1587651993798;
        Thu, 23 Apr 2020 07:26:33 -0700 (PDT)
Received: from localhost (176.122.158.71.16clouds.com. [176.122.158.71])
        by smtp.gmail.com with ESMTPSA id a19sm2846848pfd.91.2020.04.23.07.26.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 07:26:33 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     gregkh@linuxfoundation.org, tglx@linutronix.de,
        FlorianSchandinat@gmx.de, b.zolnierkie@samsung.com,
        ralf@linux-mips.org, tsbogend@alpha.franken.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2] console: console: Complete exception handling in newport_probe()
Date:   Thu, 23 Apr 2020 22:26:27 +0800
Message-Id: <20200423142627.1820-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A call of the function ¡°do_take_over_console¡± can fail here.
The corresponding system resources were not released then.
Thus add a call of the function ¡°iounmap¡± together with the check
of a failure predicate.

Fixes: e84de0c6190503 ("MIPS: GIO bus support for SGI IP22/28")
CC: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v1 -> v2:
	- modify the commit comments by Markus'suggestion.

 drivers/video/console/newport_con.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 00dddf6e08b0..6bfc8e3ffd4a 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -720,6 +720,9 @@ static int newport_probe(struct gio_device *dev,
 	console_lock();
 	err = do_take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
 	console_unlock();
+
+	if (err)
+		iounmap((void *)npregs);
 	return err;
 }
 
-- 
2.25.0

