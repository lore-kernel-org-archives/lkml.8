Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DFAC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139B12073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgCEWsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:48:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:5209 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgCEWsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:48:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:48:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="387645389"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga004.jf.intel.com with ESMTP; 05 Mar 2020 14:48:52 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C0679301BC6; Thu,  5 Mar 2020 14:48:52 -0800 (PST)
Date:   Thu, 5 Mar 2020 14:48:52 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Luwei Kang <luwei.kang@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, hpa@zytor.com, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        pawan.kumar.gupta@linux.intel.com, thomas.lendacky@amd.com,
        fenghua.yu@intel.com, kan.liang@linux.intel.com,
        like.xu@linux.intel.com
Subject: Re: [PATCH v1 00/11] PEBS virtualization enabling via DS
Message-ID: <20200305224852.GE1454533@tassilo.jf.intel.com>
References: <1583431025-19802-1-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583431025-19802-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Testing:
> The guest can use PEBS feature like native. e.g.

Could you please add example qemu command lines too? That will make it much easier
for someone to reproduce.

-Andi
> 
> # perf record -e instructions:ppp ./br_instr a
> 
> perf report on guest:
> # Samples: 2K of event 'instructions:ppp', # Event count (approx.): 1473377250
> # Overhead  Command   Shared Object      Symbol
>   57.74%  br_instr  br_instr           [.] lfsr_cond
>   41.40%  br_instr  br_instr           [.] cmp_end
>    0.21%  br_instr  [kernel.kallsyms]  [k] __lock_acquire
> 
> perf report on host:
> # Samples: 2K of event 'instructions:ppp', # Event count (approx.): 1462721386
> # Overhead  Command   Shared Object     Symbol
>   57.90%  br_instr  br_instr          [.] lfsr_cond
>   41.95%  br_instr  br_instr          [.] cmp_end
>    0.05%  br_instr  [kernel.vmlinux]  [k] lock_acquire
