Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD19CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 00:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7312206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 00:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgFEAPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 20:15:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:64305 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgFEAPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 20:15:47 -0400
IronPort-SDR: ezMOngJyfryD0Q40WG7mRJKECQlrFvad0iJcpN8xBZTVpGoGx/V+oWLwYXmyvincXwlkGQohK2
 q2+BdRbfQUiA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 17:15:46 -0700
IronPort-SDR: 5N6C2ToGgttdbw3hpTCJTivhdhcLus3ANU9los7TrjJlJLkEZt5HIQ72fBdijiCbHUnHuVKT2u
 CVLic+ig+kFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,474,1583222400"; 
   d="scan'208";a="269588272"
Received: from zyu4-mobl2.ccr.corp.intel.com (HELO [10.255.30.96]) ([10.255.30.96])
  by orsmga003.jf.intel.com with ESMTP; 04 Jun 2020 17:15:44 -0700
Subject: Re: [LKP] Re: [netfilter] e32a4dc651:
 BUG:using_smp_processor_id()in_preemptible
To:     Stefano Brivio <sbrivio@redhat.com>,
        kernel test robot <lkp@intel.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200603084934.GF12456@shao2-debian>
 <20200605002323.501b1cc6@redhat.com>
From:   Liu Yiding <yidingx.liu@intel.com>
Message-ID: <7dd4f0d2-34a7-8086-99cb-424ff2e039ca@intel.com>
Date:   Fri, 5 Jun 2020 08:15:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20200605002323.501b1cc6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/5/20 6:23 AM, Stefano Brivio wrote:
> Hi,
>
> On Wed, 3 Jun 2020 16:49:34 +0800
> kernel test robot <lkp@intel.com> wrote:
>
>> Greeting,
>>
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: e32a4dc6512ce3c1a1920531246e7037896e510a ("netfilter: nf_tables: make sets built-in")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> in testcase: kernel-selftests
>> with following parameters:
>>
>> 	group: kselftests-netfilter
> I couldn't find this information in the report. Would it be possible to
> have here an indication of what kselftest specifically is failing?
> There are a number of tests in that group. I have an obvious suspicion
> here (nft_concat_range.sh), but it would be nice to know, in general.


Yes, it's nft_concat_range.sh caused this error.

```

[  165.249447] # selftests: netfilter: nft_concat_range.sh
[  165.249453]
[  165.295336] # TEST: reported issues
[  165.295342]
[  165.316525] BUG: using smp_processor_id() in preemptible [00000000] 
code: nft/6247
[  165.319547] caller is nft_pipapo_insert+0x464/0x610 [nf_tables]
[  165.321846] CPU: 1 PID: 6247 Comm: nft Not tainted 
5.6.0-rc5-01595-ge32a4dc6512ce3 #1

```


And i think this error is caused by some kconfigs.

This test was passed until we enabled all kconfigs defined in 
netfilter/config. :-(


>
>> [...]
>>
>> [  165.316525] BUG: using smp_processor_id() in preemptible [00000000] code: nft/6247
>> [  165.319547] caller is nft_pipapo_insert+0x464/0x610 [nf_tables]
> I'll take care of this, thanks Florian for forwarding.
>
-- 
Best regards.
Liu Yiding

