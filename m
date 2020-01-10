Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AF8C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28202077B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sKUMJWsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbgAJGyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 01:54:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46452 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731530AbgAJGyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 01:54:24 -0500
Received: by mail-pg1-f195.google.com with SMTP id z124so521932pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 22:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YhPLZOvbusu+BDcW4xtLEV0ezjrgdDBJUzmow7dtjMQ=;
        b=sKUMJWsXvcFP9jEO0Hl4uUyNvbyljQCLxhGsldiqDRvsC8IpLpEay5tiVJTep7pkQo
         oRqBgROQLiR2Dvoq/TyO1UMoQhdyRJ3wjy/MPdywSKlfQfgIT8OA5zHb8eDxN8hur6+m
         bmj0RfiXa6xUTOzhi3oi6cDzqHFZQqMWYm1TGCbkHjBAjoW1ygXyRXpF3uzJoPIuknpy
         U45mfuGgCk9q6RAjFHyZZE2ggGK2YJciePz/phNcN5zwDp79efcs1taM0Ee8bj8mvq6Z
         Vmx+d9BNX8QdTcgXvWiC6oEoF3c/fN21NQ2PM/PN7y0A+ZT+UCIE+AziDVobHNKrEQ5H
         6cpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YhPLZOvbusu+BDcW4xtLEV0ezjrgdDBJUzmow7dtjMQ=;
        b=Ngu8ufi8kjFRj/mgxE7/WsEzVIOmWA3FitAvpUwKbTjV3T0jAbPQQzbtuVwS/rwPnp
         1iwuIEur6gPi8LWO3vkhiSCEHu3dxDO/7E29Rmx0r+J9wiC8+Yetp5PfjsrmmOT38HJD
         pgbhMvcoZ3x4lvIBlx2zkt3ZYMGt6bH4+o3yWYRDgDbjapjkGQCtiHPsWaTDqRvwrsyN
         J9F+76rNSLPjiIIX+YunZei28+za3QuGhUTKaxgd3jyaVwKYAUr63mvVgqSx4lJz1PRF
         J1H79w7lTRdUV0iPZVugvvjsfcfAk66NNdMyDkSU84oP+UxjdOyqAUN/yvT0T0ebszaj
         6FVQ==
X-Gm-Message-State: APjAAAXGOM8jvoB7+iFjSypsE/yDBI5nzgG+S703Kdd1TSFCTdB2SESt
        boEwGhWFER2n2lYZyrNORnIhsg==
X-Google-Smtp-Source: APXvYqyqmwrNqG8WUg323dOQJc2jziGsBSe/4bAS5Q+Tv3gJE3iTY9fjXWBEohxRSFWlHgkV0K65JA==
X-Received: by 2002:a63:4824:: with SMTP id v36mr2501774pga.343.1578639263873;
        Thu, 09 Jan 2020 22:54:23 -0800 (PST)
Received: from localhost ([122.172.140.51])
        by smtp.gmail.com with ESMTPSA id i3sm1384035pfo.72.2020.01.09.22.54.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2020 22:54:23 -0800 (PST)
Date:   Fri, 10 Jan 2020 12:24:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/3] OPP: Add support for bandwidth OPP tables
Message-ID: <20200110065420.3bp4fjj2wbezoyrc@vireshk-i7>
References: <20191207002424.201796-1-saravanak@google.com>
 <20191207002424.201796-3-saravanak@google.com>
 <20200108105348.p4y3s2mbuchiu4mf@vireshk-i7>
 <CAGETcx8QEV+_+d2yt_+bE09mi4qyHZDHPJqPiDXv_HgJPgQJoQ@mail.gmail.com>
 <20200109043108.fzvk3hp7vodtw6zy@vireshk-i7>
 <CAGETcx_1B8AfxBuJ9Mbq8BNx-fYyP8pOnF6caN=ooyPARaaJ3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_1B8AfxBuJ9Mbq8BNx-fYyP8pOnF6caN=ooyPARaaJ3A@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-01-20, 10:35, Saravana Kannan wrote:
> Agreed for the example you are giving where PM domains/voltages are
> dropped automatically when dropping the device freq to suspend freq.
> I'm just wondering about a different scenario where if some power
> domain needed to be at say 0.5v when it's suspended (no consumer using
> it)

The domain should be powered off in this case I think.

> to not lose state, or to come back up without brownouts, etc then
> suspend OPP for PM domains might be useful. But I don't know enough
> about that to speak with authority, so I'll leave it at this.
> 
> I see this suspend-opp as a way to mark to what level the bandwidth
> needs to be dropped to/brought back up from during suspend/resume by
> the driver making interconnect bandwidth requests. For example, what
> if the CPU -> DDR needed to be at some level to avoid suspend/resume
> issues (say CPU bug with respect to timing/latencies)? In this
> example, the CPU driver would be the one making bandwidth requests for
> CPU -> DDR bandwidth during normal operation and during
> suspend/resume. So it's basically exactly the same way it would treat
> CPU freq OPP.

I understand your concerns but to me it all looks hypothetical right
now. I am not saying we won't support suspend-opp for interconnect or
domains, but that we should do it only if it is required.

> Btw, I don't have a strong opinion on this. But, even if we do only a
> rate comparison, what does it even mean to compare rates for genpd or
> BW opp tables?

We will never do the comparison because those tables will never have
the suspend OPP in the respective tables.

-- 
viresh
