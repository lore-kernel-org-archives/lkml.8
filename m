Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06D2C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A820622204
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PQxQZ0JS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIKQYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:24:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726252AbgIKQXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:23:16 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BG37l7037897;
        Fri, 11 Sep 2020 12:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lOnrFIuEaE/pDiC6n1rHdJwCuxXfzojQQVwHfi0mask=;
 b=PQxQZ0JSl2AM7fUeedp6YI8bgfEO9wrdeYcMybbhc2z3RvRTDmByCAzYN4R5RU30V9cz
 xXH/oQIyvY+rHHxv7iCVZ1P4W+vL6Sf4A4e5SIOO3iRRb8LRXseg8RUWRg28TbU9N0SI
 2B01ysIprxD2ifbGkgdIWJOCg5Uhb+3sP46PpeAQSWSwjGycf48vQ1KS3zpTNI9y2s0v
 mMfTwM7Ub/Dw5/gxJcpYkEqeVVGuSKMYw1z6u26I39qy/7pg3RlP4I/eWNkssKPRzJCR
 pP7ZJBHc4Ogmll7zSfe84084/ZbO5hbMJ187sbr7iwfrbc07anaD/dMYo11LFjfW6FyA TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33gc820u4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 12:23:07 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08BGI7ip092466;
        Fri, 11 Sep 2020 12:23:06 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33gc820u3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 12:23:06 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BGMnk7032383;
        Fri, 11 Sep 2020 16:23:04 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 33c2a8fdpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 16:23:04 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08BGN1fA53608874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 16:23:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BF4311C052;
        Fri, 11 Sep 2020 16:23:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F87B11C04A;
        Fri, 11 Sep 2020 16:23:00 +0000 (GMT)
Received: from pomme.local (unknown [9.145.47.39])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Sep 2020 16:23:00 +0000 (GMT)
Subject: Re: [PATCH 1/3] mm: replace memmap_context by memplug_context
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        Oscar Salvador <osalvador@suse.de>, mhocko@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mm@kvack.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        nathanl@linux.ibm.com, cheloha@linux.ibm.com,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200911134831.53258-1-ldufour@linux.ibm.com>
 <20200911134831.53258-2-ldufour@linux.ibm.com>
 <09528ef5-29fd-056d-4e58-fc13e55f418f@redhat.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Message-ID: <6552ef9a-ac02-e79f-2eb6-08380ba4b478@linux.ibm.com>
Date:   Fri, 11 Sep 2020 18:23:00 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <09528ef5-29fd-056d-4e58-fc13e55f418f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_08:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 11/09/2020 à 16:59, David Hildenbrand a écrit :
>>   		struct page *start;
>>   		struct memmap_init_callback_data args;
>> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
>> index 375515803cd8..cd2bd21d3a4d 100644
>> --- a/include/linux/memory_hotplug.h
>> +++ b/include/linux/memory_hotplug.h
>> @@ -15,6 +15,15 @@ struct memory_block;
>>   struct resource;
>>   struct vmem_altmap;
>>   
>> +/*
>> + * Memory plugin context, use to differentiate memory added at boot time and
> 
> "Memory plugin context" sounds weird.

Any suggestion ?

>> + * hot-plugged memory.
>> + */
>> +enum memplug_context {
>> +	MEMPLUG_EARLY,
>> +	MEMPLUG_HOTPLUG,
>> +};
> 
> Not fully sure this is the right place, though. memory_hotplug.h is
> about MEMPLUG_HOTPLUG only ... I'd leave it at the old spot.

Fair enough.

