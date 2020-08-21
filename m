Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24A7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 05:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A90620702
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 05:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i53SGtAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgHUFAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 01:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgHUFAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 01:00:32 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F258C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 22:00:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g33so443982pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 22:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xhIog8jW0T1b90LynPtu3oGxYtUKBFIhObGpRX5PCN8=;
        b=i53SGtAbChIAK2QxoCA21twg+Ec5u7kv6uYWEAjbS8pv69lMdJHtlb0PlxFiwOkDyT
         znrs7ZUO0uqko2hofD5heDRr7HNPkukxzJzckNnqQqMphu8z+MGYfO5K8PzAzR7kdqmB
         E7I7fdNqHtHMVmtPFkhRjzehVu+jlWlLm3QU/qR7uqe4ZC/M1UZekl5X9T5/wQHrjOrT
         3pO00cdtj0GxbB0uC59yUpLCKlx8UzwIW7Acua3rZn8WnwdJoCxMg82nuqLcavpwOnYt
         bP1Y3mVi0vBNNBIVYOfi902BrDqGmAbGSWhxrVTj22p0AYw6UtGLU9R55h19vulAZaLi
         yW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xhIog8jW0T1b90LynPtu3oGxYtUKBFIhObGpRX5PCN8=;
        b=iEOYb7ZssAwMnjRI4pWinF6Vw28su2g8Oehdon58DJREhh/sMJebj2rIFvGcvfOi1Y
         bH6uZ9YkypOcy28E65bGY9iee6BxyOJjo1s5D0wx9cXHCNB+Y6hnMJNRTVE/Wp1MyTHY
         +lz9Oq7J0NEpy1Bs2uk01st2g6KjzH8qPeEmm8GjTuUK+lrome97a17CJpGCTbbEuqgT
         qhv8ncm1/HrYNEOkSxdSdCAJHM/B5BsTp5Ge1DKqAKp4f033w3WnLUCEyiYMxaWIPIzV
         TRoz3dKrzvCBEN9O3VWRxqFbOKN56l4P9qq6kRwsvnJXaP1Lviywz3rM4d1JE0XQlCGy
         S4xQ==
X-Gm-Message-State: AOAM530+d5NHerqTNGBt6UaXlfI7uaJ6GDUS8i+fA0bMktcLxfbmvAUL
        xjEQoudTJDW+B1ZWR5xkZa/TlQ==
X-Google-Smtp-Source: ABdhPJzI19u3500KBRbjT18haaazuqFxPjzl/XcNJecb2bFf1ETTZ6cRXONSqFLpE27msha9PjqsTA==
X-Received: by 2002:a63:30c:: with SMTP id 12mr1042830pgd.155.1597986031559;
        Thu, 20 Aug 2020 22:00:31 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id s64sm837184pfs.111.2020.08.20.22.00.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 22:00:30 -0700 (PDT)
Date:   Fri, 21 Aug 2020 10:30:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com,
        zhangwen@yulong.com
Subject: Re: [PATCH] thermal: sysfs: Fall back to vmalloc() for cooling
 device's statistics
Message-ID: <20200821050028.ojao3u5je7dfhsnc@vireshk-i7>
References: <20200821024406.10404-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821024406.10404-1-zbestahu@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-20, 10:44, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> We observed warning about kzalloc() when register thermal cooling device
> in backlight_device_register(). backlight display can be a cooling device
> since reducing screen brightness will can help reduce temperature.
> 
> However, ->get_max_state of backlight will assign max brightness of 1024
> to states. The memory size can be getting 1MB+ due to states * states.
> That is so large to trigger kmalloc() warning.
> 
> So, let's use kvzalloc() to avoid the issue, also change kfree -> kvfree.
> 
> Suggested-by: Amit Kucheria <amitk@kernel.org>
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  drivers/thermal/thermal_sysfs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
