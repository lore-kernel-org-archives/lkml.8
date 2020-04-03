Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D808C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B712082F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404334AbgDCPfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:35:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:61909 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404171AbgDCPfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:35:51 -0400
IronPort-SDR: 999bLMYgJypysDSYO6K+LdzvS27N2nR5fBb+2nZv71FqPv8R0XImzTqhWMNi09MHZmzIt0MSSS
 qc84Qcbj0hYA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 08:35:50 -0700
IronPort-SDR: /8Kx6Fr3AFBUEFndItwYFkDShMvhjJOcyYzK0tosICU3Z1Mr3oLvqfzhg0ol3bpphYKwxrJrQj
 K05dBsTZ94nA==
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; 
   d="scan'208";a="329197211"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.28.58]) ([10.251.28.58])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 08:35:50 -0700
Subject: Re: [PATCH 2/2] x86/resctrl: Use appropriate API for strings
 terminated by newline
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, kuo-lang.tseng@intel.com,
        Ingo Molnar <mingo@redhat.com>, babu.moger@amd.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1585765499.git.reinette.chatre@intel.com>
 <2a51c327497738ad7012e4f185046c530dba4594.1585765499.git.reinette.chatre@intel.com>
 <20200402130625.GA1922688@smile.fi.intel.com>
 <720ab442-3e2e-bd6d-d35c-5cc5de1d9824@intel.com>
 <CAHp75VdoVxDaBYtiH8D_0DLKcwP7AAS2M7XoyrDj7LAv8cOoDA@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <13499ebf-dd5f-1940-3d01-366f038d5a66@intel.com>
Date:   Fri, 3 Apr 2020 08:35:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdoVxDaBYtiH8D_0DLKcwP7AAS2M7XoyrDj7LAv8cOoDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 4/3/2020 12:27 AM, Andy Shevchenko wrote:
> On Fri, Apr 3, 2020 at 12:54 AM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 4/2/2020 6:06 AM, Andy Shevchenko wrote:
>>> On Wed, Apr 01, 2020 at 11:30:48AM -0700, Reinette Chatre wrote:

...

>>>>      /* Valid input requires a trailing newline */
>>>>      if (nbytes == 0 || buf[nbytes - 1] != '\n')
>>>>              return -EINVAL;
>>>> -    buf[nbytes - 1] = '\0';
>>>
>>> The above test is not needed and comment now is misleading.
>>> WRT nbytes I believe that kernel fs code checks for that.
> 
> This module provides it's own kernfs_ops...
> 
>> If nbytes is 0 it is still passed to this function. You are correct that
>> those tests are not needed though (if nbytes is 0 then
>> sysfs_match_string() will not find a match and return EINVAL via that path).
>>
>> Thank you for catching this. I'll remove those unnecessary checks.
> 
> ...which means that nbytes == 0 is a valid check. Please keep it
> there. It will protect from unnecessary locking and loading CPU for
> nothing.
> 

Will do. Thank you.

Reinette
