Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E8CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 02:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F9920663
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 02:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgFCCCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 22:02:15 -0400
Received: from mail.loongson.cn ([114.242.206.163]:53636 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725777AbgFCCCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 22:02:15 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr2l4BNdeXuE8AA--.2735S3;
        Wed, 03 Jun 2020 10:01:30 +0800 (CST)
Subject: Re: [PATCH 1/2] perf tools: check libasan and libubsan in
 Makefile.config
To:     Jiri Olsa <jolsa@redhat.com>
References: <1591071304-19338-1-git-send-email-yangtiezhu@loongson.cn>
 <20200602141551.GC1169993@krava>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <35e55bec-1f8a-0e8f-798b-bab51ad30797@loongson.cn>
Date:   Wed, 3 Jun 2020 10:01:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20200602141551.GC1169993@krava>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxr2l4BNdeXuE8AA--.2735S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1DCw13ZF1rWF4fAFWxtFb_yoW5Aw45pw
        4fCa1DtaykJrW8Xa1kAFW8WF4rKrs7tFWjqFy5t347Ar4fGwsFyrs0vFW5WFy7Xw48Ja12
        va4xWa47K3yUAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07Al
        zVAYIcxG8wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUbPEf7UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2020 10:15 PM, Jiri Olsa wrote:
> On Tue, Jun 02, 2020 at 12:15:03PM +0800, Tiezhu Yang wrote:
>> When build perf with ASan or UBSan, if libasan or libubsan can not find,
>> the feature-glibc is 0 and there exists the following error log which is
>> wrong, because we can find gnu/libc-version.h in /usr/include, glibc-devel
>> is also installed.
>>
>> [yangtiezhu@linux perf]$ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address'
>>    BUILD:   Doing 'make -j4' parallel build
>>    HOSTCC   fixdep.o
>>    HOSTLD   fixdep-in.o
>>    LINK     fixdep
>> <stdin>:1:0: warning: -fsanitize=address and -fsanitize=kernel-address are not supported for this target
>> <stdin>:1:0: warning: -fsanitize=address not supported for this target
>>
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
>>   tools/perf/Makefile.config | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>> index 12a8204..b699d21 100644
>> --- a/tools/perf/Makefile.config
>> +++ b/tools/perf/Makefile.config
>> @@ -387,6 +387,12 @@ else
>>         NO_LIBBPF := 1
>>         NO_JVMTI := 1
>>       else
>> +      ifneq ($(shell ldconfig -p | grep libasan >/dev/null 2>&1; echo $$?), 0)
>> +        msg := $(error No libasan found, please install libasan);
>> +      endif
>> +      ifneq ($(shell ldconfig -p | grep libubsan >/dev/null 2>&1; echo $$?), 0)
>> +        msg := $(error No libubsan found, please install libubsan);
>> +      endif
> hum, would it be better to have check for this in tools/build/features?

Hi Jiri,

Thanks for your suggestion.

Do you mean that it is better to add this check at the end of file
tools/build/Makefile.feature?

>
> jirka
>
>>         ifneq ($(filter s% -static%,$(LDFLAGS),),)
>>           msg := $(error No static glibc found, please install glibc-static);
>>         else
>> -- 
>> 2.1.0
>>

