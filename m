Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFC4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 888C7207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M8ycmal7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgERJeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgERJeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:34:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C60C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2j4tkpm5JHeMcQSIOd5huHTdfscenHCGpDJTxFjuOQI=; b=M8ycmal7zUd3GNKv6m41wBJcG2
        uoyz6yFsIUKwbR+rIX97MHGtLVjExxNhILOnzMFyQVcR+si4Qeh1y9kjlsl+KDdjFIQzsiuEe8t9R
        woCrW5w1Bcy/kx4oSp2JUgFs4DjB9FoRxUsPvcqp3Ei+cc28aRbdexrNg9uvHWjWeHE5HXeq/FcEw
        vxeNw+aOweYB/WOhDE/WaZRclDl1wJeSYxwgWcRKnCroHI8dJ21O18i0VzGaG/aImQ3gwbXghLetd
        7urT0HEjZ65/hrGS3APtnThBgapV4xHsQnJywpLBuovUUCYzQ8xdzMr6IOM5+b6FjN1yLd4w0YaLo
        M6dAvDLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jac9s-0005EN-Py; Mon, 18 May 2020 09:34:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29822300478;
        Mon, 18 May 2020 11:34:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E63EF2B3CFEEA; Mon, 18 May 2020 11:34:02 +0200 (CEST)
Date:   Mon, 18 May 2020 11:34:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, mingo@elte.hu, irogers@google.com,
        kim.phillips@amd.com, jolsa@redhat.com
Subject: Re: [PATCH 3/3] perf/x86/rapl: add AMD Fam17h RAPL support
Message-ID: <20200518093402.GB277222@hirez.programming.kicks-ass.net>
References: <20200515215733.20647-1-eranian@google.com>
 <20200515215733.20647-4-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515215733.20647-4-eranian@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 02:57:33PM -0700, Stephane Eranian wrote:

> +static struct perf_msr amd_rapl_msrs[] = {
> +	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, NULL},
> +	[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr },
> +	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   NULL},
> +	[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   NULL},
> +	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL},
> +};

Why have those !PKG things initialized? Wouldn't they default to 0
anyway? If not, surely { 0, } is sufficient.
