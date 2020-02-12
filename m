Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABE1C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932B82082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgBLKIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:08:50 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2411 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729082AbgBLKIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:08:49 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 72916B6B72BB7CB57E10;
        Wed, 12 Feb 2020 10:08:47 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Feb 2020 10:08:47 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 12 Feb
 2020 10:08:45 +0000
Subject: Re: [PATCH RFC 5/7] perf pmu: Support matching by sysid
From:   John Garry <john.garry@huawei.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <will@kernel.org>, <ak@linux.intel.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <suzuki.poulose@arm.com>,
        <james.clark@arm.com>, <zhangshaokun@hisilicon.com>,
        <robin.murphy@arm.com>, "liuqi (BA)" <liuqi115@huawei.com>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <1579876505-113251-6-git-send-email-john.garry@huawei.com>
 <20200210120759.GG1907700@krava>
 <63799909-067b-e5f4-dcf1-9ba1ec145348@huawei.com>
 <20200211134704.GB93194@krava>
 <2a51ce93-fa68-8088-f31f-2fd692253335@huawei.com>
Message-ID: <f72c7f52-a285-e052-8656-de2940a6fc7f@huawei.com>
Date:   Wed, 12 Feb 2020 10:08:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <2a51ce93-fa68-8088-f31f-2fd692253335@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2020 15:07, John Garry wrote:
> On 11/02/2020 13:47, Jiri Olsa wrote:
> 
> Hi Jirka,
> 
>>>>> +
>>>>> +    return buf;
>>>>> +}
>>>>> +
>>>
>>> I have another series to add kernel support for a system identifier 
>>> sysfs
>>> entry, which I sent after this series:
>>>
>>> https://lore.kernel.org/linux-acpi/1580210059-199540-1-git-send-email-john.garry@huawei.com/ 
>>>
>>>
>>> It is different to what I am relying on here - it uses a kernel soc 
>>> driver
>>> for firmware ACPI PPTT identifier. Progress is somewhat blocked at the
>>> moment however and I may have to use a different method:
>>>
>>> https://lore.kernel.org/linux-acpi/20200128123415.GB36168@bogus/
>>
>> I'll try to check ;-)
> 
> Summary is that there exists an ACPI firmware field which we could 
> expose to userspace via sysfs - this would provide the system id. 
> However there is a proposal to deprecate it in the ACPI standard and, as 
> such, would prefer that we don't add kernel support for it at this stage.
> 
> So I am evaluating the alternative in the meantime, which again is some 
> firmware method which should allow us to expose a system id to userspace 
> via sysfs. Unfortunately this is arm specific. However, other archs can 
> still provide their own method, maybe a soc driver:
> 
> Documentation/ABI/testing/sysfs-devices-soc#n15
> 
>>
>>>
>>>>> +static char *perf_pmu__getsysid(void)
>>>>> +{
>>>>> +    char *sysid;
>>>>> +    static bool printed;
>>>>> +
>>>>> +    sysid = getenv("PERF_SYSID");
>>>>> +    if (sysid)
>>>>> +        sysid = strdup(sysid);
>>>>> +
>>>>> +    if (!sysid)
>>>>> +        sysid = get_sysid_str();
>>>>> +    if (!sysid)
>>>>> +        return NULL;
>>>>> +
>>>>> +    if (!printed) {
>>>>> +        pr_debug("Using SYSID %s\n", sysid);
>>>>> +        printed = true;
>>>>> +    }
>>>>> +    return sysid;
>>>>> +}
>>>>
>>>> this part is getting complicated and AFAIK we have no tests for it
>>>>
>>>> if you could think of any tests that'd be great.. Perhaps we could
>>>> load 'our' json test files and check appropriate events/aliasses
>>>> via in pmu object.. or via parse_events interface.. those test aliases
>>>> would have to be part of perf, but we have tests compiled in anyway
>>>
>>> Sorry, I don't fully follow.
>>>
>>> Are you suggesting that we could load the specific JSONs tables for a 
>>> system
>>> from the host filesystem?
>>
>> I wish to see some test for all this.. I can only think about having
>> 'test' json files compiled with perf and 'perf test' that looks them
>> up and checks that all is in the proper place
> 
> OK, let me consider this part for perf test support.

I will note that perf test has many issues on my arm64 board:

do] password for john:
  1: vmlinux symtab matches kallsyms                       : Skip
  2: Detect openat syscall event                           : FAILED!
  3: Detect openat syscall event on all cpus               : FAILED!
  4: Read samples using the mmap interface                 : FAILED!
  5: Test data source output                               : Ok
  6: Parse event definition strings                        : FAILED!
  7: Simple expression parser                              : Ok
  8: PERF_RECORD_* events & perf_sample fields             : Ok
  9: Parse perf pmu format                                 : Ok
10: DSO data read                                         : Ok
11: DSO data cache                                        : Ok
12: DSO data reopen                                       : Ok
13: Roundtrip evsel->name                                 : Ok
14: Parse sched tracepoints fields                        : FAILED!
15: syscalls:sys_enter_openat event fields                : FAILED!
16: Setup struct perf_event_attr                          : Skip
17: Match and link multiple hists                         : Ok
18: 'import perf' in python                               : Ok
21: Breakpoint accounting                                 : Ok
22: Watchpoint                                            :
22.1: Read Only Watchpoint                                : Ok
22.2: Write Only Watchpoint                               : Ok
22.3: Read / Write Watchpoint                             : Ok
22.4: Modify Watchpoint                                   : Ok
23: Number of exit events of a simple workload            : Ok
24: Software clock events period values                   : Ok
25: Object code reading                                   : Ok
26: Sample parsing                                        : Ok
27: Use a dummy software event to keep tracking           : Ok
28: Parse with no sample_id_all bit set                   : Ok
29: Filter hist entries                                   : Ok
30: Lookup mmap thread                                    : Ok
31: Share thread maps                                     : Ok
32: Sort output of hist entries                           : Ok
33: Cumulate child hist entries                           : Ok
34: Track with sched_switch                               : Ok
35: Filter fds with revents mask in a fdarray             : Ok
36: Add fd to a fdarray, making it autogrow               : Ok
37: kmod_path__parse                                      : Ok
38: Thread map                                            : Ok
39: LLVM search and compile                               :
39.1: Basic BPF llvm compile                              : Skip
39.2: kbuild searching                                    : Skip
39.3: Compile source for BPF prologue generation          : Skip
39.4: Compile source for BPF relocation                   : Skip
40: Session topology                                      : FAILED!
41: BPF filter                                            :
41.1: Basic BPF filtering                                 : Skip
41.2: BPF pinning                                         : Skip
41.3: BPF prologue generation                             : Skip
41.4: BPF relocation checker                              : Skip
42: Synthesize thread map                                 : Ok
43: Remove thread map                                     : Ok
44: Synthesize cpu map                                    : Ok
45: Synthesize stat config                                : Ok
46: Synthesize stat                                       : Ok
47: Synthesize stat round                                 : Ok
48: Synthesize attr update                                : Ok
49: Event times                                           : Ok
50: Read backward ring buffer                             : FAILED!
51: Print cpu map                                         : Ok
52: Merge cpu map                                         : Ok
53: Probe SDT events                                      : Ok
54: is_printable_array                                    : Ok
55: Print bitmap                                          : Ok
56: perf hooks                          umber__scnprintf 
                : Ok
59: mem2node                                              : Ok
60: time utils                                            : Ok
61: Test jit_write_elf                                    : Ok
62: maps__merge_in                                        : Ok
63: DWARF unwind                                          : Ok
64: Check open filename arg using perf trace + vfs_getname: FAILED!
65: Add vfs_getname probe to get syscall args filenames   : FAILED!
66: Use vfs_getname probe to get syscall args filenames   : FAILED!
67: Zstd perf.data compression/decompression              : Ok
68: probe libc's inet_pton & backtrace it with ping       : Skip
john@ubuntu:~/linux$

I know that the perf tool definitely has issues for system topology for 
arm64, which I need to check on.

Maybe I can conscribe help internally to help check the rest...

Thanks,
john
