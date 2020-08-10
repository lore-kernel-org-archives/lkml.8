Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0615C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9641B2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tE+ZaBoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgHJVlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgHJVlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:41:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1805C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 14:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PPtYVo8sITErFXD2s+M5PM3te1O7oF9+MdUGhVyUaCo=; b=tE+ZaBoZa2JsAER4ZWTm4e1QiT
        5S/tPqQEqgIk8KQlsVGdL5yLAgpLXfO1EfepC8DKzrbiS5NKHvKA4hFcJe3dU9v17lT5mYW4Q9Sme
        IFKcP5C+jhFps4BGPeGahDYjnXwuF0qBKkKu+qt61xq3J5b8CZDlLjQb+SWX1Grl9vivWdv4QI9EY
        MnO/EcPrROckKRL+PXsjtFzQrBeX+Rk/7UkzeGT+cqCU7l0mZ9bU7yRUnfGljQmhpkB7Mv7jOaTVU
        QYUnBezrTxAwjFhtwHjtuG0oZA6ToAPmhSkIXhB5Jfkft2vBzCbWmqbzy/omefe5KM1ny+YAviory
        AoIygLRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5FXR-0002Kg-RE; Mon, 10 Aug 2020 21:41:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1C3D980D39; Mon, 10 Aug 2020 23:41:00 +0200 (CEST)
Date:   Mon, 10 Aug 2020 23:41:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH V6 03/16] perf/core: Add support for
 PERF_SAMPLE_CODE_PAGE_SIZE
Message-ID: <20200810214100.GL3982@worktop.programming.kicks-ass.net>
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
 <20200810212436.8026-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810212436.8026-4-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 02:24:23PM -0700, Kan Liang wrote:
> From: Stephane Eranian <eranian@google.com>
> 
> When studying code layout, it is useful to capture the page size of the
> sampled code address.
> 
> Add a new sample type for code page size.
> The new sample type requires collecting the ip. The code page size can
> be calculated from the IRQ-safe perf_get_page_size().
> 
> Only the generic support is covered. The large PEBS will be disabled
> with this sample type.

-ENOREASON
