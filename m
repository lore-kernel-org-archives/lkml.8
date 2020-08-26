Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F631C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B2F2206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VlVyQ6zF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgHZADc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 20:03:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52168 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgHZADb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 20:03:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PNwX1V070204;
        Wed, 26 Aug 2020 00:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wIl8s2B8eTFWWunkTo8ECzb8nM7pgkrznApLJURGLI8=;
 b=VlVyQ6zFW0TmHw9lJyLhVD8Hjvf4jbLpujhx2XbnIg8IWn+SgSgN4kRbMUkBT/vD9S38
 dlz0Vr/a8ySwm9z5OmURZPE5x/Y10No+/tU2vD4UYdhlJ7Enap7hAQfFm+rjVLk9h2Vn
 IP9nvIF/fBcVOMf5Sqo9sgNowK6yp8tmZSIAK6vCvugxOXMUnlT4HlynRBinOS68XFmt
 3eYDG4TA/FukhbphSUZ+xCuFVdgQo05SUqn/MyIpuvT9BftFZLzHYzSfbp/4KMMZkNrF
 6vMKrmtMOIit/1SPzPj3hPHzF3IVtAb8Dq/tOqeoOcEAfsZAUD70ZnN5Eg7C/cgzvPlZ AA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 333csj5k55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 00:03:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PNsn8c048791;
        Wed, 26 Aug 2020 00:01:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 333r9kh2hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 00:01:23 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07Q01KNa023789;
        Wed, 26 Aug 2020 00:01:22 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Aug 2020 17:01:20 -0700
Subject: Re: [External] Re: [PATCH] mm/hugetlb: Fix a race between hugetlb
 sysctl handlers
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, ak@linux.intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200822095328.61306-1-songmuchun@bytedance.com>
 <20200824135924.b485e000d358cee817c4f05c@linux-foundation.org>
 <79800508-54c9-4cda-02de-29b1a6912e75@oracle.com>
 <CAMZfGtXh+FP0O92ccj532Y=K4m2S==eSK8LjYEM+p6cttV0p8Q@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <231ec1f1-fe7a-c48a-2427-1311360d4b9b@oracle.com>
Date:   Tue, 25 Aug 2020 17:01:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtXh+FP0O92ccj532Y=K4m2S==eSK8LjYEM+p6cttV0p8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008250177
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/20 8:01 PM, Muchun Song wrote:
> On Tue, Aug 25, 2020 at 5:21 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> I too am looking at this now and do not completely understand the race.
>> It could be that:
>>
>> hugetlb_sysctl_handler_common
>> ...
>>         table->data = &tmp;
>>
>> and, do_proc_doulongvec_minmax()
>> ...
>>         return __do_proc_doulongvec_minmax(table->data, table, write, ...
>> with __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, ...
>> ...
>>         i = (unsigned long *) data;
>>         ...
>>                 *i = val;
>>
>> So, __do_proc_doulongvec_minmax can be dereferencing and writing to the pointer
>> in one thread when hugetlb_sysctl_handler_common is setting it in another?
> 
> Yes, you are right.
> 
>>
>> Another confusing part of the message is the stack trace which includes
>> ...
>>      ? set_max_huge_pages+0x3da/0x4f0
>>      ? alloc_pool_huge_page+0x150/0x150
>>
>> which are 'downstream' from these routines.  I don't understand why these
>> are in the trace.
> 
> I am also confused. But this issue can be reproduced easily by letting more
> than one thread write to `/proc/sys/vm/nr_hugepages`. With this patch applied,
> the issue can not be reproduced and disappears.

There certainly is an issue here as one thread can modify data in another.
However, I am having a hard time seeing what causes the 'kernel NULL pointer
dereference'.

I tried to reproduce the issue myself but was unsuccessful.  I have 16 threads
writing to /proc/sys/vm/nr_hugepages in an infinite loop.  After several hours
running, I did not hit the issue.  Just curious, what architecture is the
system?  any special config or compiler options?

If you can easily reproduce, can you post the detailed oops message?

The 'NULL pointer' seems strange because after the first assignment to
table->data the value should never be NULL.  Certainly it can be modified
by another thread, but I can not see how it can be NULL.  At the beginning
of __do_proc_doulongvec_minmax, there is a check for NULL pointer with:

	if (!data || !table->maxlen || !*lenp || (*ppos && !write)) {
		*lenp = 0;
		return 0;
	}

I looked at the code my compiler produced for __do_proc_doulongvec_minmax.
It appears to use the same value/register for the pointer throughout the
routine.  IOW, I do not see how the pointer can be NULL for the assignment
when the routine does:

			*i = val;

Again, your analysis/patch points out a real issue.  I just want to get
a better understanding to make sure there is not another issue causing
the NULL pointer dereference.
-- 
Mike Kravetz
