Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E42C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA5F2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0B8t2y3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEGRK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:10:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56230 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgEGRKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:10:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047H9IOI108015;
        Thu, 7 May 2020 17:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=gG7bTjTjoKjY+icodWWOFFLzhIbaSy9a5HaoBRsqp/0=;
 b=0B8t2y3E0cZ3XiC/BPwBUekhM1lZ0E2gKdor1s37pc5iO/I/1pxzMpKIQV1ZgbqfqWc6
 7Px6CLEC4ZeLJk6aAO7jKLhaWA7vgS2Pj7eTpMTRfSrkFWPWNW8G2sAM8PVOlya+Ts85
 L2aYr6wsnDuVio2T3nXt+DH+EEKGQiAd4ugvO8hv88OL00yqJTSuDkFjsHzYLGwNQFqz
 IVRhk6UavVaRzWg0VToFtaaVWLVaFiPsqYYqWw1m8cTSR45zrZDoXZk04K5d2QRkS71b
 JoUwKhTZpsur5WbQQlMSedQQ6ujBxl0id0ZeCNCJJVL+yT86BP80M94nHoiAeDHEJJdd pQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30usgq8he7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 17:10:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047H6uiO179434;
        Thu, 7 May 2020 17:08:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30sjdyh0rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 17:08:19 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 047H8IDp003236;
        Thu, 7 May 2020 17:08:18 GMT
Received: from [192.168.1.24] (/70.114.128.235)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 May 2020 10:08:18 -0700
Subject: Re: [PATCH] MAINTAINER: Update my email address
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
References: <20200507161229.31448-1-himanshu.madhani@oracle.com>
 <f83a2eb7013d203eab4be27f27ca0d996bbc5b47.camel@perches.com>
From:   himanshu.madhani@oracle.com
Organization: Oracle Corporation
Message-ID: <0c9af33d-0101-119b-4512-7838a0e0e9a0@oracle.com>
Date:   Thu, 7 May 2020 12:08:17 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f83a2eb7013d203eab4be27f27ca0d996bbc5b47.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/20 11:57 AM, Joe Perches wrote:
> On Thu, 2020-05-07 at 11:12 -0500, Himanshu Madhani wrote:
>> I do not have access to my @marvell.com email ID anymore.
>> Lets map my new email address correctly in .mailmap
> 
> Bad patch subject, this is a .mailmap patch.
> 
> Maybe [PATCH] .mailmap: Update address of Himanshu Madhani
> 

Okay. Thanks for pointing that out. I noticed that most of the patches 
submitted for .mailmap had MAINTAINER in there so i used that. I will 
repost with updated patch subject.

>> Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
>> ---
>>   .mailmap | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/.mailmap b/.mailmap
>> index db3754a41018..30d8c3f10ca7 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -99,6 +99,8 @@ Henk Vergonet <Henk.Vergonet@gmail.com>
>>   Henrik Kretzschmar <henne@nachtwindheim.de>
>>   Henrik Rydberg <rydberg@bitmath.org>
>>   Herbert Xu <herbert@gondor.apana.org.au>
>> +Himanshu Madhani <himanshu.madhani@oracle.com>
>> +Himanshu Madhani <hmadhani2024@gmail.com>
>>   Jacob Shin <Jacob.Shin@amd.com>
>>   Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@google.com>
>>   Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@motorola.com>
> 

-- 
Himanshu Madhani
Oracle Linux Engineering
