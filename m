Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D65C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC3A2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WLPTf9Pl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390416AbgAXQlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:41:53 -0500
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com ([40.107.92.85]:42080
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388400AbgAXQlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:41:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D78tI/n6r+3FjxjXUW4SKEMpDsefg3TPl6tXKg1tcO97kuE/ADBGJLlw2a53hP5AL1QBSuzvA47+ElI5NqKHwQOipOPLHz1l42QHfTdm54OZnwuOaBPorFRXTc0azjjKKdCby6lDUgmshUyogBMDmhh42rmJBgbqWVUyh572chXMn2xIU/rKgQil/QI+YFmkDwR1x23OPLQ7oN3S1xYGeS45P4ZdiOUDuQop+rgABQxFGVlfnJ6s+3TQCRYpGvj9xaAiU0uzsMIZ9Z67WIlEfRAU8eK9TizluPR7dnNxKfOsxV9Mb01X6Hkj8H/43fqoWIxNxpL9z3tcEhK9MZjNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8pW8H6OhQ6r7Jl7rMAjbaggYqFjY+YIZ/1Xzx9PlO4=;
 b=XuWWDSJcXz2k8TzBYrSB2Bqw4zJ/ufoJIGxbU12PXl2GbYqsCbEGqlhRw3sEu7kpJ/JEqM3oKrybhhJw8ogUvotw1O8gzEsZmo/REKjXYpymm70C33GJi4TiphR87J+TKHR7nnXnZyL0/Xd4iGmOZNqbx4TbX1BxSvPis1ee5HsHW1XaEaYeAxl2vdfQwAqnuwMLDCqVjmLnXTyjFLii3lRuGYo3ZjU4wDyckUg9u7wSraBBUN/RBuP/ywOqpFSXhIJsX81oQokvVsUVj2h38z05s0tBVj/igAYT/wDC5PvvnmIKFTkJ/zYNRFoutJOGatVd96gQDE5gQHktaIWDdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8pW8H6OhQ6r7Jl7rMAjbaggYqFjY+YIZ/1Xzx9PlO4=;
 b=WLPTf9Pl+AwGRYxjjYZxdiq50mpGtaKGEEq518ro9+VWJ52uJ7vpemK14CMapb2XkQwnExFkh2tQj55/JXFS5QaKP7y9BpwwwktPQ5hZFbkDKZWUJ+IBX/hb01Dn6qIJXYEOgTCtMioJPqi9X7CEcox2HzBwxHbZZhEECK1vmEk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2657.namprd12.prod.outlook.com (20.176.178.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Fri, 24 Jan 2020 16:41:48 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::587f:6ef1:19b7:cf3b]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::587f:6ef1:19b7:cf3b%7]) with mapi id 15.20.2644.027; Fri, 24 Jan 2020
 16:41:47 +0000
Subject: Re: [PATCH] drm/amd/display: do not allocate display_mode_lib
 unnecessarily
To:     Dor Askayo <dor.askayo@gmail.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
References: <20200104122217.148883-1-dor.askayo@gmail.com>
 <CAO80jNS795mgHCp3XedZQ1o1QHbwxb8DeuSqPtKHmKbAVYsfmg@mail.gmail.com>
 <CAO80jNS6fV+8s1R5CH9swbkDB+-RmZADFvA0UkBmWG2bEQioPw@mail.gmail.com>
From:   Leo <sunpeng.li@amd.com>
Message-ID: <a20b2261-5f6d-0ef2-e48f-e1385fb1bf60@amd.com>
Date:   Fri, 24 Jan 2020 11:41:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <CAO80jNS6fV+8s1R5CH9swbkDB+-RmZADFvA0UkBmWG2bEQioPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::15)
 To BN7PR12MB2593.namprd12.prod.outlook.com (2603:10b6:408:25::23)
MIME-Version: 1.0
Received: from [172.29.240.98] (165.204.55.250) by YT1PR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Fri, 24 Jan 2020 16:41:47 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c974047e-3b89-49fc-e17d-08d7a0ec4de7
X-MS-TrafficTypeDiagnostic: BN7PR12MB2657:|BN7PR12MB2657:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB26578608C4EBA46086320A6B820E0@BN7PR12MB2657.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02929ECF07
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(189003)(199004)(4326008)(36756003)(31686004)(52116002)(6486002)(53546011)(966005)(2906002)(66556008)(31696002)(16526019)(186003)(81156014)(8676002)(478600001)(26005)(110136005)(8936002)(54906003)(5660300002)(81166006)(66946007)(956004)(86362001)(66476007)(316002)(2616005)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2657;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WdNqvrAcpL0Imy+iRplfxSIfs/TbGF5YwLp1DthMZ88JS8AqSbGDO91cEw+wXsxROlxWtTKbLd/Cb/0NMxua+uzJ0+kuM1wptz9djPXd6Fhv7h7+0h/wjQp2ZckeZrWNgoB5bClddL/WIyKrlG/8WAmCTG9CavQg8P4Tci8tOaJyZdgum6Wl0WebID/2vwwv/QBbkC1PH7GCInIzfsioZoIxlTgSy5tEkr9VfqFqAyCeIAi5IhPcAbUpFug+0SoCEZ0EJX2uFO8+nBDmQIBP5xNmqtptoFqLa+kZ9MW8vdFZs+DPaosGqJDpJ2N40f6ZbiDrv3wOlDzYUwpBITTTCzPuG/kSIz0AXE9/ySKPfn+4+EmyLxePjdV/NpqippcZKsNQa+HlsuP2Mu/2Qnhf407lso9tQvMCagS1Oxascgia332pLHQgW+XHKkix9sTuSYrq47i7ADw2QkQHHgco+3VYi8S5tJw6S01KEvC2KxA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c974047e-3b89-49fc-e17d-08d7a0ec4de7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2020 16:41:47.7671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgN4xOd9am0LDjN6Ytuq+8xo57djiqFuon2NjCheHLZJcD2InVTflPA9tSkcJMRk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2657
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay, change LGTM. 

Reviewed-by: Leo Li <sunpeng.li@amd.com>

, and applied.

Thanks!
Leo

On 2020-01-24 5:18 a.m., Dor Askayo wrote:
> On Fri, Jan 17, 2020 at 12:59 PM Dor Askayo <dor.askayo@gmail.com> wrote:
>>
>> On Sat, Jan 4, 2020 at 2:23 PM Dor Askayo <dor.askayo@gmail.com> wrote:
>>>
>>> This allocation isn't required and can fail when resuming from suspend.
>>>
>>> Bug: https://gitlab.freedesktop.org/drm/amd/issues/1009
>>> Signed-off-by: Dor Askayo <dor.askayo@gmail.com>>>> ---
>>>  drivers/gpu/drm/amd/display/dc/core/dc.c | 17 +++++++++--------
>>>  1 file changed, 9 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
>>> index dd4731ab935c..83ebb716166b 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>>> @@ -2179,12 +2179,7 @@ void dc_set_power_state(
>>>         enum dc_acpi_cm_power_state power_state)
>>>  {
>>>         struct kref refcount;
>>> -       struct display_mode_lib *dml = kzalloc(sizeof(struct display_mode_lib),
>>> -                                               GFP_KERNEL);
>>> -
>>> -       ASSERT(dml);
>>> -       if (!dml)
>>> -               return;
>>> +       struct display_mode_lib *dml;
>>>
>>>         switch (power_state) {
>>>         case DC_ACPI_CM_POWER_STATE_D0:
>>> @@ -2206,6 +2201,12 @@ void dc_set_power_state(
>>>                  * clean state, and dc hw programming optimizations will not
>>>                  * cause any trouble.
>>>                  */
>>> +               dml = kzalloc(sizeof(struct display_mode_lib),
>>> +                               GFP_KERNEL);
>>> +
>>> +               ASSERT(dml);
>>> +               if (!dml)
>>> +                       return;
>>>
>>>                 /* Preserve refcount */
>>>                 refcount = dc->current_state->refcount;
>>> @@ -2219,10 +2220,10 @@ void dc_set_power_state(
>>>                 dc->current_state->refcount = refcount;
>>>                 dc->current_state->bw_ctx.dml = *dml;
>>>
>>> +               kfree(dml);
>>> +
>>>                 break;
>>>         }
>>> -
>>> -       kfree(dml);
>>>  }
>>>
>>>  void dc_resume(struct dc *dc)
>>> --
>>> 2.24.1
>>>
>>
>> I've been running with this fix applied on top of Fedora's
>> 5.3.16-300.fc31.x86_64 kernel for the past two weeks, suspending
>> and resuming often. This the first time since I bought my RX 580 8GB
>> more than a year ago that I can suspend and resume reliably.
>>
>> I'd appreciate a quick review for the above, it really is a trivial change.
>>
>> Thanks,
>> Dor
> 
> Bumping this up again. I've been running with this change for the past
> 20 days without issues.
> 
> Thanks,
> Dor
> 
> On Fri, Jan 17, 2020 at 12:59 PM Dor Askayo <dor.askayo@gmail.com> wrote:
>>
>> On Sat, Jan 4, 2020 at 2:23 PM Dor Askayo <dor.askayo@gmail.com> wrote:
>>>
>>> This allocation isn't required and can fail when resuming from suspend.
>>>
>>> Bug: https://gitlab.freedesktop.org/drm/amd/issues/1009
>>> Signed-off-by: Dor Askayo <dor.askayo@gmail.com>
>>> ---
>>>  drivers/gpu/drm/amd/display/dc/core/dc.c | 17 +++++++++--------
>>>  1 file changed, 9 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
>>> index dd4731ab935c..83ebb716166b 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>>> @@ -2179,12 +2179,7 @@ void dc_set_power_state(
>>>         enum dc_acpi_cm_power_state power_state)
>>>  {
>>>         struct kref refcount;
>>> -       struct display_mode_lib *dml = kzalloc(sizeof(struct display_mode_lib),
>>> -                                               GFP_KERNEL);
>>> -
>>> -       ASSERT(dml);
>>> -       if (!dml)
>>> -               return;
>>> +       struct display_mode_lib *dml;
>>>
>>>         switch (power_state) {
>>>         case DC_ACPI_CM_POWER_STATE_D0:
>>> @@ -2206,6 +2201,12 @@ void dc_set_power_state(
>>>                  * clean state, and dc hw programming optimizations will not
>>>                  * cause any trouble.
>>>                  */
>>> +               dml = kzalloc(sizeof(struct display_mode_lib),
>>> +                               GFP_KERNEL);
>>> +
>>> +               ASSERT(dml);
>>> +               if (!dml)
>>> +                       return;
>>>
>>>                 /* Preserve refcount */
>>>                 refcount = dc->current_state->refcount;
>>> @@ -2219,10 +2220,10 @@ void dc_set_power_state(
>>>                 dc->current_state->refcount = refcount;
>>>                 dc->current_state->bw_ctx.dml = *dml;
>>>
>>> +               kfree(dml);
>>> +
>>>                 break;
>>>         }
>>> -
>>> -       kfree(dml);
>>>  }
>>>
>>>  void dc_resume(struct dc *dc)
>>> --
>>> 2.24.1
>>>
>>
>> I've been running with this fix applied on top of Fedora's
>> 5.3.16-300.fc31.x86_64 kernel for
>> the past two weeks, suspending and resuming often. This the first time
>> since I bought my
>> RX 580 8GB more than a year ago that I can suspend and resume reliably.
>>
>> I'd appreciate a quick review for the above, it really is a trivial change.
>>
>> Thanks,
>> Dor
