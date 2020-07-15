Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC88BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E682064B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="woa3M/aE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbgGOJwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbgGOJwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:52:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA4FC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pXXHx3TK8l1DJFns+jDkeiOnj2ZNx1QSUKqQxIXBSPo=; b=woa3M/aECeeSc0kiWjJjomMCpY
        6aiHgYn8bGjtlUaTnsOOFrLjRAZ0Pw+8l4yC4kvyfaFW8GOgTX+YMCYJqb2uJ+9ZlMURbBls2HeSH
        OYqJBHCRM8gU0I/ocaOw0jB5GlzRK1s+W18HY9wIVoYMGLPdnn7uxgiDozyul2AjMrO3gKxx+jCKk
        KiR94UE9ArAgwGMLDgIROGl26nho+7cYXWKUcMBxxYy/+vo0sga325Ao7bS7OFRZpeObjFqRpswaO
        pXOUgaCW59B/RcozZSZd/t4EBtT+PueRFNftfbe2TDVW844tsOgQwDjrWHUXe9X+A5i0VabhqXN0v
        8xRJaCgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jve5O-0000o4-6v; Wed, 15 Jul 2020 09:52:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DDBAC3028C8;
        Wed, 15 Jul 2020 11:52:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE52A2145CCC0; Wed, 15 Jul 2020 11:52:20 +0200 (CEST)
Date:   Wed, 15 Jul 2020 11:52:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, jogness@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] sched_clock: Expose struct clock_read_data
Message-ID: <20200715095220.GH10769@hirez.programming.kicks-ass.net>
References: <20200715020512.20991-1-leo.yan@linaro.org>
 <20200715020512.20991-2-leo.yan@linaro.org>
 <20200715055650.GB225020@debian-buster-darwi.lab.linutronix.de>
 <20200715081222.GB10769@hirez.programming.kicks-ass.net>
 <20200715081443.GB43129@hirez.programming.kicks-ass.net>
 <20200715092345.GA231464@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715092345.GA231464@debian-buster-darwi.lab.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 11:23:45AM +0200, Ahmed S. Darwish wrote:
> 
> Can we then please replace the raw_read_seqcount(), in the original
> patch which started this discussion, with raw_read_seqcount_latch()?

Separate patch please, but ACK for making the change.
