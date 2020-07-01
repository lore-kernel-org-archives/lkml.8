Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B6FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C1720780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ACRPC2TV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbgGAPvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:51:45 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2503 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732138AbgGAPvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:51:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efcb1000000>; Wed, 01 Jul 2020 08:51:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 01 Jul 2020 08:51:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 01 Jul 2020 08:51:41 -0700
Received: from [172.20.40.59] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 15:51:40 +0000
Subject: Re: [git pull] drm for 5.8-rc1
To:     Karol Herbst <kherbst@redhat.com>
CC:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
 <20200630230808.wj2xlt44vrszqfzx@box>
 <ef7816b4-72ee-9e0e-8cac-4d80d8343f9f@nvidia.com>
 <CACO55tvT0fOMai7k7oAP1TL42YAuMwJocxk2seNgjYibs+h5oA@mail.gmail.com>
From:   James Jones <jajones@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <11e5ee1d-8b5e-2721-091e-ffbf9e1271d1@nvidia.com>
Date:   Wed, 1 Jul 2020 08:51:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CACO55tvT0fOMai7k7oAP1TL42YAuMwJocxk2seNgjYibs+h5oA@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593618689; bh=Mzvm6cuPWYO3wPA51AT6fuQKzrpGXQe7QiaZZeMs4IA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ACRPC2TVbiVt/VwmKP1HOCHmXGn41MG/BZqANI7FTHKcQXLpfGQdE6dHBj/M7QQRj
         8RfgDnbtcFrRWxxeNorWV0FO35Gg1SNfZ/ybgFbqj+gKBEU50i2+p6JXKYTWcpFDna
         EYVS5cygsBO5636IA2+ZpmJIHQpNVnb49Qz1xd7h9v9uBmalzzL0Kg7MVH7llXmC17
         beJJobeEWP3fWVkE+fU7YNBz+nTdmsym5wwpZaCe5MPyyLlEC/LsInCN2aLi/JBtMD
         OGF27MGZxG35Dy2FCcg/sWLD/a3DGUAg6ldy2OP7tq32EGQ+648sQtVLZqIB9Uf1Y/
         0bYTvAUMTgHKA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/20 4:24 AM, Karol Herbst wrote:
> On Wed, Jul 1, 2020 at 6:45 AM James Jones <jajones@nvidia.com> wrote:
>>
>> This implies something is trying to use one of the old
>> DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK format modifiers with DRM-KMS without
>> first checking whether it is supported by the kernel.  I had tried to
>> force an Xorg+Mesa stack without my userspace patches to hit this error
>> when testing, but must have missed some permutation.  If the stalled
>> Mesa patches go in, this would stop happening of course, but those were
>> held up for a long time in review, and are now waiting on me to make
>> some modifications.
>>
> 
> that's completely irrelevant. If a kernel change breaks userspace,
> it's a kernel bug.

Agreed it is unacceptable to break userspace, but I don't think it's 
irrelevant.  Perhaps the musings on pending userspace patches are.

My intent here was to point out it appears at first glance that 
something isn't behaving as expected in userspace, so fixing this would 
likely require some sort of work-around for broken userspace rather than 
straight-forward fixing of a bug in the kernel logic.  My intent was not 
to shift blame to something besides my code & testing for the 
regression, though I certainly see how it could be interpreted that way.

Regardless, I'm looking in to it.

Thanks,
-James

>> Are you using the modesetting driver in X?  If so, with glamor I
>> presume?  What version of Mesa?  Any distro patches?  Any non-default
>> xorg.conf options that would affect modesetting, your X driver if it
>> isn't modesetting, or glamour?
>>
>> Thanks,
>> -James
>>
>> On 6/30/20 4:08 PM, Kirill A. Shutemov wrote:
>>> On Tue, Jun 02, 2020 at 04:06:32PM +1000, Dave Airlie wrote:
>>>> James Jones (4):
>>> ...
>>>>         drm/nouveau/kms: Support NVIDIA format modifiers
>>>
>>> This commit is the first one that breaks Xorg startup for my setup:
>>> GTX 1080 + Dell UP2414Q (4K DP MST monitor).
>>>
>>> I believe this is the crucial part of dmesg (full dmesg is attached):
>>>
>>> [   29.997140] [drm:nouveau_framebuffer_new] Unsupported modifier: 0x300000000000014
>>> [   29.997143] [drm:drm_internal_framebuffer_create] could not create framebuffer
>>> [   29.997145] [drm:drm_ioctl] pid=3393, ret = -22
>>>
>>> Any suggestions?
>>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
