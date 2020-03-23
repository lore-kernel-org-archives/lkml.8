Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DD7C10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD148206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaI7uUBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgCWGLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 02:11:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35712 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgCWGLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 02:11:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id u68so7009175pfb.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 23:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vfoKLrcgOv8lhgFhm678nBtvyoCad1xXGEKxp5I8sOk=;
        b=QaI7uUBdCw4wZBiXNO3VSb6ctt4H+hKvJZS3YpFOkrcOAF+JPD7hQbL/gOrRNsJ/xT
         Jsh8atyEeeJSPZyAzzPnYjl7AzENbxmf5ZzGnWCC21gEvC+sPttjlKcI1vYstKmT4LeY
         scPRUe1+9P4c+xkI2KFFXiFX9yB6Zvz2In4w57qhuxfDz6s+QSsnhl15EAf9e6L5drzY
         iH16L/9MKrDBwqiHWIiOp0dMoft1Yd73SxjMfq+kUgzDqSJQ334qKv+4fpcqyKjRF1+m
         Ukw35ivToU/Jsay1QQSLiIa57423ob8aebixDsanGI5JQqbMoeTEepMOBVyE+3FqeUI7
         Q8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vfoKLrcgOv8lhgFhm678nBtvyoCad1xXGEKxp5I8sOk=;
        b=UwQJyvd2XNGXsLimIS7aFwCP+dootufly4N2vcmU3sr0RR2piKuSaufhE8gZ0cpoeP
         vkP2Kb3a8X5RDHbfF2+K5KFRkN1YkbkJaJFbpK/Nh1Ixl9KPEkboPVsnPszTSvDIX7yY
         B1M/430O3W0ypIoOgIzGZ4XxsYpvFincQBDJKz9sJEv8Mfe31qPZGUiDOYgzOgYlfj1B
         MDxhpl8lELrH1RRaSxoSnyyXp6pHqjNhpz5c9aoTYw1NYvEicJk4sRIrJv/2QGIJaVGQ
         WbVN//bm5KCx8NpHHuOM+npIYLTRIk3UPAWomO8F8n2kOWUlW6+hmrBntnPimsPclrNa
         NhCQ==
X-Gm-Message-State: ANhLgQ0irIeXxCQyRNFALFpCYbqjXmr6D5SN7snrn9IgyexUkfvqmlqM
        Mb4wvWPuvqzSEAUtzxmZY5Q=
X-Google-Smtp-Source: ADFU+vvH2XMMCavwjfL57o367bU1E5OGljDM7FxDqXkhqUg/AKVp+CwZMLa1nPEBn1m98X9gJbitOA==
X-Received: by 2002:a62:4e4c:: with SMTP id c73mr23200170pfb.254.1584943892655;
        Sun, 22 Mar 2020 23:11:32 -0700 (PDT)
Received: from localhost ([49.207.51.24])
        by smtp.gmail.com with ESMTPSA id b25sm12268960pfd.185.2020.03.22.23.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Mar 2020 23:11:32 -0700 (PDT)
Date:   Mon, 23 Mar 2020 11:41:30 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource/drivers/timer-vf-pit: Fix build error
Message-ID: <20200323061130.GA6286@afzalpc>
References: <202003230153.VzOyvdbR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003230153.VzOyvdbR%lkp@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently all usages of setup_irq() was replaced by request_irq(). The
replacement in timer-vf-pit.c missed closing parentheses resulting in
build error (vf610m4_defconfig). Fix it.

Fixes: cc2550b421aa ("clocksource: Replace setup_irq() by request_irq()")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---
 drivers/clocksource/timer-vf-pit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index 7ad4a8b008c2..1a86a4e7e344 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -129,7 +129,7 @@ static int __init pit_clockevent_init(unsigned long rate, int irq)
 	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
 
 	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
-			   "VF pit timer", &clockevent_pit);
+			   "VF pit timer", &clockevent_pit));
 
 	clockevent_pit.cpumask = cpumask_of(0);
 	clockevent_pit.irq = irq;
-- 
2.25.1

