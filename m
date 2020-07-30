Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E96AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C3A62075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYVboXYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgG3Ixj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgG3Ixi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:53:38 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63D2C0619D2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 01:53:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p1so13440034pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 01:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g/F+xHLHXd/8ZK6rRny/UPGuRPEZkN35i9bRzFzL+j4=;
        b=eYVboXYblrL6RtiIxbJMiDIHoMMoENN+pSuhwWnshhdoyeEgfnz9JQSxsg6wqYbDye
         5mVYcgt9RPNn6uHYKOpoXXojVKxAp9E3jUr0PHcH0ulOM8g0uG9A7MXThCy5iMcp7he6
         SbD4NW2iPk+FLH0Mx+FfBWyOl4meaY3hDWMQT6815OOzUADDh85sxYIN5e1RGreWm3Fz
         sONgc+IpTZnyjt3F5jad5IIXviZh4ZyGaVtN/ziIqpk5DDJTnBDnD7O2fgQoPq3+Rje5
         ktREp/V3FCN3+X64XSzUbICHx9cZZ0XFwmT+MBPGT//qPw9jF5EaYvvvijHDbedOIsLE
         MGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g/F+xHLHXd/8ZK6rRny/UPGuRPEZkN35i9bRzFzL+j4=;
        b=IZ8UL3ksTqaliOtuq2bm1TU4bVwIg31kcGH2xAsb+aRuWiXDeJ+JrzC7QpzSZc1lil
         oR6snoO/wpPqABAm+DtXJbuazytYjaaRAT8OtDQir2e+Gu/qxmrTUCC5z4kx28vQP3rk
         6o87iwgX98c61VndUCAmVUjLhA4zDpXoqsc1ZX5ETOlxL8ot14r2n1BuVhSA8ROS8txf
         R49Zx5karkHU5Da9KUifSTPz8M5HMMBBYJ0nqPH9Bx4OYYpRhhQKmDEyTJwofw7jMUzG
         wXcHxdk5ad8U9ZjY0Ysm5hz6yV7UwFIRV0cwd/HtcW+8z9NRsujfGjkV9wNUrAjiKg0T
         JNhA==
X-Gm-Message-State: AOAM533GhMy3DxqghoC0vJAuCt2YbquWl/JRbYDfZojANs1OVghiAY24
        HvGA5A/rWGHIs1A+W5A7ktZUgA==
X-Google-Smtp-Source: ABdhPJynGbQhVKvlob9Kyth3PdwegGJXph6cQB/rXc/Czv0Fyoem2apeOrLEwVIDrGiXSlw9TkRh2w==
X-Received: by 2002:a17:90a:a502:: with SMTP id a2mr2134344pjq.15.1596099217283;
        Thu, 30 Jul 2020 01:53:37 -0700 (PDT)
Received: from localhost ([106.201.14.19])
        by smtp.gmail.com with ESMTPSA id q13sm5531410pjc.21.2020.07.30.01.53.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Jul 2020 01:53:36 -0700 (PDT)
Date:   Thu, 30 Jul 2020 14:23:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com,
        cristian.marussi@arm.com, rjw@rjwysocki.net
Subject: Re: [PATCH 0/4] CPUFreq statistics retrieved by drivers
Message-ID: <20200730085333.qubrsv7ufqninihd@vireshk-mac-ubuntu>
References: <20200729151208.27737-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729151208.27737-1-lukasz.luba@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-07-20, 16:12, Lukasz Luba wrote:
> The existing CPUFreq framework does not tracks the statistics when the
> 'fast switch' is used or when firmware changes the frequency independently
> due to e.g. thermal reasons. However, the firmware might track the frequency
> changes and expose this to the kernel.
> 
> This patch set aims to introduce CPUfreq statistics gathered by firmware
> and retrieved by CPUFreq driver. It would require a new API functions
> in the CPUFreq, which allows to poke drivers to get these stats.
> 
> The needed CPUFreq infrastructure is in patch 1/4, patch 2/4 extends
> ARM SCMI protocol layer, patches 3/4, 4/4  modify ARM SCMI CPUFreq driver.

Are you doing this for the fast switch case or because your platform
actually runs at frequencies which may be different from what cpufreq
core has requested ?

I am also not sure what these tables should represent, what the
cpufreq core has decided for the CPUs or the frequencies we actually
run at, as these two can be very different for example if the hardware
runs at frequencies which don't match exactly to what is there in the
freq table. I believe these are rather to show what cpufreq and its
governors are doing with the CPUs.

Over that I would like the userspace stats to work exactly as the way
they work right now, i.e. capture all transitions from one freq to
other, not just time-in-state. Also resetting of the stats from
userspace for example. All allocation and printing of the data must be
done from stats core, the only thing which the driver would do at the
end is updating the stats structure and nothing more. Instead of
reading all stats from the firmware, it will be much easier if you can
just get the information from the firmware whenever there is a
frequency switch and then we can update the stats the way it is done
right now. And that would be simple.

-- 
viresh
