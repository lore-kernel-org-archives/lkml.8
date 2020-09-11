Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45F0C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DAD6204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mAZoUcPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgIKQa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:30:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726582AbgIKQ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:27:58 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BG3HqN079345;
        Fri, 11 Sep 2020 12:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hQ8tKUNZK1sTHpyRCmfC9l3HjePpn6HZgloH/5VYvhw=;
 b=mAZoUcPVl9YgvpuSq/43wxbwBUUSFuRORpunVEe+lHTsJf9JDRMAp6SJbvoWIYnI19TS
 dZPVJ1PNFmtCKfPXs/tptTK/50VhwrKOsL8Dt8MbFy66cYC8zI8gKGCkbla40PJ1lwpJ
 IOLZsG3/o6eR05rjtBp+oBVO8i8x0QcjyVS32YoDn/9zWWvb/vuuFVeUKWwwd8rU9QGd
 AfKUHfvXaUF88DSCnGKbIfP3MCc2ueIOxkmOdfGNhAL7CyTTnqUCvYGI68Hmp/UugqJK
 ZmnEyET2GAKLJcCrbABMAGq5qFEc+isDQLpiiUR7odny2fD3EmuM8fVp+al0OLZ4ociv HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33gc8hh1eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 12:27:48 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08BG47w9085974;
        Fri, 11 Sep 2020 12:27:48 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33gc8hh1d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 12:27:48 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BGNRHN027256;
        Fri, 11 Sep 2020 16:27:46 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 33e5gmt8q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 16:27:45 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08BGQ9Hs59113834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 16:26:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C807511C052;
        Fri, 11 Sep 2020 16:27:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1088011C04A;
        Fri, 11 Sep 2020 16:27:42 +0000 (GMT)
Received: from pomme.local (unknown [9.145.47.39])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Sep 2020 16:27:41 +0000 (GMT)
Subject: Re: [PATCH 3/3] mm: don't panic when links can't be created in sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     akpm@linux-foundation.org, David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>, mhocko@kernel.org,
        linux-mm@kvack.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        nathanl@linux.ibm.com, cheloha@linux.ibm.com,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200911134831.53258-1-ldufour@linux.ibm.com>
 <20200911134831.53258-4-ldufour@linux.ibm.com>
 <20200911140100.GA3812164@kroah.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Message-ID: <3713153c-d239-e6f9-fc1a-a3e4357ee069@linux.ibm.com>
Date:   Fri, 11 Sep 2020 18:27:41 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911140100.GA3812164@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_08:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 11/09/2020 à 16:01, Greg Kroah-Hartman a écrit :
> On Fri, Sep 11, 2020 at 03:48:31PM +0200, Laurent Dufour wrote:
>> At boot time, or when doing memory hot-add operations, if the links in
>> sysfs can't be created, the system is still able to run, so just report the
>> error in the kernel log.
>>
>> Since the number of memory blocks managed could be high, the messages are
>> rate limited.
>>
>> As a consequence, link_mem_sections() has no status to report anymore.
>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> ---
>>   drivers/base/node.c  | 25 +++++++++++++++++--------
>>   include/linux/node.h | 17 ++++++++---------
>>   mm/memory_hotplug.c  |  5 ++---
>>   3 files changed, 27 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index 862516c5a5ae..749a1c8ea992 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -811,12 +811,21 @@ static int register_mem_sect_under_node(struct memory_block *mem_blk,
>>   		ret = sysfs_create_link_nowarn(&node_devices[nid]->dev.kobj,
>>   					&mem_blk->dev.kobj,
>>   					kobject_name(&mem_blk->dev.kobj));
>> -		if (ret)
>> -			return ret;
>> +		if (ret && ret != -EEXIST)
>> +			pr_err_ratelimited(
>> +				"can't create %s to %s link in sysfs (%d)\n",
>> +				kobject_name(&node_devices[nid]->dev.kobj),
>> +				kobject_name(&mem_blk->dev.kobj), ret);
> 
> dev_err_ratelimited()?

Thanks Greg, I was not aware about this.

> Same elsewhere in this patch.
> 
> thanks,
> 
> greg k-h
> 

