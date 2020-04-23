Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E574AC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD34920728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgDWQkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:40:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:63456 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbgDWQka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:40:30 -0400
IronPort-SDR: Y7ST5mk+gOS7WLDxLzZzkCfqCUEeRXhthLaO+DEsriSFoTsjDvumnBYq/98xogwPOXXK8KwCRe
 j/Og6LLNxn4A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 09:40:29 -0700
IronPort-SDR: RvtqLlC+SPSst880mSvesTs0je541inKc3w5VF7v7avh8diVfRiHu11gpSKeoqjZ88XibKYtfi
 ZTBCyarl8PWg==
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; 
   d="scan'208";a="430386003"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.72.195]) ([10.254.72.195])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 09:40:29 -0700
Subject: Re: [PATCH 0/2] x86/resctrl: Support wider MBM counters
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1585763047.git.reinette.chatre@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <f1820861-9ecb-d685-be3d-accd0047126d@intel.com>
Date:   Thu, 23 Apr 2020 09:40:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1585763047.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas and Borislav,

On 4/1/2020 10:51 AM, Reinette Chatre wrote:
> Memory Bandwidth Monitoring (MBM) is an Intel Resource Director
> Technology (RDT) feature that tracks Total and Local bandwidth
> generated which misses the L3 cache.
> 
> The original Memory Bandwidth Monitoring (MBM) architectural
> definition defines counters of up to 62 bits and the first-generation
> MBM implementation uses 24 bit counters. Software is required to poll
> at 1 second or faster to ensure that data is retrieved before a counter
> rollover occurs more than once under worst conditions.
> 
> As system bandwidths scale the software requirement is maintained with
> the introduction of a per-resource enumerable MBM counter width.
> 
> This series adds support for the new enumerable MBM counter width.
> 
> Details about the feature can be found in Chapter 9 of the most
> recent Intel ISE available from
> https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
> 
> Reinette Chatre (2):
>   x86/resctrl: Maintain MBM counter width per resource
>   x86/resctrl: Support CPUID enumeration of MBM counter width
> 
>  arch/x86/include/asm/processor.h          |  1 +
>  arch/x86/kernel/cpu/common.c              |  5 +++++
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  8 ++++---
>  arch/x86/kernel/cpu/resctrl/internal.h    | 15 ++++++++++---
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 27 ++++++++++++++++-------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
>  6 files changed, 43 insertions(+), 15 deletions(-)
> 


Would it be possible to consider this for inclusion in v5.8?

Thank you

Reinette

ps. Upon your consideration I am planning to follow up with same
the question for the next resctrl new feature series available
at:https://lore.kernel.org/lkml/cover.1586801373.git.reinette.chatre@intel.com/

You could view outstanding resctrl changes at branch resctrl/next of
https://github.com/rchatre/linux.git

