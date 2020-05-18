Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EBBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D6F920674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgERQGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:06:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:45856 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbgERQGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:06:04 -0400
IronPort-SDR: Qmbtw2F8zNZipQY9deifv2fvr/GHaJHWjEfubbHmsOqKnt2S46OAlbwDadhju4oFzabZfRfrcF
 qcIobJ6jClXg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 09:06:03 -0700
IronPort-SDR: w50aPhiGKgfyEp2ixKa+Ql5GA/p/3PIzAErG1Sfc3HLpOw1HrIe3LRA73fAIsyhI68Ja/TYrXO
 hjR03SIr9B0A==
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="465630075"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.66.2]) ([10.254.66.2])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 09:06:02 -0700
Subject: Re: [PATCH V4 4/4] x86/resctrl: Use appropriate API for strings
 terminated by newline
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com, kuo-lang.tseng@intel.com,
        ravi.v.shankar@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1589652468.git.reinette.chatre@intel.com>
 <0c04b58148f181ba182b9a487465e4853e4eadbb.1589652468.git.reinette.chatre@intel.com>
 <20200518115026.GA1634618@smile.fi.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <060e3cf6-8fcb-6b43-01ef-63ef0a5ff64a@intel.com>
Date:   Mon, 18 May 2020 09:06:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518115026.GA1634618@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 5/18/2020 4:50 AM, Andy Shevchenko wrote:
> On Sat, May 16, 2020 at 11:28:41AM -0700, Reinette Chatre wrote:
>> The user input to files in the resctrl filesystem are expected to be
>> terminated with a newline. Testing the user input includes a test for
>> the presence of a newline and then replacing the newline with NUL
>> byte followed by comparison using strcmp().
>>
>> sysfs_streq() exists to test if strings are equal, treating both NUL and
>> newline-then-NUL as equivalent string terminations. Even more,
>> sysfs_match_string() exists to match a given string in an array using
>> sysfs_streq().
>>
>> Replace existing strcmp() comparisons of strings that are terminated
>> with a newline with more appropriate sysfs_streq() via the
>> sysfs_match_string() API that can perform the match across the different
>> mode strings that are already maintained in an array.
> 
> Sorry for late comment, but just have noticed...

No problem. I do appreciate your feedback because it helps me to improve
the code.

> 
>>  	if (mode == RDT_MODE_PSEUDO_LOCKED) {
>> @@ -1445,14 +1450,14 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
>>  		goto out;
>>  	}
>>  
>> -	if (!strcmp(buf, "shareable")) {
>> +	if (user_m == RDT_MODE_SHAREABLE) {
>>  		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
>>  			ret = rdtgroup_locksetup_exit(rdtgrp);
>>  			if (ret)
>>  				goto out;
>>  		}
> 
>>  		rdtgrp->mode = RDT_MODE_SHAREABLE;
> 
> ...can we simple move this and similar (in other branches) to...
> 
> 
>> -	} else {
>> -		rdt_last_cmd_puts("Unknown or unsupported mode\n");
>> -		ret = -EINVAL;
>>  	}
> 
> ...here as
> 
> 		rdtgrp->mode = user_m;

Will do.

It also looks like the only reason for the "mode" local variable was to
make those earlier "strcmp" lines shorter. With those long lines removed
in this patch this local variable is no longer needed and I will remove
it also.

Reinette

