Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFC3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 838372070A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uCF7g4iM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgETP5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:57:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57390 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgETP5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4BvS0jlr7oCkELud6O1ojDhouiIv+OR3l1j2reO5sk8=; b=uCF7g4iMdRgoUPWcbjTe0Snrjj
        BwLdfo1Pa0HFqHeeUAucfOojPiDhZY4u3xsV90Y3T+1ARjSQdogIYimoU/bjc5uTFoL8qvOX7VSpN
        aSu8Q/LToJQNRynpYO7UA6SdLtOJkTvWONmAjkGYmNHar+r679N6RDgWtlAe892UDtLOtGKFZqNkX
        4O8CCyHLR19r4zEdj/VNQ5Bgiw9Abwgqev5pJxpDTDZ8FUY0e0raNi8dY2n8N3PNTiayTAfhM5P6A
        yvVH72aercMKexZaImiMhTjt2u7xVZsiSEj0K/D3fe5ymvYqlFxzlsL1JFtUjY/51hl0YdFRaGgYP
        VpJWMoWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbR5A-0004os-HR; Wed, 20 May 2020 15:56:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6E05F301A80;
        Wed, 20 May 2020 17:56:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 50E6C29DE0750; Wed, 20 May 2020 17:56:34 +0200 (CEST)
Date:   Wed, 20 May 2020 17:56:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 00/15] perf/x86: Add perf text poke events
Message-ID: <20200520155634.GQ317569@hirez.programming.kicks-ass.net>
References: <20200512121922.8997-1-adrian.hunter@intel.com>
 <bee04840-143c-18bb-df82-5aa58d70730e@intel.com>
 <20200520014001.GF28228@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520014001.GF28228@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 10:40:01PM -0300, Arnaldo Carvalho de Melo wrote:
> PeterZ, from what we discussed for the next merge Window, perhaps we
> should route the kernel bits via the tip tree while I will push the
> tooling bits on my 5.8 merge request to Linus, Ok?

Sure, I can take the kernel bits. Thanks!
