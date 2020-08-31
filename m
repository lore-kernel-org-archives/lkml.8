Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2414EC43461
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00387206EB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgF7Dfsf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgHaEjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 00:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgHaEjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 00:39:18 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEB5C061755
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 21:39:16 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id n3so1694899pjq.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 21:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eK4HJEXVysJqY3H0HRpuKE64bWmfk+MIff/zDDdh058=;
        b=dgF7DfsfgxuT9oJTzh49Q55n+VQFmgp6g1F2K862ACF6INQXaDDqnOAFaIM+pWb91x
         bPyOS+Rx+5UGnULEhSocC6LP2ytaeNXvqVRy2kXIcQBz8LJeZWECPUVnNGyfpJkce+nQ
         RsnWO7OFQqYBFkyFL3XfSDGQsrxI3YbH+tNVI1UYHGMX4RiEacjEq11YsUIv//Zaonvj
         oOT21Wx8sS66bVnNuz7Xom8Ti1w9JZ2tlmenJfaZlAiPxdfGIjY0yHk3zHXD2+7lKivI
         BWWHzsQukeg1cmIoFebvX8xOjr1PisXH9ZIMA1cL9hvLoPnBLuyq6BEMnJO/VSSJjLOq
         WRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eK4HJEXVysJqY3H0HRpuKE64bWmfk+MIff/zDDdh058=;
        b=cn7+/+Agqr+v5hBE0SSGuaqw/JZrVcU0aCgvfv7Z1EBie32tE0RxxY9+4VH7AUNORj
         qhUzvnuRNgLLVEUfJOBzf5fAuZXOfNyFR4gjY4cUtuu+br07p/ZcV9p8oXaEraE1ptqy
         MSXw5zbR8LZjHzojVarQso0Ssu0/ns6U1t3A9rqEtha8ZeZ3CMwaruqTh+nbmH9JniD1
         hs/1xtRCtRoVw/ul2jtBcaQcKvur5hah9Kc0nVOLNunwh5fuhjdmmNvrmf+AqkmlJrjY
         GRN/0PfhWO7sqRZ6IZ4TZ1TPAB7ArXpu2AZw2jZOomD1MRGqf040pTq5aVIPj8cgKdAQ
         iwsQ==
X-Gm-Message-State: AOAM531IRHMb2rA6RnfLmMK0FsS9MAW5FLcxhgdr3T6Ev8S7FeEN4onQ
        wVTTE3Vj3pT6l3MSheRvFSFTZw==
X-Google-Smtp-Source: ABdhPJxaL3cyZNWOP2NQ3q4g/ZNU7QIPjGKqARj3Y782jHZtc3+5BbYdDk8M94yhDr8nn2UtuztSiw==
X-Received: by 2002:a17:90a:1741:: with SMTP id 1mr9611028pjm.173.1598848756361;
        Sun, 30 Aug 2020 21:39:16 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id t5sm5487141pji.51.2020.08.30.21.39.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2020 21:39:15 -0700 (PDT)
Date:   Mon, 31 Aug 2020 10:09:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: tegra: Pass multiple versions in
 opp-supported-hw property
Message-ID: <20200831043908.mtw4dglybcmcabjb@vireshk-i7>
References: <cover.1598442485.git.viresh.kumar@linaro.org>
 <b13f1b112532fe0189d1f7bbb50903d9e1defb07.1598442485.git.viresh.kumar@linaro.org>
 <b0763074-859f-fccb-dde4-03d1a50ea021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0763074-859f-fccb-dde4-03d1a50ea021@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-20, 10:37, Dmitry Osipenko wrote:
> 26.08.2020 14:50, Viresh Kumar пишет:
> > We can now pass multiple versions in "opp-supported-hw" property, lets
> > do that and simplify the tables a bit.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > ---
> > Dmitry, I think there is further scope of simplifying stuff here by
> > using the opp-microvolt-<name> property and corresponding
> > dev_pm_opp_set_prop_name() call.

Any inputs on this Dmitry ?

> > diff --git a/arch/arm/boot/dts/tegra30-cpu-opp.dtsi b/arch/arm/boot/dts/tegra30-cpu-opp.dtsi
> ...
> > -		opp@1000000000,975,3,7 {
> > -			clock-latency-ns = <100000>;
> > -			opp-supported-hw = <0x08 0x0080>;
> > -			opp-hz = /bits/ 64 <1000000000>;
> > +			opp-supported-hw = <0x0F 0x0001>,
> > +				<0x01 0x0002>,
> > +				<0x01 0x0010>,
> > +				<0x01 0x0080>,
> > +				<0x01 0x0100>;
> > +			opp-hz = /bits/ 64 <475000000>;
> >  		};
> 
> The only very minor difference between my OPP-gen result and yours is
> that the above hunk has inconsistent single-column formatting, while all
> others are two-column.

Ah, my mistake. Fixed and pushed now.

> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>

Thanks.

-- 
viresh
