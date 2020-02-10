Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E37C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF52E2168B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgBJLRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 06:17:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727369AbgBJLRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 06:17:02 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ABAb0h083569
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 06:17:01 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1u55sb16-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 06:17:00 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 10 Feb 2020 11:16:58 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Feb 2020 11:16:55 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01ABGs6152953090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 11:16:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC67A4204D;
        Mon, 10 Feb 2020 11:16:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF56242045;
        Mon, 10 Feb 2020 11:16:50 +0000 (GMT)
Received: from [9.199.63.139] (unknown [9.199.63.139])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Feb 2020 11:16:50 +0000 (GMT)
Subject: Re: [PATCH 3/4] perf map: Set kmap->kmaps backpointer for main kernel
 map chunks
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
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
 <2617ead1-60e2-3da6-cde6-9efd68412139@linux.ibm.com>
 <20200209150108.GA1784847@krava> <20200209193238.GA1907700@krava>
 <20200210003757.GB1907700@krava>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Mon, 10 Feb 2020 16:46:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210003757.GB1907700@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20021011-4275-0000-0000-0000039FBAAF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021011-4276-0000-0000-000038B3EE40
Message-Id: <5d1387c8-70bc-ceaf-901f-96903868b8a3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_02:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/20 6:07 AM, Jiri Olsa wrote:
> On Sun, Feb 09, 2020 at 08:32:38PM +0100, Jiri Olsa wrote:
> 
> SNIP
> 
>>>>
>>>> perf top from perf/core has started crashing at __map__is_kernel():
>>>>
>>>>    (gdb) bt
>>>>    #0  __map__is_kernel (map=<optimized out>) at util/map.c:935
>>>>    #1  0x000000000045551d in perf_event__process_sample (machine=0xbab8f8,
>>>>        sample=0x7fffe5ffa6d0, evsel=0xba7570, event=0xbcac50, tool=0x7fffffff84e0)
>>>>        at builtin-top.c:833
>>>>    #2  deliver_event (qe=<optimized out>, qevent=<optimized out>) at builtin-top.c:1192
>>>>    #3  0x000000000050b9fb in do_flush (show_progress=false, oe=0x7fffffff87e0)
>>>>        at util/ordered-events.c:244
>>>>    #4  __ordered_events__flush (oe=oe@entry=0x7fffffff87e0, how=how@entry=OE_FLUSH__TOP,
>>>>        timestamp=timestamp@entry=0) at util/ordered-events.c:323
>>>>    #5  0x000000000050c1b5 in __ordered_events__flush (timestamp=<optimized out>,
>>>>        how=<optimized out>, oe=<optimized out>) at util/ordered-events.c:339
>>>>    #6  ordered_events__flush (how=OE_FLUSH__TOP, oe=0x7fffffff87e0) at util/ordered-events.c:341
>>>>    #7  ordered_events__flush (oe=oe@entry=0x7fffffff87e0, how=how@entry=OE_FLUSH__TOP)
>>>>        at util/ordered-events.c:339
>>>>    #8  0x0000000000454e21 in process_thread (arg=0x7fffffff84e0) at builtin-top.c:1104
>>>>    #9  0x00007ffff7f2c4e2 in start_thread () from /lib64/libpthread.so.0
>>>>    #10 0x00007ffff76086d3 in clone () from /lib64/libc.so.6
>>>>
>>>> I haven't debugged it much but seems like the actual patch that's causing the
>>>> crash is de90d513b246 ("perf map: Use map->dso->kernel + map__kmaps() in
>>>> map__kmaps()").
>>>>
>>>> Did you face this / aware of it?
>>>
>>> hum, looks like there are few more places where we don't set
>>> kmaps pointer, patch below fixes that for me
>>>
>>> I'll still need to do more checking and I'll send a fix
>>>
>>> jirka
>>>
>>>
>>> ---
>>
>> I found one more place.. please check the attached patch
> 
> and third time's the charm.. hopefully ;-)
> 
> I made the fix more central.. it still needs to be split
> into several small fixes, but I'm running perf top for
> few hours now without the crash

I also kept it running for ~20 mins but didn't see the crash.
Feel free to add:

Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

