Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED8BC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F34206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgDVOmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:42:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725935AbgDVOmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:42:23 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MEX8c6114188
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 10:42:22 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gf5td03h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 10:42:22 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Wed, 22 Apr 2020 15:42:14 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Apr 2020 15:42:11 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03MEgG0Y64159842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 14:42:16 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E96DDA4051;
        Wed, 22 Apr 2020 14:42:15 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFD2DA4055;
        Wed, 22 Apr 2020 14:42:10 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.206.180.111])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Apr 2020 14:42:10 +0000 (GMT)
Subject: Re: kernel/perf: Sample data being lost
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <f09e62d0-af40-683a-648f-3c3b7137369b@linux.ibm.com>
 <20200421155946.GB12295@kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Wed, 22 Apr 2020 16:42:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200421155946.GB12295@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20042214-0028-0000-0000-000003FD0318
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042214-0029-0000-0000-000024C2CAA7
Message-Id: <89099efe-638e-e4e4-e008-b475bf064d99@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_06:2020-04-22,2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/20 5:59 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Apr 21, 2020 at 05:54:29PM +0200, Thomas Richter escreveu:
>> Since a couple of days I see this warning popping up very often:
>>
>> [root@m35lp76 perf]# ./perf record --call-graph dwarf -e rb0000 -- find /
>> [ perf record: Woken up 282 times to write data ]
>> Warning:
>> Processed 16999 events and lost 382 chunks!
>>
>> Check IO/CPU overload!
>>
>> [ perf record: Captured and wrote 125.730 MB perf.data (16219 samples) ]
>> [root@m35lp76 perf]#
>>
>> The machine is idle, its my development system, so not much going on.
>> It also happens using a software event, for example cycles. It shows
>> up more often, the larger the sample size is. So for example:
>>
>> [root@m35lp76 perf]# pwd
>> /root/linux/tools/perf
>> [root@m35lp76 perf]#  ./perf record  --call-graph dwarf -- find
>> [ perf record: Woken up 2 times to write data ]
>> Warning:
>> Processed 231 events and lost 7 chunks!
>>
>> Check IO/CPU overload!
>>
>> [ perf record: Captured and wrote 1.000 MB perf.data (130 samples) ]
>> [root@m35lp76 perf]#
>>
>> I have very seldom observed this before, only in extremely rare cases with
>> a heavily loaded machine. I am wondering what has changed, I haven't
>> changed anything in the s390 PMU device drivers.
>> It could be
>>  - common kernel code when writing into the ringbuffer.
>>  - the perf tool too slow to read data from the mapped buffer
>>    However I have not come across changes in this area.
>>
>> Has anybody observed similar issue?
>>
>> PS: I have added some printk messages into my PMU devices drivers.
>> I have seen messages that the 16384 pages for auxilary buffers are full
>> and that samples have been dropped.
> 
> Can you try to bisect tools/perf?
> 
> Something like:
> 
> git checkout v5.4
> 
> build it, no problems? Use it as the 'git bisect good' starting point.
> 
> - Arnaldo
> 

I think this was my fault. The samples with call-graphs are large and I forgot
to increase the mapped ringbuffer with the -m option.
So the buffer default size is 128 pages (516kb) which fills quite quickly.

Sorry for the noise.

I also realized this status line running perf top

Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)

It shows up after ca 1 minutes on an idle system.
I guess this is the sane root cause?
-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

