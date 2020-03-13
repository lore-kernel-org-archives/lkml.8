Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75F3C5ACBF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB812073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GVMDp2vZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgCMKPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:15:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55311 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgCMKPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:15:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id 6so9252355wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 03:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A2S0VguwI+vPRoafp0n7H/FnoxCrEJkQC7JvYKj1Y0s=;
        b=GVMDp2vZE2aQwlKRTXncVtfN/X+6h48E0TlmseeRuAA107vTByb4SPEwMedGts2FpH
         0TL7glG8mEnbMDZ+queQzD2z8DhUOZNdJH7ieZjOQnso4/ztWA4Zn75c65eSChADubSd
         0cXZHBjArc0TCK17CXch9WBT9JSoawEIY9faPIiTiyZVLh7CB+EXTkP4tDkHsfeB1+R2
         YXRhfNpkpNTIcVQmQ/Elu9NY3FwXfyvYutM+MW2tImKrOwQKW22UE3kEC/U09RRMs36N
         k87s/4AcSbJhgTuxTtpxn6vzTgZzEV/FulMOW4LM8nYmHWyTFOvERzjfZVu+JYlP2r9S
         epPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A2S0VguwI+vPRoafp0n7H/FnoxCrEJkQC7JvYKj1Y0s=;
        b=LTiUJomi9Bbifwd6FH/8P3dEW24B/5HLOZiP4FWSLn9r+iD2oNy7wNTfvPKmfuESDg
         CEB8K0+6AXNKnapcn7oRMC9heDiZDj0ZlkVKxaE2YcGjb9zL0bTtW+h+xe+XP/AOVci+
         0XEiBJxGOt/Pn8Lv7iK9SHhPEHBp/XoVAdQRQaoXdziaeT4fSJLbfPds5J4/RrvXAWil
         zpCY540QW42VuhNa/ay09mfCERAAa+ziYLPrNM+BNG3i8wWTxVfmtkVR2JTSHszBBi+c
         ZEv+qxveNR7N9tBCvds2IHWNmGlhwcYRZUATjPqiMfCPaszTN80uDOzSQwyKxNf+3NC+
         +5iw==
X-Gm-Message-State: ANhLgQ35lSFhR6N3tyLrPTmzBzV6xVBtd5hPt5K0sXnO3hJvtX5NFvS/
        RlKIU2WFSTrYtjU2y4nHuU2gWQ==
X-Google-Smtp-Source: ADFU+vvfNiM0lhbIk+4DF69YACHaSoOD2UzvSXjcbL/Yevz/3tgRAyjOYY4bwXeZHBIHemSgOn8+hQ==
X-Received: by 2002:a1c:9e85:: with SMTP id h127mr9702121wme.145.1584094528850;
        Fri, 13 Mar 2020 03:15:28 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id a73sm280921wme.47.2020.03.13.03.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 03:15:28 -0700 (PDT)
Date:   Fri, 13 Mar 2020 10:15:24 +0000
From:   Quentin Perret <qperret@google.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Morten.Rasmussen@arm.com,
        Dietmar.Eggemann@arm.com, javi.merino@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net,
        sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com,
        sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org
Subject: Re: [PATCH v4 2/4] OPP: change parameter to device pointer in
 dev_pm_opp_of_register_em()
Message-ID: <20200313101524.GA150397@google.com>
References: <20200309134117.2331-1-lukasz.luba@arm.com>
 <20200309134117.2331-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309134117.2331-3-lukasz.luba@arm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 Mar 2020 at 13:41:15 (+0000), Lukasz Luba wrote:
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index d2b5f062a07b..676b56424886 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -275,7 +275,9 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.transition_latency = transition_latency;
>  	policy->dvfs_possible_from_any_cpu = true;
>  
> -	dev_pm_opp_of_register_em(policy->cpus);
> +	ret = dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
> +	if (ret)
> +		dev_dbg(cpu_dev, "Couldn't register Energy Model %d\n", ret);
>  
>  	return 0;

Ah, that answers my comment on patch 01. You're adding the error
messages here.

Isn't this more boilerplate for the drivers ? All they do is print the
same debug message. Maybe just move it inside dev_pm_opp_of_register_em
directly ?

Thanks,
Quentin
