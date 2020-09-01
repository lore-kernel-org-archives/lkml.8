Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670D5C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D723208DB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f9oKyBNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgIAGAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIAGAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 02:00:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E30EC0612A3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 23:00:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y6so14126plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 23:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xfNNJUqlo12EqEl+OZqmK3D7Dp4+eSw5NmHR85YZ3AE=;
        b=f9oKyBNl4lW+ONVYjUpKz1+clo6GSvJYPMw9ycWx5m89ci5i//YkPO1O+mHulx4/qm
         1BahhljIYUhGcNHEO7BGViJ/xOu+rCVudyAn/jYOdAnKcDa2mC9Clgq4BeJVZmoS/G0L
         OM35AFprOpZmMdAkhfZsM0umC+GFXroOHL9qznGkahrORRfBLG/LZIhcqFxE+jdWRfta
         KPh0b0DDDUDyZOM+4BK2TGGMAYOqfLUIsKjFb0KTg8jrZP6qbo94+0q+bUTVk4qQQnty
         7R66JOZ+/04wH2EZlIsljMENGy3OfT5STvUrIWzAuOIwY2OmgrlsdJuF8KJmqJIRa5J3
         8zeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xfNNJUqlo12EqEl+OZqmK3D7Dp4+eSw5NmHR85YZ3AE=;
        b=ETnVgL61fdAyw4walFNJb6CFujjC5XDvgeGg7bJL9rHbYwTsfpvgT2AYzSZMxma2Fj
         3vW+ViZajccGXZBEKmo9RoVH7dj50eaIk04zURoa8Kq2Xha7Kbf50enGA5wWOTPmhUk4
         +gzgf9wn/a1NwqYMqTl79em9bSgBEcYwTaxqHKPk8cU5dujI+Ge+/Og9jGKWoJ20RqUD
         SSeyseBliiMRHiqZ5ygIkbOYpr8AcJ+LTdKvtOH2nFCzYGCGprBpI940+72cOy77SBXM
         lSq3KmmxM4lbjr/larLbA2byx7jtBLQXYvns7qgMaLH0vIf7+KKo8KPg3uqWcy2Rznyj
         IJoQ==
X-Gm-Message-State: AOAM531nanMUOgm14jQNtQK/nxCsYJs8tTyMnlejNFoP6IYgsmWhYZR/
        eaH+utmxxF6fBS1q19KCpZc/dQ==
X-Google-Smtp-Source: ABdhPJxML0AqWpoEUuGVmEbnBXr5j52FVANb+S4GiK9TUWQGhDXyWpp8+Ctn6UVM/8757wrBPlfcVA==
X-Received: by 2002:a17:90a:9405:: with SMTP id r5mr67195pjo.74.1598940019489;
        Mon, 31 Aug 2020 23:00:19 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id u191sm553190pgu.56.2020.08.31.23.00.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 23:00:18 -0700 (PDT)
Date:   Tue, 1 Sep 2020 11:30:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [PATCH v2] opp: Power on (virtual) power domains managed by the
 OPP core
Message-ID: <20200901060009.w6pkmbnxmjarvqcc@vireshk-i7>
References: <20200826093328.88268-1-stephan@gerhold.net>
 <20200831121457.2v6avendroclvrn5@vireshk-i7>
 <20200831154938.GA33622@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831154938.GA33622@gerhold.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-08-20, 17:49, Stephan Gerhold wrote:
> I appreciate it, thank you! But actually after our discussion regarding
> the "manage multiple power domains which might not always need to be on"
> use case I would like to explore that a bit further before we decide on
> a final solution that complicates changes later.
> 
> The reason I mention this is that after our discussion I have been
> (again) staring at the vendor implementation of CPU frequency scaling of
> the platform I'm working on (qcom msm8916). Actually there seems to be yet
> another power domain that is scaled only for some CPU frequencies within
> the clock driver. (The vendor driver implies this is a requirement of
> the PLL clock that is used for higher CPU frequencies, but not sure...)
> 
> I don't fully understand how to implement this in mainline yet. I have
> started some research on these "voltage requirements" for clocks, and
> based on previous discussions [1] and patches [2] it seems like I'm
> *not* supposed to add this to the clock driver, but rather as another
> required-opp to the CPU OPP table.
> 
> If that is the case, we would pretty much have a situation like you
> described, a power domain that should only be scaled for some of the
> OPPs (the higher CPU frequencies).
> 
> But first I need to do some more research, and probably discuss how to
> handle that power domain separately first. I think it would be easier if
> we postpone this patch till then. I don't think anyone else needs this
> patch at the moment.

Heh, okay, I can keep it out of my tree then :)

> [1]: https://lore.kernel.org/linux-clk/9439bd29e3ccd5424a8e9b464c8c7bd9@codeaurora.org/
> [2]: https://lore.kernel.org/linux-pm/20190320094918.20234-1-rnayak@codeaurora.org/
> 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > [ Viresh: Rearranged the code to remove extra loop and minor cleanup ]
> 
> FWIW, the reason I put this into an extra loop is that the
> dev_pm_domain_attach_by_name() might return -EPROBE_DEFER (or some other
> error) for some of the power domains. If you create the device links
> before attaching all domains you might unnecessarily turn on+off some of
> them.

Hmm, but that shouldn't have any significant side affects, right ? And
shouldn't result in some other sort of error. It makes the code look
more sensible/readable and so I would prefer to keep a single loop if
it doesn't make something not-work.

> Having it in a separate loop avoids that, because we only start powering
> on the power domains when we know that all the power domains are
> available.

-- 
viresh
