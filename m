Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E20C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97DD02074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DiLyrUB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgG0OFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:05:10 -0400
Received: from mail-dm6nam12on2086.outbound.protection.outlook.com ([40.107.243.86]:24320
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728479AbgG0OFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:05:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWV6WuMtMk6rocvkzEbro5hagm2kyvsZSLviCquEv8kakqfxus6GfoJV5Dp9/49Ki21BTciTdQh6zRM++THtk9UdCEOGVcFIKifuTOxYTuws1mKCFx861xPs2aXN32q4+kYBSI5GqavcvzzVm37lp/GzoHz+cj7z8LTwcmRHIh03onDIoXWyEm8vo005DmIB/TxOFKJWL6Q/CxkEptNnQc8GFTTjPaggmStalbrQ/iyQdTVw6kfNnv1ZjKNCtRN04g2KotvWS59Qvmpg+oxBoxreIk7ab92pdixWS3LN7M78cbYUaUCXSIoKUIrpAGaIcqqDSikpq0E/Ab8zFRbTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHYTdusamJwCxX+n1ab6vpKjAtGGwKntZgQhiD1AwdI=;
 b=bqedtU8iC2xtIruEs2/Rs8Zea/cyfQ4yHo71n4jZG5WKnH+x9Rtp2gZitoca0JJF5E1rBEijddeOMkVDJ0oQB1S6v+o3HyDfC71GflEDUfIbOghzbXURiSERJk1oFUnR3a1+4ZpmAGehrk5eaOZHG9uNn/FZaPhadhY/gTJ5IV9lJ9mAzK8jcMS//a4RVLUbynId5S8gnZhT1m0rNAbFD1NFFuHLg5HLTbKwchRhhbvHduvsGzhSl84DUPtWR3TnVx/4LwCxkNaikWbd4ZLLOo1f+sNd7fhzSMiTsLBROzIl1+J5UDCAI8z+bfrd4zYQr+Auejy0+b0+JmuDxF2W/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHYTdusamJwCxX+n1ab6vpKjAtGGwKntZgQhiD1AwdI=;
 b=DiLyrUB+MM6woOZpBeKR5HQ2YLoqataV+zuObuMYYC6CihKCgMAo2GKkJD/8GzupL46GBaKsBoeFTD3qqnoZXj7MjIPFdIgzBvYZkIfQIjbGC+EALYamxNfj4fuo/xqTFLEPkKdiym9kTRgaNuiUOaMyUCxwR63I/o7JfORyQco=
Authentication-Results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3561.namprd12.prod.outlook.com (2603:10b6:5:3e::26) by
 DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.33; Mon, 27 Jul 2020 14:05:06 +0000
Received: from DM6PR12MB3561.namprd12.prod.outlook.com
 ([fe80::6df0:61cb:d37:2a0b]) by DM6PR12MB3561.namprd12.prod.outlook.com
 ([fe80::6df0:61cb:d37:2a0b%6]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 14:05:05 +0000
Subject: Re: [PATCH] drm/amd/display: Clear dm_state for fast updates
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
From:   "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <e2f55480-c24f-6c85-08d3-21131a22d0bf@amd.com>
Date:   Mon, 27 Jul 2020 10:05:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <ba078fb0-0dbc-df06-cfe9-f9537883f82a@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::41)
 To DM6PR12MB3561.namprd12.prod.outlook.com (2603:10b6:5:3e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by YT1PR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Mon, 27 Jul 2020 14:05:05 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce32ea47-ff5a-4409-7610-08d83236105c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2533:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2533F4F2C0A305F8ACEA8FF4EC720@DM5PR12MB2533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIPxJAHC7JD/TACeQk37iMu6chvccei3WefcaRuxFLSQsp3nXrUBiXS2iSj+ET0eWuPnOfYllXRJErWtUoELWwflKmWvZPs9xYgcCh/w2g3Wc4EP58S7aoHMMyuSZoBBhPNWek19zQcIW/ag8u1Vcndc/Zp2V5qFNwMC5Va4WzHmxReN5LO82LyBZt1FK7y6A494BVKd5grT+VWXmQpdJAhm+vDcHRc8gy7BYWQhpTsQiVS14he7And/DRmJfNZ59kV3xLxd6OiMpTvDRVY9xIyIb6JA4PLvd1qOJGZKVU3DK0fYHjS2AetIU8x8f2KoMP5614quJlcvsWYqr1jsTSrmvMYvTKeg9TahsJerWxBKpEnSBlk/kZBgPYx4/FCO6WrLMMwZ7wFRxqt4isK6tqmrYcqNtH79DIaU4kKKLxaeBKtXgAAfRVZ+LzS62TqPLk/Bjl+3aQNJf3MwOJglCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3561.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(316002)(86362001)(5660300002)(6486002)(66574015)(8936002)(8676002)(16576012)(54906003)(15650500001)(110136005)(2906002)(31696002)(66476007)(66556008)(26005)(53546011)(16526019)(66946007)(36756003)(83380400001)(186003)(478600001)(966005)(2616005)(956004)(4326008)(52116002)(6666004)(31686004)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BagserpB/3ffAcri9c/WWJS8tKIDgEA1GdBnAFShHv1BE8poIcorEQzGsAGjSTG+KcD7e2vQs3CIIQ/S6fmZP+IIQzGQxL19PTdsLNdlvGEbwFRrv1x/FdfWjVzy190t8Idra+xixgoNHVZtt467ea0v+ymHOFMeb1ZDZaeD7LAS9/JBroWwchg7ga+QdVgLuOi0YNfEF5pI9dql9GeHMhPbgd40Lqj+ZP2cu6ncSVpuZ6FOTSerurvFmjlpdpQzwfCR/B4lLZXJypHZxpWC33S9S7UJmI9cul3SX1sL8hcUBtFBxUc4MShTdPSRYn/fU3etapmyrriBu3fE2B0QpiZSG20y+MHHMHQO0H8B7xi2TLQU13JX0NCsGTTi2NItVNc38TIW+t//7KBkXKTw1CUucXeMviHH5sGJS2RTJfky0dImWzDdUHh9A8D46/4W0M9F9zKX1zE2k0IVS5G5W7OpO6BDmdkESZruSHdbRIGtNFzEN8zfw8CBoWpXcjZ5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce32ea47-ff5a-4409-7610-08d83236105c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3561.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 14:05:05.8662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEmoDu1n2h+CFMI+hscf6qPgNuqVhux+kSXVqJ1iPlH2Uit2jWeqvpBrDK+8h7bckqlFVuRgmcWWI6CLXynM1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2533
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-27 9:39 a.m., Christian König wrote:
> Am 27.07.20 um 07:40 schrieb Mazin Rezk:
>> This patch fixes a race condition that causes a use-after-free during
>> amdgpu_dm_atomic_commit_tail. This can occur when 2 non-blocking commits
>> are requested and the second one finishes before the first. Essentially,
>> this bug occurs when the following sequence of events happens:
>>
>> 1. Non-blocking commit #1 is requested w/ a new dm_state #1 and is
>> deferred to the workqueue.
>>
>> 2. Non-blocking commit #2 is requested w/ a new dm_state #2 and is
>> deferred to the workqueue.
>>
>> 3. Commit #2 starts before commit #1, dm_state #1 is used in the
>> commit_tail and commit #2 completes, freeing dm_state #1.
>>
>> 4. Commit #1 starts after commit #2 completes, uses the freed dm_state
>> 1 and dereferences a freelist pointer while setting the context.
> 
> Well I only have a one mile high view on this, but why don't you let the 
> work items execute in order?
> 
> That would be better anyway cause this way we don't trigger a cache line 
> ping pong between CPUs.
> 
> Christian.

We use the DRM helpers for managing drm_atomic_commit_state and those 
helpers internally push non-blocking commit work into the system unbound 
work queue.

While we could duplicate a copy of that code with nothing but the 
workqueue changed that isn't something I'd really like to maintain going 
forward.

Regards,
Nicholas Kazlauskas

> 
>>
>> Since this bug has only been spotted with fast commits, this patch fixes
>> the bug by clearing the dm_state instead of using the old dc_state for
>> fast updates. In addition, since dm_state is only used for its dc_state
>> and amdgpu_dm_atomic_commit_tail will retain the dc_state if none is 
>> found,
>> removing the dm_state should not have any consequences in fast updates.
>>
>> This use-after-free bug has existed for a while now, but only caused a
>> noticeable issue starting from 5.7-rc1 due to 3202fa62f ("slub: relocate
>> freelist pointer to middle of object") moving the freelist pointer from
>> dm_state->base (which was unused) to dm_state->context (which is
>> dereferenced).
>>
>> Bugzilla: 
>> https://bugzilla.kernel.org/show_bug.cgi?id=207383 
>>
>> Fixes: bd200d190f45 ("drm/amd/display: Don't replace the dc_state for 
>> fast updates")
>> Reported-by: Duncan <1i5t5.duncan@cox.net>
>> Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 36 ++++++++++++++-----
>>   1 file changed, 27 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 86ffa0c2880f..710edc70e37e 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -8717,20 +8717,38 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>            * the same resource. If we have a new DC context as part of
>>            * the DM atomic state from validation we need to free it and
>>            * retain the existing one instead.
>> +         *
>> +         * Furthermore, since the DM atomic state only contains the DC
>> +         * context and can safely be annulled, we can free the state
>> +         * and clear the associated private object now to free
>> +         * some memory and avoid a possible use-after-free later.
>>            */
>> -        struct dm_atomic_state *new_dm_state, *old_dm_state;
>>
>> -        new_dm_state = dm_atomic_get_new_state(state);
>> -        old_dm_state = dm_atomic_get_old_state(state);
>> +        for (i = 0; i < state->num_private_objs; i++) {
>> +            struct drm_private_obj *obj = state->private_objs[i].ptr;
>>
>> -        if (new_dm_state && old_dm_state) {
>> -            if (new_dm_state->context)
>> -                dc_release_state(new_dm_state->context);
>> +            if (obj->funcs == adev->dm.atomic_obj.funcs) {
>> +                int j = state->num_private_objs-1;
>>
>> -            new_dm_state->context = old_dm_state->context;
>> +                dm_atomic_destroy_state(obj,
>> +                        state->private_objs[i].state);
>> +
>> +                /* If i is not at the end of the array then the
>> +                 * last element needs to be moved to where i was
>> +                 * before the array can safely be truncated.
>> +                 */
>> +                if (i != j)
>> +                    state->private_objs[i] =
>> +                        state->private_objs[j];
>>
>> -            if (old_dm_state->context)
>> -                dc_retain_state(old_dm_state->context);
>> +                state->private_objs[j].ptr = NULL;
>> +                state->private_objs[j].state = NULL;
>> +                state->private_objs[j].old_state = NULL;
>> +                state->private_objs[j].new_state = NULL;
>> +
>> +                state->num_private_objs = j;
>> +                break;
>> +            }
>>           }
>>       }
>>
>> -- 
>> 2.27.0
>>
> 

