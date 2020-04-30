Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB3BC83009
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C8B42082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PKeLiGXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgD3HyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgD3Hx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:53:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDD8C08E859
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:53:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id fu13so377602pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kG8gxxShO/ZQhCVTu79MXllzxxRhWUROOMH4XeWOBIo=;
        b=PKeLiGXUA4odheuCOywjcjg5uNgODSCQFNSlQQE+92Z5Pz1kC2KBwFCBfGbS3B0AMG
         SJR5F6Ltj/XdoVo8dxh/txZW1JV5a4dPakAC2FMBeH/ZcVMujxkY78e6MpI+bguLRJHK
         0c0ZBndbA+al3r0fnuGeOKNwt8jM1ZIq3QpgiPD8Q30y54hmob/xloHvcTdgkv8rQEHO
         fk7IP0s7X8uHp1Y219FGypcyMqJKNdCmWnvycsxQsaJEU9Q2fIoyNINRmitgO9ICPNw9
         jOIIvDzq3Pele6Z+9pgP6Qsa0KzopjHntNX++q1A9mNLBySYNvZsn9i6ZwMEZy7zC7mB
         0fsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kG8gxxShO/ZQhCVTu79MXllzxxRhWUROOMH4XeWOBIo=;
        b=TBJJFGBV9icmQ9Qr1WGChL0jzCG/Pg+3/Wrd8L9L416Ip2pzeARVlWY7MuJGCCGuOb
         32Q1hgkGzJ4Afj+xaraytROtj2BIedhi3IGlDpyNV/6lCGPnYE5IeXDE2xUWwZhIYFTi
         OGX3VKMBrMsi2ZyDIt6Cy9aLlf3L3P3bGD/P2UsfGZloVzqgCMAF+BbMUHFTGf2DBkOQ
         U0JP59vcB8LhrDyoNcLPnqCA3UDPDqZEZeYFEP3pjX+YS0Em0uRRxSe6rNlelaEW0XiX
         MQYeycl6b/pFqhbM4vQPmMgBUSqbnbQOsYs2yzcWqTSA18OToNnAVe+JNz/8eR6OOcQi
         FzGw==
X-Gm-Message-State: AGi0PuZquc3ptfme7VaVWPv7DGxMw64LKLl+Ajwuu3VLfLarHs9NObad
        Hnz5ixzCcZIk8dDEJg/YmJBCnQ==
X-Google-Smtp-Source: APiQypKL0XTZRutxcUdK04koig/l/oiYa+fGs3Nz3+weSHu7hACweER1oNgsKvxdySh7mi63MCLnnw==
X-Received: by 2002:a17:90a:d808:: with SMTP id a8mr1513940pjv.6.1588233238830;
        Thu, 30 Apr 2020 00:53:58 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id l1sm1073995pjr.17.2020.04.30.00.53.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2020 00:53:58 -0700 (PDT)
Date:   Thu, 30 Apr 2020 13:23:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 6/7] OPP: Update the bandwidth on OPP frequency changes
Message-ID: <20200430075356.rjtctfuenirvhxgn@vireshk-i7>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-7-georgi.djakov@linaro.org>
 <CAGETcx9iAJRW9Y9orHNF-fC53nNob_vZKYUNEpwf_AeAdWCOjw@mail.gmail.com>
 <20200430060901.j7jjw6soo5h5xoul@vireshk-i7>
 <CAGETcx_zH_KJ7_A7Ofc2M5GfHKX_J__URJB127MSMcTeaqyzjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_zH_KJ7_A7Ofc2M5GfHKX_J__URJB127MSMcTeaqyzjw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-04-20, 00:35, Saravana Kannan wrote:
> On Wed, Apr 29, 2020 at 11:09 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 24-04-20, 14:18, Saravana Kannan wrote:
> > > My only comment is -- can we drop this patch please? I'd like to use
> > > devfreq governors for voting on bandwidth and this will effectively
> > > override whatever bandwidth decisions are made by the devfreq
> > > governor.
> >
> > And why would that be better ? FWIW, that will have the same problem
> > which cpufreq governors had since ages, i.e. they were not proactive
> > and were always too late.
> >
> > The bw should get updated right with frequency, why shouldn't it ?
> 
> I didn't say the bw would be voted based on just CPUfreq. It can also
> be based on CPU busy time and other stats. Having said that, this is
> not just about CPUfreq. Having the bw be force changed every time a
> device has it's OPP is changed is very inflexible. Please don't do it.

So, the vote based on the requirements of cpufreq driver should come
directly from the cpufreq side itself, but no one stops the others
layers to aggregate the requests and then act on them. This is how it
is done for other frameworks like clk, regulator, genpd, etc.

You guys need to figure out who aggregates the requests from all users
or input providers for a certain path. This was pushed into the genpd
core in case of performance state for example.

-- 
viresh
