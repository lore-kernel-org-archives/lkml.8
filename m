Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49977C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13AE72077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ugPkvx1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgAJHBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:01:46 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52814 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgAJHBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:01:45 -0500
Received: by mail-pj1-f65.google.com with SMTP id a6so571551pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 23:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3lXSs26I3wGImS7PjlRCzszP97Zcz7qic/VgP0ssNd4=;
        b=ugPkvx1rLtZXxhEYXIWg2OwEtYgmXZkT7SoavpBZ5DNn9Cej1ydJjHZEHicrV4MfVZ
         NeK3xhRNUAb4nVseqqQG38o5elE5JgigX+wQovkXoGX/nHbknVACCA255Ye1joc9LqJb
         MMU6Z/tulGuel8VTKi/LrIQikdtqSsweXHSbxco4jvjHAW+63JF5spFg1vJwb5YWg8lG
         pljb8AMfvEIlPr0+vev7MXLlVIY/lB6LGHaq7AWJCAb65o8PY8weHrMKrFzfzCoeHrd0
         aSHogVLh7bmTFZ/B/VVK9U+KI4a2z0EKpVFK6Sf4LdhFn0JxkbbgQkFokBnqMXSigx0n
         WGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3lXSs26I3wGImS7PjlRCzszP97Zcz7qic/VgP0ssNd4=;
        b=nU4PnPJlawwI58uxF8sumIeowqmstMntC5aLZNJu8wOJ6xffHHEnvW08Io9wqRjL4o
         suhuMD4PRMzm28ukLYlThPXSFMVdO0wgDOGrsosvMikEO8qYARlAKsYaf/sR1c8Aszl1
         SvjQ7vC0HGUyDqGkM9os3Q/nmCsG19PG0Yiz/lVrOHIvGe+m/qpHX1Hauy8QEecL9g/A
         8KPTV/zpqhteO41V1MzlqE+RrUy81EL/DMdXqZ1j3lF4yoiQTWdgNPSBEq0CKW0/qE1J
         c7TJLBQ3/V6y+6F5usxDo/6KZgC87wcctlJWrk9IE3pCHJpedk3N4W1k2bJQSGPYSbe7
         d4BQ==
X-Gm-Message-State: APjAAAUleKqxgEfS0bKsTLKng8fmROXJ+YQlsm346b+aZqW15nHav1YV
        YC1ai/74brd6n4BUFSEdijviFw==
X-Google-Smtp-Source: APXvYqwcHxSntks6ca+zn8Ku5M5DI1ACFUm8wuF7NB9Nt7J0Q9XlY9PQzsc/RT9UFe0UTbOaG4QUUg==
X-Received: by 2002:a17:902:8f97:: with SMTP id z23mr2542710plo.170.1578639705002;
        Thu, 09 Jan 2020 23:01:45 -0800 (PST)
Received: from localhost ([122.172.140.51])
        by smtp.gmail.com with ESMTPSA id 200sm1414725pfz.121.2020.01.09.23.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2020 23:01:44 -0800 (PST)
Date:   Fri, 10 Jan 2020 12:31:42 +0530
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
Subject: Re: [PATCH v6 3/3] OPP: Add helper function for bandwidth OPP tables
Message-ID: <20200110070142.gn3fnpytxhu3dqti@vireshk-i7>
References: <20191207002424.201796-1-saravanak@google.com>
 <20191207002424.201796-4-saravanak@google.com>
 <20200108111947.q5aafrlz26tnk3nq@vireshk-i7>
 <CAGETcx_T7VONkSd-r9CY-5OpZBZ2iD0tFoCf0+d8CY2b5zgr9g@mail.gmail.com>
 <20200109044051.62ocfpt44q25q6qi@vireshk-i7>
 <CAGETcx-UWFSaZ8q1iiFVFUEPLN8t1uFb-u6v4VJiMarS21RLRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-UWFSaZ8q1iiFVFUEPLN8t1uFb-u6v4VJiMarS21RLRQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-01-20, 10:44, Saravana Kannan wrote:
> Agree, the OPP framework itself shouldn't be responsible. And I'm not
> doing anything here? Just giving those devices a way to look up what
> their suspend bandwidth is? So they can vote for it when they suspend?

I think this will originate by itself from the device in case of
interconnects as well and you don't need to separately have that for
interconnects.

For example, the device (lets say GPU) will have one of its OPP (and
frequency, maybe the lowest one) marked as suspend-OPP. Then the
driver which is doing the co-relation normally between GPU/DDR/Cache
OPPs should be able to do this conversion as well without any extra
help from the interconnect table.

If the minimum freq of the device correspond to the minimum freq of
the DDR/Cache during normal operation, that should still work during
suspend times, isn't it ?

> Ok, but you want this done only for "exact" or for all the other
> helpers too?

All helpers that you need for PM domains and interconnects.

> Also, this means that I'll have to implement a
> _opp_compare_key2() or whatever because the generic one that
> automatically picks the key is still needed for the generic code. Is
> that fine by you?

I am not concerned about the number of helpers but their optimization.
I will leave it for you to do that and review it when I see how you
have done it :)

-- 
viresh
