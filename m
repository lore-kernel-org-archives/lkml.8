Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48436C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290DD2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406852AbgAPS1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:27:10 -0500
Received: from foss.arm.com ([217.140.110.172]:58314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436715AbgAPS1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:27:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B4AC139F;
        Thu, 16 Jan 2020 10:27:04 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C99B23F534;
        Thu, 16 Jan 2020 10:27:03 -0800 (PST)
Subject: Re: [regression] cpuset: offlined CPUs removed from affinity masks
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Li Zefan <lizefan@huawei.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <1251528473.590671.1579196495905.JavaMail.zimbra@efficios.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <3010d5a9-cce9-bc79-22c0-365d88f1135c@arm.com>
Date:   Thu, 16 Jan 2020 18:27:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1251528473.590671.1579196495905.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2020 17:41, Mathieu Desnoyers wrote:
> Hi,
> 
> I noticed the following regression with CONFIG_CPUSET=y. Note that
> I am not using cpusets at all (only using the root cpuset I'm given
> at boot), it's just configured in. I am currently working on a 5.2.5
> kernel. I am simply combining use of taskset(1) (setting the affinity
> mask of a process) and cpu hotplug. The result is that with
> CONFIG_CPUSET=y, setting the affinity mask including an offline CPU number
> don't keep that CPU in the affinity mask, and it is never put back when the
> CPU comes back online. CONFIG_CPUSET=n behaves as expected, and puts back
> the CPU into the affinity mask reported to user-space when it comes back
> online.
> 
> 
> * With CONFIG_CPUSET=y (unexpected behavior):
> 
> # echo 0 > /sys/devices/system/cpu/cpu1/online
> 
> % taskset 0x7 ./loop &
> % taskset -p $!
> pid 1341's current affinity mask: 5
> 
> # echo 1 > /sys/devices/system/cpu/cpu1/online
> 
> taskset -p $!
> pid 1341's current affinity mask: 5
> 
> kill $!
> 

As discussed on IRC, this is because we have in sched_setaffinity():

  cpuset_cpus_allowed(p, cpus_allowed);
  cpumask_and(new_mask, in_mask, cpus_allowed);

Another source of issue is that CPUs are taken out of cpusets when
hotplugged out, and not put back in when hotplugged back in (except for the
root cpuset which follows cpu_active_mask).

Both cpuset.effective_cpus and cpuset.allowed_cpus seem to only span
online CPUs:

  root@valsch-juno:~# cat /sys/fs/cgroup/cpuset/cpuset.effective_cpus 
  0-5
  root@valsch-juno:~# cat /sys/fs/cgroup/cpuset/cpuset.cpus
  0-5
  root@valsch-juno:~# echo 0 > /sys/devices/system/cpu/cpu3/online                                     
  [93418.733050] CPU3: shutdown
  [93418.735815] psci: CPU3 killed (polled 0 ms)
  root@valsch-juno:~# cat /sys/fs/cgroup/cpuset/cpuset.cpus                                            
  0-2,4-5
  root@valsch-juno:~# cat /sys/fs/cgroup/cpuset/cpuset.effective_cpus                                  
  0-2,4-5

The thing is, with CONFIG_CPUSET=n, we can absolutely cope with p->cpus_ptr
spanning CPUs that are offline because we still check the active/online
mask (is_cpu_allowed()). So one thing I'd like to know is why do cpusets
remove offline cpus from their mask? I could see cpuset.allowed containing
both online & offline CPUs, and cpuset.effective containing just the online
ones.

That way in sched_setaffinity() we can still check for cpuset.allowed, and
we still have the online/active check in __set_cpus_allowed_ptr() to deny
stupid requests.
