Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F083C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2373C2068F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599011358;
	bh=ACnmUo/q7wikQNAqquuTw1JPZJIlINIYP3A9vIHgDXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dFKFXycW7+o+GRV6KHK9Sc0h1BcSKHNXoN7saIlCf6jPtW2G8J0KLCyYA/f4dl6R9
	 LxFHfaib+9BQNPE7oqrIbgS5aYQE5YM3tSVN1z3RtUOa/1UGUe4joUUKczOUk8GlG2
	 ySjHtEVRH1otmv70KdWEfzKnAbrqmJnTuAqz8mh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgIBBtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 21:49:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgIBBr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 21:47:57 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6A082068F;
        Wed,  2 Sep 2020 01:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599011277;
        bh=ACnmUo/q7wikQNAqquuTw1JPZJIlINIYP3A9vIHgDXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k8MK8Bb0dxIQrH34HVR3KRioFlzw+N1SwWNUtWAmeBX6n+8opBmc0BC6I1FFlBEhR
         BH782NR2rCXX9vt0S8wRrxs7CMih5usB70/pYKsuv/qgwlmy2Y/nNcR6eOqFVizbJP
         pmzS9vF3SmhyUWJxWmIUwB+YfkpH/M74pPp8lJlQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8860440D3D; Tue,  1 Sep 2020 22:47:54 -0300 (-03)
Date:   Tue, 1 Sep 2020 22:47:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Al Grant <al.grant@arm.com>
Subject: Re: [PATCH 1/2] perf cs-etm: Fix corrupt data after perf inject from
Message-ID: <20200902014754.GA3444345@kernel.org>
References: <20200819084751.17686-1-leo.yan@linaro.org>
 <20200827205354.GE22307@xps15>
 <20200831000432.GA4715@leoy-ThinkPad-X240s>
 <20200901145432.GB1422817@kernel.org>
 <20200902003931.GA3306@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902003931.GA3306@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 02, 2020 at 08:39:32AM +0800, Leo Yan escreveu:
> On Tue, Sep 01, 2020 at 11:54:32AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Aug 31, 2020 at 08:04:32AM +0800, Leo Yan escreveu:
> > > On Thu, Aug 27, 2020 at 02:53:54PM -0600, Mathieu Poirier wrote:
> > > > On Wed, Aug 19, 2020 at 04:47:50PM +0800, Leo Yan wrote:
> > > > I've see this patch before...  I thought it had been merged - what happened?

> > > This patch before has been sent by Al to CoreSight mailing list but has
> > > not sent to LKML, this is why I resent it to LKML in case it's missed.

> > So, was it Acked on the CoreSight mailing list? Are we missing any
> > Acked-by or Reviewed-by for this 1/2 patch as we got for 2/2?
 
> The CoreSight mailing list has some discussion for this patch set,
> when respin this patch set, I confirmed we don't miss any 'Acked' or
> 'Reviewed' tags.

So, this patch was included in today's
perf-tools-fixes-for-v5.9-2020-09-01 signed tag sent to Linus in a pull
req, please update your perf/urgent branch, and go on from there, I'll
merge that into my perf/core branch as soon as Linus merges it.

- Arnaldo
