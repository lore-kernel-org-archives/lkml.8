Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AAEC35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F110C20578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lxe0XZyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbgBUQ35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:29:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40624 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgBUQ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:29:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so2555571wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gsYHWWvvrbSnKE2h1s2uPePVi0iNmW0YqRRUZJzQR6k=;
        b=Lxe0XZycAYu+kEjhPwBiI7HBI6p1HU3eLM31JOauc6DYAgp+0uQrcAAq1VweQ3Psju
         O9LtNu3iJr92q2nJ70FXQIl5k9fGi9FrK3u9WbGTNniCNxn8z20YE32oDgBMVG4IFfME
         UKQmBzJMuWOKH4VgpMMSr8owiU4yaZiDNKvBYqSVs2h6ZG5GckqSwKx44lnVkdS1iQSw
         g2vkDBHJhKxrNTO3HFYRPu/13ObjNpou7SA/y/lNsONamYMCzVMxhsicxvcrqQNFhuu8
         O1uTD5rI/DAZbIjdeuEZQJkUb5yNgDLJmo+ZzoyxFkEi4veky205yxh7vXNUfMi0vM1S
         Jhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gsYHWWvvrbSnKE2h1s2uPePVi0iNmW0YqRRUZJzQR6k=;
        b=R6PrQIYE4EqXM89zjTAfwDuh5xpJXmse1fDOdzDS91O3xzfYXcow+r1RiWwrBo9KNQ
         88ECz7WeZoCWpuhUvQkOVR96QUo2v+fKhmOc6H4fTkLzxCFSkBmJ6ZNRjKShkA80jvWr
         ExebgRZVSp9BkWWxgavgeUWP/y5lHO52wV3Vs5j5oTQdcyrQ5Qdr4nvmDUcFixAJz+lu
         WpZwVGpPSeEfiFl+4WDfJbTI1phQavvcF5Y0IrYxRqD6t9DqzJYF86CA15EcYA3+lp2y
         dE6Ghe9LVXovtg33G/P0YTc9kemJFXui1hactxA3t5aQ+wySV+gE8KJtVYgD1mv6pGwt
         MP+A==
X-Gm-Message-State: APjAAAUb9UrgFQdSeODNlC3bfWZ39qGLBUilhQBWasILz5s5c6NeW5BC
        tJot3Et+82Q8PWI5v6Ni6cUVOg==
X-Google-Smtp-Source: APXvYqzUIIH/6h2MwdMx+WBw1B9W/Sdsz6REpLbvc95hgTFz2gWX+XjPsJ0sa3YEKmI9oVk1GQ8xoA==
X-Received: by 2002:a7b:c1d0:: with SMTP id a16mr4658764wmj.175.1582302594591;
        Fri, 21 Feb 2020 08:29:54 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:903b:a048:f296:e3ae])
        by smtp.gmail.com with ESMTPSA id w13sm4669892wru.38.2020.02.21.08.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 08:29:54 -0800 (PST)
Date:   Fri, 21 Feb 2020 17:29:51 +0100
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
Subject: Re: [PATCH v9 13/17] cpuidle: tegra: Squash Tegra30 driver into the
 common driver
Message-ID: <20200221162951.GQ10516@linaro.org>
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-14-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212235134.12638-14-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:51:30AM +0300, Dmitry Osipenko wrote:
> Tegra20 and Terga30 SoCs have common C1 and CC6 idling states and thus
> share the same code paths, there is no point in having separate drivers
> for a similar hardware. This patch merely moves functionality of the old
> driver into the new, although the CC6 state is kept disabled for now since
> old driver had a rudimentary support for this state (allowing to enter
> into CC6 only when secondary CPUs are put offline), while new driver can
> provide a full-featured support. The new feature will be enabled by
> another patch.
> 
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Jasper Korten <jja2000@gmail.com>
> Tested-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/Makefile          |   3 -
>  arch/arm/mach-tegra/cpuidle-tegra30.c | 123 --------------------------

Add the -M option when resending please.

