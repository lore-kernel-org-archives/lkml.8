Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8C5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB162067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgGHK6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:58:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726110AbgGHK6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 06:58:08 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 068AYSIa193645;
        Wed, 8 Jul 2020 06:57:24 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3256x5a8nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 06:57:24 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 068AYUP6193911;
        Wed, 8 Jul 2020 06:57:24 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3256x5a8nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 06:57:24 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 068AsS43006562;
        Wed, 8 Jul 2020 10:57:23 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma05wdc.us.ibm.com with ESMTP id 324yf9w1hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 10:57:23 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 068AvNOj41943408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jul 2020 10:57:23 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2507828059;
        Wed,  8 Jul 2020 10:57:23 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F23328058;
        Wed,  8 Jul 2020 10:57:19 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.102.2.253])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Jul 2020 10:57:19 +0000 (GMT)
X-Mailer: emacs 27.0.91 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        Joonsoo Kim <js1304@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 04/11] mm/hugetlb: make hugetlb migration callback
 CMA aware
In-Reply-To: <8549326e-7485-dd6d-1fa1-a899228b9b2f@suse.cz>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-5-git-send-email-iamjoonsoo.kim@lge.com>
 <c1cd6e11-08c3-5654-60e7-dec2eb80987a@suse.cz>
 <20200708071602.GB16543@js1304-desktop>
 <20200708074103.GD7271@dhcp22.suse.cz>
 <8549326e-7485-dd6d-1fa1-a899228b9b2f@suse.cz>
Date:   Wed, 08 Jul 2020 16:27:16 +0530
Message-ID: <87h7uil1f7.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_07:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 cotscore=-2147483648
 adultscore=0 phishscore=0 impostorscore=0 clxscore=1011 mlxlogscore=906
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007080073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vlastimil Babka <vbabka@suse.cz> writes:

> On 7/8/20 9:41 AM, Michal Hocko wrote:
>> On Wed 08-07-20 16:16:02, Joonsoo Kim wrote:
>>> On Tue, Jul 07, 2020 at 01:22:31PM +0200, Vlastimil Babka wrote:
>>> 
>>> Simply, I call memalloc_nocma_{save,restore} in new_non_cma_page(). It
>>> would not cause any problem.
>> 
>> I believe a proper fix is the following. The scope is really defined for
>> FOLL_LONGTERM pins and pushing it inside check_and_migrate_cma_pages
>> will solve the problem as well but it imho makes more sense to do it in
>> the caller the same way we do for any others. 
>> 
>> Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pages allocated from CMA region")
>
> Agreed.
>
>> 
>> I am not sure this is worth backporting to stable yet.
>
> CC Aneesh.
>
> Context: since check_and_migrate_cma_pages() calls __get_user_pages_locked(), it
> should also be called under memalloc_nocma_save().

But by then we faulted in all relevant pages and migrated them out of
CMA rea right?


>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index de9e36262ccb..75980dd5a2fc 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -1794,7 +1794,6 @@ static long __gup_longterm_locked(struct task_struct *tsk,
>>  				     vmas_tmp, NULL, gup_flags);
>>  
>>  	if (gup_flags & FOLL_LONGTERM) {
>> -		memalloc_nocma_restore(flags);
>>  		if (rc < 0)
>>  			goto out;
>>  
>> @@ -1802,11 +1801,13 @@ static long __gup_longterm_locked(struct task_struct *tsk,
>>  			for (i = 0; i < rc; i++)
>>  				put_page(pages[i]);
>>  			rc = -EOPNOTSUPP;
>> +			memalloc_nocma_restore(flags);
>>  			goto out;
>>  		}
>>  
>>  		rc = check_and_migrate_cma_pages(tsk, mm, start, rc, pages,
>>  						 vmas_tmp, gup_flags);
>> +		memalloc_nocma_restore(flags);
>>  	}
>>  
>>  out:
>> 

-aneesh
