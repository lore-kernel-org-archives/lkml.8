Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E7DC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C862C20775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tAAE4TEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgG1CuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:50:00 -0400
Received: from mail-bn8nam11on2054.outbound.protection.outlook.com ([40.107.236.54]:41335
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726443AbgG1Ct7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:49:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIZ3u1goS4xlYYlE0AIclXI9Ogdk/kp9A3FTrvWruqxqSzcVCJ/BxPOhSAq2gWsKIltTaLEWKL5iAejsUHnUFBvdO3ekwEAjkdluI25yvDW+5KrIw5FVQ6Ps9fGA0BmhlQiOtIuZJlxKcfmE1Y89KoZxEp7m9EctA62k7SiSXZtCkDwUNR/6ZjFTVKdSYK/pPo0CmJoDOtqoRgIT3NU0r8V14c2mUF98OZ74y+4xjusgVKxtvC5BmNAEqvfuDoT8NrR6Ly5pKuXuBUtZKIEhH/catlULV0UegLK7FtsrTYiKT9jyuJH0I9lADSY3bYNTdLWwDWofR2OeNua2R7Hmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cBP6Q/gKK1T85IOE/o0z7VQqxXUMmSHA0smJuaorf8=;
 b=O8WSfozQQ28PrX7wKNfh4hYQ2SjJWLsovRK49vajU0POI9qsnspb+qhjgShd09bThJ1Coobzz7tYJnqu12I0ti/T2DA+j4JZcHTQdqSfUPmifQ9NZbnqZ0KZXDXQi9MQWW07pMHaP7V/6oum65sRA9xn9les+R19P0WiUjgojx64lCjGvak32o0QiI90zcNx3vJNb8jclV7CzMnbPv9kOgKZReBUzyHDgqTqyLwCUu2v8ZrAc8TTUtRQuOaNfMrVJ0S4wIwmWeKZZ1e3TWWMI9ed33JlZRt9nTlzhkYvGjqu5sxoyEO1hnWL05Ix8qdDl9/R4YgM46sfQAd3fcV4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cBP6Q/gKK1T85IOE/o0z7VQqxXUMmSHA0smJuaorf8=;
 b=tAAE4TEORJi3XY51vVNqRp2TxFf/VFEzjbTBR8uf3Yks50grE7s2rK7x0EuKaetiVBZr3Jd0UZYTIoF8boZYA86Zw7NhCqZWJVBLGcTZg4ngIe+8mhgSSHmmaLUiCNhyT2GrFrrzccnGUJR04bC3zL8KAjs+47T9RltLgB3sU9c=
Authentication-Results: yahoo.com.br; dkim=none (message not signed)
 header.d=none;yahoo.com.br; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2821.namprd12.prod.outlook.com (2603:10b6:a03:9b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 02:49:54 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::7d42:c932:e35f:71b1]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::7d42:c932:e35f:71b1%7]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 02:49:54 +0000
Subject: Re: [PATCH] drm/amd/display: Clear dm_state for fast updates
To:     Daniel Vetter <daniel@ffwll.ch>, Mazin Rezk <mnrzk@protonmail.com>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "anthony.ruhier@gmail.com" <anthony.ruhier@gmail.com>,
        Duncan <1i5t5.duncan@cox.net>, Kees Cook <keescook@chromium.org>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "mphantomx@yahoo.com.br" <mphantomx@yahoo.com.br>
References: <M0lxN5AUlPvzBKULfIBe5BZRwfQGXeMQCdWItYcQ-9P79y32WzExYK2Y0DwyNVtyGelqbvV07_lFk1oeT4cApbT-P_oH0bnxQbMmFsJv_xg=@protonmail.com>
 <ba078fb0-0dbc-df06-cfe9-f9537883f82a@amd.com>
 <e2f55480-c24f-6c85-08d3-21131a22d0bf@amd.com>
 <3b7e3e50-2ff7-eff3-2ffc-abaa4b36ce7f@amd.com>
 <CAKMK7uHCu02P4tvhF4LQbtYeNciU61ONC9EZRmQ-0wEGFPzZgg@mail.gmail.com>
 <Fnx2lsAReNccvQbyMYBgghvef4ekiQ_ZWL0m5BwF-2h48gvnNLghI4zkIWhQwy-H6CiytTXaxEtZ83dYRlzAXeKHujBRLc_tffmcJVWjwuo=@protonmail.com>
 <CAKMK7uFAnedLTp6LJYum6gYj3xaWkuuXJr70UJ48Pxxr-4dA7w@mail.gmail.com>
From:   "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <dcc84e05-54ef-4314-a32b-3c596fccb327@amd.com>
Date:   Mon, 27 Jul 2020 22:49:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAKMK7uFAnedLTp6LJYum6gYj3xaWkuuXJr70UJ48Pxxr-4dA7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::37) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.180] (24.212.165.133) by YQBPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Tue, 28 Jul 2020 02:49:52 +0000
X-Originating-IP: [24.212.165.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 418a86bf-7160-4282-d440-08d832a0e7b5
X-MS-TrafficTypeDiagnostic: BYAPR12MB2821:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2821B656B9009EDE56A30E8BEC730@BYAPR12MB2821.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1s5XTaKfHaD2Xtxvut31raWxv1HWGR8/87gw2lGQdqyCDEIRij7Ik2r2+umBgkTz93Zbr8+qKS+CdsZ6zRKw4w/YppJDbz1mKO2FjLXr7AuPFozB3ZaOSSvbVIfSKhtCbNDiyWiSVrM1pOk727eAyFr4ZaVbc7uovGqygZLdz+xOwtQrNVfOUrZCJSHmvL3tvgJsd4yb2K8iw1Y/JLBjAEFTOlTPtOZRd4njN7Ik02MGINNBt+5fb1Eb+RUsRvSy9CDdGhgR6xviAUaKeSajKCq6w1gjg90k6bcvAm2s7oDb66ag+cPh9C3tuFXXDdYlJR84vt4nlIr5NjOLkl0JMs2TP2VkZp01uLTdlPHVSJD2ANoz3eFhex6I2WqV992XYD/UZIZV5uI8J25aaGRQbhgkd3re1KtJGv6t4uuR6iCBJoGRcxvxsgG3zcYnaWle6Mi9c99zzvcNiORz/W1STw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(53546011)(83080400001)(83380400001)(86362001)(8936002)(31696002)(8676002)(966005)(66476007)(7416002)(52116002)(31686004)(66556008)(36756003)(186003)(316002)(6666004)(54906003)(956004)(2616005)(478600001)(66574015)(5660300002)(26005)(110136005)(4326008)(16576012)(15650500001)(66946007)(30864003)(2906002)(6486002)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZmXczlUebiYzPTauJMqv3J8TomvBPXvWryuBD1+FvH5JWeUCBOQaa9PR1DsgWrTZ/nOGnCnbMHcEDfh94uMoAFAJshUKqlpA3ON/4dETu2hgpv4tKLerib28f/CwjSa5FKMJM8ZhbGgnpnoerLntItVKoxyJYwO0qPVz5+0SX+ZbxseiJQ9uaewU29Kk07FCpwTOi5SS2RiXiYh8c0k+0mhiL+MTKDnl8ngQTxLVL0AlN6R7UIg74sfrRSZpQFsRujBHnEmjNMzJfjaPT545vX1X0beYSxyjxdiXnHMGWyxfYqa80L73H0Qcr1VbJt3YFM+BYLC9faF2504ajnoOX0vp6pkOGNBNziX5OEQgTUlFI9KqJ/+PcSTlr8GVv5nZBWyZjMUP3vEdDBtpKorlYjG8Er8Exh7qVS4zwsStzt1whASn2GsCM/jfVJRrWq4CUX8DRSj2JeEU0+Yzv8RqRHyr43Ob963/sUd0gOdEvZCuaoU4+lw5cBAZKotgjZoR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418a86bf-7160-4282-d440-08d832a0e7b5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 02:49:54.0002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C98bRYefzfzlsxxKe9I1OyvW/ImUJKEEeVtVWdjfV8ani1MlGYiZknhhT3gfnxWl5TxtOfNGoiEnXaBv2S0rZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-27 5:32 p.m., Daniel Vetter wrote:
> On Mon, Jul 27, 2020 at 11:11 PM Mazin Rezk <mnrzk@protonmail.com> wrote:
>>
>> On Monday, July 27, 2020 4:29 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
>>
>>> On Mon, Jul 27, 2020 at 9:28 PM Christian König
>>> <christian.koenig@amd.com> wrote:
>>>>
>>>> Am 27.07.20 um 16:05 schrieb Kazlauskas, Nicholas:
>>>>> On 2020-07-27 9:39 a.m., Christian König wrote:
>>>>>> Am 27.07.20 um 07:40 schrieb Mazin Rezk:
>>>>>>> This patch fixes a race condition that causes a use-after-free during
>>>>>>> amdgpu_dm_atomic_commit_tail. This can occur when 2 non-blocking
>>>>>>> commits
>>>>>>> are requested and the second one finishes before the first.
>>>>>>> Essentially,
>>>>>>> this bug occurs when the following sequence of events happens:
>>>>>>>
>>>>>>> 1. Non-blocking commit #1 is requested w/ a new dm_state #1 and is
>>>>>>> deferred to the workqueue.
>>>>>>>
>>>>>>> 2. Non-blocking commit #2 is requested w/ a new dm_state #2 and is
>>>>>>> deferred to the workqueue.
>>>>>>>
>>>>>>> 3. Commit #2 starts before commit #1, dm_state #1 is used in the
>>>>>>> commit_tail and commit #2 completes, freeing dm_state #1.
>>>>>>>
>>>>>>> 4. Commit #1 starts after commit #2 completes, uses the freed dm_state
>>>>>>> 1 and dereferences a freelist pointer while setting the context.
>>>>>>
>>>>>> Well I only have a one mile high view on this, but why don't you let
>>>>>> the work items execute in order?
>>>>>>
>>>>>> That would be better anyway cause this way we don't trigger a cache
>>>>>> line ping pong between CPUs.
>>>>>>
>>>>>> Christian.
>>>>>
>>>>> We use the DRM helpers for managing drm_atomic_commit_state and those
>>>>> helpers internally push non-blocking commit work into the system
>>>>> unbound work queue.
>>>>
>>>> Mhm, well if you send those helper atomic commits in the order A,B and
>>>> they execute it in the order B,A I would call that a bug :)
>>>
>>> The way it works is it pushes all commits into unbound work queue, but
>>> then forces serialization as needed. We do _not_ want e.g. updates on
>>> different CRTC to be serialized, that would result in lots of judder.
>>> And hw is funny enough that there's all kinds of dependencies.
>>>
>>> The way you force synchronization is by adding other CRTC state
>>> objects. So if DC is busted and can only handle a single update per
>>> work item, then I guess you always need all CRTC states and everything
>>> will be run in order. But that also totally kills modern multi-screen
>>> compositors. Xorg isn't modern, just in case that's not clear :-)
>>>
>>> Lucking at the code it seems like you indeed have only a single dm
>>> state, so yeah global sync is what you'll need as immediate fix, and
>>> then maybe fix up DM to not be quite so silly ... or at least only do
>>> the dm state stuff when really needed.
>>>
>>> We could also sprinkle the drm_crtc_commit structure around a bit
>>> (it's the glue that provides the synchronization across commits), but
>>> since your dm state is global just grabbing all crtc states
>>> unconditionally as part of that is probably best.
>>>
>>>>> While we could duplicate a copy of that code with nothing but the
>>>>> workqueue changed that isn't something I'd really like to maintain
>>>>> going forward.
>>>>
>>>> I'm not talking about duplicating the code, I'm talking about fixing the
>>>> helpers. I don't know that code well, but from the outside it sounds
>>>> like a bug there.
>>>>
>>>> And executing work items in the order they are submitted is trivial.
>>>>
>>>> Had anybody pinged Daniel or other people familiar with the helper code
>>>> about it?
>>>
>>> Yeah something is wrong here, and the fix looks horrible :-)
>>>
>>> Aside, I've also seen some recent discussion flare up about
>>> drm_atomic_state_get/put used to paper over some other use-after-free,
>>> but this time related to interrupt handlers. Maybe a few rules about
>>> that:
>>> - dont
>>> - especially not when it's interrupt handlers, because you can't call
>>> drm_atomic_state_put from interrupt handlers.
>>>
>>> Instead have an spin_lock_irq to protect the shared date with your
>>> interrupt handler, and _copy_ the date over. This is e.g. what
>>> drm_crtc_arm_vblank_event does.
>>
>> Nicholas wrote a patch that attempted to resolve the issue by adding every
>> CRTC into the commit to use use the stall checks. [1] While this forces
>> synchronisation on commits, it's kind of a hacky method that may take a
>> toll on performance.
>>
>> Is it possible to have a DRM helper that forces synchronisation on some
>> commits without having to add every CRTC into the commit?
>>
>> Also, is synchronisation really necessary for fast updates in amdgpu?
>> I'll admit, the idea of eliminating the use-after-free bug by eliminating
>> the use entirely doesn't seem ideal; but is forcing synchronisation on
>> these updates that much better?
> 
> Well clearing the dc_state pointer here and then allocating another
> one in atomic_commit_tail also looks fishy. The proper fix is probably
> a lot more involved, but yeah interim fix is to grab all crtc states
> iff you also grabbed the dm_atomic_state structure. Real fix is to
> only do this when necessary, which pretty much means the dc_state
> needs to be somehow split up, or there needs to be some guarantees
> about when it's necessary and when not. Otherwise parallel commits on
> different CRTC are not possible with the current dc backend code.

Thanks for spending some time to help take a look at this as well.

The DRM documentation (at least at the time) seemed to imply that 
subclassing DRM private state was for legacy usage only and DRM wanted 
to move away from it. DRM private objects seemed to fit as the nicer 
atomic method for handling this since they have old/new, but as you can 
guess from this issue it's a mess (from our end).

The first step to fixing this is going back to subclassing DRM state.

It's actually the right tool for the job for allocating temporary state 
outside of the core DRM objects, and we need this to form the DC state 
object and necessary stream update bundles which might be too big to fit 
on the stack for commit check/commit tail. We'll be a lot closer to 
fixing the lockdep issues this way once we get around to getting rid of 
allocations in the DC commit paths.

The second step is to fix validation itself. The old state requirement 
for checking stream/plane updates was actually an entirely pointless 
endeavor since dc global validation doesn't every look at updates, just 
the final state for a set streams/planes - it's stateless.

We wanted to rely on DC to internally notify DM when DRM changes would 
do this, but DM actually requires this logic as well to know when to 
use a fast path vs a full programming path to recreate planes/streams 
based on the new DRM state to pass into validation.

State updates will change to be formed from a delta of the old/new plane 
state, but the new one can be discarded if not needed.

Any update that requires clock/bandwidth changes will have to add all 
the CRTCs and stall for any fast updates to complete first. This is 
because they could potentially reshuffle around the pipes as well, but 
these updates happen infrequently enough that the stall isn't too bad here.

DC state unfortunately still does need to exist due to requirements on 
hardware resources/pipe splitting that don't fit nicely into the DRM 
infrastructure. It's really hard to shift everything over into the DRM 
infrastructure as well because of the DKMS problem we chatted about 
briefly last year at XDC.

I'd really like to tackle a third step as well at some point, and that's 
cleaning up our IRQ management. Our interrupt handlers unfortunately 
access DRM state directly (since it's so easy to do) and thus introduce 
a requirement that it doesn't get changed while these are still enabled. 
This requires us to introduce our own stall checks in atomic_check and 
perform the interrupt disable in commit before the state swap.

The fix for this one isn't too bad, but it's tedious - copying all the 
state we need to the interrupt handlers before enabling them and letting 
them continue to work off of that state. This way we can remove the 
stall from atomic_check and actually disable/enable interrupts from 
commit_tail like we should be doing.

> 
> See also my dma-fence annotation fixup patch, there dc_state also gets
> in the way:
> 
> https://lore.kernel.org/dri-devel/20200707201229.472834-21-daniel.vetter@ffwll.ch/
> 
> Nicholas, btw I'm still waiting for some dc feedback on that entire
> series, and what/if there's plans to fix these issues properly.
> 
> Maybe even going back to the subclassed drm_atomic_state might be
> better than what we currently have.
> -Daniel

I've taken a look at that series but forgot to ACK. While this isn't the 
same thread for it, you can have my:

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

...on the DC/DM bits. Everything you've identified there is correct and 
it's something I'd really like to get around to taking a look at by the 
end of the year, hopefully.

State allocations will be solved by the DM state allocation rework and 
the tiling flags thing needs to be solved by storing those in 
atomic_check instead on the plane.

Regards,
Nicholas Kazlauskas

>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=207383#c96
>>
>> Thanks,
>> Mazin Rezk
>>
>>>
>>> Cheers, Daniel
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Regards,
>>>>> Nicholas Kazlauskas
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Since this bug has only been spotted with fast commits, this patch
>>>>>>> fixes
>>>>>>> the bug by clearing the dm_state instead of using the old dc_state for
>>>>>>> fast updates. In addition, since dm_state is only used for its dc_state
>>>>>>> and amdgpu_dm_atomic_commit_tail will retain the dc_state if none is
>>>>>>> found,
>>>>>>> removing the dm_state should not have any consequences in fast updates.
>>>>>>>
>>>>>>> This use-after-free bug has existed for a while now, but only caused a
>>>>>>> noticeable issue starting from 5.7-rc1 due to 3202fa62f ("slub:
>>>>>>> relocate
>>>>>>> freelist pointer to middle of object") moving the freelist pointer from
>>>>>>> dm_state->base (which was unused) to dm_state->context (which is
>>>>>>> dereferenced).
>>>>>>>
>>>>>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207383
>>>>>>> Fixes: bd200d190f45 ("drm/amd/display: Don't replace the dc_state
>>>>>>> for fast updates")
>>>>>>> Reported-by: Duncan <1i5t5.duncan@cox.net>
>>>>>>> Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
>>>>>>> ---
>>>>>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 36
>>>>>>> ++++++++++++++-----
>>>>>>>    1 file changed, 27 insertions(+), 9 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>>> index 86ffa0c2880f..710edc70e37e 100644
>>>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>>> @@ -8717,20 +8717,38 @@ static int amdgpu_dm_atomic_check(struct
>>>>>>> drm_device *dev,
>>>>>>>             * the same resource. If we have a new DC context as part of
>>>>>>>             * the DM atomic state from validation we need to free it and
>>>>>>>             * retain the existing one instead.
>>>>>>> +         *
>>>>>>> +         * Furthermore, since the DM atomic state only contains the DC
>>>>>>> +         * context and can safely be annulled, we can free the state
>>>>>>> +         * and clear the associated private object now to free
>>>>>>> +         * some memory and avoid a possible use-after-free later.
>>>>>>>             */
>>>>>>> -        struct dm_atomic_state *new_dm_state, *old_dm_state;
>>>>>>>
>>>>>>> -        new_dm_state = dm_atomic_get_new_state(state);
>>>>>>> -        old_dm_state = dm_atomic_get_old_state(state);
>>>>>>> +        for (i = 0; i < state->num_private_objs; i++) {
>>>>>>> +            struct drm_private_obj *obj = state->private_objs[i].ptr;
>>>>>>>
>>>>>>> -        if (new_dm_state && old_dm_state) {
>>>>>>> -            if (new_dm_state->context)
>>>>>>> -                dc_release_state(new_dm_state->context);
>>>>>>> +            if (obj->funcs == adev->dm.atomic_obj.funcs) {
>>>>>>> +                int j = state->num_private_objs-1;
>>>>>>>
>>>>>>> -            new_dm_state->context = old_dm_state->context;
>>>>>>> +                dm_atomic_destroy_state(obj,
>>>>>>> +                        state->private_objs[i].state);
>>>>>>> +
>>>>>>> +                /* If i is not at the end of the array then the
>>>>>>> +                 * last element needs to be moved to where i was
>>>>>>> +                 * before the array can safely be truncated.
>>>>>>> +                 */
>>>>>>> +                if (i != j)
>>>>>>> +                    state->private_objs[i] =
>>>>>>> +                        state->private_objs[j];
>>>>>>>
>>>>>>> -            if (old_dm_state->context)
>>>>>>> -                dc_retain_state(old_dm_state->context);
>>>>>>> +                state->private_objs[j].ptr = NULL;
>>>>>>> +                state->private_objs[j].state = NULL;
>>>>>>> +                state->private_objs[j].old_state = NULL;
>>>>>>> +                state->private_objs[j].new_state = NULL;
>>>>>>> +
>>>>>>> +                state->num_private_objs = j;
>>>>>>> +                break;
>>>>>>> +            }
>>>>>>>            }
>>>>>>>        }
>>>>>>>
>>>>>>> --
>>>>>>> 2.27.0
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>
>>>
>>>
>>> --
>>> Daniel Vetter
>>> Software Engineer, Intel Corporation
>>> http://blog.ffwll.ch/
> 
> 
> 

