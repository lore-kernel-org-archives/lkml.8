Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D193AC433F7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F8A520714
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BCLrHNby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgGXOvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgGXOvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:51:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17BAC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2B6Se+TXVfPjKkzsWI7G6Ng0wHqohREHU6ITtVoF3+w=; b=BCLrHNby8+LkYLq5qEfFVN7O2Q
        +USXbIMPywnlJUrE4FfgdxYulgzh9nPBDe4w7k8seC+LBDjz8tWvVCgAicigRG+zH7OfdmNnRkMkd
        Bm2MbHDssFgXjDRzrXw0wsaUXf8SeOgWO6gskOG9EsacRRKK2093AI/kg+eiiTPoeZBtelZb+8ddE
        T4A5N2oQTCnr/U3tlsizRn12WiajlAnkjMlC81UaWTxL1axIe1Ar2BloDLQ99R8iFOcny6/KH21pJ
        oIV0y70cOLxGT+lIEMcG5NYfurKZSW+taZJcrtIwWRUkDj90uNTqCS8JVtlTfZZluYdjOqND5pg5t
        eT5vp8yQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyz30-0005XD-VC; Fri, 24 Jul 2020 14:51:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8A530305E21;
        Fri, 24 Jul 2020 16:51:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 724FC236F1EA4; Fri, 24 Jul 2020 16:51:42 +0200 (CEST)
Date:   Fri, 24 Jul 2020 16:51:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kan.liang@linux.intel.com, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, like.xu@linux.intel.com
Subject: Re: [PATCH V7 07/14] perf/core: Add a new PERF_EV_CAP_COEXIST event
 capability
Message-ID: <20200724145142.GC10769@hirez.programming.kicks-ass.net>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
 <20200723171117.9918-8-kan.liang@linux.intel.com>
 <20200724105543.GV119549@hirez.programming.kicks-ass.net>
 <20200724114628.GJ43129@hirez.programming.kicks-ass.net>
 <20200724143908.GC1180481@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724143908.GC1180481@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 07:39:08AM -0700, Andi Kleen wrote:
> > The consequence is that SLOTS must be the leader, is that really a
> > problem? You keep providing the {cycles, slots, metric-things} example,
> 
> Yes that's a problem. One (major) use case for topdown is to
> sample on lots of different events, but always create groups that
> also measure topdown metrics for that sampling period. For that we need
> other leaders.

Apparently the only problem here is the tool, the kernel doesn't care
which events in a group are sampling, there could be multiple.

