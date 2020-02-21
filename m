Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7495C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79703206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLOXiT3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgBURle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:41:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32966 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbgBURld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:41:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id m10so5679071wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 09:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WYt19hWbIa5Xu8CWd9oipzHMFzU2GBfzETdCcySKemk=;
        b=vLOXiT3LsFWCymfBWSf00sI8eNVCzOAsnAYW2uMu2fl5aol6UNQA1cDd5eBMO6+E8X
         cDJpIAGGZx0RA+9rmpmL2S7/RmM7BY0Y9qQ7thrXPF3b6AR+Ykj6cN27an4Hi7FKF2wN
         NBlG16z/AfiNYeM7wwugQp1X1RtxgjPYHtspY6lEjAuL9pXH6WaOmthn6YgTAx/eIQhp
         +TNVXXACeXcBBOEkEUvKjSL6RG6A+uLcldANURzXnA3MGyO8jpjF2QWiQvTQD0QP1ozd
         98KvSuy1Oe+7jTHBZub6c5lA7xdKBc8ZDnx922r6+qRd9EiaogA+6Tz9MIobp6ObKwib
         jKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WYt19hWbIa5Xu8CWd9oipzHMFzU2GBfzETdCcySKemk=;
        b=aG5zOUDVR8t+OCH88NhWeN4EOqcKabRvY0H8/mM6J7uoALoQD3lu1U/qS9SvDQTx1u
         Zl0wltxWwXZUfqdcdGWOk1AB8FxrDn97Jfsxa96b2XQrBcdPOCHnjgdOiYNgRt3VgBcj
         2PzoPIftZnBI78CxwWeNuCwAOY64Y0DbMf27Q8IJWNHKE4owhxAS0XY+/AzUNfGa+O9q
         SoMUEhNkdpwEpmWhBfrPmpCc8plecq3YNatZV3DZUfBj9u1SKha0fxVlMkMJ/4nimCxf
         uHkC5TiYiHfbdd4LxlmX4kNU7eSBlWiMY/BIUmQcSr4Bqsc7/dPlAhJ0IjqHEokJEhfy
         QJow==
X-Gm-Message-State: APjAAAXpm7oVxEbsMcF7JDNAS568hIrzftPzgicrY0YEX+hoKy7ExEKf
        VsZMSf/RnPFNQ6znPjfemwy2Mw==
X-Google-Smtp-Source: APXvYqxS9rE7ngm9CQLvZpUgXpRRYzTQIAk89jaGKyx1v3OnFAHZORuHOe8eqf+brp+9uMmwLjbhbA==
X-Received: by 2002:a05:600c:4105:: with SMTP id j5mr5150857wmi.28.1582306891123;
        Fri, 21 Feb 2020 09:41:31 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:903b:a048:f296:e3ae])
        by smtp.gmail.com with ESMTPSA id a5sm4658651wmb.37.2020.02.21.09.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 09:41:30 -0800 (PST)
Date:   Fri, 21 Feb 2020 18:41:28 +0100
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
Message-ID: <20200221174128.GW10516@linaro.org>
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-14-digetx@gmail.com>
 <20200221162951.GQ10516@linaro.org>
 <89a9838c-faf3-b890-cea2-aad53df1eac3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89a9838c-faf3-b890-cea2-aad53df1eac3@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 07:59:14PM +0300, Dmitry Osipenko wrote:
> 21.02.2020 19:29, Daniel Lezcano пишет:
> > On Thu, Feb 13, 2020 at 02:51:30AM +0300, Dmitry Osipenko wrote:
> >> Tegra20 and Terga30 SoCs have common C1 and CC6 idling states and thus
> >> share the same code paths, there is no point in having separate drivers
> >> for a similar hardware. This patch merely moves functionality of the old
> >> driver into the new, although the CC6 state is kept disabled for now since
> >> old driver had a rudimentary support for this state (allowing to enter
> >> into CC6 only when secondary CPUs are put offline), while new driver can
> >> provide a full-featured support. The new feature will be enabled by
> >> another patch.
> >>
> >> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> >> Tested-by: Peter Geis <pgwipeout@gmail.com>
> >> Tested-by: Jasper Korten <jja2000@gmail.com>
> >> Tested-by: David Heidelberg <david@ixit.cz>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  arch/arm/mach-tegra/Makefile          |   3 -
> >>  arch/arm/mach-tegra/cpuidle-tegra30.c | 123 --------------------------
> > 
> > Add the -M option when resending please.
> 
> Okay, thank you very much for taking a look at the patches!

Yeah, sorry for the delay. Nice cleanup BTW.

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
