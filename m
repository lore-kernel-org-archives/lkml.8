Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B59C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 02:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2AE20768
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 02:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgFOCUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 22:20:31 -0400
Received: from mail.loongson.cn ([114.242.206.163]:34492 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727946AbgFOCUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 22:20:30 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx32na2uZeTjBDAA--.4416S3;
        Mon, 15 Jun 2020 10:20:12 +0800 (CST)
Subject: Re: [PATCH v2] tools build: Check libasan and libubsan in
 Makefile.feature
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
References: <1591164604-20806-1-git-send-email-yangtiezhu@loongson.cn>
 <20200603113228.GV31795@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <7bbd7c0c-7e09-7eaf-5a54-602e70e36112@loongson.cn>
Date:   Mon, 15 Jun 2020 10:20:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20200603113228.GV31795@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dx32na2uZeTjBDAA--.4416S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1DCw13ZF1rWr4rJr1rCrg_yoWrKr1Dpw
        4FkFWDtayfGrWxZ34kAF48WFWrKF4IvayYqay5t347AF1rKwnFkr4YyFy5WF17Xw18Jay2
        kw17Way8Gw4UAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07Al
        zVAYIcxG8wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfUomiiDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2020 07:32 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 03, 2020 at 02:10:04PM +0800, Tiezhu Yang escreveu:
>> When build perf with ASan or UBSan, if libasan or libubsan can not find,
>> the feature-glibc is 0 and there exists the following error log which is
>> wrong, because we can find gnu/libc-version.h in /usr/include, glibc-devel
>> is also installed.
>   
>> [yangtiezhu@linux perf]$ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address'
>>    BUILD:   Doing 'make -j4' parallel build
>>    HOSTCC   fixdep.o
>>    HOSTLD   fixdep-in.o
>>    LINK     fixdep
>> <stdin>:1:0: warning: -fsanitize=address and -fsanitize=kernel-address are not supported for this target
>> <stdin>:1:0: warning: -fsanitize=address not supported for this target
>   
>> Auto-detecting system features:
>> ...                         dwarf: [ OFF ]
>> ...            dwarf_getlocations: [ OFF ]
>> ...                         glibc: [ OFF ]
>> ...                          gtk2: [ OFF ]
>> ...                      libaudit: [ OFF ]
>> ...                        libbfd: [ OFF ]
>> ...                        libcap: [ OFF ]
>> ...                        libelf: [ OFF ]
>> ...                       libnuma: [ OFF ]
>> ...        numa_num_possible_cpus: [ OFF ]
>> ...                       libperl: [ OFF ]
>> ...                     libpython: [ OFF ]
>> ...                     libcrypto: [ OFF ]
>> ...                     libunwind: [ OFF ]
>> ...            libdw-dwarf-unwind: [ OFF ]
>> ...                          zlib: [ OFF ]
>> ...                          lzma: [ OFF ]
>> ...                     get_cpuid: [ OFF ]
>> ...                           bpf: [ OFF ]
>> ...                        libaio: [ OFF ]
>> ...                       libzstd: [ OFF ]
>> ...        disassembler-four-args: [ OFF ]
>>
>> Makefile.config:393: *** No gnu/libc-version.h found, please install glibc-dev[el].  Stop.
>> Makefile.perf:224: recipe for target 'sub-make' failed
>> make[1]: *** [sub-make] Error 2
>> Makefile:69: recipe for target 'all' failed
>> make: *** [all] Error 2
>> [yangtiezhu@linux perf]$ ls /usr/include/gnu/libc-version.h
>> /usr/include/gnu/libc-version.h
>>
>> After install libasan and libubsan, the feature-glibc is 1 and the build
>> process is success, so the cause is related with libasan or libubsan, we
>> should check them and print an error log to reflect the reality.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>
>> v2:
>>    - Check libasan and libubsan in tools/build/Makefile.feature
>>    - Modify the patch subject
>>
>>   tools/build/Makefile.feature | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
>> index 3abd431..e147c17 100644
>> --- a/tools/build/Makefile.feature
>> +++ b/tools/build/Makefile.feature
>> @@ -252,3 +252,10 @@ ifeq ($(feature_verbose),1)
>>     $(foreach feat,$(TMP),$(call feature_print_status,$(feat),))
>>     $(info )
>>   endif
>> +
>> +ifneq ($(shell ldconfig -p | grep libasan >/dev/null 2>&1; echo $$?), 0)
>> +  msg := $(error No libasan found, please install libasan);
>> +endif
>> +ifneq ($(shell ldconfig -p | grep libubsan >/dev/null 2>&1; echo $$?), 0)
>> +  msg := $(error No libubsan found, please install libubsan);
>> +endif
> Hey, we need to only do that if -fsanitize=address is in EXTRA_CFLAGS,
> right?

Sorry for the late reply.
Maybe -fsanitize=undefined is also needed.
Please reference tools/perf/Documentation/Build.txt

>
> I applied it and got:
>
>    $ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf
>    $ make O=/tmp/build/perf -C tools/perf install-bin
>    make: Entering directory '/home/acme/git/perf/tools/perf'
>      BUILD:   Doing 'make -j8' parallel build
>      HOSTCC   /tmp/build/perf/fixdep.o
>      HOSTLD   /tmp/build/perf/fixdep-in.o
>      LINK     /tmp/build/perf/fixdep
>    Warning: Kernel ABI header at 'tools/perf/util/hashmap.h' differs from latest version at 'tools/lib/bpf/hashmap.h'
>    diff -u tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
>    Warning: Kernel ABI header at 'tools/perf/util/hashmap.c' differs from latest version at 'tools/lib/bpf/hashmap.c'
>    diff -u tools/perf/util/hashmap.c tools/lib/bpf/hashmap.c
>    
>    Auto-detecting system features:
>    ...                         dwarf: [ on  ]
>    ...            dwarf_getlocations: [ on  ]
>    ...                         glibc: [ on  ]
>    ...                          gtk2: [ on  ]
>    ...                        libbfd: [ on  ]
>    ...                        libcap: [ on  ]
>    ...                        libelf: [ on  ]
>    ...                       libnuma: [ on  ]
>    ...        numa_num_possible_cpus: [ on  ]
>    ...                       libperl: [ on  ]
>    ...                     libpython: [ on  ]
>    ...                     libcrypto: [ on  ]
>    ...                     libunwind: [ on  ]
>    ...            libdw-dwarf-unwind: [ on  ]
>    ...                          zlib: [ on  ]
>    ...                          lzma: [ on  ]
>    ...                     get_cpuid: [ on  ]
>    ...                           bpf: [ on  ]
>    ...                        libaio: [ on  ]
>    ...                       libzstd: [ on  ]
>    ...        disassembler-four-args: [ on  ]
>    
>    /home/acme/git/perf/tools/build/Makefile.feature:255: *** No libasan found, please install libasan.  Stop.
>    make[1]: *** [Makefile.perf:231: sub-make] Error 2
>    make: *** [Makefile:110: install-bin] Error 2
>    make: Leaving directory '/home/acme/git/perf/tools/perf'
>    $
>
> Something enclosed in:
>
> 	ifneq ($(filter s% -fsanitize=address%,$(EXTRA_CFLAGS),),)
>
> Right Jiri?
>
> - Arnaldo

