Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26046C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00EE4218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wiQ1w0Y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgEGR2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:28:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46044 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgEGR2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:28:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047HRhk9088401;
        Thu, 7 May 2020 17:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=KEw0jB4mu0JbwkEdmOt9aiMeM3LJb3HoOgTnR5MijrI=;
 b=wiQ1w0Y6QiwmaWoz2lxTL09p6pVFMUiCX14mjp/3mO/q97r0ExDqmsilY8TUgrbnYgCm
 dCJvlGa5Ca5FFZr8fs/7SBQAtYotbPFmw46Bxdjewn2hWucJxFIwjbOOCZ29evDTyANA
 7lsVsWLK9+jqNFZ0kp6VfTIKzF0ieuUPhGUjmXsvVZP8aJ93BGjNEan+ndATkxJ6x2ib
 C87gXIanoccW6CmJDXMofRV0FmVys4CzMpGIcdk4j8Kz/px6WQ7ipWs3koyrq1BJy3RV
 FXfuYg51UmoB4xFX99xSDcacFXZGE+0JtmBsiU6Sjt7TGWrK73sXMvDs6VhplyVMyo5e xQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30vhvyhucu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 17:28:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047HHnfm193355;
        Thu, 7 May 2020 17:26:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30t1rb492u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 17:26:35 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 047HQYYh014236;
        Thu, 7 May 2020 17:26:34 GMT
Received: from [192.168.1.33] (/70.114.128.235)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 May 2020 10:26:34 -0700
Subject: Re: [PATCH] MAINTAINER: Update my email address
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
References: <20200507161229.31448-1-himanshu.madhani@oracle.com>
 <f83a2eb7013d203eab4be27f27ca0d996bbc5b47.camel@perches.com>
 <0c9af33d-0101-119b-4512-7838a0e0e9a0@oracle.com>
 <acb0794c5ba71b4d6ddc0b6a71252a4dfbfd497d.camel@perches.com>
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
Message-ID: <a6524759-ac3d-836b-0e81-02037c8b4f94@oracle.com>
Date:   Thu, 7 May 2020 12:26:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <acb0794c5ba71b4d6ddc0b6a71252a4dfbfd497d.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/7/20 12:23 PM, Joe Perches wrote:
> On Thu, 2020-05-07 at 12:08 -0500, himanshu.madhani@oracle.com wrote:
>> On 5/7/20 11:57 AM, Joe Perches wrote:
>>> On Thu, 2020-05-07 at 11:12 -0500, Himanshu Madhani wrote:
>>>> I do not have access to my @marvell.com email ID anymore.
>>>> Lets map my new email address correctly in .mailmap
>>> Bad patch subject, this is a .mailmap patch.
>>>
>>> Maybe [PATCH] .mailmap: Update address of Himanshu Madhani
>>>
>> Okay. Thanks for pointing that out. I noticed that most of the patches
>> submitted for .mailmap had MAINTAINER in there so i used that. I will
>> repost with updated patch subject.
> That's because those patches also generally update MAINTAINERS
> entries and update .mailmap at the same time.
Agree.  sent v2 with correct patch subject.
> cheers, Joe
>
>>>> Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
>>>> ---
>>>>    .mailmap | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/.mailmap b/.mailmap
>>>> index db3754a41018..30d8c3f10ca7 100644
>>>> --- a/.mailmap
>>>> +++ b/.mailmap
>>>> @@ -99,6 +99,8 @@ Henk Vergonet <Henk.Vergonet@gmail.com>
>>>>    Henrik Kretzschmar <henne@nachtwindheim.de>
>>>>    Henrik Rydberg <rydberg@bitmath.org>
>>>>    Herbert Xu <herbert@gondor.apana.org.au>
>>>> +Himanshu Madhani <himanshu.madhani@oracle.com>
>>>> +Himanshu Madhani <hmadhani2024@gmail.com>
>>>>    Jacob Shin <Jacob.Shin@amd.com>
>>>>    Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@google.com>
>>>>    Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@motorola.com>
