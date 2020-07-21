Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0345C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B797820702
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MhXt+NdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgGUOZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgGUOZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:25:12 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1923DC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OwZ5k4B21uSZKuzQJZt3/c4ozHvHOEuoSPFuVoaeGMc=; b=MhXt+NdOkWM1Q6iqFnYm6RPxQK
        wImXznp+9juWTGr44NAyzvz95WDypgdG0xRzPWHzwNmdFz9BJIy/BepmjMhjFhv3gwrTZWzPV+SdY
        arifFjd1osDSyAMpg2fMGlgQDGSaMH4LN/0cxvddhA/C6lczjhXExhDYHUw1R0pxQ0vkNavJw5XQt
        uVkmi1lxpMqST5A2h90Clu9FEbbYnTan+c0BYEwO40mNaurLllKtLqRgjxTCnLTSudSnBHuOCCUrP
        ctjpOHmrYCrUmruRPJ5t0KPM3oK2kv3BHxOJW8DVfSKkCtRpnAr0lI++r3Rlb5sfp2WyzE5g74n9K
        NIcm4cKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxtCc-0001N7-NE; Tue, 21 Jul 2020 14:25:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 74E06304E03;
        Tue, 21 Jul 2020 16:25:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F53320410551; Tue, 21 Jul 2020 16:25:05 +0200 (CEST)
Date:   Tue, 21 Jul 2020 16:25:05 +0200
From:   peterz@infradead.org
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V6 07/14] perf/x86/intel: Generic support for hardware
 TopDown metrics
Message-ID: <20200721142505.GK119549@hirez.programming.kicks-ass.net>
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
 <20200717140554.22863-8-kan.liang@linux.intel.com>
 <20200721094327.GW10769@hirez.programming.kicks-ass.net>
 <3a6b082e-7906-9df1-28b9-c7639127e8a7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a6b082e-7906-9df1-28b9-c7639127e8a7@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 10:05:55AM -0400, Liang, Kan wrote:
> On 7/21/2020 5:43 AM, Peter Zijlstra wrote:
> > @@ -1098,37 +1105,20 @@ static int collect_events(struct cpu_hw_
> >   		cpuc->pebs_output = is_pebs_pt(leader) + 1;
> >   	}
> > -	if (x86_pmu.intel_cap.perf_metrics &&
> > -	    add_nr_metric_event(cpuc, leader, &max_count, false))
> > +	if (is_x86_event(leader) && collect_event(cpuc, leader, max_count, n))
> >   		return -EINVAL;
> > +	n++;
> 
> If a leader is not an x86 event, n will be mistakenly increased.
> But is it possible that a leader is not an x86 event here?

You're right, and yes that can happen, see the move_group=1 case in
sys_perf_event_open().

	if (is_x86_event(leader)) {
		if (collect_event(cpuc, leader, max_count, n))
			return -EINVAL;
		n++;
	}

it is then..
