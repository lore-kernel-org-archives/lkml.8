Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C657EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9949F208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OCTQ5OmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgCBKNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:13:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgCBKNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KDtV+b9cFlndjXE+4IObWypoEmyIhd+qmjWv7G9GcpQ=; b=OCTQ5OmV9g5OyjoYsMsXUUPFMS
        j2bs106DUvw3yN8koJmXq/m76PhI+yikxhgNztcxl+hxV9SgpKEW3Cq5MEZQuacxXIRGBhcOxb1ml
        BLgt6WGGQYFyU4YZasM+vMwhqhF0fsnIE6Xr9pLpYAPh+YHO8iC8Q+Qx0SCxYuLrMof/Iu5vogENh
        ycQ00kz3TEtoOv0hzj34n7gk1eMMWgPIpb33YGMKR7kWfia8Mx5CRSFk4T50soYE8SHidg9LE2Bul
        4H1cv0l723IriduKQsQ6B8n104XtephHJwvbDEHHAtvuv7ZwOLyTW+F58ZfUbKTSqFliB+yObPl0r
        WtDbvnPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8i4t-0001nQ-Ey; Mon, 02 Mar 2020 10:13:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7E303012C3;
        Mon,  2 Mar 2020 11:11:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45912202A4098; Mon,  2 Mar 2020 11:13:32 +0100 (CET)
Date:   Mon, 2 Mar 2020 11:13:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        eranian@google.com, mpe@ellerman.id.au, paulus@samba.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, alexey.budankov@linux.intel.com,
        yao.jin@linux.intel.com, robert.richter@amd.com,
        kim.phillips@amd.com, maddy@linux.ibm.com
Subject: Re: [RFC 00/11] perf: Enhancing perf to export processor hazard
 information
Message-ID: <20200302101332.GS18400@hirez.programming.kicks-ass.net>
References: <20200302052355.36365-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302052355.36365-1-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 10:53:44AM +0530, Ravi Bangoria wrote:
> Modern processors export such hazard data in Performance
> Monitoring Unit (PMU) registers. Ex, 'Sampled Instruction Event
> Register' on IBM PowerPC[1][2] and 'Instruction-Based Sampling' on
> AMD[3] provides similar information.
> 
> Implementation detail:
> 
> A new sample_type called PERF_SAMPLE_PIPELINE_HAZ is introduced.
> If it's set, kernel converts arch specific hazard information
> into generic format:
> 
>   struct perf_pipeline_haz_data {
>          /* Instruction/Opcode type: Load, Store, Branch .... */
>          __u8    itype;
>          /* Instruction Cache source */
>          __u8    icache;
>          /* Instruction suffered hazard in pipeline stage */
>          __u8    hazard_stage;
>          /* Hazard reason */
>          __u8    hazard_reason;
>          /* Instruction suffered stall in pipeline stage */
>          __u8    stall_stage;
>          /* Stall reason */
>          __u8    stall_reason;
>          __u16   pad;
>   };

Kim, does this format indeed work for AMD IBS?
