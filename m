Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3133CC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C8F20674
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgBEMmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:42:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726386AbgBEMms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:42:48 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 015Cb4le010963
        for <linux-kernel@vger.kernel.org>; Wed, 5 Feb 2020 07:42:48 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhn2panm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:42:47 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Wed, 5 Feb 2020 12:42:45 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Feb 2020 12:42:41 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 015CgeOC65339608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Feb 2020 12:42:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B17CA4055;
        Wed,  5 Feb 2020 12:42:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 812F4A404D;
        Wed,  5 Feb 2020 12:42:38 +0000 (GMT)
Received: from [9.124.35.38] (unknown [9.124.35.38])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Feb 2020 12:42:38 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [PATCH v11 8/9] hugetlb_cgroup: Add hugetlb_cgroup reservation
 tests
To:     Mina Almasry <almasrymina@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, shuah <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
References: <20200203232248.104733-1-almasrymina@google.com>
 <20200203232248.104733-8-almasrymina@google.com>
 <0fa5d77c-d115-1e30-cb17-d6a48c916922@linux.ibm.com>
 <CAHS8izPobKi_w8R4pTt_UyfxzBJJYuNUw+Z6hgFfvZ1Xma__YA@mail.gmail.com>
 <CAHS8izNmSYumXpYXT1d8tAm36=-BRjXqdCDjLB6UNMwn5xhPZg@mail.gmail.com>
Date:   Wed, 5 Feb 2020 18:12:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHS8izNmSYumXpYXT1d8tAm36=-BRjXqdCDjLB6UNMwn5xhPZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20020512-0028-0000-0000-000003D79F6C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020512-0029-0000-0000-0000249BFDDC
Message-Id: <a980c9f7-2759-45a7-1add-89a390b79b39@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_03:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002050101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/02/20 4:03 am, Mina Almasry wrote:
> On Tue, Feb 4, 2020 at 12:36 PM Mina Almasry <almasrymina@google.com> wrote:
>>
>> So the problem in this log seems to be that this log line is missing:
>>     echo Waiting for hugetlb memory to reach size $size.
>>
>> The way the test works is that it starts a process that writes the
>> hugetlb memory, then it *should* wait until the memory is written,
>> then it should record the cgroup accounting and kill the process. It
>> seems from your log that the wait doesn't happen, so the test
>> continues before the background process has had time to write the
>> memory properly. Essentially wait_for_hugetlb_memory_to_get_written()
>> never gets called in your log.
>>
>> Can you try this additional attached diff on top of your changes? I
>> attached the diff and pasted the same here, hopefully one works for
>> you:
>> ...
> 
> I got my hands on a machine with 16MB default hugepage size and
> charge_reserved_hugetlb.sh passes now after my changes. Please let me
> know if you still run into issues.
> 

With your updates, the tests are passing. Ran the tests on a ppc64 system
that uses radix MMU (2MB hugepages) and everything passed there as well.

- Sandipan

