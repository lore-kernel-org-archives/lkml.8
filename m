Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023D3C0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C70420753
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbgCLCDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 22:03:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:44742 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387501AbgCLCDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 22:03:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 19:03:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,543,1574150400"; 
   d="scan'208";a="236488961"
Received: from lshi-mobl1.ccr.corp.intel.com (HELO [10.255.29.252]) ([10.255.29.252])
  by fmsmga008.fm.intel.com with ESMTP; 11 Mar 2020 19:03:29 -0700
Subject: Re: [kbuild-all] Re: [PATCH 3/3] proc: Remove the now unnecessary
 internal mount of proc
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <87r1yeqxbp.fsf_-_@x220.int.ebiederm.org>
 <202002291137.px8YXKJI%lkp@intel.com> <8736auov5g.fsf@x220.int.ebiederm.org>
From:   Li Zhijian <zhijianx.li@intel.com>
Message-ID: <1a9e79f4-9dd1-19f1-2361-150a4417aa7a@intel.com>
Date:   Thu, 12 Mar 2020 10:03:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <8736auov5g.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/29/20 12:49 PM, Eric W. Biederman wrote:
> kbuild test robot <lkp@intel.com> writes:
>
>> Hi "Eric,
>>
>> Thank you for the patch! Yet something to improve:
> Dear kbuild robot,
>
> Yep. You got it the wrong base.  I will see about using --base
> if I repost, or have another patchset that so clearly needs
> to be applied on top of a non-default base.
>
> Thank you for writing me how to do that.

Hi, Eric

May i know which tree/branch your patch is basing on ?  this input might 
help 0day robot to pickup the candidate bases more intelligent.


Thanks
Zhijian

>
> Eric
>
>
>> [auto build test ERROR on uml/linux-next]
>> [also build test ERROR on linux/master kees/for-next/pstore linus/master v5.6-rc3 next-20200228]
>> [if your patch is applied to the wrong git tree, please drop us a note to help
>> improve the system. BTW, we also suggest to use '--base' option to specify the
>> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>>
>> url:    https://github.com/0day-ci/linux/commits/Eric-W-Biederman/proc-Actually-honor-the-mount-options/20200229-100926
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git linux-next
>> config: x86_64-defconfig (attached as .config)
>> compiler: gcc-7 (Debian 7.5.0-5) 7.5.0
>> reproduce:
>>          # save the attached .config to linux build tree
>>          make ARCH=x86_64
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     fs/proc/base.c: In function 'proc_flush_task':
>>>> fs/proc/base.c:3217:33: error: 'struct pid_namespace' has no member named 'proc_mnt'; did you mean 'proc_self'?
>>        proc_flush_task_mnt(upid->ns->proc_mnt, upid->nr,
>>                                      ^~~~~~~~
>>                                      proc_self
>>
>> vim +3217 fs/proc/base.c
>>
>> ^1da177e4c3f41 Linus Torvalds    2005-04-16  3180
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3181  /**
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3182   * proc_flush_task -  Remove dcache entries for @task from the /proc dcache.
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3183   * @task: task that should be flushed.
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3184   *
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3185   * When flushing dentries from proc, one needs to flush them from global
>> 60347f6716aa49 Pavel Emelyanov   2007-10-18  3186   * proc (proc_mnt) and from all the namespaces' procs this task was seen
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3187   * in. This call is supposed to do all of this job.
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3188   *
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3189   * Looks in the dcache for
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3190   * /proc/@pid
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3191   * /proc/@tgid/task/@pid
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3192   * if either directory is present flushes it and all of it'ts children
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3193   * from the dcache.
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3194   *
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3195   * It is safe and reasonable to cache /proc entries for a task until
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3196   * that task exits.  After that they just clog up the dcache with
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3197   * useless entries, possibly causing useful dcache entries to be
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3198   * flushed instead.  This routine is proved to flush those useless
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3199   * dcache entries at process exit time.
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3200   *
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3201   * NOTE: This routine is just an optimization so it does not guarantee
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3202   *       that no dcache entries will exist at process exit time it
>> 0895e91d60ef9b Randy Dunlap      2007-10-21  3203   *       just makes it very unlikely that any will persist.
>> 60347f6716aa49 Pavel Emelyanov   2007-10-18  3204   */
>> 60347f6716aa49 Pavel Emelyanov   2007-10-18  3205
>> 60347f6716aa49 Pavel Emelyanov   2007-10-18  3206  void proc_flush_task(struct task_struct *task)
>> 60347f6716aa49 Pavel Emelyanov   2007-10-18  3207  {
>> 9fcc2d15b14894 Eric W. Biederman 2007-11-14  3208  	int i;
>> 9b4d1cbef8f41a Oleg Nesterov     2009-09-22  3209  	struct pid *pid, *tgid;
>> 130f77ecb2e7d5 Pavel Emelyanov   2007-10-18  3210  	struct upid *upid;
>> 130f77ecb2e7d5 Pavel Emelyanov   2007-10-18  3211
>> 130f77ecb2e7d5 Pavel Emelyanov   2007-10-18  3212  	pid = task_pid(task);
>> 130f77ecb2e7d5 Pavel Emelyanov   2007-10-18  3213  	tgid = task_tgid(task);
>> 9fcc2d15b14894 Eric W. Biederman 2007-11-14  3214
>> 9fcc2d15b14894 Eric W. Biederman 2007-11-14  3215  	for (i = 0; i <= pid->level; i++) {
>> 130f77ecb2e7d5 Pavel Emelyanov   2007-10-18  3216  		upid = &pid->numbers[i];
>> 130f77ecb2e7d5 Pavel Emelyanov   2007-10-18 @3217  		proc_flush_task_mnt(upid->ns->proc_mnt, upid->nr,
>> 9b4d1cbef8f41a Oleg Nesterov     2009-09-22  3218  					tgid->numbers[i].nr);
>> 130f77ecb2e7d5 Pavel Emelyanov   2007-10-18  3219  	}
>> 60347f6716aa49 Pavel Emelyanov   2007-10-18  3220  }
>> 60347f6716aa49 Pavel Emelyanov   2007-10-18  3221
>>
>> :::::: The code at line 3217 was first introduced by commit
>> :::::: 130f77ecb2e7d5ac3e53e620f55e374f4a406b20 pid namespaces: make proc_flush_task() actually from entries from multiple namespaces
>>
>> :::::: TO: Pavel Emelyanov <xemul@openvz.org>
>> :::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

