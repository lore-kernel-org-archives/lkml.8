Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557F3C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D8A207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bOsdsARn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgAMO6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:58:14 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34182 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbgAMO6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:58:13 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so4833548pgf.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 06:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ABwgmPKfDy+N+TGKbofrmdsL1lafnTHl6Ci0Ho1XYT8=;
        b=bOsdsARnyhmEOKyiyqxc6hjzJPnadrq4BiEyPdBgmJkzhUQxndVn+RuaCK6zspxAjj
         XA2VmeP7hQZyiIsbEotZCC70+fJp6p7gcsWI8jXeM+UsU3BhkqLV8zP5C9A6dse3f1cG
         WvSW0D1I8dMSS5vmwNqpoNSGkH6TrLBhQwxpDAT8Xtn0wEKhrP3P1KkD76vCyq482ypm
         ratxTPWzQsmX+LuvXctaw0zLo4nZA7NfaUOQ+lMmNYcVcvtgnMrnRODI9/5DtL38jTni
         Q6vwdGCAmjRyyhf3IKKnTFcqZReTUxykBqI2mgoYDmvfKF0q/GHj/xGegJvjOLGl/L7O
         7i3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ABwgmPKfDy+N+TGKbofrmdsL1lafnTHl6Ci0Ho1XYT8=;
        b=l7uEMQu/6BAN1R60Tq+oednM4wMy6Bpybv+XllV8FiFtQ1Guf2iEFa/Qh1WVCC5YU3
         BWn8KN8tyAOlRBHnFy7HwHCfx4hvWxOM7yt+fs2XVMCNfzsxhRvDpH4PPJSVj35Pvuyj
         3xnPcnc7a3j476+OqKeANYTdeo2hNz4E0c12eNQXDpEK7Kl25Jl/ArHHPvm2xbD11wRS
         S0kr84Q+pqusfin9k+YYGcMCiEvzYIm5elI2BQKy7pfVMzffYAkqh0fVGaKtzAUMRjxI
         sqZ69WC+xl6YGp90iKn/fqtzrUTPbZDD6eR1jRCzX2u6DsbLMKu5uMrveAFaTGaLvhPH
         Waew==
X-Gm-Message-State: APjAAAUlYPVgb2+ZEJH7sozJGArW02rzr4Q6JQJKB3aTnqU2M5mGisO/
        Ff9fVbL7+T6bFiPV20w4YgQj5A==
X-Google-Smtp-Source: APXvYqzBF9RnJzzjN8d3ypYT+NVQzN+8f/shFljnUu2NyTcyE8qPeGaNq2hQb3H1101ndSj85JVYHg==
X-Received: by 2002:a62:e30d:: with SMTP id g13mr20089294pfh.92.1578927492811;
        Mon, 13 Jan 2020 06:58:12 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id i127sm15559616pfe.54.2020.01.13.06.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Jan 2020 06:58:12 -0800 (PST)
Date:   Mon, 13 Jan 2020 22:58:03 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        nd@arm.com, Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Igor Lubashev <ilubashe@akamai.com>
Subject: Re: [PATCH] perf tools: Fix bug when recording SPE and non SPE events
Message-ID: <20200113145803.GB10620@leoy-ThinkPad-X240s>
References: <20191220110525.30131-1-james.clark@arm.com>
 <20191223034852.GB3981@leoy-ThinkPad-X240s>
 <fd4f4278-fa43-86dc-1f2f-3439f19fea9e@arm.com>
 <20200113141751.GA10620@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113141751.GA10620@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 10:17:51PM +0800, Leo Yan wrote:

[...]

> > > On Fri, Dec 20, 2019 at 11:05:25AM +0000, James Clark wrote:
> > > > This patch fixes an issue when non Arm SPE events are specified after an
> > > > Arm SPE event. In that case, perf will exit with an error code and not
> > > > produce a record file. This is because a loop index is used to store the
> > > > location of the relevant Arm SPE PMU, but if non SPE PMUs follow, that
> > > > index will be overwritten. Fix this issue by saving the PMU into a
> > > > variable instead of using the index, and also add an error message.
> > > > 
> > > > Before the fix:
> > > >      ./perf record -e arm_spe/ts_enable=1/ -e branch-misses ls; echo $?
> > > >      237
> > > > 
> > > > After the fix:
> > > >      ./perf record -e arm_spe/ts_enable=1/ -e branch-misses ls; echo $?
> > > >      ...
> > > >      0
> > > 
> > > Just bring up a question related with PMU event registration.  Let's
> > > see the DT binding in arch/arm64/boot/dts/arm/fvp-base-revc.dts:
> > > 
> > >           spe-pmu {
> > >                   compatible = "arm,statistical-profiling-extension-v1";
> > >                   interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
> > >           };
> > > 
> > > 
> > > Now SPE registers PMU event for every CPU; seem to me, though SPE is an
> > 
> > Do you mean "SPE PMU" here ? SPE is different from ETM, where the trace
> > data is micro-architecture dependent. And thus you cannot mix the trace
> > on different CPUs with different micro-archs.
> 
> Understood that SPE is micro-architecture dependent.

Maybe SPE is more general than we think :)

Since SPE is defined in ARMv8 architecture reference manual (ARM DDI
0487D.a); should SPE trace data format is unified and defined in Chapter
D9 "Statistical Profiling Extension Sample Record Specification"?

Thanks,
Leo
