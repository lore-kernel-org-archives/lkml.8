Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD211C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD6592076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgDQO5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:57:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:20424 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgDQO5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:57:51 -0400
IronPort-SDR: 114KHlgUnNvnaR9xQwM/Qp1w1gxM3/Dah0YdRXRem6L6alNVrhEUuoCTAeWNMsIh1tnO4+yeXA
 Bc8zf3FeHGRQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 07:57:50 -0700
IronPort-SDR: z5eMw9P+NeZr6KBO3Z9aNE7tBa6UpZMRvO9tAqYaMtvxlqRwtoOVCUdKA9lKsxv8haQGab/nnS
 o0rKVzn+a16g==
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="428250666"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.16.52]) ([10.251.16.52])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 07:57:50 -0700
Subject: Re: [PATCH v3] x86/resctrl: Preserve CDP enable over cpuhp
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>
References: <20200221162105.154163-1-james.morse@arm.com>
 <8d84868f-4045-8d69-ed45-d0f0629ba25c@intel.com>
 <a411323a-2439-5d30-2106-2e3598e9a8c7@intel.com>
 <20200417141841.GD7322@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <e762a1c9-b13a-cc8c-e945-292218af418b@intel.com>
Date:   Fri, 17 Apr 2020 07:57:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417141841.GD7322@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav and James,

On 4/17/2020 7:18 AM, Borislav Petkov wrote:
> On Wed, Apr 15, 2020 at 08:57:34AM -0700, Reinette Chatre wrote:
>> Hi Thomas and Borislav,
>>
>> Could you please consider this patch for inclusion as a fix for v5.7?
> 
> Do you mean by that that I should add
> 
> Cc: <stable@vger.kernel.org>
> 
> so that it goes to stable?
> 
> The commit in Fixes: is from 4.10-ish times...
> 

Borislav: Sorry about that and thank you very much for catching this
omission. Yes, this patch needs to go to stable.

James: would you be able to do the backports to stable? Please note that
support for L2 and L3 CDP was added across Linux versions and the
resctrl files moved around since then so the backport would need some
changes to address this issue in all versions.

Reinette
