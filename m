Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CF3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 00:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F4720774
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 00:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Na0v5lkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgE3AdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 20:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE3AdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 20:33:22 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F75C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 17:33:22 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 5so2130828pjd.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 17:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K40zQGEK4jSQHBjFQCq4Zws8+ThGBud9TFA0gM2iEdw=;
        b=Na0v5lkDLc2WjRPJr8zp+9Hkpgnz8pIDfX4L3tZa1hn0l8xy2E9lJ+xt+7VueM4qVc
         M3EDCO/DAYPNvqkHnW28mjGBrN4aORwRczWa+NuWl2e09BpV4YTrTz0/GGT0lXB4e9EW
         g/xxxvnv48IuXj0ZezKKW9xKx5uN2wFYoVKkGyDz7nWpg4VhETPYHyDw2WLfVXvDEUen
         ASrLv6WaEuo0mhkDuLMmge8uW+rCA54XBTFw52mPlSEiN3de40GWH1cM4L0JnslFpjQJ
         sI5dbjJY0WK3esiD66Z9RJ+WvpPD2zAQSIxg3R1f5vzp4ohaHvk+tY/g2jjd8dhsHzoJ
         hiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K40zQGEK4jSQHBjFQCq4Zws8+ThGBud9TFA0gM2iEdw=;
        b=uVrA/87lymn44Nw2LU1eyTpc99SQW0I2jL9/ibIxtUk3UvFCidcnPpJttjlikURsjo
         +rZPUDFrBQL0NoCqnrIqDo7NO8yOabjgHqDbONogcI+Xuh+1m34ulHO+S0JymACfhEBD
         oYlph1vIYuIg1OrWbrLbKGYt5dIhcVVQfZiIcpMURxlQMTNXJJ1jGFDQUpoeTsmUEHZZ
         dw2eT2UZuUtw/3DlcLMoxTqGUNLwsIQwQjGKuzWmY7I7J5rJLSVrQ8pLBNewpYguw4OD
         utFAAS/8dNpfsDoy3POZXPuje0g2yvw8PTLBFWGZTiIiwlnyf4DFPJAVHs+sD7UeXu/q
         YQDg==
X-Gm-Message-State: AOAM532AsAdLC9lxULmZxNs5hxJgB60KR+YEBEqMAbPtFojjmYektDy7
        WFNz0AjZN6YIjo+ogWKf/v00Og==
X-Google-Smtp-Source: ABdhPJzZBBqLk8akClIg5R7Rhi70HOWdFvnycU2XevRqjMbM6vpQJYHYMOMftB6KD+8DCjerj0OTWg==
X-Received: by 2002:a17:902:6a89:: with SMTP id n9mr9262953plk.337.1590798802125;
        Fri, 29 May 2020 17:33:22 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id p4sm8080211pff.159.2020.05.29.17.33.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 17:33:20 -0700 (PDT)
Date:   Sat, 30 May 2020 08:33:30 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>, Will Deacon <will@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v7 0/3] perf arm-spe: Add support for synthetic events
Message-ID: <20200530003330.GA26136@leoy-ThinkPad-X240s>
References: <20200504115625.12589-1-leo.yan@linaro.org>
 <20200522030919.GE32389@leoy-ThinkPad-X240s>
 <20200526102602.GA27166@willie-the-truck>
 <20200526104337.GA7154@leoy-ThinkPad-X240s>
 <20200526195438.GC2206@willie-the-truck>
 <3a80a66f-b991-ec55-77a5-a8fc4fa69e5e@arm.com>
 <20200529152800.GB21552@leoy-ThinkPad-X240s>
 <20200529161830.GD537@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529161830.GD537@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 01:18:30PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, May 29, 2020 at 11:28:01PM +0800, Leo Yan escreveu:
> > Hi James,
> > 
> > On Fri, May 29, 2020 at 03:58:23PM +0100, James Clark wrote:
> > > Hi Will and Leo,
> > > 
> > > I've tested this on an Arm N1 machine and it looks good to me.
> > 
> > This is great!  Will respin the new patch set with adding your test tag
> > and send to ML.  Thanks a lot for the effort.
> > 
> > Hi Will, Arnaldo, sorry for late replying you due to other works and
> > thanks for suggestions in other emails.
> 
> Np, please do it on top of my tmp.perf/core branch, it'll become
> perf/core as soon as testing that is ongoing finishes.

Understood, will do.

Thanks,
Leo
