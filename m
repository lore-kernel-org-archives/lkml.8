Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130DDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E13FC206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQ+VblBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgHXKlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 06:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgHXKlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:41:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D12C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 03:41:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b11so4016859pld.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 03:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XgbO9mR4mVK+VLe98mmxfWqoTjzntsorurnkGUqDaCQ=;
        b=ZQ+VblBjWGeESG4rusKo+1JZYRqRf6bSGcqBa0n7UR7OlQN91evh6PFcWm7y0cwdAl
         GoZGJDpLTdUtIPVhtpMg6jPckeHsuPgbiO1OBgN7vhQD6K241KUnVouI9K17/SmA6MZ7
         +dD9bsFPu01qj6HGGtRvTb5caKNSv/Z0B5egaB4dCbgeyMKmYvaPAyK7U3FTIOG97G/u
         ANP4lhMCYbhFlVxhdM/OoH45tmA6gmP0vfz4PoiBGXw8z13OtUmds+tSOcfv/3bWFlSn
         Wcx8GVsAakX8MCe1A8jTmjba7cT9q74/knHOzlGiek+AEA9vZ1v2970dJC3rTZ0Q2sLU
         xQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XgbO9mR4mVK+VLe98mmxfWqoTjzntsorurnkGUqDaCQ=;
        b=mD0gTaHf4YTQd/OogXeEm8s41bh/wXsUq8JEkq/XH6O/3EMVFx5K8Yn9YIO1Kp+5uJ
         oZJMLnkGlxuj0yCm6W3dOb1NWSo/ZFCqyAuoclmqyATuXCi7iwi+i8bemgB3Uw4xi+X9
         ii3vYal/Fh0GcghjSQysUPQtOk4ysyHze7Vh+vCeH0wLkGebn5kpAAlJcKpBniWFb0oq
         sPJTsiZsqEQmViUH/YtnJySndUsU0nXNyluQA4d9Ljn/1rOfjU9DXFvwQjbQTDrFNJtq
         fpvW3XfKK/TaAUjJMV7amXkwf83KFQqh2+jNpXz3fYWOAc6JhHa41uwXCRo1uu0DfIiH
         bGdw==
X-Gm-Message-State: AOAM533Uqj3Ocgy+cYbHXSzablAujTsHOo5rQJmfE3vWWoGy6CtDWE6c
        S8L+bzdcPOMw2gV7A/C/MxFEMw==
X-Google-Smtp-Source: ABdhPJzHp5qGiAawE2z0LljcaMUrf104gCiqxPBac1WAVL6UMn9NdE5K7a2ZqlOVIeg4Fersn7deiw==
X-Received: by 2002:a17:902:7585:: with SMTP id j5mr3553270pll.168.1598265661050;
        Mon, 24 Aug 2020 03:41:01 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id na16sm9040302pjb.30.2020.08.24.03.41.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 03:41:00 -0700 (PDT)
Date:   Mon, 24 Aug 2020 16:10:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>, vincent.guittot@linaro.org,
        saravanak@google.com, sibis@codeaurora.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/2] Add Krait Cache Scaling support
Message-ID: <20200824104053.kpjpwzl2iw3lpg2m@vireshk-i7>
References: <20200821140026.19643-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821140026.19643-1-ansuelsmth@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Vincent/Saravana/Sibi

On 21-08-20, 16:00, Ansuel Smith wrote:
> This adds Krait Cache scaling support using the cpufreq notifier.
> I have some doubt about where this should be actually placed (clk or cpufreq)?
> Also the original idea was to create a dedicated cpufreq driver (like it's done in
> the codeaurora qcom repo) by copying the cpufreq-dt driver and adding the cache
> scaling logic but i still don't know what is better. Have a very similar driver or
> add a dedicated driver only for the cache using the cpufreq notifier and do the
> scale on every freq transition.
> Thanks to everyone who will review or answer these questions.

Saravana was doing something with devfreq to solve such issues if I
wasn't mistaken.

Sibi ?

-- 
viresh
