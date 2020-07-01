Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5981EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E6DE20780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eALCYy23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732596AbgGARhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:37:21 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19446 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgGARhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 13:37:20 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efcc99e0000>; Wed, 01 Jul 2020 10:36:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 01 Jul 2020 10:37:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 01 Jul 2020 10:37:20 -0700
Received: from [172.20.40.59] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 17:37:19 +0000
Subject: Re: [git pull] drm for 5.8-rc1
To:     Karol Herbst <kherbst@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
CC:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
 <20200630230808.wj2xlt44vrszqfzx@box>
 <ef7816b4-72ee-9e0e-8cac-4d80d8343f9f@nvidia.com>
 <CACO55tvT0fOMai7k7oAP1TL42YAuMwJocxk2seNgjYibs+h5oA@mail.gmail.com>
 <11e5ee1d-8b5e-2721-091e-ffbf9e1271d1@nvidia.com>
 <CAKMK7uEzoFyW6o1gP6xszWH7fKHrVSR32JLs73KeFfYgD=BHPQ@mail.gmail.com>
 <CACO55tu8z_Rt50QXUr+MBKV_vtxZfVgz8Cfoj2xbinbtTYM3WQ@mail.gmail.com>
From:   James Jones <jajones@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <efaf3c55-e2af-09ec-430e-79064fe43668@nvidia.com>
Date:   Wed, 1 Jul 2020 10:37:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CACO55tu8z_Rt50QXUr+MBKV_vtxZfVgz8Cfoj2xbinbtTYM3WQ@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593624990; bh=cXZEr27LprXJYShblnGcgmM6MY17nsJ+vvd3S/zGFtU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=eALCYy231tTvAeD0KL4YDaypZ9tMUtGLPZ4ZcpBxcxf5hiRPMVUy9qTvmPUT9LBes
         ttc6Utp/MX+JPE9mAUnLPTPUFaTJg2A3HTtPM4IDKxbH3+TA4Oa021KJyEqWJoiJFq
         3vdu7hMrbe7/mQJ+PnAqDFJEOAiDgBZxEOlVQ7b4obhmaImEUWfofnRG8yDOqMmcxD
         GaVCMSwqTS492TIXi7dOZbzXzf8bZ8rOJNQnqgu270jQFc51aKQv352tkJ2Zkahs+C
         9zbDdAXCqSp3I5RLqDLalpKse2gLQcOykf29lSXcSJO2tthnOxZqsRT1be1jI+jrB0
         4iakkCjdfCHRw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/20 10:04 AM, Karol Herbst wrote:
> On Wed, Jul 1, 2020 at 6:01 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>>
>> On Wed, Jul 1, 2020 at 5:51 PM James Jones <jajones@nvidia.com> wrote:
>>>
>>> On 7/1/20 4:24 AM, Karol Herbst wrote:
>>>> On Wed, Jul 1, 2020 at 6:45 AM James Jones <jajones@nvidia.com> wrote:
>>>>>
>>>>> This implies something is trying to use one of the old
>>>>> DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK format modifiers with DRM-KMS without
>>>>> first checking whether it is supported by the kernel.  I had tried to
>>>>> force an Xorg+Mesa stack without my userspace patches to hit this error
>>>>> when testing, but must have missed some permutation.  If the stalled
>>>>> Mesa patches go in, this would stop happening of course, but those were
>>>>> held up for a long time in review, and are now waiting on me to make
>>>>> some modifications.
>>>>>
>>>>
>>>> that's completely irrelevant. If a kernel change breaks userspace,
>>>> it's a kernel bug.
>>>
>>> Agreed it is unacceptable to break userspace, but I don't think it's
>>> irrelevant.  Perhaps the musings on pending userspace patches are.
>>>
>>> My intent here was to point out it appears at first glance that
>>> something isn't behaving as expected in userspace, so fixing this would
>>> likely require some sort of work-around for broken userspace rather than
>>> straight-forward fixing of a bug in the kernel logic.  My intent was not
>>> to shift blame to something besides my code & testing for the
>>> regression, though I certainly see how it could be interpreted that way.
>>>
>>> Regardless, I'm looking in to it.
>>
> 
> I assume the MR you were talking about is
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/3724 ?

Correct.

> I am
> also aware of the tegra driver being broken on my jetson nano and I am
> now curious if this MR could fix this bug as well... and sorry for the
> harsh reply, I was just a annoyed by the fact that "everything
> modifier related is just breaking things", first tegra and that nobody
> is looking into fixing it and then apparently the userspace code being
> quite broken as well :/
> 
> Anyway, yeah I trust you guys on figuring out the keeping "broken"
> userspace happy from a kernel side and maybe I can help out with
> reviewing the mesa bits. I am just wondering if it could help with the
> tegra situation giving me more reasons to look into it as this would
> solve other issues I should be working on :)

Not sure if you're claiming this, but if there's Tegra breakage 
attributable to this patch series, I'd love to hear more details there 
as well.  The Tegra patches did have backwards-compat code to handle the 
old modifiers, since Tegra was the only working use case I could find 
for them within the kernel itself.  However, the Tegra kernel patches 
are independent (and haven't even been reviewed yet to my knowledge), so 
Tegra shouldn't be affected at all given it uses TegraDRM rather than 
Nouveau's modesetting driver.

If there are just general existing issues with modifier support on 
Tegra, let's take that to a smaller venue.  I probably won't be as much 
help there, but I can at least try to help get some eyes on it.

Thanks,
-James

>> If we do need to have a kernel workaround I'm happy to help out, I've
>> done a bunch of these and occasionally it's good to get rather
>> creative :-)
>>
>> Ideally we'd also push a minimal fix in userspace to all stable
>> branches and make sure distros upgrade (might need releases if some
>> distro is stuck on old horrors), so that we don't have to keep the
>> hack in place for 10+ years or so. Definitely if the hack amounts to
>> disabling modifiers on nouveau, that would be kinda sad.
>> -Daniel
>>
>>>
>>> Thanks,
>>> -James
>>>
>>>>> Are you using the modesetting driver in X?  If so, with glamor I
>>>>> presume?  What version of Mesa?  Any distro patches?  Any non-default
>>>>> xorg.conf options that would affect modesetting, your X driver if it
>>>>> isn't modesetting, or glamour?
>>>>>
>>>>> Thanks,
>>>>> -James
>>>>>
>>>>> On 6/30/20 4:08 PM, Kirill A. Shutemov wrote:
>>>>>> On Tue, Jun 02, 2020 at 04:06:32PM +1000, Dave Airlie wrote:
>>>>>>> James Jones (4):
>>>>>> ...
>>>>>>>          drm/nouveau/kms: Support NVIDIA format modifiers
>>>>>>
>>>>>> This commit is the first one that breaks Xorg startup for my setup:
>>>>>> GTX 1080 + Dell UP2414Q (4K DP MST monitor).
>>>>>>
>>>>>> I believe this is the crucial part of dmesg (full dmesg is attached):
>>>>>>
>>>>>> [   29.997140] [drm:nouveau_framebuffer_new] Unsupported modifier: 0x300000000000014
>>>>>> [   29.997143] [drm:drm_internal_framebuffer_create] could not create framebuffer
>>>>>> [   29.997145] [drm:drm_ioctl] pid=3393, ret = -22
>>>>>>
>>>>>> Any suggestions?
>>>>>>
>>>>> _______________________________________________
>>>>> dri-devel mailing list
>>>>> dri-devel@lists.freedesktop.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>>>
>>>>
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>>
>>
>>
>>
>> --
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> http://blog.ffwll.ch
>>
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
