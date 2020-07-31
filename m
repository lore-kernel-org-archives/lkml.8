Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8201CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 06:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C52D207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 06:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0hNTk18A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731454AbgGaG6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 02:58:05 -0400
Received: from mail-co1nam11on2050.outbound.protection.outlook.com ([40.107.220.50]:44033
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731375AbgGaG6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 02:58:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNAgaY73+tJhoQfO78OFh0IT8dl21MNe+6lixvu+Q7zcjvz+MMYcf1WYEcYVZ3wgfHWRHF4TL8Pl0L0PbWKKLI9Vly0TfoXYXBYVyY5DraCtyaI6KVs9VHJzkP6hY0IFiK/9/9vWHNSGD26+CUJAuS8+eBPs2VGV+bfZVCymSMchNLae6C9SBAtr9S4zUJGRXDIaKMj5PVzdPYbk75AyMSDt6bzaJCxYict4HYa16Dowk0A5A/JBLCoe1ImX1aomo1F7pzCkzWVDbbzHFThPi2/6i0m/bTkoXqZ4I9SQfmasHedCwnuQmuwFMjHBYKNwLhjQC+ljv8dZCWkuxnnKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiGJwtdPGT/hh1eIRZDNKFNn8IjlOFp2g6vBWdKnsBY=;
 b=TaHqAHmZR/Cgid83/IMjaik9zcGzAeozsjL58hfGbrFhLLCAudoLEkiB1a4wBPnpg3gvqj9JwgMo2GHuyV7HSr27Ps26hmaAVJoQiHsfjHxFwXL/r12uju1e+3nACXHXX/kXAuM3xnRg/9p0YT8I6Qbkht7ANy9a8842L4dsumCZwAB+5JlFQZZ6S95gMsONm4KecS2JYE+OIKfSP43V4X/MxWcS6g4eZTBR9A7Po9Is9LV1hQhA7qIB4GEUuy+XXmEmdvKgtsjGdp3ynIKDdjKBL2l80eocTDBGLApZvd/dWU/pjaBxMF30newvgAEmceKRzUlBjADf/+DMniUmwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiGJwtdPGT/hh1eIRZDNKFNn8IjlOFp2g6vBWdKnsBY=;
 b=0hNTk18Af7vdcGVK87s6rqP5XNvzW8bXGKf9ID7SdPidV/8Lr8q6MM7uLu327bLA970/FeWXIZ+uYblSmnm8rbruF5vEVNh/oyNHK+wZnQm12VR19gjROMuTrFiPUV1YgFRkEhd8rloWFlhqGayLzocV+yKtQ/H33qQRbcKamBY=
Authentication-Results: lists.linuxfoundation.org; dkim=none (message not
 signed) header.d=none;lists.linuxfoundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Fri, 31 Jul
 2020 06:58:01 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 06:58:01 +0000
Subject: Re: [Linux-kernel-mentees] [PATCH] drm/amdgpu: Prevent
 kernel-infoleak in amdgpu_info_ioctl()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luben Tuikov <luben.tuikov@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Xiaojie Yuan <xiaojie.yuan@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
        Hans de Goede <hdegoede@redhat.com>, Trek <trek00@inbox.ru>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>, Leo Liu <leo.liu@amd.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20200728192924.441570-1-yepeilin.cs@gmail.com>
 <30b2a31f-77c2-56c1-ecde-875c6eea99d5@gmail.com>
 <CADnq5_NXOiAc7q5gQqF_wwtJD1o6nHjXM4O3gY6EwAQe9iOtXw@mail.gmail.com>
 <8c5cf518-12d2-7495-7822-c7ebf8e61972@amd.com>
 <20200731065322.GA1518178@kroah.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <690213fd-d3d2-2253-dcb2-367a65b34f38@amd.com>
Date:   Fri, 31 Jul 2020 08:57:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200731065322.GA1518178@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0145.eurprd05.prod.outlook.com
 (2603:10a6:207:3::23) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM3PR05CA0145.eurprd05.prod.outlook.com (2603:10a6:207:3::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 06:57:58 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d729d82f-a85e-4670-7983-08d8351f1070
X-MS-TrafficTypeDiagnostic: MN2PR12MB4253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4253ADC9EAA0C67BE4A3A0BD834E0@MN2PR12MB4253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/R+ORIk3Lh7K50Msjj8z7g1kDpZfBdn7jT7ufslLalIPfSOeprtQsjYWTacVkoAI2KMPyu1EXrATGTT3VKbLzjtqXOUXKww7+hmH903VamgQKr0g8LlPrCNIRmeFc4XZqMxIXkBgJeb8WQue9Q4SxIyN7O4/1+c49u4tv9TnGhQElFh0UO2SepcNBc7XHqHQ7pUxHD1+jVreLvLuxFVpxI0WbTixeLzaLTSkKUgRop+gwK2QFKujOTwTXc2z7X2XIBskhbOtrcW2eLrVaCW4xgjqjzxjHjvCIjx891/kOwuRxheFcT1xyrUGCflx08bZlaBuygEkSkHq0E3uG9SJAUabyAlLgibLUWUvjif1KXsmoc0dV4vZsQTD3+FqQJ4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(478600001)(83380400001)(2906002)(2616005)(6636002)(8936002)(8676002)(31686004)(7416002)(4326008)(31696002)(5660300002)(52116002)(6486002)(316002)(66556008)(66476007)(86362001)(66946007)(54906003)(110136005)(36756003)(6666004)(53546011)(16526019)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4qYWsVXA6Y8X9JWufzUJ8Y/Mzo1l6rjXh0YIKnZFXHuYqU9KMMdwkzz8wmYLBQqAfyWNhnUU819ApE+fER41zbK0KdQaA2uIHQG1egCtyKrRzACoyJ4rj6W+tImbguz99/zmZkXHvgLlxq465axLcXLwAKOb/sbMPLOpqaSJubipvvZyq/qoK5Fpcg5mi4UHukaKGzWRWd2p8CZ1cmAXBLMNPAxAdhzeqZ/rtITW4OMa6rxzFtsrwdT7G9HRbl9dN2gEYtNW4QismAGxWKllbYsYFgiJ8hCfKfXnYLab6rVur1qN47L4K8/gyqGk+s9Wv7bSrLyjPQjYobg4mAIQ50miSudVz/AnR6LWaqy3r/QmB9NE2MVm8we3fZi/iy1YG7YoPYISJOIVwZETzAcBjoLkiHlf5FUbbwVKsIJvX7VBU1KLTaS+M2FMMW3EBtWH7QmlAsbYqnBxX6OFAJhP2/HiQ7yTYZ2Hz0ejng8nk95xKSMZRjSiFDrnISaD1d5rjPQhJdzx2Jb94JOlmyiW3e5iquC8j/vSxDOMJWuQoy09Toe+/uIR0KclDO+fp4rjSE5xJMdNvXCg19uJrpY5Zc4E1fuR2lQUoyOB+0k7kTBVszPQDAUVZbzuai4yeIMt5/4Vo1blwYah69PpJVddN09x/ReJwNITGaKTGiviOP7oUhPw3HBLgB9TX6YvfcVYpo9ygpDJ+FujFoKZkDPrUg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d729d82f-a85e-4670-7983-08d8351f1070
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 06:58:01.5226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6UtAKS1hfGcILrXzOJZ0IGwwmbn0dXmpupQBIfWkWnsZlC8xFKh8dvCB3W1b9wu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 31.07.20 um 08:53 schrieb Greg Kroah-Hartman:
> On Thu, Jul 30, 2020 at 05:09:07PM -0400, Luben Tuikov wrote:
>> On 2020-07-29 9:49 a.m., Alex Deucher wrote:
>>> On Wed, Jul 29, 2020 at 4:11 AM Christian König
>>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>>> Am 28.07.20 um 21:29 schrieb Peilin Ye:
>>>>> Compiler leaves a 4-byte hole near the end of `dev_info`, causing
>>>>> amdgpu_info_ioctl() to copy uninitialized kernel stack memory to userspace
>>>>> when `size` is greater than 356.
>>>>>
>>>>> In 2015 we tried to fix this issue by doing `= {};` on `dev_info`, which
>>>>> unfortunately does not initialize that 4-byte hole. Fix it by using
>>>>> memset() instead.
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Fixes: c193fa91b918 ("drm/amdgpu: information leak in amdgpu_info_ioctl()")
>>>>> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
>>>>> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>>> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>>
>>>> I can't count how many of those we have fixed over the years.
>>>>
>>>> At some point we should probably document that using "= {}" or "= { 0 }"
>>>> in the kernel is a really bad idea and should be avoided.
>>> Moreover, it seems like different compilers seem to behave relatively
>>> differently with these and we often get reports of warnings with these
>>> on clang.  When in doubt, memset.
>> There are quite a few of those under drivers/gpu/drm, for "amd/", "scheduler/"
>> drm*.c files,
>>
>> $find . \( -regex "./drm.*\.c" -or -regex "./amd/.*\.c" -or -regex "./scheduler/.*\.c" \) -exec egrep -n -- " *= *{ *(|NULL|0) *}" \{\} \+ | wc -l
>> 374
>> $_
>>
>> Out of which only 16 are of the non-ISO C variety, "= {}",
>>
>> $find . \( -regex "./drm.*\.c" -or -regex "./amd/.*\.c" -or -regex "./scheduler/.*\.c" \) -exec egrep -n -- " *= *{ *}" \{\} \+ | wc -l
>> 16
>> $_
>>
>> Perhaps the latter are the more pressing ones, since it is a C++ initializer and not a ISO C one.
> It only matters when we care copying the data to userspace, if it all
> stays in the kernel, all is fine.

Well only as long as you don't try to compute a CRC32, MD5 or any 
fingerprint for a hash from the bytes from the structure.

Then it fails horrible and you wonder why the code doesn't works as 
expected.

Regards,
Christian.

>
> thanks,
>
> greg k-h

