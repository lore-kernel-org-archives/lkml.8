Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047B6C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31D224673
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCCBda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 20:33:30 -0500
Received: from mga18.intel.com ([134.134.136.126]:22579 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbgCCBda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:33:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 17:33:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,509,1574150400"; 
   d="scan'208";a="233416585"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga008.jf.intel.com with ESMTP; 02 Mar 2020 17:33:29 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 899533011B1; Mon,  2 Mar 2020 17:33:29 -0800 (PST)
Date:   Mon, 2 Mar 2020 17:33:29 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        eranian@google.com, mpe@ellerman.id.au, paulus@samba.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, alexey.budankov@linux.intel.com,
        yao.jin@linux.intel.com, robert.richter@amd.com,
        kim.phillips@amd.com, maddy@linux.ibm.com
Subject: Re: [RFC 00/11] perf: Enhancing perf to export processor hazard
 information
Message-ID: <20200303013329.GB1319864@tassilo.jf.intel.com>
References: <20200302052355.36365-1-ravi.bangoria@linux.ibm.com>
 <20200302101332.GS18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302101332.GS18400@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 11:13:32AM +0100, Peter Zijlstra wrote:
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

Intel PEBS has a similar concept for annotation of memory accesses,
which is already exported through perf_mem_data_src. This is essentially
an extension. It would be better to have something unified here. 
Right now it seems to duplicate at least part of the PEBS facility.

-Andi

