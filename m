Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFDDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 829142072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V4Rtd+YI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgG0T22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:28:28 -0400
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com ([40.107.93.84]:61665
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbgG0T21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:28:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPtqpjTefNqGuy0HKltYt7u/UkNz9EZJXECxUIlZ4dhPh/WZLT/RrK9dYelzjmM3y+khI0FQB0bQZLkxz0FkkZ3B2lj2jBAbEx9/RM8yPjfZKhKC83KBYAU9whwcs8NIS5XFM6Sco5Y44XK+kieNl5QqGYZ3XBWzZtSeUzjCCx0EiUIMF2liwodYAvYzp/T8p4naqQKTO4tOGqwzlOcCSajzjO2GLI0sfbSpSTcaqVO4Sz3o8LTARcOMMoSej4pXeQGmK20IkCww9l3rJtikLlUn0JMIZxXC0UgKwja1DCVY1ZpfS9uFR/3zk0fJdd/GuF51wzHvtuqtC6v0lgjJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9hXZGd02O/XDpcv3LeQg/RGvBY67f6xKxq/r4rWuQY=;
 b=micOcWs0sh+8HaYLXB3HfHFpcJ/BkqQp0yMpUq2uypD7qNj1WD2UAFJVgUREiDfSx513zZivuA+SNKgPx9DVWu+mzXYQkjXKfXjG2720Mi8JjWWvhXKScHTy0bm7WK+DPfTOVx8yB5Oj8//zxpFcO8aI8MpoNh6tsulKyM0J8YQ8JADwsCjURdmBP5z+vKzBre+b4sdOs+3RQv0oQU9UykqwRzHtQWL2oWzRMh/tvxe0jJgPEnMaVDSWm3r5L4CO/IrTJ0NkU3cjvYZcfsQGBeLGu6VAS+cnCh7jRxA+HoYJDbEr9qr2Favps5LX88CLE+gZl/NqmeaxFJrmlVjDxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9hXZGd02O/XDpcv3LeQg/RGvBY67f6xKxq/r4rWuQY=;
 b=V4Rtd+YIEUjyCznUi+gu2HZLSkjKU6cUeTcsvRg2RVWMPRzjZdzfPbSP58fheCta6HT6y29ANhuEwEVSrJoCqXWjwc54S7OWr/QmrKNHMWKVDRMT1kQyjewF4ZB9zNpkfovtv+K2S0afARefgNtmkdTCkVEB6H11ZKwHi+o0Tqs=
Authentication-Results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3886.namprd12.prod.outlook.com (2603:10b6:208:16a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Mon, 27 Jul
 2020 19:28:23 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:28:23 +0000
Subject: Re: [PATCH] drm/amd/display: Clear dm_state for fast updates
To:     "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Mazin Rezk <mnrzk@protonmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Harry Wentland <Harry.Wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Duncan <1i5t5.duncan@cox.net>,
        "mphantomx@yahoo.com.br" <mphantomx@yahoo.com.br>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "anthony.ruhier@gmail.com" <anthony.ruhier@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
References: <M0lxN5AUlPvzBKULfIBe5BZRwfQGXeMQCdWItYcQ-9P79y32WzExYK2Y0DwyNVtyGelqbvV07_lFk1oeT4cApbT-P_oH0bnxQbMmFsJv_xg=@protonmail.com>
 <ba078fb0-0dbc-df06-cfe9-f9537883f82a@amd.com>
 <e2f55480-c24f-6c85-08d3-21131a22d0bf@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3b7e3e50-2ff7-eff3-2ffc-abaa4b36ce7f@amd.com>
Date:   Mon, 27 Jul 2020 21:28:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <e2f55480-c24f-6c85-08d3-21131a22d0bf@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0174.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::43) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR01CA0174.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Mon, 27 Jul 2020 19:28:19 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a1a26105-45d0-4416-d3a8-08d8326339d5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3886:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3886BF181D3F10D40035600F83720@MN2PR12MB3886.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zljo50kLvea1x8SB0UFXwXmJaeaStZji4KiqI6Ib4drwj3go6hqW+mdBkbABBVFjnsPZS+Z0YMT6gginG0h2efkQQC9kjdscyHjADPmIQhsar/wRNfRSLOVr1+Qp5YXnz0EKTkoCXRbZ2BE7dOR4xMrE3VIR1OEx90mg+f2nSy5QFk4A033IRitZS4LIVQoe3zc6VfNalV6irkJ6muAskPER9fJsLb8XzXYgrcdb9a4H1oGeyy40NLxGWP8Lz5CiT1JwRRXxchg0wMtGKLlH+chiuezow+KkSLYxL5Bz3nOeZtU991xp+DmLFC6gwD1+ZXHbNdc7iMrYZrsLD+aVCsw1JmgM7VWYTIzEiK022kHe25NK/ERyTki4sVMbfAWUe13ReB7SEClOofykDboqxNxL6ngWOxvUBdacDf9m74H3DnDEtOJVYTQwVxhsrBFzmpq/XNTXEfjaF6L9fFLfGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(7416002)(4326008)(316002)(478600001)(966005)(31686004)(2906002)(8936002)(66574015)(110136005)(54906003)(8676002)(66556008)(83380400001)(66476007)(6486002)(66946007)(15650500001)(2616005)(6666004)(5660300002)(16526019)(186003)(53546011)(52116002)(36756003)(86362001)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rPU5mPmtTM4XnVPzAIoRv5k34aYkIpTEectF9EEI+IpywouyWEh5DnhQrETNP9ena7/svIhxtLimvaWcHqOryzj43Mf7Vd1LIef/uxgkFHJrWOL6AyoAIA7xSq34tozP5IVMpa9bkWKjW3yAtn/Zkvlti9Es6+6V6n6OZBumbWlw4KqZDF3i3nM+3TGogAkH5C3spn9oT7hx8RxlM+rWbV7jSVBTaBed0A0GSZwyUehLUrXPWhRCIrYVFi8150Ya33//CDw69d8zS5dpOGmKxeBX9lK+T273Uah1pVGioW5qsNAJ5fzRaMxHCyeK60xDzoUESuzUNL/A2Cica7HBHlZlBnfjWHLrGyaWkxayPDQIg7ql8AqyvBuFmMZZ3nVZ7rX1SNLgeY4LxnbGraxM7X3KefjmwXyOcc8eHG3+m8mtBpbznk/HYd804NLp8C9qR/Q7KqfMabtEqvLrLT5HL/S5LGuIJQx/5Ik17mqijkOR4XRBp5b94rzAKTfT7KYWEPITrvdsct0FoeVKxvED7i/h9Iw8NF/wA9G0TQ+/5RT39h3xmzHNexdqKvvmRvu5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a26105-45d0-4416-d3a8-08d8326339d5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:28:22.8839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IS3YDSEJPNcReBOtsbKDf3oLjIi372mzbPlp+9N69qU6bgtczVih7hGVCcuaEg7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3886
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 27.07.20 um 16:05 schrieb Kazlauskas, Nicholas:
> On 2020-07-27 9:39 a.m., Christian König wrote:
>> Am 27.07.20 um 07:40 schrieb Mazin Rezk:
>>> This patch fixes a race condition that causes a use-after-free during
>>> amdgpu_dm_atomic_commit_tail. This can occur when 2 non-blocking 
>>> commits
>>> are requested and the second one finishes before the first. 
>>> Essentially,
>>> this bug occurs when the following sequence of events happens:
>>>
>>> 1. Non-blocking commit #1 is requested w/ a new dm_state #1 and is
>>> deferred to the workqueue.
>>>
>>> 2. Non-blocking commit #2 is requested w/ a new dm_state #2 and is
>>> deferred to the workqueue.
>>>
>>> 3. Commit #2 starts before commit #1, dm_state #1 is used in the
>>> commit_tail and commit #2 completes, freeing dm_state #1.
>>>
>>> 4. Commit #1 starts after commit #2 completes, uses the freed dm_state
>>> 1 and dereferences a freelist pointer while setting the context.
>>
>> Well I only have a one mile high view on this, but why don't you let 
>> the work items execute in order?
>>
>> That would be better anyway cause this way we don't trigger a cache 
>> line ping pong between CPUs.
>>
>> Christian.
>
> We use the DRM helpers for managing drm_atomic_commit_state and those 
> helpers internally push non-blocking commit work into the system 
> unbound work queue.

Mhm, well if you send those helper atomic commits in the order A,B and 
they execute it in the order B,A I would call that a bug :)

> While we could duplicate a copy of that code with nothing but the 
> workqueue changed that isn't something I'd really like to maintain 
> going forward.

I'm not talking about duplicating the code, I'm talking about fixing the 
helpers. I don't know that code well, but from the outside it sounds 
like a bug there.

And executing work items in the order they are submitted is trivial.

Had anybody pinged Daniel or other people familiar with the helper code 
about it?

Regards,
Christian.

>
> Regards,
> Nicholas Kazlauskas
>
>>
>>>
>>> Since this bug has only been spotted with fast commits, this patch 
>>> fixes
>>> the bug by clearing the dm_state instead of using the old dc_state for
>>> fast updates. In addition, since dm_state is only used for its dc_state
>>> and amdgpu_dm_atomic_commit_tail will retain the dc_state if none is 
>>> found,
>>> removing the dm_state should not have any consequences in fast updates.
>>>
>>> This use-after-free bug has existed for a while now, but only caused a
>>> noticeable issue starting from 5.7-rc1 due to 3202fa62f ("slub: 
>>> relocate
>>> freelist pointer to middle of object") moving the freelist pointer from
>>> dm_state->base (which was unused) to dm_state->context (which is
>>> dereferenced).
>>>
>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207383
>>> Fixes: bd200d190f45 ("drm/amd/display: Don't replace the dc_state 
>>> for fast updates")
>>> Reported-by: Duncan <1i5t5.duncan@cox.net>
>>> Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
>>> ---
>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 36 
>>> ++++++++++++++-----
>>>   1 file changed, 27 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 86ffa0c2880f..710edc70e37e 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -8717,20 +8717,38 @@ static int amdgpu_dm_atomic_check(struct 
>>> drm_device *dev,
>>>            * the same resource. If we have a new DC context as part of
>>>            * the DM atomic state from validation we need to free it and
>>>            * retain the existing one instead.
>>> +         *
>>> +         * Furthermore, since the DM atomic state only contains the DC
>>> +         * context and can safely be annulled, we can free the state
>>> +         * and clear the associated private object now to free
>>> +         * some memory and avoid a possible use-after-free later.
>>>            */
>>> -        struct dm_atomic_state *new_dm_state, *old_dm_state;
>>>
>>> -        new_dm_state = dm_atomic_get_new_state(state);
>>> -        old_dm_state = dm_atomic_get_old_state(state);
>>> +        for (i = 0; i < state->num_private_objs; i++) {
>>> +            struct drm_private_obj *obj = state->private_objs[i].ptr;
>>>
>>> -        if (new_dm_state && old_dm_state) {
>>> -            if (new_dm_state->context)
>>> -                dc_release_state(new_dm_state->context);
>>> +            if (obj->funcs == adev->dm.atomic_obj.funcs) {
>>> +                int j = state->num_private_objs-1;
>>>
>>> -            new_dm_state->context = old_dm_state->context;
>>> +                dm_atomic_destroy_state(obj,
>>> +                        state->private_objs[i].state);
>>> +
>>> +                /* If i is not at the end of the array then the
>>> +                 * last element needs to be moved to where i was
>>> +                 * before the array can safely be truncated.
>>> +                 */
>>> +                if (i != j)
>>> +                    state->private_objs[i] =
>>> +                        state->private_objs[j];
>>>
>>> -            if (old_dm_state->context)
>>> -                dc_retain_state(old_dm_state->context);
>>> +                state->private_objs[j].ptr = NULL;
>>> +                state->private_objs[j].state = NULL;
>>> +                state->private_objs[j].old_state = NULL;
>>> +                state->private_objs[j].new_state = NULL;
>>> +
>>> +                state->num_private_objs = j;
>>> +                break;
>>> +            }
>>>           }
>>>       }
>>>
>>> -- 
>>> 2.27.0
>>>
>>
>

