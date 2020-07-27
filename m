Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EADC433F7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 02:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DAEC2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 02:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgG0CHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 22:07:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:13311 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgG0CHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 22:07:41 -0400
IronPort-SDR: rW708y1MZFBcw0hztjkyt0Zbu4SiDcdmhw4mlcABbiabSIpMgZuCsONNCGXczudJHkIOBq6f9l
 tA8ldyT3adCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="130491847"
X-IronPort-AV: E=Sophos;i="5.75,400,1589266800"; 
   d="scan'208";a="130491847"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 19:07:41 -0700
IronPort-SDR: TtGtgOgwmpxakpzrZxKBcbKzj4fmqoZX35n5z+t1z5fEo+iAlzaHPsu2bta6oHIw3pqDK2JuO6
 LB+tUzoEEnIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,400,1589266800"; 
   d="scan'208";a="489350796"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.4.18]) ([10.238.4.18])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jul 2020 19:07:39 -0700
Subject: Re: [LKP] Re: [fsnotify] c738fbabb0: will-it-scale.per_process_ops
 -9.5% regression
To:     Rong Chen <rong.a.chen@intel.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org
References: <20200721001505.GD19262@shao2-debian>
 <CAOQ4uxgq39EDS_k3eDTngEAm8cxHPa7qrkUSW8Rk6qS9cxC18w@mail.gmail.com>
 <9a2a4086-fbad-b4f8-9c00-2b7606441022@intel.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <e54b662d-4a21-7b80-31ea-530cd2d40160@linux.intel.com>
Date:   Mon, 27 Jul 2020 10:07:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9a2a4086-fbad-b4f8-9c00-2b7606441022@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2020 10:44 AM, Rong Chen wrote:
> 
> 
> On 7/21/20 11:59 PM, Amir Goldstein wrote:
>> On Tue, Jul 21, 2020 at 3:15 AM kernel test robot 
>> <rong.a.chen@intel.com> wrote:
>>> Greeting,
>>>
>>> FYI, we noticed a -9.5% regression of will-it-scale.per_process_ops 
>>> due to commit:
>>>
>>>
>>> commit: c738fbabb0ff62d0f9a9572e56e65d05a1b34c6a ("fsnotify: fold 
>>> fsnotify() call into fsnotify_parent()")
>> Strange, that's a pretty dumb patch moving some inlined code from one
>> function to
>> another (assuming there are no fsnotify marks in this test).
>>
>> Unless I am missing something the only thing that changes slightly is
>> an extra d_inode(file->f_path.dentry) deference.
>> I can get rid of it.
>>
>> Is it possible to ask for a re-test with fix patch (attached)?
> 

I apply the fix patch, the regression still exists.
=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_task/mode/test/cpufreq_governor/ucode:
 
lkp-csl-2ap2/will-it-scale/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/16/process/open1/performance/0x5002f01

commit:
   71d734103edfa2b4c6657578a3082ee0e51d767e
   c738fbabb0ff62d0f9a9572e56e65d05a1b34c6a
   5c32fe90f2a57e7c4da06be51f705aec6affceb6 (the commit which the fix 
patch apply based on)
   7f66797f773621d0ef6718df0ef2cf849814d114 (the fix patch)

71d734103edfa2b4 c738fbabb0ff62d0f9a9572e56e 5c32fe90f2a57e7c4da06be51f7 
7f66797f773621d0ef6718df0ef
---------------- --------------------------- --------------------------- 
---------------------------
          %stddev     %change         %stddev     %change 
%stddev     %change         %stddev
              \          |                \          |                \ 
         |                \
     229940            -9.8%     207333           -13.0%     199996 
      -11.7%     202927        will-it-scale.per_process_ops
    3679048            -9.8%    3317347           -13.0%    3199942 
      -11.7%    3246851        will-it-scale.workload



> Hi Amir,
> 
> We failed to apply this patch, could you tell us the base commit or the 
> base branch?
> 
> Best Regards,
> Rong Chen
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org

-- 
Zhengjun Xing
