Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E9BC433F8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4E4206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PipfBR+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388700AbgGTQWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388695AbgGTQWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:22:47 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC46C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OxMDt2k/5hf5ul+MN4+NkwJ2ux1u4+nbqRvCh4zpOvQ=; b=PipfBR+swWLK2QDSix3ch+lDRU
        Zwhc/NbLhmSQCjgnW5VKdE90MIkXW+eufv/Vkd5p4JPqkImZ09ofQfPvwtpSx8p0lD2KZnjE4ogdn
        bv3TfwDqdCCbk+hOtJmj2XwMN4HEE/mFtxh9QTYp5yiWXzJO+v0Rc5RXCrMWV4LwMk1W2xaMxb524
        ZmRuBzt799Xka0qVccRuwEp9cTlWjASkVRPmBeTLfQtSDYidvWs23qakEi6TA5fLMQEEO1YzxsVaM
        Tigbj6aqohrzszGQVe5vq1v5ye9MF4/CAJjALPeMJXO3qUc7Z+xGRmJEKUqZ769QSie65686S9K2Y
        B1H/4Asw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYYs-0002rc-PT; Mon, 20 Jul 2020 16:22:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 37377307B99;
        Mon, 20 Jul 2020 18:22:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C8BF23426BB8; Mon, 20 Jul 2020 18:22:41 +0200 (CEST)
Date:   Mon, 20 Jul 2020 18:22:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V6 06/14] perf/x86/intel: Use switch in
 intel_pmu_disable/enable_event
Message-ID: <20200720162241.GU10769@hirez.programming.kicks-ass.net>
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
 <20200717140554.22863-7-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717140554.22863-7-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 07:05:46AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Many items are checked in the intel_pmu_disable/enable_event. More items
> will be added later, e.g. perf metrics events.
> 
> Use switch, which is more efficient, to replace the if-else.

Perhaps explain how; does this actually generate a jump-table?
