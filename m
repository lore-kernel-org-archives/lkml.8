Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFF5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6ECB2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="v7Bdhpsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbgGaOh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 10:37:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47332 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbgGaOh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 10:37:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VEWxWX101171;
        Fri, 31 Jul 2020 14:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=CAU59/Kk3uhijA2RVgiAR8MuGY+ZYGPMzuMEOUcZW+4=;
 b=v7BdhpsmdCNuxfnY84aZtqzeqcJYGo3V6ueX/pIfXVVOAIFefyBTjSpT1+51u9UTxIdY
 GKEWOGF7arC+0EtKwGCNF6Dp1Pg5SdvmXExp2LXwJXZJwdSKWwLFqTmUt41Hj84YwOPs
 32z59sx/KHpBBRrxSrIRzm6VADcbgrgvQi/PxZ0xnQCDVQIAOUAsgVv8k4K/p15EWvuA
 Xf8ERRwQGLnwwxNWXNWhG1CX9nqe5V0MaX9D3F1lxW8YwL++UvpAaWxskhv9LE5s4XBh
 NUxYeKM5EvVrIJ+vECrLAJJ9/SHnyk3g+GwmqG1BX58fEOL/iP2cvZb+4Zo97o3D9Etd UA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32hu1jsd5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Jul 2020 14:37:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VETVl1180878;
        Fri, 31 Jul 2020 14:35:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 32hu5ytype-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 14:35:53 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06VEZqfS031989;
        Fri, 31 Jul 2020 14:35:52 GMT
Received: from [192.168.1.126] (/47.220.71.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 Jul 2020 07:35:52 -0700
Subject: Re: [PATCH v2: [linux-4.14.y] ] dm cache: submit writethrough writes
 in parallel to origin and cache
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <48659508-86e7-8107-75db-584b2896ad48@oracle.com>
 <20200731065431.GB1518178@kroah.com>
From:   John Donnelly <john.p.donnelly@oracle.com>
Message-ID: <09b4fc22-2eef-1fff-a505-e3ead74474b9@oracle.com>
Date:   Fri, 31 Jul 2020 09:35:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731065431.GB1518178@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/20 1:54 AM, Greg KH wrote:
> On Thu, Jul 30, 2020 at 03:33:42PM -0500, John Donnelly wrote:
>> From: Mike Snitzer <snitzer@redhat.com>
>>
>> Discontinue issuing writethrough write IO in series to the origin and
>> then cache.
>>
>> Use bio_clone_fast() to create a new origin clone bio that will be
>> mapped to the origin device and then bio_chain() it to the bio that gets
>> remapped to the cache device.  The origin clone bio does _not_ have a
>> copy of the per_bio_data -- as such check_if_tick_bio_needed() will not
>> be called.
>>
>> The cache bio (parent bio) will not complete until the origin bio has
>> completed -- this fulfills bio_clone_fast()'s requirements as well as
>> the requirement to not complete the original IO until the write IO has
>> completed to both the origin and cache device.
>>
>> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
>>
>> (cherry picked from commit 2df3bae9a6543e90042291707b8db0cbfbae9ee9)
>>
>> Fixes: 4ec34f2196d125ff781170ddc6c3058c08ec5e73 (dm bio record:
>> save/restore bi_end_io and bi_integrity )
>>
>> 4ec34f21 introduced a mkfs.ext4 hang on a LVM device that has been
>> modified with lvconvert --cachemode=writethrough.
>>
>> CC:stable@vger.kernel.org for 4.14.x .
>>
>> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
>> Reviewed-by: Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>
>>
>> conflicts:
>> 	drivers/md/dm-cache-target.c. -  Corrected usage of
>> 	writethrough_mode(&cache->feature) that was caught by
>> 	compiler, and removed unused static functions : writethrough_endio(),
>> 	defer_writethrough_bio(), wake_deferred_writethrough_worker()
>> 	that generated warnings.
>> ---
>>   drivers/md/dm-cache-target.c | 94
>> ++++++++++++++++++--------------------------
> 
> Line wrapped?

  ummm .. that is weird

> 
>>   1 file changed, 38 insertions(+), 56 deletions(-)
>>
>> diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
>> index 69cdb29ef6be..2d9566bfe08b 100644
>> --- a/drivers/md/dm-cache-target.c
>> +++ b/drivers/md/dm-cache-target.c
>> @@ -1,5 +1,5 @@
>>   /*
>> - * Copyright (C) 2012 Red Hat. All rights reserved.
>> + i Copyright (C) 2012 Red Hat. All rights reserved.
> 
> What happened here?

  spurious character from vi ;-(

> 
> This patch can't be applied as-is :(
> 
> greg k-h
> 

  I will repost next week Thank you.

