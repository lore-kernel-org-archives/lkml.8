Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AE3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 00:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A5220829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 00:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VzNCGN/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbgGaAad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 20:30:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41872 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbgGaAad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 20:30:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06V0N6R2097227;
        Fri, 31 Jul 2020 00:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=e8NbgnfIfawl+5h9493v+Q+IJVod5c4QJ1ApMKOFxag=;
 b=VzNCGN/NNvaAM3aLs1F98yMpWokGwXo5GV/JemHOx/8RMlQFStmsv//PTXlFdEWZKSpf
 6RUQxRqqtsj2rl5WYgbR3pQl9rlNCoGDybgyz3sPvSbhezFfsXyDuh1qxGKGOPsz0ldI
 qQhj5rEpVsYsNpvjuB8Px3NSTo/5U+qoSZszTo5IienuH9A95kywSaUfapvseSQjvJtl
 MvkZSQztf0MzUlK77Chnd0jSU/68gZ1jJaU5oll2+cdtID0TvGUvEVhYQ5FF6BC/jMw8
 8oYi49O0M4tFuZWU5DHoaexmoUN8/stgDdKi29LNP9X1vH1/VvCOSoq3YGL/UGdXlCJD Zg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32hu1jpkre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Jul 2020 00:30:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06V0IqPh079582;
        Fri, 31 Jul 2020 00:28:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32hu5y4qtw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 00:28:21 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06V0SF79008146;
        Fri, 31 Jul 2020 00:28:15 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jul 2020 17:28:15 -0700
Subject: Re: [PATCH v2] mm/hugetlb: Fix calculation of
 adjust_range_if_pmd_sharing_possible
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20200730201636.74778-1-peterx@redhat.com>
 <4680014a-a328-b0c2-dc86-8c1eb4556f69@oracle.com>
 <20200730232656.GE3649@xz-x1.hitronhub.home>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5ce544da-4c94-cd42-2ab4-d4d76f3c139d@oracle.com>
Date:   Thu, 30 Jul 2020 17:28:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730232656.GE3649@xz-x1.hitronhub.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/20 4:26 PM, Peter Xu wrote:
> Hi, Mike,
> 
> On Thu, Jul 30, 2020 at 02:49:18PM -0700, Mike Kravetz wrote:
>> On 7/30/20 1:16 PM, Peter Xu wrote:
>>> This is found by code observation only.
>>>
>>> Firstly, the worst case scenario should assume the whole range was covered by
>>> pmd sharing.  The old algorithm might not work as expected for ranges
>>> like (1g-2m, 1g+2m), where the adjusted range should be (0, 1g+2m) but the
>>> expected range should be (0, 2g).
>>>
>>> Since at it, remove the loop since it should not be required.  With that, the
>>> new code should be faster too when the invalidating range is huge.
>>
>> Thanks Peter!
>>
>> That is certainly much simpler than the loop in current code.  You say there
>> are instances where old code 'might not work' for ranges like (1g-2m, 1g+2m).
>> Not sure I understand what you mean by adjusted and expected ranges in the
>> message.  Both are possible 'adjusted' ranges depending on vma size.
>>
>> Just trying to figure out if there is an actual problem in the existing code
>> that needs to be fixed in stable.  I think the existing code is correct, just
>> inefficient.
> 
> Thanks for the quick review!
> 
> I'm not sure whether that will cause a real problem, but iiuc in my previous
> example of (1g-2m, 1g+2m) in the commit message, the old code will extend the
> range to (0, 1g+2m).  In this case, if unluckily the (1g, 2g) range is a pud
> with shared pmd, then imho we face the risk of partial tlb flushing with the
> old code, because it will only flush tlb for range (0, 1g+2m) but not (0, 2g).
> If that's the case, maybe it worths cc stable.
> 
> Anyway, I'd like to double confirm with you in case I missed something.

You are correct.  With range (1g-2m, 1g+2m) within a vma (0, 2g) the existing
code will only adjust to (0, 1g+2m) which is incorrect.

We should cc stable.  The original reason for adjusting the range was to
prevent data corruption (getting wrong page).  Since the range is not always
adjusted correctly, the potential for corruption still exists.

However, I am fairly confident that adjust_range_if_pmd_sharing_possible is
only gong to be called in two cases:
1) for a single page
2) for range == entire vma
In those cases, the current code should produce the correct results.

To be safe, let's just cc stable.

Also,
Fixes: 017b1660df89 ("mm: migration: fix migration of huge PMD shared pages")
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
