Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30859C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024BC208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fAAklVNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgBUPQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:16:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34868 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgBUPQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:16:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id b17so2302683wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lsRtvfQ93vhY3R5WN0DHRgFSBr0NRD5+eVgC+E/3Pbw=;
        b=fAAklVNs6u22WEFZnDC9d3+wS0ae4X2F3sUylnwCuDLPilr2eb91R4kz0vBP7QrY/v
         QKDxU7B7r4SuuQR4fWjmrGd9kF0elPfjL6nTklyFRi+Yng5dntCdgTHHcN478Yg3aJRA
         B94xKDBI6YBo3mAp3NyWMsm0TG1okPl9+xTc27v/at80ODKV0fXF+7nwvGDdGlCD0JdI
         0OnR6zADpSAuhYhBmVicqBS5eXMNLC7B8tgGwSb3ejDcTaY8HHEC28xksKWyFzKns3WJ
         EueDIvgrc5dCfwDqMMRpyTwE7GOZGmOYu5/VjtsyPJR+C9E9d+ojXpEJu/kGABv4mDpS
         7Myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lsRtvfQ93vhY3R5WN0DHRgFSBr0NRD5+eVgC+E/3Pbw=;
        b=Rbil1DgBgFwHdnrYwRD/px9MYq42ULibKqKMH6Dv1skmmgTl6u7RKTiEzXECNIPNn0
         +VSYOA6mDudsbPgF3eE4EJ+3SXHS/jY8NnfalsjHj8Trwyy3jZ8PMzfzN4pphQ7szEhM
         bMx493hpNVMjxS9XjX6V8HKJ8Sl8gcISkckHQVjIKwHKM3CdaCMYCsMk7m0swtVQ5sq4
         xppb9ow+lmULaeI0PXQVx+5zppx5cwJD2Buchycg9SaWWVUw0t9yxw6RT3VtPvvjWDO1
         8t7IVUYhTJzL7SrDI7CVjtTh8qD3y5rOH22Q6KRdYaYtUaVSTOvSX2JWXHby2ViJVl9G
         eq9w==
X-Gm-Message-State: APjAAAWBpVwWhuv6eACmPG8xP+Eb/dxSw0IPSs7lS6lq3bJbcmedESvN
        5sDSRsJU8ijkDZH9nJg8Jz0vLTiPsAs=
X-Google-Smtp-Source: APXvYqxw++XREifah78diEeK1TZzx8Ns6mS0TdJog/RtI1u9e/6SveUpjFpR92+56VCNuy0kMv6cdw==
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr4450716wml.110.1582298175055;
        Fri, 21 Feb 2020 07:16:15 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:903b:a048:f296:e3ae])
        by smtp.gmail.com with ESMTPSA id b16sm3955789wmj.39.2020.02.21.07.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 07:16:14 -0800 (PST)
Date:   Fri, 21 Feb 2020 16:16:12 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 05/17] ARM: tegra: Propagate error from
 tegra_idle_lp2_last()
Message-ID: <20200221151612.GJ10516@linaro.org>
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200212235134.12638-6-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:51:22AM +0300, Dmitry Osipenko wrote:
> Technically cpu_suspend() may fail and it's never good to lose information
> about failure. For example things like cpuidle core could correctly sample
> idling time in the case of failure.
> 
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Jasper Korten <jja2000@gmail.com>
> Tested-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

[ ... ]

>  	cpu_cluster_pm_enter();
>  	suspend_cpu_complex();
>  
> -	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
> +	err = cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
>  
>  	/*
>  	 * Resume L2 cache if it wasn't re-enabled early during resume,
> @@ -208,6 +210,8 @@ void tegra_idle_lp2_last(void)
>  
>  	restore_cpu_complex();

If the cpu_suspend fails, does restore_cpu_complex() need to be called ?

>  	cpu_cluster_pm_exit();
> +
> +	return err;
>  }

[ ... ]

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
