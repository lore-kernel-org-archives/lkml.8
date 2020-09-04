Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C051C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3975B20770
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ggjJL5Z9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgIDKwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgIDKwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:52:45 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FBCC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 03:52:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t10so6322150wrv.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 03:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+iE8KKkck/xEAOwmmOF3xny94TS+1Do/CvzA4IxanHc=;
        b=ggjJL5Z9HOKQFBj0T0XHZXCKcdvrBgKoB/723JkP+x5v+swsNt0f/7fTp/9KOXmPk7
         agfSAD7Migk+IEmxFZji8v1DMCeOUTlt4AuwNatt6iMrYaeX9Ig6Z5CN6jvD7Ujgq00P
         abApqDHg2ob9wcQvpRGvmGCV0CGY6RV6LgSENEUu7NEqP9pmBcSuQG0FlnNRYSQXs8dL
         BmA2rog4/yXvySGnc4cgRt6d09YoI3MwupjUKjjIzHAW1K6d8FOnjlvCOE6MRGqSILn7
         NVuq/3cciwlGQpL1gfmKsU8WEf+O5MDE1QfGbTSWDYdWXHDkQWLKEA5+qlpInIPEvIQv
         snOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+iE8KKkck/xEAOwmmOF3xny94TS+1Do/CvzA4IxanHc=;
        b=OroafUuH04pO1ShDROlh3yz66K45BClZ4te2/U3vE7mvzDbgovgMS9o0jPSmjvxf55
         tA6QVANPWSGZvRNGoJmB9xJNqVLUCV/e3VJTbOv+cewrDtfESSS/fRl+U2YG7W3p8LKu
         BpXGSuE1dI/hxF5qnA3CN5g4vSXja9AsQ6ClKM7yWOo68ptSz/MiR8fH+GP3v0tXZXNg
         Mna9qOeQuoUKq3SwVXBTlJlJtVbrV9KGHwXe43JDBMDdDwL1Pa7i8wnSbMkNNI2xjeXI
         WVi9/H4E7QXZEsvFN3Wvd0vRBtIinmv0TxBAfry8qOSGfpHedxi3lsY9Nt2vlbgEkcOC
         9HeA==
X-Gm-Message-State: AOAM531AG0/X3cleA+fb9JKnS3mVkgoj7CaBJFKE07WATCQlwcCZBp0o
        R2ej7TPx55h15VP1D9AZtgaEpkWRcu++qw==
X-Google-Smtp-Source: ABdhPJx2iyDL6jMli8nl/e42y75F1m3oC21j7pDQ6qUbWp1FFL1zlCZEGoeRupL7zatohnitC12szg==
X-Received: by 2002:adf:81c6:: with SMTP id 64mr6774218wra.176.1599216759238;
        Fri, 04 Sep 2020 03:52:39 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:35e2:113b:59f2:81a? ([2a01:e34:ed2f:f020:35e2:113b:59f2:81a])
        by smtp.googlemail.com with ESMTPSA id f19sm10387140wmh.44.2020.09.04.03.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 03:52:38 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Tony Lindgren <tony@atomide.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers fixes for v5.9-rc4
Message-ID: <921c157b-7f18-52bb-2d94-513f33cf9f41@linaro.org>
Date:   Fri, 4 Sep 2020 12:52:37 +0200
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

The following changes since commit b0294f30256bb6023b2044fd607855123863d98f:

  time: Delete repeated words in comments (2020-08-10 22:14:07 +0200)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git
tags/timers-v5.9-rc4

for you to fetch changes up to bc6717d55d07110d8f3c6d31ec2af50c11b07091:

  clocksource/drivers/timer-gx6605s: Fixup counter reload (2020-08-24
13:01:39 +0200)

----------------------------------------------------------------
- Fix wrong signed return value when checking of_iomap in the probe
  function for the h8300 timer (Tianjia Zhang)

- Fix reset sequence when setting up the timer on the dm_timer (Tony
  Lindgren)

- Fix counter reload when the interrupt fires on gx6605s (Guo Ren)

----------------------------------------------------------------
Guo Ren (1):
      clocksource/drivers/timer-gx6605s: Fixup counter reload

Tianjia Zhang (1):
      clocksource/drivers/h8300_timer8: Fix wrong return value in
h8300_8timer_init()

Tony Lindgren (1):
      clocksource/drivers/timer-ti-dm: Do reset before enable

 drivers/clocksource/h8300_timer8.c         |  2 +-
 drivers/clocksource/timer-gx6605s.c        |  1 +
 drivers/clocksource/timer-ti-dm-systimer.c | 44
+++++++++++++++++++++++---------------------
 3 files changed, 25 insertions(+), 22 deletions(-)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
