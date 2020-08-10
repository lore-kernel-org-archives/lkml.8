Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB01C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E953C206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="soOjRB5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgHJWoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHJWoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 18:44:15 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0586FC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 15:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jEYD+DmHqlF4FFMwJQgsC6gYml2r38qsCWztMik+ihQ=; b=soOjRB5d5ijph2SZK5/W88+4hE
        CQ586S3WJoH+lL0+ribs9iiYbS6eTmJpW141fyuloOWZocIKSFanO7yHsiCeSuILQ4Dfnn6osvNFT
        TSvToHth0W4htYAYOfKiOzuK6k3/uTXpJJd/nKl3JtDdRDFnmm7KYvJlEnYIW/xI72MCJzieNoXIi
        DwIWN7ngBJRjrKDQBWOWapDwJ6WmhH2vg3AEJYx16gq9+3bMNiq7QFF+q2C86xiRIsU+WC/l5QBQz
        z1XSv4AN/po5Lre2Xsswjhq3uIBdk+tyQYV8zrtfeb1guuxXObk6QVeggJhiNaYpObhNHmUI6wzoc
        5evZRnqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5GWT-0005GN-PM; Mon, 10 Aug 2020 22:44:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52E8D980BF8; Tue, 11 Aug 2020 00:44:03 +0200 (CEST)
Date:   Tue, 11 Aug 2020 00:44:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH V6 03/16] perf/core: Add support for
 PERF_SAMPLE_CODE_PAGE_SIZE
Message-ID: <20200810224403.GN3982@worktop.programming.kicks-ass.net>
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
 <20200810212436.8026-4-kan.liang@linux.intel.com>
 <20200810214100.GL3982@worktop.programming.kicks-ass.net>
 <3313128b-04f3-e5b5-9918-aaed7ede43de@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3313128b-04f3-e5b5-9918-aaed7ede43de@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 06:37:08PM -0400, Liang, Kan wrote:
> 
> 
> On 8/10/2020 5:41 PM, Peter Zijlstra wrote:
> > On Mon, Aug 10, 2020 at 02:24:23PM -0700, Kan Liang wrote:
> > > From: Stephane Eranian <eranian@google.com>
> > > 
> > > When studying code layout, it is useful to capture the page size of the
> > > sampled code address.
> > > 
> > > Add a new sample type for code page size.
> > > The new sample type requires collecting the ip. The code page size can
> > > be calculated from the IRQ-safe perf_get_page_size().
> > > 
> > > Only the generic support is covered. The large PEBS will be disabled
> > > with this sample type.
> > 
> > -ENOREASON
> 
> I think the reason is similar to PERF_SAMPLE_DATA_PAGE_SIZE. For large PEBS,
> the mapping could be gone for the earlier PEBS records. Invalid page size
> may be retrieved. I will update the commit message.

That's extremely unlikely though.. We might as well just do it and pray.
The worst case is that we return '0' page-size because it's gone, that
seems fairly sane.

Alternatively, we can register mmu_notifiers or something and flush PEBS
buffers when ranges get invalidated.
