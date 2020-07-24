Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F57C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 02:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C9CF20714
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 02:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgGXCpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 22:45:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:38883 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbgGXCpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 22:45:06 -0400
IronPort-SDR: Guh+m5ut9YPsv6xJ9kqYjhFCHkibjsJrcI37GQc54pzwwhPuhcdOQ9NMm7cR2OfcU7bLRpqh8R
 axFWHbK4Eraw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="212186158"
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="212186158"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 19:45:05 -0700
IronPort-SDR: iBx90Pr7CFLoBrXMYma7ZeELqZZhGNtzLh3cmTkYLqziolVzBvsjenanNTiDKag9mwB731SVIm
 cb/2DPDyllxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="319181835"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga008.jf.intel.com with ESMTP; 23 Jul 2020 19:45:03 -0700
Subject: Re: [fsnotify] c738fbabb0: will-it-scale.per_process_ops -9.5%
 regression
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org
References: <20200721001505.GD19262@shao2-debian>
 <CAOQ4uxgq39EDS_k3eDTngEAm8cxHPa7qrkUSW8Rk6qS9cxC18w@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <9a2a4086-fbad-b4f8-9c00-2b7606441022@intel.com>
Date:   Fri, 24 Jul 2020 10:44:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxgq39EDS_k3eDTngEAm8cxHPa7qrkUSW8Rk6qS9cxC18w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/20 11:59 PM, Amir Goldstein wrote:
> On Tue, Jul 21, 2020 at 3:15 AM kernel test robot <rong.a.chen@intel.com> wrote:
>> Greeting,
>>
>> FYI, we noticed a -9.5% regression of will-it-scale.per_process_ops due to commit:
>>
>>
>> commit: c738fbabb0ff62d0f9a9572e56e65d05a1b34c6a ("fsnotify: fold fsnotify() call into fsnotify_parent()")
> Strange, that's a pretty dumb patch moving some inlined code from one
> function to
> another (assuming there are no fsnotify marks in this test).
>
> Unless I am missing something the only thing that changes slightly is
> an extra d_inode(file->f_path.dentry) deference.
> I can get rid of it.
>
> Is it possible to ask for a re-test with fix patch (attached)?

Hi Amir,

We failed to apply this patch, could you tell us the base commit or the 
base branch?

Best Regards,
Rong Chen
