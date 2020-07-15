Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745A0C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 513EC2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xCm6WtGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgGODic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 23:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgGODib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:38:31 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B13BC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:38:31 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m9so1318323pfh.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DC+j4EVae4RnLgJTCnOM6IjTjMXDQK4HU4GWa3Ol4iw=;
        b=xCm6WtGghrzZIHVeAIpX3VeTjOAkwZB6Fpfm+5q+peTbvNwBqUgp7IbGuiU9enBs7U
         5uHg40id4ZeaRWExKahikfXjxTSRsayAf1OXtEwF2YY1M2ucllTGBKph8FxkHmFxe9vX
         O4cr4qQvAn05YFGyDunY/3YCeP+Fd45IrYqMrp7lpgFgs6OPtGQ7lBFkQN3WJMca2jI4
         weeg3jYtK8YO9eKuAFpTmBWVhXHH+aGK3hPDr8f7e7c8uRK7rQaD6SLQvBduNO269v1/
         EC7201KifvPXfG5MRO0gKp3lv2JdU7+45Diuj4RBonHUhLB9rEMeHspt+9KUb9i8jkQa
         FNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DC+j4EVae4RnLgJTCnOM6IjTjMXDQK4HU4GWa3Ol4iw=;
        b=ZVh7Az+I307Ln5zrpwd9ZD+EWX6FrY/he10P8hOQAsIP61rrfBzDgTjKHkehN21ppx
         7N0g1l9iKcqzDc5/s0qqmExWFGmoVlLHZtJ99OjtZ2CXvbNl3Kw1xeH0/CP2cUPLv0kz
         PgCv8wWqo6Jf49Tf1i4LBy2M1TVS/pGQ4Rd7BziZKy0xWkkGiliSEKPEPvAV57V3xbPl
         LqYeXRQlrhAem1H+t3HaTZf9Vnnbn1D3jOZbQbKvzA/RpZzJuJHD7GW6LsG1Harmg5fu
         JykVgd9HbFkf2YCJjGwLCcSfTAkzaWJF9GW2LkEZxs2XSZ/fiAccm/16rcCUPERFVUkD
         QosQ==
X-Gm-Message-State: AOAM531trITLaLo3CguFP2o9I4bSs/AD1VWjfZw1MD0986WvgOjxarRJ
        /wJH9gxmUTDLBSric38nR560HQ==
X-Google-Smtp-Source: ABdhPJxrD9asMf+2w6YPcEVsiXhZteYoAJngfCjvTBomN8Y7B2D79FF9MwHPqmVmjskvbysGwmnbwQ==
X-Received: by 2002:aa7:858c:: with SMTP id w12mr7531416pfn.143.1594784310954;
        Tue, 14 Jul 2020 20:38:30 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id m26sm302796pff.84.2020.07.14.20.38.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 20:38:30 -0700 (PDT)
Date:   Wed, 15 Jul 2020 09:08:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "andrew-sh.cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v7 2/8] cpufreq: mediatek: Enable clock and regulator
Message-ID: <20200715033828.zzjavbzg32dxkga4@vireshk-i7>
References: <1594348284-14199-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1594348284-14199-3-git-send-email-andrew-sh.cheng@mediatek.com>
 <20200713093909.676v7wxjzsz4vbxv@vireshk-i7>
 <1594732689.24540.4.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594732689.24540.4.camel@mtksdaap41>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-20, 21:18, andrew-sh.cheng wrote:
> On Mon, 2020-07-13 at 15:09 +0530, Viresh Kumar wrote:
> > On 10-07-20, 10:31, Andrew-sh.Cheng wrote:
> > > From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> > > 
> > > Need to enable regulator,
> > > so that the max/min requested value will be recorded
> > > even it is not applied right away.
> > > 
> > > Intermediate clock is not always enabled by ccf in different projects,
> > > so cpufreq should enable it by itself.
> > > 
> > > Change-Id: I9f4c8b1ea793794f5f9cdc65427daad1393f5df8
> > 
> > You are on V7 right now, these should have been gone long back.
> 
> Hi Viresh, 
> Sorry for forgetting to remove the change-ID message.
> 
> > 
> > > Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> > > ---
> > >  drivers/cpufreq/mediatek-cpufreq.c | 33 +++++++++++++++++++++++++++++----
> > >  1 file changed, 29 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> > > index 0c98dd08273d..4b479c110cc9 100644
> > > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> > > @@ -350,6 +350,11 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
> > >  		ret = PTR_ERR(proc_reg);
> > >  		goto out_free_resources;
> > >  	}
> > > +	ret = regulator_enable(proc_reg);
> > > +	if (ret) {
> > > +		pr_warn("enable vproc for cpu%d fail\n", cpu);
> > > +		goto out_free_resources;
> > > +	}
> > 
> > This is already done by the OPP core now.
> 
> Do you mean I can use dev_pm_opp_set_regulators() and
> dev_pm_opp_set_rate() to do dvfs?
> Due to mediatek-cpufreq may change Vproc and Vsram by special flow, that
> is not suitable.

Sorry about that. I completely missed that you aren't using
dev_pm_opp_set_rate().

-- 
viresh
