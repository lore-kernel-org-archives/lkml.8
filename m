Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0947FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D457E207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bYqrkNSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbgGaH6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 03:58:03 -0400
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:8339
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731684AbgGaH6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:58:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFrZK7euAjUDN750amEaSAl77e1ie2CafTvyvNPHfPS6RSdPpScL1dx2KVdGOeHagIWG2t7gm0Uz0F2i5La65nXVAeRqKh6iwKGwsdw8RErP1864AdjNZepLqiKf3poAPuU3fCfxvn8kSt+QQVe+GhUvTyE1q8RHuW7IHQoQ1aSruDL3xkFH2GU9XmHAGq1zR0rnfcp7dHyeMX5Y+Ip70c3BOKZ96DmnDwdXpuvLJdRF1D1sskflxhaE0+kjmzmLqAMkrJ4t+snvu1dWh2+mSGSy/AiTu/VYxp8sy5ClGVFnPZGDMaQOVY9kLdaJhPRL06kN0qx8y6IY5Ya9MFqTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWrbLKteyzlg4pknpEMOnlAslKd+FILpEwfRydNqkeA=;
 b=CppWPI6LswwuMheKohOB447T8yFXNvJ4Nf1P05BohsvZYxNuonOwKp/gn0ddVpSGBOYmRBYEh/EUGfTi9gaG7ezEW10ScEH3wtVNzA2toh4IEGBoNtWAid7c+Jv0D6qv/omQjKViI/3v8mmK3z/3F/QcSjCsl5bdEiVAWShV2SvAbXqpcnFklXQv+WZe6fJ/wkF5yvDD/cDRtheFzJo3nScygW7wc3fRcQgcwhR3aAskyWKowJZt8G8ZvIh4zGIbv7Z/BrXbNUyZxLQACO+3Hc7wXZVrt6ma5p0UiZx7p2CczM68mdKYlE+ndOjr4EKQz6ehMu/Y2FCVo8dH1DdP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWrbLKteyzlg4pknpEMOnlAslKd+FILpEwfRydNqkeA=;
 b=bYqrkNSQz4NSS3x8FEF18/9dzxLvQrX87rv2nW7PufhPV5MkiDYP1oQk8nZfJORgb22TKZ/iP/8tEjkClZbHeVqgV5SDbRXw6h0HY9NxYI3UIkkoyRuILC9/2UwQR+ka0k29OgW+m3dYPUU+aq+pGQUdTxAAL+4OXm3OtB32GO8=
Authentication-Results: lists.linuxfoundation.org; dkim=none (message not
 signed) header.d=none;lists.linuxfoundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3949.namprd12.prod.outlook.com (2603:10b6:208:167::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Fri, 31 Jul
 2020 07:57:56 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 07:57:56 +0000
Subject: Re: [Linux-kernel-mentees] [PATCH] drm/amdgpu: Prevent
 kernel-infoleak in amdgpu_info_ioctl()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luben Tuikov <luben.tuikov@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>,
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
 <690213fd-d3d2-2253-dcb2-367a65b34f38@amd.com>
 <20200731071052.GA1522097@kroah.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <13cbff82-bf19-d3eb-d757-95ed5c5bd6bf@amd.com>
Date:   Fri, 31 Jul 2020 09:57:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200731071052.GA1522097@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0046.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::26) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR10CA0046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18 via Frontend Transport; Fri, 31 Jul 2020 07:57:50 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 02d2987c-704a-49c3-fd2f-08d835276f31
X-MS-TrafficTypeDiagnostic: MN2PR12MB3949:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB394942040ACB82BFFCEEBD2B834E0@MN2PR12MB3949.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnVnYbjHYA4MVQK7TeAZWqg1wtV4c/AJ1IX1xrHNw+fiyGer7qyobGZ7PTNxMcxxK4HC/HGt9o2zBQVCMgB/H+BlF5I3x76f4jWkXCIs9JWrwVB7UgE+LH/6sFcLiGE/ACl6BJV5Op+CzktCHH6hXfVhgXMwxFGhTzjNneo7aI8/D28XMeqaPdHI4RmDyM3EbNA8VG9zXyrHpXVVkFUPclD/amdki2jyANZjVql48v5XpCHM1+/Xwym0VfvOmYnK9eEmqeV9/AH5v/L6gRYqQKazN7Ps6PC5XCTelW4Ilu4sClHpvao+6ghL6LHnRYkyZFM4p+ztXPtkrJhs3aTKyI7XDwAHzCKjCoNo/Ifqu00v3qSWgJFT72AaJ/katGw5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(8676002)(66574015)(83380400001)(6486002)(54906003)(6916009)(4326008)(8936002)(31696002)(31686004)(316002)(36756003)(186003)(66476007)(6666004)(16526019)(5660300002)(53546011)(66556008)(52116002)(2906002)(478600001)(66946007)(2616005)(86362001)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3VhwE/KfFZRIE8qCWua7GiDyxvte6/8WXFWEuHQaGZtkdYIfkxYFYtl1R4Cq0ss/E0NkZaA4QT7r7chQznghCkz+MMS/HCq9cvB8ty5MGaboDBrAGce5NxY3TMzcF7MAAQYRBAl+PBpj1sXfref4C6pF1qVmdRSJ0x7wBIyirW/pLtk0icADvZ7Lr/B17cVB3HYDxxCgVeZ1d99O3TdSgR7gqwWiQgFXAHZq1Nii36SciNrNp0FwxTiRDB8iI3z4/GB5G6MeI70hQYV5n3VM6ma/WEyA9+xCYrfLmvbNPG3fJeyd6ByVrPFnPyu3jL4qbtjOnv8joPR+oXCYmGPjXptxfX5+Gdpa1c6DOEzl6nWxHVv29ZkpDSMLW5f+8es60SliQoSDi0Z8dqhAna1dHsWBkF/Ze6Rez+utW4lBmtFQLJSjk3ISFABUhKfFrPT76aGxij0NUqbcmYMoTgRpzMUpOtTRQaIVXqF4e1BcoJzDY8VgDGlT3oNX+Uq1qQyuEbZ29PRUr7IPIIShNMcY3qn7tpm9CpQ2+kWfSO415NR/Y5BCQXIjAdz6fET8or+OWX3pdJQmdyDpH0XPnPfmYk3CGeNWQnuS2MdLmj062BqlIAvDdsCmfVuVbzphads3EG3stn8xnMI+e2yJ5uD/LFs6FIIGAMEQzRWtnl1Tt+uUdKS9LmrOEFaRCBprgPVa/9JMxvgG7uleivNx+ynsnQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d2987c-704a-49c3-fd2f-08d835276f31
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 07:57:56.6534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzHgkFIC6V2J53SepUcPFzLGG5GshyxRG2BM+Pemq/Zk5j9LE9NGYJPHOTJ0bnBl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3949
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 31.07.20 um 09:10 schrieb Greg Kroah-Hartman:
> On Fri, Jul 31, 2020 at 08:57:53AM +0200, Christian König wrote:
>> Am 31.07.20 um 08:53 schrieb Greg Kroah-Hartman:
>>> On Thu, Jul 30, 2020 at 05:09:07PM -0400, Luben Tuikov wrote:
>>>> On 2020-07-29 9:49 a.m., Alex Deucher wrote:
>>>>> On Wed, Jul 29, 2020 at 4:11 AM Christian König
>>>>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>>>>> Am 28.07.20 um 21:29 schrieb Peilin Ye:
>>>>>>> Compiler leaves a 4-byte hole near the end of `dev_info`, causing
>>>>>>> amdgpu_info_ioctl() to copy uninitialized kernel stack memory to userspace
>>>>>>> when `size` is greater than 356.
>>>>>>>
>>>>>>> In 2015 we tried to fix this issue by doing `= {};` on `dev_info`, which
>>>>>>> unfortunately does not initialize that 4-byte hole. Fix it by using
>>>>>>> memset() instead.
>>>>>>>
>>>>>>> Cc: stable@vger.kernel.org
>>>>>>> Fixes: c193fa91b918 ("drm/amdgpu: information leak in amdgpu_info_ioctl()")
>>>>>>> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
>>>>>>> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>>>>> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
>>>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>>>>
>>>>>> I can't count how many of those we have fixed over the years.
>>>>>>
>>>>>> At some point we should probably document that using "= {}" or "= { 0 }"
>>>>>> in the kernel is a really bad idea and should be avoided.
>>>>> Moreover, it seems like different compilers seem to behave relatively
>>>>> differently with these and we often get reports of warnings with these
>>>>> on clang.  When in doubt, memset.
>>>> There are quite a few of those under drivers/gpu/drm, for "amd/", "scheduler/"
>>>> drm*.c files,
>>>>
>>>> $find . \( -regex "./drm.*\.c" -or -regex "./amd/.*\.c" -or -regex "./scheduler/.*\.c" \) -exec egrep -n -- " *= *{ *(|NULL|0) *}" \{\} \+ | wc -l
>>>> 374
>>>> $_
>>>>
>>>> Out of which only 16 are of the non-ISO C variety, "= {}",
>>>>
>>>> $find . \( -regex "./drm.*\.c" -or -regex "./amd/.*\.c" -or -regex "./scheduler/.*\.c" \) -exec egrep -n -- " *= *{ *}" \{\} \+ | wc -l
>>>> 16
>>>> $_
>>>>
>>>> Perhaps the latter are the more pressing ones, since it is a C++ initializer and not a ISO C one.
>>> It only matters when we care copying the data to userspace, if it all
>>> stays in the kernel, all is fine.
>> Well only as long as you don't try to compute a CRC32, MD5 or any
>> fingerprint for a hash from the bytes from the structure.
>>
>> Then it fails horrible and you wonder why the code doesn't works as
>> expected.
> True, but the number of times I have ever needed to do that to a
> structure for a driver is, um, never...
>
> If a structure ever needs to have that happen to it, I would sure hope
> the developer was aware of padding fields, otherwise, well, someone
> needs to take away their C language certification :)

Well it is very likely that stack allocated structures have the same 
values in the padding bytes most of the time. So the problem is very 
subtle and hard to detect.

We've seen enough problems with that over the last ~10 years that I'm 
clearly in favor of adding something to checkpatch.pl to spill out a 
warning if "= { }" is used for zero initialization.

Alternatively some of the people who know gcc/clang better than I do 
could come up with a warning that you shouldn't cast a structure with 
uninitialized padding to void* or u8*.

I mean KASAN is already doing a great job detecting that kind of stuff, 
but for this you still need to hit the offending code path.

Thanks,
Christian.

>
> thanks,
>
> greg k-h

