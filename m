Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B8CC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCF42166E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lV8GXcPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgCBUVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:21:21 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33303 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgCBUVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 15:21:21 -0500
Received: by mail-vk1-f195.google.com with SMTP id i78so217847vke.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 12:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GrNNnjItPXoUSAp5/6CuW8AHlrS1JSgSwId4oyjSgCk=;
        b=lV8GXcPAD9YUu7oqVXNTN6JNL/pszISLDCdNOgt79zz4pHerK02MjVMnhAURV3NvCL
         FVFoNlTCfa2PZhHk3fEYezlSqSKM62JrSPEwYjwOHyRnUFDTozemgg9LyngGdXKjUq7p
         Wmh18IXVYhHE4ZDnjl8Mf0viqutS8huzuUi4hNPhnMUbUoyCXJGSijzCz8L9JWEW9l2f
         hukDFobeolOUmuTVrc93oy20GgtW0hHalC9pjb/i9j75FuU7JC1vidgsB6RVK9We/eWP
         BJdPE9etmq//Wogoiq4/GZCgdD0EPRY7KHiZqjnzThzLdSAHgMQChrrg3U+Va43dmx2h
         8gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GrNNnjItPXoUSAp5/6CuW8AHlrS1JSgSwId4oyjSgCk=;
        b=Xohls7RQJk7g+sZPrbLNDqQcMklD/5MJ4pD5Bw9d3bHJTu2bHBwwpYxQNZw5Hc/oBm
         yB4Q3TsLphYzQvRRxKsNI3W7qaCMkrESwSa9quffAmCQl2Ow+MeZ/aUMsaFK1UlYoZuQ
         ccr5f/TkqZge3FKy6KPv1cMaoq9bgUbRAzQvUD+vvqcFVmNMkXiq5MzUyC+Zklh4ihM4
         MDJy2uYNSx6gkId6viOnkHFVdVsminyDeyOCbb+r+L/sVtYBLP4llrWogC9HvMYapeAY
         2eCC/Jff4VaotrnFDPQDjYqvR7jmTBh0m3NIUm8Q0uFyi0D6Z/RScKQ75hiBVwnK6sjh
         LK/A==
X-Gm-Message-State: ANhLgQ2eXYDWj28r634frYha1CIyKvr6vAmB5HryMYQuJMJpaBrr8T+g
        UDGaGLhM1/880IqWrdzy4HgwCn70fKROyUcS+nMJWA==
X-Google-Smtp-Source: ADFU+vuHDDUez4FqqKiHhS43fjWXjrsrzfWXTcjtessfBqf9EPjwVXyf1gR166Ynvh9kTlFxmW/y8N+oPw7+f3OE5cI=
X-Received: by 2002:a1f:a9d0:: with SMTP id s199mr926630vke.40.1583180480007;
 Mon, 02 Mar 2020 12:21:20 -0800 (PST)
MIME-Version: 1.0
References: <20200302052355.36365-1-ravi.bangoria@linux.ibm.com> <20200302101332.GS18400@hirez.programming.kicks-ass.net>
In-Reply-To: <20200302101332.GS18400@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 2 Mar 2020 12:21:09 -0800
Message-ID: <CABPqkBSzwpR6p7UZs7g1vWGCJRLsh565mRMGc6m0Enn1SnkC4w@mail.gmail.com>
Subject: Re: [RFC 00/11] perf: Enhancing perf to export processor hazard information
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        yao.jin@linux.intel.com, Robert Richter <robert.richter@amd.com>,
        "Phillips, Kim" <kim.phillips@amd.com>, maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 2:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Mar 02, 2020 at 10:53:44AM +0530, Ravi Bangoria wrote:
> > Modern processors export such hazard data in Performance
> > Monitoring Unit (PMU) registers. Ex, 'Sampled Instruction Event
> > Register' on IBM PowerPC[1][2] and 'Instruction-Based Sampling' on
> > AMD[3] provides similar information.
> >
> > Implementation detail:
> >
> > A new sample_type called PERF_SAMPLE_PIPELINE_HAZ is introduced.
> > If it's set, kernel converts arch specific hazard information
> > into generic format:
> >
> >   struct perf_pipeline_haz_data {
> >          /* Instruction/Opcode type: Load, Store, Branch .... */
> >          __u8    itype;
> >          /* Instruction Cache source */
> >          __u8    icache;
> >          /* Instruction suffered hazard in pipeline stage */
> >          __u8    hazard_stage;
> >          /* Hazard reason */
> >          __u8    hazard_reason;
> >          /* Instruction suffered stall in pipeline stage */
> >          __u8    stall_stage;
> >          /* Stall reason */
> >          __u8    stall_reason;
> >          __u16   pad;
> >   };
>
> Kim, does this format indeed work for AMD IBS?


Personally, I don't like the term hazard. This is too IBM Power
specific. We need to find a better term, maybe stall or penalty.
Also worth considering is the support of ARM SPE (Statistical
Profiling Extension) which is their version of IBS.
Whatever gets added need to cover all three with no limitations.
