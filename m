Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD041C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E33207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgETUYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 16:24:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:13641 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbgETUYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:24:42 -0400
IronPort-SDR: afjfcTGcUMaZ/GXfs8xFl0OeHgtlhx2FY8DNf+Qv2I3bfdYrWdBqyBujYqNRHZUa3t5GTk4wqg
 mDprX2MvJkQQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 13:24:41 -0700
IronPort-SDR: 5Pcl5kLFOaYs3NYO7bCucja3dcJ0D3dSdiHsXs6UuzLGjqN8YyM5G0PyPqKLqbM/+2sfaAQpMP
 NQGrvwULfIIQ==
X-IronPort-AV: E=Sophos;i="5.73,415,1583222400"; 
   d="scan'208";a="268388157"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.101.53]) ([10.254.101.53])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 13:24:41 -0700
Subject: Re: [PATCH V6 0/4] x86/resctrl: Enable user to view and select thread
 throttling mode
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, ravi.v.shankar@intel.com,
        mingo@redhat.com, babu.moger@amd.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1589922949.git.reinette.chatre@intel.com>
 <20200519213516.GF444@zn.tnic>
 <1d9ee0f0-8078-e8b6-ce66-6c0bf51cb3b4@intel.com>
 <20200520071109.GA1457@zn.tnic>
 <5c044d17-e42e-1493-28a5-3ecac043c8f1@intel.com>
 <20200520183508.GI1457@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <0e2b37d4-1b43-c666-b8b1-4caeceaf48e0@intel.com>
Date:   Wed, 20 May 2020 13:24:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520183508.GI1457@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 5/20/2020 11:35 AM, Borislav Petkov wrote:
> On Wed, May 20, 2020 at 10:32:02AM -0700, Reinette Chatre wrote:
> 
>> It seems inappropriate that I have the title of maintainer and not be
>> able to have patches considered for inclusion during an entire release
>> cycle.
> 
> Well, we try very hard to be fair when looking at patchsets. In your
> case, I already took a patchset from you this cycle and there are other
> patchsets waiting for a lot longer than yours - even patchsets from your
> colleagues at Intel.
> 
> So I understand that you think it might be inappropriate but please try
> to understand it also from our standpoint in that we try to round-robin
> between everyone as fair as possible.

I understand now. Thank you very much.

> 
> So I will try to look at yours in the next days but I cannot promise you
> anything.

Please don't. That would be unfair to everybody waiting longer then me
as well set a bad precedent.

Reinette

