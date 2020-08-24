Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D44C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F116020774
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iqLr05L9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgHXLbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgHXLaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:30:39 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2282C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 04:30:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 17so4650665pfw.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 04:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KFVBStf/gf1dn9u4zO2x0xipCrd73hHfqj8Q+elUA6k=;
        b=iqLr05L9bMYf1Q1YOzzoOeQuCLaPr/lR39Wr1rxWF64ZbU0xLpZBF8iUwYh/a3/5VC
         K1lL5Il0RvcoFxohuj31lGwRHYwD+h7NMKfo2lmfMQ1iLqLvNDujhvNcQEhp0Ae0kDH9
         IR4OiPOcd9b1WB97D4SkdRLgWaPsEdhOG05MRr1Ov/lXXoEn0zTsTaIYgARNOdtLJDiw
         xgIJKzGjmeXNxaLu0Olnx2evewVxzXldixTPJlzoU/ScmAPXIIk/P9rYR+qWb8HQ7hC7
         XT2eIHtIgOR/PXaEs3pQAZzZ3qsR0AnInnRzshA7AaWSOuXTmeava6a40ndJRxvH4jUV
         adLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KFVBStf/gf1dn9u4zO2x0xipCrd73hHfqj8Q+elUA6k=;
        b=Bg8L4dveYWfxlByxSar/ODgnrCbh3boe5LpbZBW3W0Qva9TtbCmrk6d5W6vxDcfE+g
         ISD20OrxBHhJAphH69FGxQwck4wDIBUVj85eBMzpSRLhcdYLgHEzFt4EQh1FSrzlAcHy
         TfEKnRmuoTjTF38TQdgO4YWdQ4I1LNZEgFb6tQ2ITghtGVbhU3tBq0oDx51+4gQxM7W2
         qfVQq2JITzzP3oe/nrauSpYCAeBnRf4Z1IOvEXtJLJ59STtVpbBeSHfJHOgA30YRrIFy
         KdcHIc73EJkBfLTut/sJId2kHoHR3On/ae2Sznr3kAZBSdzy0gfzwpD+DvQtIzJZd3QD
         qS9g==
X-Gm-Message-State: AOAM531KT5gn4OT3wGOGZwl1d4UdI+vv+m5bpWuMn1+EY+3Zt4i3UB4P
        1OToTcBxAVLIcfJEPA4GkQjcWQ==
X-Google-Smtp-Source: ABdhPJwof+0lVQnVChbft2uU8gERi7rnvy18l1DB/HKP5XCCoWFy6zzd0qvuoXraHA02UUv2w1CLsw==
X-Received: by 2002:a05:6a00:851:: with SMTP id q17mr3790700pfk.214.1598268630288;
        Mon, 24 Aug 2020 04:30:30 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id x13sm2714433pfr.69.2020.08.24.04.30.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 04:30:29 -0700 (PDT)
Date:   Mon, 24 Aug 2020 17:00:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [RFC PATCH 2/3] opp: Set required OPPs in reverse order when
 scaling down
Message-ID: <20200824113027.lzh6fp4bottjl6cc@vireshk-i7>
References: <20200730080146.25185-1-stephan@gerhold.net>
 <20200730080146.25185-3-stephan@gerhold.net>
 <20200821163152.GA3422@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821163152.GA3422@gerhold.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-20, 18:31, Stephan Gerhold wrote:
> This patch does not apply anymore after the cleanup you pushed to
> opp/linux-next. I would be happy to send a v2 with that fixed.
> 
> On my other OPP patch set you mentioned that you might apply these
> directly with some of your own changes - would you also prefer to do it
> yourself in this case or should I send a v2?

I will pick the first 2 myself, that's fine. Lets see where we go with
the third one :)

> Still looking for your feedback on both patch sets by the way! :)

Sorry about the delay, I was on vacation for over a week in between and
this and the other patchset was a bit tricky (which you may have not
realized, not sure, as I wondered if something will not work within
the OPP core for v1 binding, but it did finally I believe) :)

-- 
viresh
