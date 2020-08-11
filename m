Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972D9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D8AC20678
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgHKIMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:12:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:1493 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbgHKIMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 04:12:42 -0400
IronPort-SDR: mYERgpeWGaI4Ce2imFbdxj1EXPQlvm7toEl1JkWtHcoCVG9wN6CL0K8HhQ1aSlE6RqYtlXboYs
 uD4kRfQdffbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="151364737"
X-IronPort-AV: E=Sophos;i="5.75,460,1589266800"; 
   d="scan'208";a="151364737"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 01:12:42 -0700
IronPort-SDR: D4y46sC0Ef5ocWgaOIwdPWYAAuQXaDhiTLq/NhqmTn9hOqM2krynsy+9eCoCcMz7HHDsGpq3/D
 gQJLVyPROXog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,460,1589266800"; 
   d="scan'208";a="277511088"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 11 Aug 2020 01:12:42 -0700
Received: from [10.249.225.27] (abudanko-mobl.ccr.corp.intel.com [10.249.225.27])
        by linux.intel.com (Postfix) with ESMTP id 3D21F5807AA;
        Tue, 11 Aug 2020 01:12:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] perf: Add closing sibling events' file descriptors
To:     Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, adrian.hunter@intel.com
References: <20200708151635.81239-1-alexander.shishkin@linux.intel.com>
 <20200708151635.81239-2-alexander.shishkin@linux.intel.com>
 <20200806083530.GV2674@hirez.programming.kicks-ass.net>
 <20200806153205.GA1448395@tassilo.jf.intel.com>
 <875z9q1u3g.fsf@ashishki-desk.ger.corp.intel.com>
 <20200810144518.GB1448395@tassilo.jf.intel.com>
 <20200810203632.GF3982@worktop.programming.kicks-ass.net>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d9389142-1065-0769-33b4-0f97e5d6eca4@linux.intel.com>
Date:   Tue, 11 Aug 2020 11:12:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810203632.GF3982@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10.08.2020 23:36, Peter Zijlstra wrote:
> On Mon, Aug 10, 2020 at 07:45:18AM -0700, Andi Kleen wrote:
> 
>> Unfortunately we're kind of stuck with the old NFILE=1024 default
>> even though it makes little sense on modern servers.
> 
> Why can't that be changed? It seems to me all of userspace changes all
> the time; heck that system-doofus thing flushed 20+ years of sysadmin
> experience down the drain, just cause. Why can't we up a file limit?
> 

If you asked me I would say that
Intel VTune HW micro architecture analysis would also be unblocked
by pushing RLIMIT_NOFILE limit beyond its current 1K default.

Currently rule of thumb for VTune users is to set the limit to
value == #cores X # events. The recommended value is 64K [1].

BR,
Alexei

[1] https://software.intel.com/content/www/us/en/develop/documentation/vtune-cookbook/top/configuration-recipes/profiling-hardware-without-sampling-drivers.html
