Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0EEC35DF8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC04A2467A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEITAgIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgBYHwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:52:01 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55022 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729589AbgBYHwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:52:00 -0500
Received: by mail-pj1-f65.google.com with SMTP id dw13so891078pjb.4;
        Mon, 24 Feb 2020 23:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T1LnGLoBaV2TTPUF6toPUaaqUjCR3lePLHm0eYLmXyU=;
        b=iEITAgIl00kyXUWSBKvpCYdnRJXBwyc+KUDYeJYmABzTDgw3gcRNZBbg8LlnJz/oNX
         v8YYzG1FvT8RwvFlEPaC+A1kXJd/owZ7a+ucuUQ6OtLBcpN3As8Clp6EahNILoAjLLYL
         QJdwLi7cthjDRR+Sc+AmJ76XAMdAwNQJHg6Q12G20zFoNhffXATJn4PtI6qlYuIisw20
         fHDE340iO7iweLR3SccBAnIXnD4bG5lWttzj9AE4RlRsqH+6EeznJ6uDGhmOas6WMXIK
         0T99p1wIA1w8NTUrngcs5PxIklGlUbgiXe328C+qNmbbhTW7hZtkkXPAOpnXlA/iajxO
         H0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T1LnGLoBaV2TTPUF6toPUaaqUjCR3lePLHm0eYLmXyU=;
        b=H4b+KqLhGJ9ASW5rLFfQe6wx1OGriGTWvrmQHUy+yNuMRngbZSY5EX6i02BXJA+1x9
         PQzVKL0zD1abckSHuoR8fSsVE0e0p7HZJLNnqLVOsnYUUXM34RChr2bt+r9ukxixQq24
         w+opFE2fKXucJ+aCmUEU4/e4gjPS9X4XqA60OcdX7U6pZJqX/srYuzWkoMDUh7pAph1+
         rvG5fzc4Cv3WkSizDv19tFIyJVx8SPzhS5qsoFqJ9PTLVkiLhPb6E9gPKuoa4pe9pXmj
         nuoU+A9eYwn2aqkcXEksrLqduxKeyU0CbIY8RnCzKC7p0YaI8eyg3J6yGZQf3QnXfAcp
         2MgA==
X-Gm-Message-State: APjAAAU2CbJ0L5fXdQUMQEvXACcNuxFHhDVUfLiHuRhOQuG8zkzKKiap
        qeOrdzxS1ZM38wQEzoKUUQM=
X-Google-Smtp-Source: APXvYqx+5pXqKxI4ULLR6ATgJX5fTRooYMW74dM+2ZDktjJeVYsoT2ZTDKe76IT+s1v84AUfEpO83g==
X-Received: by 2002:a17:902:7c07:: with SMTP id x7mr3617020pll.232.1582617118595;
        Mon, 24 Feb 2020 23:51:58 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id w189sm15983184pfw.157.2020.02.24.23.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2020 23:51:58 -0800 (PST)
Date:   Tue, 25 Feb 2020 13:21:55 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Barry Song <baohua@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Prisk <linux@prisktech.co.nz>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH v2 16/18] clocksource: Replace setup_irq() by
 request_irq()
Message-ID: <20200225075155.GA6735@afzalpc>
References: <4e565e7afa2f2a0ed89774d0a1597649173b1746.1582471508.git.afzal.mohd.ma@gmail.com>
 <202002251058.U8V8FHji%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202002251058.U8V8FHji%lkp@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 25, 2020 at 10:52:55AM +0800, kbuild test robot wrote:

> Thank you for the patch! Yet something to improve:

And thanks for the report, i will try to improve :)

> [auto build test ERROR on tip/timers/core]
> [also build test ERROR on arm-soc/for-next powerpc/next linus/master v5.6-rc3 next-20200221]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

i did use --base option w/ git format-patch, though the output of it
was rigged to indicate a human understandable start point that can be
parsed by the script as well.

In cover letter, there was "base-commit: v5.6-rc1", test robot cannot
make use of that information ?, since my thought was that your script
would create a branch with any valid start point following
"base-commit:"

>    drivers/clocksource/timer-prima2.c: In function 'sirfsoc_prima2_timer_init':
> >> drivers/clocksource/timer-prima2.c:213:2: error: 'sirfsoc_timer_irq' undeclared (first use in this function); did you mean 'sirfsoc_timer_read'?
>      sirfsoc_timer_irq.irq = irq_of_parse_and_map(np, 0);
>      ^~~~~~~~~~~~~~~~~
>      sirfsoc_timer_read
>    drivers/clocksource/timer-prima2.c:213:2: note: each undeclared identifier is reported only once for each function it appears in

Does the robot keep the log of patches that are successfully built ?,
w/ v1, i did not receive similar report, and tried to find if test
robot has successfully built v1, but couldn't find out.

Regards
afzal
