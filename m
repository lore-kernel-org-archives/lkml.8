Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD47C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67813208B3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599061671;
	bh=KiXG3vPSX3QQONiOmnVN3l5DWGomJL+un/AUZiudI40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YzPRqOq+rrUqfj4n11OfC4dL2jY1nZoE2bKv0zjhoy2IXxspObj8XySdqBIO+vs4Y
	 3/ex7+DJ5w3BxIN14fFyTuWokrAJ7p/9+GcKnNVcsHib+Diyp0r5Z6FWPBG3IwgvnH
	 AiwPG8PKM0uUb8TMse9cynSEzADnBFd2nkKfWVUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgIBPrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:47:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbgIBNav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:30:51 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4CF820709;
        Wed,  2 Sep 2020 13:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599053437;
        bh=KiXG3vPSX3QQONiOmnVN3l5DWGomJL+un/AUZiudI40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=awKCJrmYIm5cDtXSBdmG87lZohTxj1yU2UyDGarMm5xwy6EL8HmJ2uIGOLNeW97yC
         KMtXqMRsyxFqGsSG9523gOfAQUgRA5Cj7J412u9FAF8YsoxnygtxOV0ESBHeaN4X/L
         iKfjVTcVCnXsGTU4DEACxGX0GUVuUd8PcggUm7aY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E60CE40D3D; Wed,  2 Sep 2020 10:30:34 -0300 (-03)
Date:   Wed, 2 Sep 2020 10:30:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Al Grant <al.grant@arm.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Ahern <dsahern@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Like Xu <like.xu@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Wei Li <liwei391@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf tools fixes for v5.9
Message-ID: <20200902133034.GB3444345@kernel.org>
References: <20200901224154.3436175-1-acme@kernel.org>
 <CAHk-=wifL-04oOF3RAbX9Odyfgz4zc4dE=pq-QL+2C-aTxUmqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wifL-04oOF3RAbX9Odyfgz4zc4dE=pq-QL+2C-aTxUmqw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 01, 2020 at 07:43:33PM -0700, Linus Torvalds escreveu:
> On Tue, Sep 1, 2020 at 3:42 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > - The SNOOPX and REMOTE offsets in the data_src bitmask in perf records were
> >   were both 37, SNOOPX is 38, fix it.
> 
> The kernel uapi side thinks it's 37. What's up?
> 
>   $ git grep PERF_MEM_SNOOPX_SHIFT
> 
> results in
> 
>   include/uapi/linux/perf_event.h:#define PERF_MEM_SNOOPX_SHIFT   37
>   tools/include/uapi/linux/perf_event.h:#define PERF_MEM_SNOOPX_SHIFT     38

Its going in a separate patch, via PeterZ/Ingo,

- Arnaldo
