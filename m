Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147C0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C892074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591024011;
	bh=9sxpQz0r5jfjy6WFXrkM4az/JF+mNS0L+Sk18DJ5y3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HsjVn+2IRlSibPqebamchzB8Cm+onRXrReu1+ObW4TO2pXwyBWfDaAEzxIfzPCr2r
	 +XiRN1GHFpcVjTKXbI+89VtVCCsvYTdGdFoxHPAH7iQ4Wd3/huIj7Y3FjsSQ8T35a6
	 ZSm1gtvwnTMyFVB+tWD8iNS8b2qRtHejfLZu5LjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgFAPGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:06:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgFAPGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:06:50 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFB8B20738;
        Mon,  1 Jun 2020 15:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591024010;
        bh=9sxpQz0r5jfjy6WFXrkM4az/JF+mNS0L+Sk18DJ5y3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TnGnUsZpDjmVurxbkq6M3cjp3Ta5VQzpwYBHLthaC+UOWW2Kr8MaoRpLNKMXUJVwg
         60F99CGpRHMM7VQRO8OkLPMvY1yTFU3OAGLTXQXviNWKxeCGzyssLYxa4T8DEAMzLS
         HzTT0GlrTp4S2D+yzcZUmFC8KDvR5P1/pSWy0PD8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 15B3D40AFD; Mon,  1 Jun 2020 12:06:48 -0300 (-03)
Date:   Mon, 1 Jun 2020 12:06:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Al Grant <al.grant@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Tan Xiaojun <tanxiaojun@huawei.com>
Subject: Re: [PATCH v8 2/3] perf auxtrace: Add four itrace options
Message-ID: <20200601150647.GK31795@kernel.org>
References: <20200530122442.490-1-leo.yan@linaro.org>
 <20200530122442.490-3-leo.yan@linaro.org>
 <aaacf3f6-daab-098e-d1fb-1509e1cf9c84@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaacf3f6-daab-098e-d1fb-1509e1cf9c84@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 01, 2020 at 10:24:00AM +0300, Adrian Hunter escreveu:
> On 30/05/20 3:24 pm, Leo Yan wrote:
> > From: Tan Xiaojun <tanxiaojun@huawei.com>
> > 
> > This patch is to add four options to synthesize events which are
> > described as below:
> > 
> >  'f': synthesize first level cache events
> >  'm': synthesize last level cache events
> >  't': synthesize TLB events
> >  'a': synthesize remote access events
> > 
> > This four options will be used by ARM SPE as their first consumer.
> > 
> > Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
> > Signed-off-by: James Clark <james.clark@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > Tested-by: James Clark <james.clark@arm.com>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks a lot!

- Arnaldo
