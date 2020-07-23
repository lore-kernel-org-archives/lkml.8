Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B0EC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B6F207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SRtxdB2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgGWSYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:24:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58418 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgGWSYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 14:24:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06NIGb1l045079;
        Thu, 23 Jul 2020 18:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ASJIFeVb4/jzzyTZ/kIiW0l+JRFXzYz6cYGbV8kdkbY=;
 b=SRtxdB2HJDb5fxt2abqDOerQ07hw8EfNxsfknJp8KN5s4J9EOWHwnEBu38Mvaaz7Di9P
 luSXSFhJCpetitzFng81kp+wyNUlwgyHO0PhAex0rkzGYnfcN5RAiseNIUjrbf8Oh5QV
 Givwr7mznDDyIrErSsFdJ30M9UKXFfZEs6LUEjHdTwXnIHAHVmeqERVkez0tqexxZTlD
 buFEjr7Y0fDq4HwTVGDXxJUXpkmte8mXpr0QOxCdEu8bHcL2dfiDVRwguRzjsb8gHKn1
 PdSEWSRtvaQlHKtiahDimjRDgG9RDNDny/vEtsbFz5maW0ScEmJbiUm1uAi1T1ajL8lN Mw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32brgru446-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jul 2020 18:23:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06NIIMJb190971;
        Thu, 23 Jul 2020 18:21:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 32fc0b2up5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 18:21:55 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06NILsC0025625;
        Thu, 23 Jul 2020 18:21:54 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jul 2020 11:21:54 -0700
Subject: Re: [PATCH v2 4/4] mm/hugetl.c: warn out if expected count of huge
 pages adjustment is not achieved
To:     Baoquan He <bhe@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, david@redhat.com,
        akpm@linux-foundation.org
References: <20200723032248.24772-1-bhe@redhat.com>
 <20200723032248.24772-5-bhe@redhat.com>
 <62c8ce6c-fe98-f371-99b6-cfdb96d1c2fd@arm.com>
 <20200723091142.GR32539@MiWiFi-R3L-srv>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b94f4dc1-5c53-68ca-2023-0aa4de4df8b7@oracle.com>
Date:   Thu, 23 Jul 2020 11:21:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200723091142.GR32539@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9691 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007230133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9691 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007230133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/20 2:11 AM, Baoquan He wrote:
> On 07/23/20 at 11:46am, Anshuman Khandual wrote:
>>
>>
>> On 07/23/2020 08:52 AM, Baoquan He wrote:
>>> A customer complained that no message is logged wh	en the number of
>>> persistent huge pages is not changed to the exact value written to
>>> the sysfs or proc nr_hugepages file.
>>>
>>> In the current code, a best effort is made to satisfy requests made
>>> via the nr_hugepages file.  However, requests may be only partially
>>> satisfied.
>>>
>>> Log a message if the code was unsuccessful in fully satisfying a
>>> request. This includes both increasing and decreasing the number
>>> of persistent huge pages.
>>
>> But is kernel expected to warn for all such situations where the user
>> requested resources could not be allocated completely ? Otherwise, it
>> does not make sense to add an warning for just one such situation.
> 
> It's not for just one such situation, we have already had one to warn
> out in mm/hugetlb.c, please check hugetlb_hstate_alloc_pages().

Those are a little different in that they are warnings based on kernel
command line parameters.

> As Mike said, in one time of persistent huge page number setting,
> comparing the old value with the new vlaue is good enough for customer
> to get the information. However, if customer want to detect and analyze
> previous setting failure, logging message will be helpful. So I think
> logging the failure or partial success makes sense.

I can understand the argument against adding a new warning for this.
You could even argue that this condition has existed since the time
hugetlb was added to the kernel which was long ago.  And, nobody has
complained enough to add a warning.  I have even heard of a sysadmin
practice of asking for a ridiculously large amount of hugetlb pages
just so that the kernel will allocate as many as possible.  They do
not 'expect' to get the ridiculous amount they asked for.  In such
cases, this will be a new warning in their log.

As mentioned in a previous e-mail, when one sets nr_hugepages by writing
to the sysfs or proc file, one needs to read the file to determine if the
number of requested pages were actually allocated.  Anyone who does not
do this is just asking for trouble.  Yet, I imagine that it may happen.

To be honest, I do not see this log message as something that would be
helpful to end users.  Rather, I could see this as being useful to support
people.  Support always asks for system logs and this could point out a
possible issue with hugetlb usage.

I do not feel strongly one way or another about adding the warning.  Since
it is fairly trivial and could help diagnose issues I am in favor of adding
it.  If people feel strongly that it should not be added, I am open to
those arguments.
-- 
Mike Kravetz
