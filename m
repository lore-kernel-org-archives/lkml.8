Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A9EC2D0EF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 01:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8E1206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 01:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkVPuBUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgC3BZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 21:25:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40319 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgC3BZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 21:25:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id u10so19407275wro.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 18:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h8VbVmf4Tt1RXozkLLJMdZY7WTxZFWQRCzKKHxM4CQI=;
        b=AkVPuBUeR9qiMXRCdMCio7LCjPAJp1a2DPYQkbXbw0otk/5++1xTdo9WUoTdQHKbbf
         XXgUicqZBlfbHm3HmIlkcXuGNjgxeZv19PMYyEwKWHlQetH4sNrwWimHtD1MwgKIW4Xg
         cXYNbm4jyP1pftPEpU/t/1TGoAkvYofsrI0CqeXqhPP0DKpE9KEFuTpIa7oHghzBunpf
         kSqxudNINEMO6wwspRcjLAgE+FveVoz3GlZ2WdAdr2Ma9MG195HrkLeSoLl7AhapwiNz
         +vb6h7UzhBY6hyd8502xnxQHk/j0//KX29R7W3PELwu+K/hWsm7eh0bnIT6w1ESni7x+
         pNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h8VbVmf4Tt1RXozkLLJMdZY7WTxZFWQRCzKKHxM4CQI=;
        b=boYo1ey1HAdu1Qxq2pZukgTAlfSrAeL5PFzap5k6Y59ZPaaTuYLCm5VrnUFMo5D+/R
         wJdoCXlQZPUQjTvVClSyV0stuCLF6VhljaA6tu+LEOji7ybXvPU0hPPs14DH+QAnq7u6
         ps9ZenSABsT+VRbfs4uo02jkMRERZRrfAJPlqoClLMPrwmZUbewAhWEciXveQHqLg1x2
         xicG1+Z+GHAEoDI16Jh8AivM78j8Djq+FMNT8Lr1RVc0bhJHDgpQnR5Y03rfkZkDVYsG
         XOeqGxZc9TdaJ448l3nCcGb6bKUaRsclT/uG1rahFgw0XFYCWeKMuvYnOHcpbEUgDvjx
         SICA==
X-Gm-Message-State: ANhLgQ0OjTErXKByMnfvamWwM5aHpg5cZWiW8IDShCWKfOeDwL2nmQoH
        EtrJ0LEddkknBLAbhmIxBwTWDun4NwRQ
X-Google-Smtp-Source: ADFU+vuA9523QG5Y9KH0PuGOOob3LQd6VfMZJraUqYwGKufLkjVc9OJ9NgHf0U6knWXvdSXTmk39Qw==
X-Received: by 2002:a5d:6a8b:: with SMTP id s11mr4826111wru.283.1585531507617;
        Sun, 29 Mar 2020 18:25:07 -0700 (PDT)
Received: from earth.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id f12sm18679545wmh.4.2020.03.29.18.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:25:07 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     julia.lawall@lip6.fr, boqun.feng@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 3/4] genirq: Replace 1 by true
Date:   Mon, 30 Mar 2020 02:24:49 +0100
Message-Id: <20200330012450.312155-4-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330012450.312155-1-jbi.octave@gmail.com>
References: <0/4>
 <20200330012450.312155-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinelle reports a warning at noirqdebug declaration

WARNING: Assignment of 0/1 to bool variable

The root cause is that
noirqdebug, a variable of bool type is initialised with the integer 1
Replacing 1 with value true fixes the issue.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/irq/spurious.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index f865e5f4d382..70ba6d55d02a 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -431,7 +431,7 @@ bool noirqdebug __read_mostly;
 
 int noirqdebug_setup(char *str)
 {
-	noirqdebug = 1;
+	noirqdebug = true;
 	printk(KERN_INFO "IRQ lockup detection disabled\n");
 
 	return 1;
-- 
2.25.1

