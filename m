Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E5FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 12:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B30C12075B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 12:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJLN9zcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgHBMrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 08:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgHBMrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 08:47:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876BAC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 05:47:17 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a15so31737944wrh.10
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 05:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qxj7CDm8G5o5DKXYiU0gRx372hA5vyn7d2K7d5Klrxg=;
        b=aJLN9zcY6rax5mB4sFLM9291LQqsRZnT8kNSlRN0Mgeu/rUbTqggdj46LFdMTUzHJG
         5Ulcxg9HqoTF3xc/vn1jQlEAAg1OXHwVymO/nFXZCTST59xKEaufw9vgoQcgbUron4ca
         rsVzQgbCOpoZzEPnUlXt5E0GguBYK+0FfpfmrN73qPBV1XCUnbgRhpKsVYeISaJJGjnk
         tHL3emhFcPcrKELhKvORGsCPD7IEeUNNRpPWbv5sH8c1hovlbIMd972xihWfqwj+035O
         qSy/Pj6IhREdm+iJmn97FqSgb56OWfg1uc06GcCQDq9Kg8M9ChHnWPkwmoCIKnWb1ewl
         0LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qxj7CDm8G5o5DKXYiU0gRx372hA5vyn7d2K7d5Klrxg=;
        b=c/dbmWJC+KqxGd/qBUhln9NFFfrqAMlYPjhcN/7A3yfygmCegi5H7WbDwdL6w54mDK
         2n6/5+57Vd9/9YXl8HX4hSmGR3xTCnKt610lntYfnS5Z4NSVZyoA9qhJUshxwBMLZV6A
         7w8sC8JGv9CMSeelCSUusodGFKC1oyRRDrfnKF74bhNVpSoMd3tubZh52T/pM4qwbd/s
         +HHKzrToXJ+E9fWvHpidsuPrP68Me3ZggrK17ycApppvzN5cIxwUkc8JyVs88STNeNWY
         qS32uX/mbEZ7fswxkpcrP2HI2zMRnSJXJ3bLqzGHefR4V+w5+CB4BviDgyw2luDwHj/G
         dqIQ==
X-Gm-Message-State: AOAM531SPF+UIgidPAwe89sPB4KgJoQQdkT+jgf9tXQSXqELVTT3VlQM
        Z/1ehpq9XdCwHud+kypKLC5k2JmvvUyE0A==
X-Google-Smtp-Source: ABdhPJwQ1hOQdvkdrK0xBFN8STvIFB7VU+Zx8pZiXSETofpYVte0xAZm5QhcYMiN0g5k4E8bYP5y+A==
X-Received: by 2002:adf:df91:: with SMTP id z17mr12197378wrl.149.1596372436002;
        Sun, 02 Aug 2020 05:47:16 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:8872:7c8c:b1b3:10aa? ([2a01:e34:ed2f:f020:8872:7c8c:b1b3:10aa])
        by smtp.googlemail.com with ESMTPSA id z6sm20434375wrs.36.2020.08.02.05.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2020 05:47:15 -0700 (PDT)
Subject: Re: [PATCH] clocksource/h8300_timer8: Fix wrong return value in
 h8300_8timer_init()
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        ysato@users.sourceforge.jp, tglx@linutronix.de
Cc:     uclinux-h8-devel@lists.sourceforge.jp,
        linux-kernel@vger.kernel.org, tianjia.zhang@alibaba.com
References: <20200802111541.5429-1-tianjia.zhang@linux.alibaba.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8f0e10e7-5a59-b6fb-c88a-769dd068cd28@linaro.org>
Date:   Sun, 2 Aug 2020 14:47:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200802111541.5429-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2020 13:15, Tianjia Zhang wrote:
> In the case of calling of_iomap() failed, a positive value ENXIO is
> returned here. I think this is a typo error. It is necessary to return
> a negative error value.

Yes, it is.

Applied, thanks for the fix.

  -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
