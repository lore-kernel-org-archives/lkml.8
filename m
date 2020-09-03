Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A424C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2282C20709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sr/AQZ5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgICJON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 05:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgICJOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 05:14:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E9FC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 02:14:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id o16so1217737pjr.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 02:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4afLgUe1cUkVRP69nTr5da9z39FDawbQG5TycdOn8JY=;
        b=Sr/AQZ5LBkyS4/m/pvaWuGKg255C7W/jwT6mmfv67FngAC3NvOEEXUyaJe3TMkFMBu
         IPCRUcEsFZTRoZWKfMHX7PcvafWTofRrRuZMy23mWgNCpIGvTCoArTK+glMkpedkMhuJ
         fx7BgG0SQ6MRRkRxapNNmrerz9E5rKRwy7cvBCXazKBDG4wBX5yNbewTUYw/pE+YQP4G
         FJbG0hNSF4lapwKvVDg7GVJ48lDnpqiY7vWzyPV6cAnyCBQ+huDV3KkUeq8SKT837XO3
         JnefJo+ZOp+y1HeKd5kXKs/h6zVhrz49ozhofIkwsLzEZQR2RDCqTQ6We7V7dLSd2jIa
         N9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4afLgUe1cUkVRP69nTr5da9z39FDawbQG5TycdOn8JY=;
        b=ON9cACCrYSVkUefZ6Cgc/g1dpVPyxzcschjVOT+yMuHZFr+cISlx9C15v/oLaOhW1R
         Rv7URhlIm7SlKB+wn2lnQP6uO9NanBSn6Uc3f4zJ/jUeED6kIXNIGedozYzumx/DcOBC
         FI7s1U9QDKcCsTE+QwUmo53+U/NXA7Spz1Xo2JyCYwlj6pfXkNypUV1mMK45NtVJjNp2
         +gdQmsjHPs1osM/2QfziQJFqVSgsNWSXZO6ksK9i7HXT5jfI8bOJWprvIQh/VQhJPuaZ
         0x9kxomLs6JLXx4/AspvhnEGQI12gP2FD8npCkKrhTI2XHbV8N1UTeD/zvG85Y09Zdf1
         IWfA==
X-Gm-Message-State: AOAM533RzGAhKjmi+mnUPC08NOWlMoug/kwFkkYBBmekLi9FXzWMJPsd
        rVml67Yj1dp4cpwN+ol+OTUS4w==
X-Google-Smtp-Source: ABdhPJwNxm0867FCHT/ZOCka2bLgCkXIxhUiDvCTty8Hi2oKdLE122ssJmVXYKzgmIcdmGWVK69Akw==
X-Received: by 2002:a17:90a:d904:: with SMTP id c4mr2292255pjv.145.1599124444493;
        Thu, 03 Sep 2020 02:14:04 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id x185sm2363995pfc.188.2020.09.03.02.13.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Sep 2020 02:14:04 -0700 (PDT)
Date:   Thu, 3 Sep 2020 17:13:55 +0800
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
Subject: Re: [PATCH RESEND v1 00/11] perf mem: Support AUX trace and Arm SPE
Message-ID: <20200903091355.GC1583@leoy-ThinkPad-X240s>
References: <20200806030727.30267-1-leo.yan@linaro.org>
 <df08fad6-eec9-12a2-3d88-0d863fb42325@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df08fad6-eec9-12a2-3d88-0d863fb42325@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 05:36:50PM +0100, James Clark wrote:
> On 06/08/2020 04:07, Leo Yan wrote:
> > This patch set is to support AUX trace and Arm SPE as the first enabled
> > hardware tracing for Perf memory tool.
> > 
> 
> Hi Leo,
> 
> I've tested this patchset with "./perf mem record -e spe-store ./a.out" on N1 and it's working for me.
> Thanks for submitting this!

Thanks a lot for your testing!  I will add your testing tag for the
patches which have not been changed in later patch set.

P.s. I have sent patch set v2 [1] for the reviewing, a brief change
comparing to v1 is it introduces 'memory' event so can allow all memory
operations to display in the same view.  You are welcome to review and
give comments, thanks!

Leo

[1] https://lore.kernel.org/lkml/20200901083815.13755-1-leo.yan@linaro.org/
