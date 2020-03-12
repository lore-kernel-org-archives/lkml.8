Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A56C2BAEE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FDC206F7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387563AbgCLAvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 20:51:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:40281 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387516AbgCLAvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:51:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 17:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; 
   d="scan'208";a="236474982"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by fmsmga008.fm.intel.com with ESMTP; 11 Mar 2020 17:51:06 -0700
Subject: Re: [LKP] Re: [PATCH v3 1/2] modpost: rework and consolidate logging
 interface
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Philip Li <philip.li@intel.com>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Matthias Maennich <maennich@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@01.org
References: <20200306160206.5609-1-jeyu@kernel.org>
 <CAK7LNARZ4VgaCa_TiDBG-99amBGTTXTQMs9LsK3nO4k+y-5KDQ@mail.gmail.com>
 <20200309095914.GA18870@linux-8ccs.fritz.box>
 <CAK7LNARf9CzZ8dcK5O5vxUoncpDdpzSZctd0YuKeWyfDG_cdwA@mail.gmail.com>
 <20200309103935.GB18870@linux-8ccs.fritz.box>
 <CAK7LNARpJ-FAvCUEH9rrNCiqx5LwRHmWospvRnT-ERQoEGjK-Q@mail.gmail.com>
 <20200309105812.GC18870@linux-8ccs.fritz.box>
 <CAK7LNAQqMGSkX4Coe+f49SbXT_jkG_Mm4XZ3EJei0_K7SEaLhg@mail.gmail.com>
 <20200310113158.GA4865@linux-8ccs.fritz.box>
 <20200310155516.GC22995@intel.com>
 <CAK7LNAQM1WF1rk5H+26J87-jC4ghYvdEs1UQSNy+C87myS94DQ@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <6637fe72-b7e5-2259-5eeb-055cf50382b8@intel.com>
Date:   Thu, 12 Mar 2020 08:50:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQM1WF1rk5H+26J87-jC4ghYvdEs1UQSNy+C87myS94DQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/20 9:00 AM, Masahiro Yamada wrote:
> On Wed, Mar 11, 2020 at 12:56 AM Philip Li <philip.li@intel.com> wrote:
>> On Tue, Mar 10, 2020 at 12:32:00PM +0100, Jessica Yu wrote:
>>> +++ Masahiro Yamada [09/03/20 20:03 +0900]:
>>>> On Mon, Mar 9, 2020 at 7:58 PM Jessica Yu <jeyu@kernel.org> wrote:
>>>>> +++ Masahiro Yamada [09/03/20 19:49 +0900]:
>>>>>> On Mon, Mar 9, 2020 at 7:39 PM Jessica Yu <jeyu@kernel.org> wrote:
>>>>>>> Ah, sorry, I mean the kbuild 0-day bot errors. I am just realizing
>>>>>>> the 0-day bot emails are not CC'd to lkml. Here is the error I got
>>>>>>> from the bot:
>>>>>>>
>>>>>>> ---
>>>>>>>
>>>>>>> I love your patch! Yet something to improve:
>>>>>>>
>>>>>>> [auto build test ERROR on linus/master]
>>>>>>> [also build test ERROR on v5.6-rc4 next-20200306]
>>>>>>> [if your patch is applied to the wrong git tree, please drop us a note to help
>>>>>>> improve the system. BTW, we also suggest to use '--base' option to specify the
>>>>>>> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>>>>>>>
>>>>>>> url:    https://github.com/0day-ci/linux/commits/Jessica-Yu/modpost-rework-and-consolidate-logging-interface/20200307-052346
>>>>>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 30fe0d07fd7b27d41d9b31a224052cc4e910947a
>>>>>>> config: sh-randconfig-a001-20200306 (attached as .config)
>>>>>>> compiler: sh4-linux-gcc (GCC) 7.5.0
>>>>>>> reproduce:
>>>>>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>>>>          chmod +x ~/bin/make.cross
>>>>>>>          # save the attached .config to linux build tree
>>>>>>>          GCC_VERSION=7.5.0 make.cross ARCH=sh
>>>>>>>
>>>>>>> If you fix the issue, kindly add following tag
>>>>>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>>>>>
>>>>>>> All errors (new ones prefixed by >>):
>>>>>>>
>>>>>>>>> ERROR: modpost: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
>>>>>>
>>>>>> Indeed, this one is odd.
>>>>>> I have no idea...
>>>>> I've pushed the patches to a branch to let the kbuild bot run through its
>>>>> build tests again, and if I have extra time today I will try to
>>>>> reproduce this and let you know the results.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Jessica
>>>>
>>>> Ah, Now I see.
>>>>
>>>>
>>>> Because you added "modpost:" prefix.
>>>>
>>>>
>>>>
>>>> The previous error message:
>>>>
>>>> ERROR: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
>>>>
>>>>
>>>> The new error message:
>>>>
>>>> ERROR: modpost: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
>>>>
>>>>
>>>>
>>>> So, the bot assumed it was a new error.
>>> Nice catch! Hm, I suppose we need to let the LKP folks know about the
>>> change in error message. CC'd LKP mailing list.
>> Thanks for the info, we will look into this to handle the
>> changed error.
>>
>>> Jessica
>>> _______________________________________________
>>> LKP mailing list -- lkp@lists.01.org
>>> To unsubscribe send an email to lkp-leave@lists.01.org
>
>
> Could you improve the report by adding more context?
>
> Currently, only new errors/warnings are shown by '>>'.
>
>
> If fixed ones had been shown by '<<',
> we would have easily noticed that
> this was just a matter of message format.
>
> << ERROR: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
>>> ERROR: modpost: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!

Hi,

Thanks for your advice, we'll add it into our todo list.

Best Regards,
Rong Chen
