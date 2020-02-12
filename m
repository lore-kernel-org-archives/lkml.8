Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DE8C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2872921569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgBLMY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:24:28 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2413 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbgBLMY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:24:28 -0500
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id AA5652B296E844F20F58;
        Wed, 12 Feb 2020 12:24:25 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Feb 2020 12:24:24 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 12 Feb
 2020 12:24:25 +0000
Subject: Re: [PATCH RFC 5/7] perf pmu: Support matching by sysid
To:     Jiri Olsa <jolsa@redhat.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "liuqi (BA)" <liuqi115@huawei.com>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <1579876505-113251-6-git-send-email-john.garry@huawei.com>
 <20200210120759.GG1907700@krava>
 <63799909-067b-e5f4-dcf1-9ba1ec145348@huawei.com>
 <20200211134704.GB93194@krava>
 <2a51ce93-fa68-8088-f31f-2fd692253335@huawei.com>
 <f72c7f52-a285-e052-8656-de2940a6fc7f@huawei.com>
 <20200212121603.GJ183981@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <68f9d5ce-d0a1-f7fa-fd01-e4f613ebad0c@huawei.com>
Date:   Wed, 12 Feb 2020 12:24:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200212121603.GJ183981@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2020 12:16, Jiri Olsa wrote:
>>> et me consider this part for perf test support.
>> I will note that perf test has many issues on my arm64 board:
>>
>> do] password for john:
>>   1: vmlinux symtab matches kallsyms                       : Skip
>>   2: Detect openat syscall event                           : FAILED!
>>   3: Detect openat syscall event on all cpus               : FAILED!
>>   4: Read samples using the mmap interface                 : FAILED!
>>   5: Test data source output                               : Ok
>>   6: Parse event definition strings                        : FAILED!
>>   7: Simple expression parser                              : Ok
>>   8: PERF_RECORD_* events & perf_sample fields             : Ok
>>   9: Parse perf pmu format                                 : Ok
>> 10: DSO data read                                         : Ok
>> 11: DSO data cache                                        : Ok
>> 12: DSO data reopen                                       : Ok
>> 13: Roundtrip evsel->name                                 : Ok
>> 14: Parse sched tracepoints fields                        : FAILED!
>> 15: syscalls:sys_enter_openat event fields                : FAILED!
> looks like some issue with tracepoints
> 
>> 16: Setup struct perf_event_attr                          : Skip
>> 17: Match and link multiple hists                         : Ok
>> 18: 'import perf' in python                               : Ok
>> 21: Breakpoint accounting                                 : Ok
>> 22: Watchpoint                                            :
>> 22.1: Read Only Watchpoint                                : Ok
>> 22.2: Write Only Watchpoint                               : Ok
>> 22.3: Read / Write Watchpoint                             : Ok
>> 22.4: Modify Watchpoint                                   : Ok
>> 23: Number of exit events of a simple workload            : Ok
>> 24: Software clock events period values                   : Ok
>> 25: Object code reading                                   : Ok
>> 26: Sample parsing                                        : Ok
>> 27: Use a dummy software event to keep tracking           : Ok
>> 28: Parse with no sample_id_all bit set                   : Ok
>> 29: Filter hist entries                                   : Ok
>> 30: Lookup mmap thread                                    : Ok
>> 31: Share thread maps                                     : Ok
>> 32: Sort output of hist entries                           : Ok
>> 33: Cumulate child hist entries                           : Ok
>> 34: Track with sched_switch                               : Ok
>> 35: Filter fds with revents mask in a fdarray             : Ok
>> 36: Add fd to a fdarray, making it autogrow               : Ok
>> 37: kmod_path__parse                                      : Ok
>> 38: Thread map                                            : Ok
>> 39: LLVM search and compile                               :
>> 39.1: Basic BPF llvm compile                              : Skip
>> 39.2: kbuild searching                                    : Skip
>> 39.3: Compile source for BPF prologue generation          : Skip
>> 39.4: Compile source for BPF relocation                   : Skip
> Skip is fine;-)
> 
>> 40: Session topology                                      : FAILED!
> I'd expect that one to fail if we don't have special
> code to support arm in there
> 
>> 41: BPF filter                                            :
>> 41.1: Basic BPF filtering                                 : Skip
>> 41.2: BPF pinning                                         : Skip
>> 41.3: BPF prologue generation                             : Skip
>> 41.4: BPF relocation checker                              : Skip
>> 42: Synthesize thread map                                 : Ok
>> 43: Remove thread map                                     : Ok
>> 44: Synthesize cpu map                                    : Ok
>> 45: Synthesize stat config                                : Ok
>> 46: Synthesize stat                                       : Ok
>> 47: Synthesize stat round                                 : Ok
>> 48: Synthesize attr update                                : Ok
>> 49: Event times                                           : Ok
>> 50: Read backward ring buffer                             : FAILED!
> hum, I thought this was generic code that would work across archs
> 
>> 51: Print cpu map                                         : Ok
>> 52: Merge cpu map                                         : Ok
>> 53: Probe SDT events                                      : Ok
>> 54: is_printable_array                                    : Ok
>> 55: Print bitmap                                          : Ok
>> 56: perf hooks                          umber__scnprintf                : Ok
>> 59: mem2node                                              : Ok
>> 60: time utils                                            : Ok
>> 61: Test jit_write_elf                                    : Ok
>> 62: maps__merge_in                                        : Ok
>> 63: DWARF unwind                                          : Ok
>> 64: Check open filename arg using perf trace + vfs_getname: FAILED!
>> 65: Add vfs_getname probe to get syscall args filenames   : FAILED!
>> 66: Use vfs_getname probe to get syscall args filenames   : FAILED!
> with these we have always a problem across archs,
> it's tricky to make script test that works everywhere:-\
> 
>> 67: Zstd perf.data compression/decompression              : Ok
>> 68: probe libc's inet_pton & backtrace it with ping       : Skip
>> john@ubuntu:~/linux$
>>
>> I know that the perf tool definitely has issues for system topology for
>> arm64, which I need to check on.
>>
>> Maybe I can conscribe help internally to help check the rest...

Hi jirka,

> the json/alias test would be also to make sure the x86 still works,
> so regardless of some tests failing on arm, I think it's still better
> to have that test

OK, I can look at this separately now, and it won't be blocked like this 
series is on the kernel sysid issue.

Thanks,
john
