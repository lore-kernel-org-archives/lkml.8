Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918B1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B4F2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgHQNSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:18:40 -0400
Received: from foss.arm.com ([217.140.110.172]:54956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728395AbgHQNSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:18:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CF5130E;
        Mon, 17 Aug 2020 06:18:10 -0700 (PDT)
Received: from [10.37.12.68] (unknown [10.37.12.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEBAB3F66B;
        Mon, 17 Aug 2020 06:18:07 -0700 (PDT)
Subject: Re: include/linux/sched/topology.h:237:9: error: implicit declaration
 of function 'cpu_logical_map'
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, chenhc@lemote.com,
        jiaxun.yang@flygoat.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org
References: <202008170623.tYjq1wEa%lkp@intel.com>
 <1bc8f16a-004b-0352-6675-2c1edeeb9823@arm.com>
Message-ID: <84239ee9-3f87-b254-29ad-ec8cc12d0190@arm.com>
Date:   Mon, 17 Aug 2020 14:18:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1bc8f16a-004b-0352-6675-2c1edeeb9823@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Adding on CC MIPS list and maintainers.

On 8/17/20 10:03 AM, Lukasz Luba wrote:
> 
> 
> On 8/16/20 11:43 PM, kernel test robot wrote:
>> Hi Lukasz,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
>> commit: 1bc138c622959979eb547be2d3bbc6442a5c80b0 PM / EM: add support 
>> for other devices than CPUs in Energy Model
>> date:   8 weeks ago
>> config: mips-randconfig-r001-20200817 (attached as .config)
>> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 
>> ab9fc8bae805c785066779e76e7846aabad5609e)
>> reproduce (this is a W=1 build):
>>          wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install mips cross compiling tool for clang build
>>          # apt-get install binutils-mips-linux-gnu
>>          git checkout 1bc138c622959979eb547be2d3bbc6442a5c80b0
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross 
>> ARCH=mips
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     arch/mips/include/asm/sync.h:147:34: note: expanded from macro 
>> '__SYNC_loongson3_war'
>>     # define __SYNC_loongson3_war   (1 << 31)
>>                                        ^
>>     In file included from arch/mips/kernel/asm-offsets.c:12:
>>     In file included from include/linux/compat.h:10:
>>     In file included from include/linux/time.h:74:
>>     In file included from include/linux/time32.h:13:
>>     In file included from include/linux/timex.h:65:
>>     In file included from arch/mips/include/asm/timex.h:19:
>>     In file included from arch/mips/include/asm/cpu-type.h:12:
>>     In file included from include/linux/smp.h:15:
>>     include/linux/llist.h:222:9: warning: converting the result of 
>> '<<' to a boolean always evaluates to true 
>> [-Wtautological-constant-compare]
>>             return xchg(&head->first, NULL);
>>                    ^
>>     arch/mips/include/asm/cmpxchg.h:102:7: note: expanded from macro 
>> 'xchg'
>>             if 
>> (!__SYNC_loongson3_war)                                      \
>>                  ^
>>     arch/mips/include/asm/sync.h:147:34: note: expanded from macro 
>> '__SYNC_loongson3_war'
>>     # define __SYNC_loongson3_war   (1 << 31)
>>                                        ^
>>     In file included from arch/mips/kernel/asm-offsets.c:12:
>>     In file included from include/linux/compat.h:15:
>>     In file included from include/linux/socket.h:8:
>>     In file included from include/linux/uio.h:10:
>>     In file included from include/crypto/hash.h:11:
>>     In file included from include/linux/crypto.h:19:
>>     In file included from include/linux/slab.h:15:
>>     In file included from include/linux/gfp.h:9:
>>     include/linux/topology.h:119:9: error: implicit declaration of 
>> function 'cpu_logical_map' [-Werror,-Wimplicit-function-declaration]
>>             return cpu_to_node(raw_smp_processor_id());
>>                    ^
>>     arch/mips/include/asm/mach-loongson64/topology.h:7:27: note: 
>> expanded from macro 'cpu_to_node'
>>     #define cpu_to_node(cpu)        (cpu_logical_map(cpu) >> 2)
> 
> 
> It looks like the energy_model.h causes this include on mips then some
> header is missing (probably smp.h from mips/asm).
> I will try to reproduce it and propose a fix.

I was wrong, the energy_model.h does not cause this issue. The issue is
already present in v5.8-rc2 (where there is no this EM commit).

I have reproduced in v5.8-rc2 with the .config from original email.
When I've fix this error:
"error: implicit declaration of function 'cpu_logical_map'"
new one showed up:
./include/linux/topology.h:210:9: error: use of undeclared identifier 
'__node_cpumask'
         return cpumask_of_node(cpu_to_node(cpu));

                ^
another showed up:
./arch/mips/include/asm/mach-loongson64/topology.h:12:33: note: expanded 
from macro 'cpumask_of_node'
#define cpumask_of_node(node)   (&__node_cpumask[node])

Then after a fix, the next one:
In file included from ./include/net/checksum.h:22:
./arch/mips/include/asm/checksum.h:195:9: error: unsupported inline asm: 
input with type 'unsigned long' matching output with type '__wsum' (aka 
'unsigned int')
         : "0" ((__force unsigned long)daddr),


Thomas, Jiaxun, Huacai are you aware of these issues? Maybe just this
randconfig triggers some awkward configuration?

Regards,
Lukasz

