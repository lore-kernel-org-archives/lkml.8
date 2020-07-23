Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31831C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B292065F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgGWUbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:31:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:1976 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgGWUbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:31:44 -0400
IronPort-SDR: fkynWmZNEp//7MwVBzyV7aTOmdOT779T3Mby2PPTR49S7YSHuoeFpOta0d/vD0PNXsYpjRwnrR
 hfJW7TVfjWtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="138113972"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="138113972"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 13:31:43 -0700
IronPort-SDR: ubEHyUCahsy4WPPvEKm68KCeoCOAlhFA7Qc/wHtG7NpIqOSqkdUgTCeBaNWzL1NGTPAuUtzZEY
 rAYSbrUtAB1Q==
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="488958662"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.212.117.226]) ([10.212.117.226])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 13:31:42 -0700
Subject: Re: [PATCH v5 00/10] x86/resctrl: Misc cleanup
To:     James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>
References: <20200708163929.2783-1-james.morse@arm.com>
 <1887b64a-dd18-25ff-a9f4-885c231c60b2@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <dbe46982-29b6-cea8-af22-8c808ac4a8cb@intel.com>
Date:   Thu, 23 Jul 2020 13:31:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1887b64a-dd18-25ff-a9f4-885c231c60b2@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James, Borislav, and Thomas,

On 7/23/2020 11:31 AM, James Morse wrote:
> Hi Reinette,
> 
> On 08/07/2020 17:39, James Morse wrote:
>> These are the miscellaneous cleanup patches that floated to the top of
>> the MPAM tree.
> 
> Is there anything else I should do with this series?
> (Does patch 10 need an ACK from anyone else?)

James: From my perspective the series is ready for consideration by the
x86 maintainers and you already included the appropriate mailing list
and cc for this series to be queued for their consideration. My
"Reviewed-by" for patch 10 should have included a "#for resctrl". It
indeed needs more reviews for the cacheinfo.h changes but I expect that
to happen during review by x86 maintainers.

> 
> Would a branch or pull request make anyone's life easier?

Borislav and Thomas: Would this perhaps help you?

>> The only interesting thing are the patches to make the AMD/Intel
>> differences something resctrl understands, instead of just 'happening'
>> because of the different function pointers.
>> This will become more important once MPAM support is added. parse_bw()
>> and friends are what enforces resctrl's ABI. Allowing an
>> architecture/platform to provide a subtly different function here would
>> be bad for user-space.
>>
>> MPAM would set arch_has_sparse_bitmaps and arch_has_empty_bitmap, but
>> not arch_needs_linear.
> 
>> Nothing in this series should change any behaviour.

Thank you very much

Reinette
