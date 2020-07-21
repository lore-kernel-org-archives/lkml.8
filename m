Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09959C433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C1520702
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rj+bXe+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgGUN72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgGUN71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:59:27 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1339EC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 06:59:27 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so21331536wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 06:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=8ZF6oWRKLZ+vCYZQr3Fo4CAwKBCkfUUcgICTHzPcMNk=;
        b=rj+bXe+N/QLRZEv0roVF69Gu6+bbMDze3X/DS5fOD5FHJ7E1VqTKFo2C1dIMDYgifb
         FePGcP3hb3tfoxc3z+hbXQ2rf3G+LaZCATGbnjraUTgSi6fP39Z9sVrxAbjeddhq+a9G
         yYlxX+isyjEm581k3nR8gsyItEgIrKhQmBW5CSTfufEMtbPT8XE61+I/lKJD3QQO3WI6
         LsFbdW82Z6l34VZQQVNN/xqUgWjCNn3XqLKC+WJhiXFCXupNp9CLeUXTqkHoPSui+MdR
         OG7+UzHYw86pd7JA5npgycDw09INGwprv5UOxKLOI078GJqXbVkaZorHMJvjGg5QFX0x
         TvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=8ZF6oWRKLZ+vCYZQr3Fo4CAwKBCkfUUcgICTHzPcMNk=;
        b=Ve+SuGtV2Jqj12DdNnWrGi3ahY0po6Py+c6GrSknf89RCyU3KXRg2/7J2JEoI21/Xn
         cTrAchpUBddrCqOkT0RX2MtvKigcLffJb+817g5Eo0R4ntYlQOqPpPvk4XZ9rsksK/2Y
         hmBr71LIs9QCnCqWdXqsrEqg4pyUigJ1Iwc8mKEZV6ArJ+FA/uOuPZICINBds0tUIVXI
         dYnoHdEurUW7ssFPpC0E1x9IrFvs0xYKFlDnEFGjC5noFuQg/zs2v/UvtdAjrgNi399k
         4+80B/zmfsNB98famBE57dQYCKxSqnjgstsjxWEmiJ1oeMyxs4wz5AjTF/cLfkSThlTZ
         Tm/w==
X-Gm-Message-State: AOAM5334Xsn/QcN3L1TUlZ0TVAtaW6EUX2D8dg0ONjti8OsdrU22qD3d
        lp+FxFIntSG96rvJLQd907i2k0rKJMk=
X-Google-Smtp-Source: ABdhPJxyUj/vE8NIyKOw9v8Ytxk/ij9mLh+7bkwIw2fuSTuY/4zM0YgbdJz/UQPzAcP6Yk8kaSlg9w==
X-Received: by 2002:a5d:6447:: with SMTP id d7mr1988687wrw.187.1595339965380;
        Tue, 21 Jul 2020 06:59:25 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c144:5385:c824:85ce? ([2a01:e34:ed2f:f020:c144:5385:c824:85ce])
        by smtp.googlemail.com with ESMTPSA id 31sm17580914wrp.87.2020.07.21.06.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 06:59:24 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Lindgren <tony@atomide.com>, Carlos Hernandez <ceh@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers fix for 5.8-rc7
Message-ID: <7a1191da-d112-99c8-91aa-8574c9637ea5@linaro.org>
Date:   Tue, 21 Jul 2020 15:59:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

The following changes since commit 30c66fc30ee7a98c4f3adf5fb7e213b61884474f:

  timer: Prevent base->clk from moving backward (2020-07-09 11:56:57 +0200)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git
tags/timers-v5.8-rc7

for you to fetch changes up to 6cfcd5563b4fadbf49ba8fa481978e5e86d30322:

  clocksource/drivers/timer-ti-dm: Fix suspend and resume for am3 and
am4 (2020-07-21 15:48:33 +0200)

----------------------------------------------------------------
- Fix kernel panic at suspend / resume time on TI am3/am4 (Tony Lindgren)

----------------------------------------------------------------
Tony Lindgren (1):
      clocksource/drivers/timer-ti-dm: Fix suspend and resume for am3
and am4

 drivers/bus/ti-sysc.c                      | 22 ++++++++++++++++++++++
 drivers/clocksource/timer-ti-dm-systimer.c | 46
++++++++++++++++++++++++++++++++++++----------
 2 files changed, 58 insertions(+), 10 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
