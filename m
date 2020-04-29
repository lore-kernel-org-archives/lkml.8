Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C30C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 609D32074A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXA/vaMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgD2PMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgD2PMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:12:33 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C49C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:12:33 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s8so1159915pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZtfxcAdJgvL3rHPILIPyvwSO0rRyZfKUkMWQ4mNPZT4=;
        b=IXA/vaMtixRg5KryB8HwKetJjz1dHyfr7hkD2KT2Lq+cGEbZpYyAkjmwGHsC5/AplN
         iY4noe7J6oEhFmhssZgyIou2PLm9jHrc8o2bNAPs2IMf6yZH36kzEM55OKXDxyv3XfDS
         xVp9WS4J0BMoH5gQG9PYdDhcXymiefnDCnKcn13fqbJdgN3u6vI+eF/Jv1yhU1iP7JAr
         iWbnrzWimQbxSikcM62nTQAJbibNwshiKXqQwNTCgKwbrZN+fpejcydB/hoMCK2yqxTo
         XVbcUljz9PW5AAgKSnQ7DjRNT6qYX+LBUVDCJMs3Fkjwjzpy3helPEiNtCyXEsx1QLc8
         dkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZtfxcAdJgvL3rHPILIPyvwSO0rRyZfKUkMWQ4mNPZT4=;
        b=XpDcqOlu+YPcPUeW363Z/J7ph7Yo82IoBKiRHiQKyLVc7vXgEo1A8pC+ICo6a1MDM2
         9OJPZsSytGLYTYJc2UsiGiyRExnDMOzNF4E3FAuR7Qkb7r2mrmx9RPWW8tw7YPWQntED
         CbSq84LmFj0Qq2zpG6fxCjYgh3g4ZiYYIHKVf3aIrAUSWgIJ/UK0AxLilELHYYR98VBI
         lHhfmRifsFy4tJMvBnYih4A35Tigs1v6u4hQX0Yn6+x3U6iEVEjjXzVtPuA0qqHunTPP
         61TiFGcjp1YycCe5xEtHytKp3xfG1J6LwkLjreSuZMVLjwdIFo6bap33rjffM1N2vXfN
         6qtw==
X-Gm-Message-State: AGi0PuYjK2nBkuHoOppEFWR2x+3w9ey4CI8xiAT2x7/9WAwxWw0kzcJ1
        lpAtfnKElSACOmFJT8l0YJQ=
X-Google-Smtp-Source: APiQypJ9KD3omt64yeDmK+4veD1+/ihs8MYf083XhRt4rgQNF1xaAZTkjvYoCOeSW/uoRsmyklXOow==
X-Received: by 2002:aa7:82d4:: with SMTP id f20mr36338827pfn.253.1588173153248;
        Wed, 29 Apr 2020 08:12:33 -0700 (PDT)
Received: from localhost ([89.208.244.169])
        by smtp.gmail.com with ESMTPSA id q97sm5305049pjb.7.2020.04.29.08.12.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 08:12:32 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     vgupta@synopsys.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v1] clocksource: arc_timer: remove duplicate error message
Date:   Wed, 29 Apr 2020 23:12:23 +0800
Message-Id: <20200429151223.3120-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it will print an error message by itself when arc_get_timer_clk()
goes wrong. so remove the duplicate error message.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/clocksource/arc_timer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/arc_timer.c b/drivers/clocksource/arc_timer.c
index b29b5a75333e..de93dd1a8c7b 100644
--- a/drivers/clocksource/arc_timer.c
+++ b/drivers/clocksource/arc_timer.c
@@ -334,10 +334,8 @@ static int __init arc_clockevent_setup(struct device_node *node)
 	}
 
 	ret = arc_get_timer_clk(node);
-	if (ret) {
-		pr_err("clockevent: missing clk\n");
+	if (ret)
 		return ret;
-	}
 
 	/* Needs apriori irq_set_percpu_devid() done in intc map function */
 	ret = request_percpu_irq(arc_timer_irq, timer_irq_handler,
-- 
2.25.0

