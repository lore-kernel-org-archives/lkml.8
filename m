Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3804EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 135F0206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UAuaHkfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgFOGFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbgFOGFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:05:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B42C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:05:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n9so6379092plk.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5bLWZytUDahU9Q9Fv7DQgMv65OXHOnlVrBakZLDuOLU=;
        b=UAuaHkfe0wS768I6KfkDZMQ7Vwm9+9PrDtdzupG41ieIJxdIWi+51K9LbclsplhZWz
         zd1RyRwcg3qpWEDPTDraRvRhEBwBErRC1RL9i5y5htRQt05/MvWD2l81QUY+BA6JnqQY
         QXwc7TrAbrD7gDLztoZQx9UlqtuTvt5Rn9s7WDfeTvvVGjydkJbC9fE/K82vE+X5f0kg
         o0E9VuJH2EPGk3orcVSPLeMzJR5VE/pQ+bg+cEoIJoHfZ6v8Wwug2r6gAgYsKScRILzR
         GPTf/QcgtdVGBxjf/e9/OyPC9IUUIK8R7q7MMJfLWqJ1GdtuhJDs7X617bwyOGPuB00O
         /sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5bLWZytUDahU9Q9Fv7DQgMv65OXHOnlVrBakZLDuOLU=;
        b=H2PIzF/jShqnXXlk9+LybiCOwOgDqgpYFPXd/s5AhWsRCoDipBhIX1OnYejLk9N9/U
         bScOuvPTvBAW3ipuK44zd5TSwME7AxvzW3QVUNJ2M672A0efAVCrKAfKxB1v/JTz7euv
         bCQlMNDqbQy8xiDftWOZ4LHvLjWgdWG0VVBgWdJ1df5X7bfC4hbarb8YdxPgjjuE8oHI
         bdRDzEChTLIH7nipPdAye4K5bxf/cny0S1Gt2hpKr9Lq4k5ACdoj1GaEQWnIRP43B/x4
         ebrCW14f/Gc+ZSKT76So947zHiKrPpzBgFuBpzkLmH+1wTSqYnXx7cm7Ei2Vp8MCIC+K
         cL4w==
X-Gm-Message-State: AOAM533J/dltDI8gIuGUEAZ++NE5duBUzKSHnNhoZPkbGqsCEprTKpll
        y0MAyXuKmkxF2C8gkGH0Q6s7iQ==
X-Google-Smtp-Source: ABdhPJwBvfb/D2z4n4g+jVVzuvYhCqdDXa+Ze1hTZMevweB3Ou2NJS//V04kvss2kpjQzJ2/vZxMTA==
X-Received: by 2002:a17:902:8bc7:: with SMTP id r7mr1198369plo.57.1592201143894;
        Sun, 14 Jun 2020 23:05:43 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id o96sm11712703pjo.13.2020.06.14.23.05.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2020 23:05:43 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:35:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Markus Mayer <markus.mayer@broadcom.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux Power Management List <linux-pm@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] cpufreq: brcmstb-avs-cpufreq: more flexible
 interface for __issue_avs_command()
Message-ID: <20200615060540.tr5bzgeviqajijec@vireshk-i7>
References: <20200528182014.20021-1-mmayer@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528182014.20021-1-mmayer@broadcom.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-05-20, 11:20, Markus Mayer wrote:
> We are changing how parameters are passed to __issue_avs_command(), so we
> can pass input *and* output arguments with the same command, rather than
> just one or the other.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 30 +++++++++++++--------------
>  1 file changed, 14 insertions(+), 16 deletions(-)

Applied, thanks.

-- 
viresh
