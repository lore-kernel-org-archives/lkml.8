Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E016CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B63EA206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DiwU5Jfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgHKDfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 23:35:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37828 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgHKDfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 23:35:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07B3Mjck101002;
        Tue, 11 Aug 2020 03:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=7J+8RG6Q669YoTmuH/gzYGPnIYh/D9j7aIwuS/6Ty0c=;
 b=DiwU5JfquMq8o5B42KiqAnwqPJJRsERg6VW9xTck9KjD5n6wq332VK827i9UPVzzWGw3
 q6rsOntlbHhqJxM65be6AeRg9Oc4yH0o71SwWhADzR5NXcMhwZ2b07jorbzXwepWVR4X
 joQitNd3JnLHRPN1Kia4sYAui9fImAjYqaVW8I0sVh4FZm0Toi1BWUJkXJbrFZTZbJB/
 eBHIkbdsagLRhenc2HBs87/YsBaiktB7GxObYe0bUXoY69m3L/hNlMcy+z3DrBB6ebi0
 V+aHwngQpsYN7ESEZVTP1/LJ5dBgxup5a6KA1VB9yZJGRFT/q2SMAb+aghpOx9/4coWv Pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32smpna4k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Aug 2020 03:35:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07B3NQ5Y172105;
        Tue, 11 Aug 2020 03:35:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 32u3h0sc6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Aug 2020 03:35:28 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07B3ZQDQ032316;
        Tue, 11 Aug 2020 03:35:26 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Aug 2020 03:35:26 +0000
Subject: Re: [PATCH v2 4/4] mm/hugetl.c: warn out if expected count of huge
 pages adjustment is not achieved
To:     Baoquan He <bhe@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, david@redhat.com,
        akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>
References: <20200723032248.24772-1-bhe@redhat.com>
 <20200723032248.24772-5-bhe@redhat.com>
 <62c8ce6c-fe98-f371-99b6-cfdb96d1c2fd@arm.com>
 <20200723091142.GR32539@MiWiFi-R3L-srv>
 <b94f4dc1-5c53-68ca-2023-0aa4de4df8b7@oracle.com>
 <20200811021152.GW14854@MiWiFi-R3L-srv>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <f659959f-47c5-93f0-ad84-48e53561b1e2@oracle.com>
Date:   Mon, 10 Aug 2020 20:35:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811021152.GW14854@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110022
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Michal

On 8/10/20 7:11 PM, Baoquan He wrote:
> Hi Mike,
> 
> On 07/23/20 at 11:21am, Mike Kravetz wrote:
>> On 7/23/20 2:11 AM, Baoquan He wrote:
> ...
>>>> But is kernel expected to warn for all such situations where the user
>>>> requested resources could not be allocated completely ? Otherwise, it
>>>> does not make sense to add an warning for just one such situation.
>>>
>>> It's not for just one such situation, we have already had one to warn
>>> out in mm/hugetlb.c, please check hugetlb_hstate_alloc_pages().
>>
>> Those are a little different in that they are warnings based on kernel
>> command line parameters.
>>
>>> As Mike said, in one time of persistent huge page number setting,
>>> comparing the old value with the new vlaue is good enough for customer
>>> to get the information. However, if customer want to detect and analyze
>>> previous setting failure, logging message will be helpful. So I think
>>> logging the failure or partial success makes sense.
>>
>> I can understand the argument against adding a new warning for this.
>> You could even argue that this condition has existed since the time
>> hugetlb was added to the kernel which was long ago.  And, nobody has
>> complained enough to add a warning.  I have even heard of a sysadmin
>> practice of asking for a ridiculously large amount of hugetlb pages
>> just so that the kernel will allocate as many as possible.  They do
>> not 'expect' to get the ridiculous amount they asked for.  In such
>> cases, this will be a new warning in their log.
>>
>> As mentioned in a previous e-mail, when one sets nr_hugepages by writing
>> to the sysfs or proc file, one needs to read the file to determine if the
>> number of requested pages were actually allocated.  Anyone who does not
>> do this is just asking for trouble.  Yet, I imagine that it may happen.
>>
>> To be honest, I do not see this log message as something that would be
>> helpful to end users.  Rather, I could see this as being useful to support
>> people.  Support always asks for system logs and this could point out a
>> possible issue with hugetlb usage.
>>
>> I do not feel strongly one way or another about adding the warning.  Since
>> it is fairly trivial and could help diagnose issues I am in favor of adding
>> it.  If people feel strongly that it should not be added, I am open to
>> those arguments.
> 
> Ping!
> 
> It's been a while, seems no objection to log the message. Do you
> consider accepting this patch or offering an Ack?
> 
> Thanks
> Baoquan

Adding Michal as he has had opinions about hugetlbfs log messages in the past.

-- 
Mike Kravetz
