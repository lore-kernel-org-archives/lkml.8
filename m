Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB07C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693A12078D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqG+SDRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgHaEqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 00:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHaEqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 00:46:14 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425A0C061755
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 21:46:13 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mw10so2342645pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 21:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9DT7T9nQfwo6eKdKm8ktrJGI/iqaC4tsTOR19DzTOIc=;
        b=gqG+SDRFtzBK7B/V2gV7gjW0mZAqUuY/579i8mfVPZ62EyXYeaZjxrmqJ4cmgi263J
         KVJuqDAAKZJ/ghgm5Sy+azj5BrwEDWUL2/F7xevIXcp525YE/I/IqhIj1El6lShC6gHA
         Rg1Dxn3AUyJImGm2mW+eqYkCrxx/f2TxJmOxJ8iMwP5QiiWLUPXsGQXluACFyBkUmhya
         0qCGHP8hXj7qjnpnzxUuFpeRrlThckzHt8aZFKUTexLXbfwR84nT08fFvOi5wHsCgodU
         wZetw2ky7aQu6OeA0Kx2LMu5/rpf16Zg8Chdqy07tLQCfySrwEreR3N1kzw4O2CEUkyS
         Vj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9DT7T9nQfwo6eKdKm8ktrJGI/iqaC4tsTOR19DzTOIc=;
        b=Ipm3jO3UQSfe4wCK9YOr+mWoIpb/gUbhY2um7977I2JUFJDm8TysIDJ65xkJQ+5bnU
         4eQa2/QUqiLICo6fF7yMd0iML6pel6BKKoBkXC//wBEbkjQwEiQOl+xO2yoH02d4rxSc
         wwx+c+S8DJWXLXV4t6uu3zSyizWoBPg+SJx+I7QQ/0u1EOtSg3M59YHZXpJ/ykOQVcwD
         puswcPN3UJTaO+alBv4Eaj18u+QtSNlzp+XmhEa2v1SVm39zNdsQoS0r3rFtle233Dsa
         YldhSQTT04aV6+dU1kIlccdj5NLPUwLxOK3+rOXd84RRmU3Ph7teJAk9Exm8WjaUQYFY
         qLFQ==
X-Gm-Message-State: AOAM531gPbfr82xYdDNRbQIyGoQzQmq2wf/QVMGVTY0zHppRI6Tkwxg/
        r2IPAqsvh+f0EK/K3zRrcvlqrg==
X-Google-Smtp-Source: ABdhPJxt8ExSDwcad3/nlwy4wcUU3CTerjAZ2bl7+IOocMW5vV2fbb+AlFHt6ItMXMlUaUtqP2vCDA==
X-Received: by 2002:a17:90b:1093:: with SMTP id gj19mr9397091pjb.149.1598849172382;
        Sun, 30 Aug 2020 21:46:12 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id h193sm5930037pgc.42.2020.08.30.21.46.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2020 21:46:11 -0700 (PDT)
Date:   Mon, 31 Aug 2020 10:16:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        lkft-triage@lists.linaro.org, John Stultz <john.stultz@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        madhuparnabhowmik10@gmail.com
Subject: Re: Kernel panic : Unable to handle kernel paging request at virtual
 address - dead address between user and kernel address ranges
Message-ID: <20200831044609.owejwct5rvrgc5e5@vireshk-i7>
References: <CA+G9fYvUwH2FA9GOeA_7GYpLA31uOmEpg32VKnJ8-d5QSK4PdQ@mail.gmail.com>
 <20200827090813.fjugeqbb47fachy7@vireshk-i7>
 <CAK8P3a2zxybiMDzHXkTsT=VpHJOLkwd1=YTtCNU04vuMjZLkxA@mail.gmail.com>
 <20200827101231.smqrhqu5da6jlz6i@vireshk-i7>
 <CA+G9fYv=XLtsuD=tVR1HHotwpKLkbwZVyPr4UhY-jD+6-duTmw@mail.gmail.com>
 <CA+G9fYvSEHua0EpW64rASucWuS-U2STAZxufrfN75UDspGt2cA@mail.gmail.com>
 <CAPDyKFrpOqpBiSvkvO7sXHiQDOwdXYmx-80Ji5wW79QF-MrOuQ@mail.gmail.com>
 <CADYN=9K3D3OZ5T_K+6MfcgVLRoktPB6LvwDiXGj-+Zpq3faYfg@mail.gmail.com>
 <CAPDyKFpNVJZ0FddJ8naXYp-oZr-mYSOH-5iXG-wASZEFozBJJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpNVJZ0FddJ8naXYp-oZr-mYSOH-5iXG-wASZEFozBJJQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-20, 14:23, Ulf Hansson wrote:
> Anders, Naresh - thanks for testing and reporting. I am dropping the
> patch from my tree.
> 
> Viresh, I suggest to keep Anders/Naresh in the cc, for the next
> version. Then I can wait for their tested-by tag before I apply again.

Sorry for the trouble, I thought you will wait for a bit before
applying the patch to see test results from Naresh, but you were fast
enough as well :)

-- 
viresh
