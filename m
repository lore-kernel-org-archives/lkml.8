Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9871C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 830BA2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgFQB4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 21:56:15 -0400
Received: from mail.loongson.cn ([114.242.206.163]:44120 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbgFQB4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 21:56:15 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_2oveOle+_dEAA--.7211S3;
        Wed, 17 Jun 2020 09:55:59 +0800 (CST)
Subject: Re: [PATCH v2] tools build: Check libasan and libubsan in
 Makefile.feature
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
References: <1591164604-20806-1-git-send-email-yangtiezhu@loongson.cn>
 <20200603113228.GV31795@kernel.org>
 <7bbd7c0c-7e09-7eaf-5a54-602e70e36112@loongson.cn>
 <20200616193941.GD6393@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <3a6d0dcb-9a72-12d5-29ac-5d3192b816a1@loongson.cn>
Date:   Wed, 17 Jun 2020 09:55:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20200616193941.GD6393@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dx_2oveOle+_dEAA--.7211S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKFW3tFy5Ww48KFW5ZF48Crg_yoW7Wr1Dpw
        1FkayDtayfKrW8Zw4vkF4Yqr4rtr4xtay0qa45t347Arn5Kw17Cr4ayFW5WF4xXw48JFW7
        Aw17Way3Gw4rAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE
        67vIY487MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUChFxUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/17/2020 03:39 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jun 15, 2020 at 10:20:10AM +0800, Tiezhu Yang escreveu:
>> On 06/03/2020 07:32 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Wed, Jun 03, 2020 at 02:10:04PM +0800, Tiezhu Yang escreveu:
>>>> When build perf with ASan or UBSan, if libasan or libubsan can not find,
>>>> the feature-glibc is 0 and there exists the following error log which is
>>>> wrong, because we can find gnu/libc-version.h in /usr/include, glibc-devel
>>>> is also installed.
>>>> [yangtiezhu@linux perf]$ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address'
>>>>     BUILD:   Doing 'make -j4' parallel build
>>>>     HOSTCC   fixdep.o
>>>>     HOSTLD   fixdep-in.o
>>>>     LINK     fixdep
>>>> <stdin>:1:0: warning: -fsanitize=address and -fsanitize=kernel-address are not supported for this target
>>>> <stdin>:1:0: warning: -fsanitize=address not supported for this target
>>>> Auto-detecting system features:
>>>> ...                         dwarf: [ OFF ]
>>>> ...            dwarf_getlocations: [ OFF ]
>>>> ...                         glibc: [ OFF ]
>>>> ...                          gtk2: [ OFF ]
>>>> ...                      libaudit: [ OFF ]
>>>> ...                        libbfd: [ OFF ]
>>>> ...                        libcap: [ OFF ]
>>>> ...                        libelf: [ OFF ]
>>>> ...                       libnuma: [ OFF ]
>>>> ...        numa_num_possible_cpus: [ OFF ]
>>>> ...                       libperl: [ OFF ]
>>>> ...                     libpython: [ OFF ]
>>>> ...                     libcrypto: [ OFF ]
>>>> ...                     libunwind: [ OFF ]
>>>> ...            libdw-dwarf-unwind: [ OFF ]
>>>> ...                          zlib: [ OFF ]
>>>> ...                          lzma: [ OFF ]
>>>> ...                     get_cpuid: [ OFF ]
>>>> ...                           bpf: [ OFF ]
>>>> ...                        libaio: [ OFF ]
>>>> ...                       libzstd: [ OFF ]
>>>> ...        disassembler-four-args: [ OFF ]
>>>>
>>>> Makefile.config:393: *** No gnu/libc-version.h found, please install glibc-dev[el].  Stop.
>>>> Makefile.perf:224: recipe for target 'sub-make' failed
>>>> make[1]: *** [sub-make] Error 2
>>>> Makefile:69: recipe for target 'all' failed
>>>> make: *** [all] Error 2
>>>> [yangtiezhu@linux perf]$ ls /usr/include/gnu/libc-version.h
>>>> /usr/include/gnu/libc-version.h
>>>>
>>>> After install libasan and libubsan, the feature-glibc is 1 and the build
>>>> process is success, so the cause is related with libasan or libubsan, we
>>>> should check them and print an error log to reflect the reality.
>>>>
>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>>> ---
>>>>
>>>> v2:
>>>>     - Check libasan and libubsan in tools/build/Makefile.feature
>>>>     - Modify the patch subject
>>>>
>>>>    tools/build/Makefile.feature | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
>>>> index 3abd431..e147c17 100644
>>>> --- a/tools/build/Makefile.feature
>>>> +++ b/tools/build/Makefile.feature
>>>> @@ -252,3 +252,10 @@ ifeq ($(feature_verbose),1)
>>>>      $(foreach feat,$(TMP),$(call feature_print_status,$(feat),))
>>>>      $(info )
>>>>    endif
>>>> +
>>>> +ifneq ($(shell ldconfig -p | grep libasan >/dev/null 2>&1; echo $$?), 0)
>>>> +  msg := $(error No libasan found, please install libasan);
>>>> +endif
>>>> +ifneq ($(shell ldconfig -p | grep libubsan >/dev/null 2>&1; echo $$?), 0)
>>>> +  msg := $(error No libubsan found, please install libubsan);
>>>> +endif
>>> Hey, we need to only do that if -fsanitize=address is in EXTRA_CFLAGS,
>>> right?
>> Sorry for the late reply.
>> Maybe -fsanitize=undefined is also needed.
>> Please reference tools/perf/Documentation/Build.txt
> Can you send an updated patch then?

OK, I will send v3 soon.

>   
>>> I applied it and got:
>>>
>>>     $ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf
>>>     $ make O=/tmp/build/perf -C tools/perf install-bin
>>>     make: Entering directory '/home/acme/git/perf/tools/perf'
>>>       BUILD:   Doing 'make -j8' parallel build
>>>       HOSTCC   /tmp/build/perf/fixdep.o
>>>       HOSTLD   /tmp/build/perf/fixdep-in.o
>>>       LINK     /tmp/build/perf/fixdep
>>>     Warning: Kernel ABI header at 'tools/perf/util/hashmap.h' differs from latest version at 'tools/lib/bpf/hashmap.h'
>>>     diff -u tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
>>>     Warning: Kernel ABI header at 'tools/perf/util/hashmap.c' differs from latest version at 'tools/lib/bpf/hashmap.c'
>>>     diff -u tools/perf/util/hashmap.c tools/lib/bpf/hashmap.c
>>>     Auto-detecting system features:
>>>     ...                         dwarf: [ on  ]
>>>     ...            dwarf_getlocations: [ on  ]
>>>     ...                         glibc: [ on  ]
>>>     ...                          gtk2: [ on  ]
>>>     ...                        libbfd: [ on  ]
>>>     ...                        libcap: [ on  ]
>>>     ...                        libelf: [ on  ]
>>>     ...                       libnuma: [ on  ]
>>>     ...        numa_num_possible_cpus: [ on  ]
>>>     ...                       libperl: [ on  ]
>>>     ...                     libpython: [ on  ]
>>>     ...                     libcrypto: [ on  ]
>>>     ...                     libunwind: [ on  ]
>>>     ...            libdw-dwarf-unwind: [ on  ]
>>>     ...                          zlib: [ on  ]
>>>     ...                          lzma: [ on  ]
>>>     ...                     get_cpuid: [ on  ]
>>>     ...                           bpf: [ on  ]
>>>     ...                        libaio: [ on  ]
>>>     ...                       libzstd: [ on  ]
>>>     ...        disassembler-four-args: [ on  ]
>>>     /home/acme/git/perf/tools/build/Makefile.feature:255: *** No libasan found, please install libasan.  Stop.
>>>     make[1]: *** [Makefile.perf:231: sub-make] Error 2
>>>     make: *** [Makefile:110: install-bin] Error 2
>>>     make: Leaving directory '/home/acme/git/perf/tools/perf'
>>>     $
>>>
>>> Something enclosed in:
>>>
>>> 	ifneq ($(filter s% -fsanitize=address%,$(EXTRA_CFLAGS),),)
>>>
>>> Right Jiri?
>>>
>>> - Arnaldo

