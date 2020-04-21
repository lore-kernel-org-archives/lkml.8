Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2265C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5194206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgDUPys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:54:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725613AbgDUPyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:54:46 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03LFXENr112181
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:54:45 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gfebpxk7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:54:45 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Tue, 21 Apr 2020 16:54:37 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Apr 2020 16:54:34 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03LFsdqQ6815904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 15:54:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBAE252050;
        Tue, 21 Apr 2020 15:54:38 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.206.132.69])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E29F05204E;
        Tue, 21 Apr 2020 15:54:33 +0000 (GMT)
To:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Subject: kernel/perf: Sample data being lost
Organization: IBM
Date:   Tue, 21 Apr 2020 17:54:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20042115-0028-0000-0000-000003FC661A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042115-0029-0000-0000-000024C22A44
Message-Id: <f09e62d0-af40-683a-648f-3c3b7137369b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_05:2020-04-20,2020-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a couple of days I see this warning popping up very often:

[root@m35lp76 perf]# ./perf record --call-graph dwarf -e rb0000 -- find /
[ perf record: Woken up 282 times to write data ]
Warning:
Processed 16999 events and lost 382 chunks!

Check IO/CPU overload!

[ perf record: Captured and wrote 125.730 MB perf.data (16219 samples) ]
[root@m35lp76 perf]#

The machine is idle, its my development system, so not much going on.
It also happens using a software event, for example cycles. It shows
up more often, the larger the sample size is. So for example:

[root@m35lp76 perf]# pwd
/root/linux/tools/perf
[root@m35lp76 perf]#  ./perf record  --call-graph dwarf -- find
[ perf record: Woken up 2 times to write data ]
Warning:
Processed 231 events and lost 7 chunks!

Check IO/CPU overload!

[ perf record: Captured and wrote 1.000 MB perf.data (130 samples) ]
[root@m35lp76 perf]#

I have very seldom observed this before, only in extremely rare cases with
a heavily loaded machine. I am wondering what has changed, I haven't
changed anything in the s390 PMU device drivers.
It could be
 - common kernel code when writing into the ringbuffer.
 - the perf tool too slow to read data from the mapped buffer.
   However I have not come across changes in this area.

Has anybody observed similar issue?

PS: I have added some printk messages into my PMU devices drivers.
I have seen messages that the 16384 pages for auxilary buffers are full
and that samples have been dropped.


Thanks a lot.                                 
-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

