Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88539C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5210A20709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hoPpQ7jo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgICJHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 05:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgICJHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 05:07:35 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C276C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 02:07:35 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 7so1600332pgm.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 02:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sXrAToGX8i1+Zn6kuQTdzFyyjixV1utUGmyV2pL4LuQ=;
        b=hoPpQ7joK80uuY/q9Bx6i2mnCHrY64ohODYdQ6SciP0vG/ujG44b5gXAiBIXAOsAzL
         KCEN88wKq8EC6WMlDJkmwqAZ+OtrPRMx1orB4kJBwS4YGaNtMgI7OqnqgLotI7w/RlKr
         SKnDidDdtZ3o9WjaHFbQrSNk5lBBcI4rIAME2T6VY7Xop2FYrWBLIEfAIShDkQEd0cuy
         wdwguqYjOZXOMeixRlqxiBdQiDYL5cbSP4WLe+tO7bOoH5bFVa4Y04C/GL08fKAKTatn
         m/6KOYCQPiWu02zW4wXFa2POGuSHbjvN4lCvN4pgvCTo61YfGQpeTmHwujT6Ptg+1LFK
         wkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sXrAToGX8i1+Zn6kuQTdzFyyjixV1utUGmyV2pL4LuQ=;
        b=ruKdKQrJqY0Z2s/H9kRuATMKR8MDCXKz3azfCVHkH69Ok4hlX7lOuXVZYrhzuy8tKU
         mM6+ql3Eoh1LoU7WSIrkKuQqc76Vuq+nJg/zCujh/Jg5ZmtvkywuTzon+g5H44qRIcX+
         bbn4qSQvXWUin/Wsysj5SgF4uY97WhUPal1p4aR6a6WB5/sQAXq2YSRq0Ab9OU9moG+0
         /85ktg+uzQt9L9Ux0ZjvKJtriv0v2E+WU+/Vr3d/rPoUOl5lnQFM+owuOXNXP33aFQKu
         Y8rDeUjbNvZ4DYXNsHo+r/WIWKkEatthRy4Thcxm9rUPzxorsf/hNkloAA0kfNDQn7Bd
         7Twg==
X-Gm-Message-State: AOAM530JglWu9oxLJhX5TufD7bd78JZbxg5b0sPS+N+vRyXR6vuH6m72
        tH0LsK4k7tKx5GebHjmQGmwKRA==
X-Google-Smtp-Source: ABdhPJx2GaTE7S0jSHYAwpKiGlUsia8mCieItPfVKYbRTtMIn65vf2+yFeJJ7F1dspP4FABuKeq+Qg==
X-Received: by 2002:a63:d918:: with SMTP id r24mr2127298pgg.158.1599124054825;
        Thu, 03 Sep 2020 02:07:34 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id w66sm2340139pfb.126.2020.09.03.02.07.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Sep 2020 02:07:34 -0700 (PDT)
Date:   Thu, 3 Sep 2020 17:07:24 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Grant <Al.Grant@arm.com>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>, nd <nd@arm.com>
Subject: Re: [PATCH RESEND v1 05/11] perf mem: Support AUX trace
Message-ID: <20200903090724.GB1583@leoy-ThinkPad-X240s>
References: <20200806030727.30267-1-leo.yan@linaro.org>
 <20200806030727.30267-6-leo.yan@linaro.org>
 <7b0e61d3-3f28-0e98-9c82-b9a9573bf571@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b0e61d3-3f28-0e98-9c82-b9a9573bf571@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Tue, Sep 01, 2020 at 04:52:54PM +0100, James Clark wrote:
> Hi Leo,
> 
> >  
> > +static int process_attr(struct perf_tool *tool __maybe_unused,
> > +			union perf_event *event,
> > +			struct evlist **pevlist)
> > +{
> > +	int err;
> > +
> > +	err = perf_event__process_attr(tool, event, pevlist);
> > +	if (err)
> > +		return err;
> > +
> > +	return 0;
> > +}
> > +
> >  int cmd_mem(int argc, const char **argv)
> >  {
> >  	struct stat st;
> > @@ -405,8 +430,12 @@ int cmd_mem(int argc, const char **argv)
> >  			.comm		= perf_event__process_comm,
> >  			.lost		= perf_event__process_lost,
> >  			.fork		= perf_event__process_fork,
> > +			.attr		= process_attr,
> >  			.build_id	= perf_event__process_build_id,
> 
> I don't understand the __maybe_unused here. And also isn't this equivalent
> to this without the new function:
> 
>   @@ -405,8 +430,12 @@ int cmd_mem(int argc, const char **argv)
>    			.comm		= perf_event__process_comm,
>    			.lost		= perf_event__process_lost,
>    			.fork		= perf_event__process_fork,
>   +			.attr		= perf_event__process_attr,
>    			.build_id	= perf_event__process_build_id,

Thanks for pointing out this, will fix this with your suggestion.

Thanks,
Leo
