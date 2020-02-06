Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0490C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7342A206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgBFJkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 04:40:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727795AbgBFJkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:40:49 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0169daSR014189
        for <linux-kernel@vger.kernel.org>; Thu, 6 Feb 2020 04:40:47 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhn59963-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 04:40:47 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 6 Feb 2020 09:40:45 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Feb 2020 09:40:41 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0169efR150987106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Feb 2020 09:40:41 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06425AE058;
        Thu,  6 Feb 2020 09:40:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A5F6AE04D;
        Thu,  6 Feb 2020 09:40:39 +0000 (GMT)
Received: from [9.124.31.49] (unknown [9.124.31.49])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Feb 2020 09:40:38 +0000 (GMT)
Subject: Re: [PATCH 3/4] perf map: Set kmap->kmaps backpointer for main kernel
 map chunks
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20191223133241.8578-1-acme@kernel.org>
 <20191223133241.8578-4-acme@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Thu, 6 Feb 2020 15:10:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191223133241.8578-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20020609-0016-0000-0000-000002E43403
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020609-0017-0000-0000-0000334718AC
Message-Id: <2617ead1-60e2-3da6-cde6-9efd68412139@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 12/23/19 7:02 PM, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> When a map is create to represent the main kernel area (vmlinux) with
> map__new2() we allocate an extra area to store a pointer to the 'struct
> maps' for the kernel maps, so that we can access that struct when
> loading ELF files or kallsyms, as we will need to split it in multiple
> maps, one per kernel module or ELF section (such as ".init.text").
> 
> So when map->dso->kernel is non-zero, it is expected that
> map__kmap(map)->kmaps to be set to the tree of kernel maps (modules,
> chunks of the main kernel, bpf progs put in place via
> PERF_RECORD_KSYMBOL, the main kernel).
> 
> This was not the case when we were splitting the main kernel into chunks
> for its ELF sections, which ended up making 'perf report --children'
> processing a perf.data file with callchains to trip on
> __map__is_kernel(), when we press ENTER to see the popup menu for main
> histogram entries that starts at a symbol in the ".init.text" ELF
> section, e.g.:
> 
> -    8.83%     0.00%  swapper     [kernel.vmlinux].init.text  [k] start_kernel
>       start_kernel
>       cpu_startup_entry
>       do_idle
>       cpuidle_enter
>       cpuidle_enter_state
>       intel_idle
> 
> Fix it.

perf top from perf/core has started crashing at __map__is_kernel():

   (gdb) bt
   #0  __map__is_kernel (map=<optimized out>) at util/map.c:935
   #1  0x000000000045551d in perf_event__process_sample (machine=0xbab8f8,
       sample=0x7fffe5ffa6d0, evsel=0xba7570, event=0xbcac50, tool=0x7fffffff84e0)
       at builtin-top.c:833
   #2  deliver_event (qe=<optimized out>, qevent=<optimized out>) at builtin-top.c:1192
   #3  0x000000000050b9fb in do_flush (show_progress=false, oe=0x7fffffff87e0)
       at util/ordered-events.c:244
   #4  __ordered_events__flush (oe=oe@entry=0x7fffffff87e0, how=how@entry=OE_FLUSH__TOP,
       timestamp=timestamp@entry=0) at util/ordered-events.c:323
   #5  0x000000000050c1b5 in __ordered_events__flush (timestamp=<optimized out>,
       how=<optimized out>, oe=<optimized out>) at util/ordered-events.c:339
   #6  ordered_events__flush (how=OE_FLUSH__TOP, oe=0x7fffffff87e0) at util/ordered-events.c:341
   #7  ordered_events__flush (oe=oe@entry=0x7fffffff87e0, how=how@entry=OE_FLUSH__TOP)
       at util/ordered-events.c:339
   #8  0x0000000000454e21 in process_thread (arg=0x7fffffff84e0) at builtin-top.c:1104
   #9  0x00007ffff7f2c4e2 in start_thread () from /lib64/libpthread.so.0
   #10 0x00007ffff76086d3 in clone () from /lib64/libc.so.6

I haven't debugged it much but seems like the actual patch that's causing the
crash is de90d513b246 ("perf map: Use map->dso->kernel + map__kmaps() in
map__kmaps()").

Did you face this / aware of it?

Ravi

