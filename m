Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13F4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BC1B20674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgESRy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 13:54:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:45549 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgESRy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 13:54:56 -0400
IronPort-SDR: Q43gCF6nAzm+KczJ8J8u3FB2Z1E14Btw9dTRv3+LSIsfrF0Ppw4XdNGCyHP2vyKmW2Xywhe0uX
 SzHX4OB1djvA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 10:54:54 -0700
IronPort-SDR: hpPnUjjcjcPumfqHPKVthzvzlEuENKNnPVgsTW0wCgzE3FsftI1zpMToUV9TUSRC9AinDR/6dS
 tFZ1ILxHWeow==
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="scan'208";a="439705633"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.255.229.46]) ([10.255.229.46])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 10:54:53 -0700
Subject: Re: [PATCH V5 4/4] x86/resctrl: Use appropriate API for strings
 terminated by newline
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, kuo-lang.tseng@intel.com,
        ravi.v.shankar@intel.com, Ingo Molnar <mingo@redhat.com>,
        Babu Moger <babu.moger@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1589844108.git.reinette.chatre@intel.com>
 <a953992d99a1930703cba1362a3005d517c4cb33.1589844108.git.reinette.chatre@intel.com>
 <CAHp75Vc_VA-2UNJh7epe+oQEiU3WBedomLbAVTD_L4_ocvt8Dw@mail.gmail.com>
 <4a9603b8-32fb-024a-e2f5-14e95b4e3763@intel.com>
 <20200519160710.GK1634618@smile.fi.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <87d00e95-7944-2fa4-fd02-1662ec4382fe@intel.com>
Date:   Tue, 19 May 2020 10:54:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519160710.GK1634618@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 5/19/2020 9:07 AM, Andy Shevchenko wrote:
> On Tue, May 19, 2020 at 08:50:22AM -0700, Reinette Chatre wrote:
>> On 5/19/2020 1:28 AM, Andy Shevchenko wrote:
>>> On Tue, May 19, 2020 at 2:50 AM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
> 
> ...
> 
>>>> +       ret = sysfs_match_string(rdt_mode_str, buf);
>>>> +       if (ret < 0) {
>>>> +               rdt_last_cmd_puts("Unknown or unsupported mode\n");
>>>> +               ret = -EINVAL;
>>>> +               goto out;
>>>> +       }
>>
>> From your previous email ...
>>
>>>> +       ret = sysfs_match_string(rdt_mode_str, buf);
>>>> +       if (ret < 0) {
>>>> +               rdt_last_cmd_puts("Unknown or unsupported mode\n");
>>>
>>>> +               ret = -EINVAL;
>>>
>>> This is redundant.
>>
>> I understand that shadowing an error code is generally of concern. In
>> this case the error code is set to -EINVAL to ensure that it is the same
>> error code that was returned to user space originally and will continue
>> to be so no matter what changes may come to sysfs_match_string().
> 
> It returns -EINVAL and if that will be ever changed this driver would be one of
> hundreds who suffers.

Not if we keep this change ... but that is no longer of concern with the
removal of the check as you propose later.

> 
> ...
> 
>>> Can't we unify latter with a former like ...
> 
>> This would have been ideal if done from the start but currently "0" is
>> returned if the current mode is pseudo-locked and user attempts to
>> change the mode to pseudo-locked. Thus, to maintain the current user
>> interface the check if user wants to set pseudo-locked mode is moved
>> after the check if new mode is same as existing mode and thus not
>> unified because that will result in an error returned always when user
>> requests pseudo-locked mode.
> 
> Ah, I see now.
> 
> But we can then drop the check from sysfs_match_string() returned value, like
> 
> 	user_m = sysfs_match_string();
> 	if (...) {
> 		...
> 	} else { // w/o even checking for the PSEUDO_LOCKED
> 		...
> 		goto out;
> 	}
> 
> Can we?
> 

Yes, we can. Will do.

Reinette
