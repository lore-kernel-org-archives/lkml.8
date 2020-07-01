Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AECC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 04:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE5C020656
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 04:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AR+QzRyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgGAEkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 00:40:20 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2038 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgGAEkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 00:40:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efc13810000>; Tue, 30 Jun 2020 21:39:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 21:40:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 30 Jun 2020 21:40:19 -0700
Received: from [172.20.40.91] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 04:40:18 +0000
Subject: Re: [git pull] drm for 5.8-rc1
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ben Skeggs <bskeggs@redhat.com>
CC:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
 <20200630230808.wj2xlt44vrszqfzx@box>
X-Nvconfidentiality: public
From:   James Jones <jajones@nvidia.com>
Message-ID: <ef7816b4-72ee-9e0e-8cac-4d80d8343f9f@nvidia.com>
Date:   Tue, 30 Jun 2020 21:40:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630230808.wj2xlt44vrszqfzx@box>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593578369; bh=+EcA5Zf1+TGhpdgcqoYfsJmtAG2eWp3seOejdMxbEHA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=AR+QzRyyjlLzFHQBKv6n2phZPIaaf/68YMPvMbEUu6ogLteDSj7Lisu6zFq+SwnY8
         rxs5NhwgypkI+uRm4SeQp393V6l2EwDAc8Dtubi6N8OdJstp0I+dlJI7TxofaJmOk/
         nd2iMCKA8x+9sdgAm6JhZfFaE2m+/AcD4Tc95+GALYEOi0sEBxqVuwMDgMJZNbx1Dv
         vERu7Go6dY9frmC4VZUFcv8NOM9yf/1+BBZwpX7bcRfC8eFZPuGkswI3nKjr4PnIk9
         4TBDQp/fG0+rn6K/1/ntmfPiG9Mxg2pcvz4tGRIrhPoURtwgSpzXeUss/CsZ2ZC07/
         ukwjjZrOj0PAg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implies something is trying to use one of the old 
DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK format modifiers with DRM-KMS without 
first checking whether it is supported by the kernel.  I had tried to 
force an Xorg+Mesa stack without my userspace patches to hit this error 
when testing, but must have missed some permutation.  If the stalled 
Mesa patches go in, this would stop happening of course, but those were 
held up for a long time in review, and are now waiting on me to make 
some modifications.

Are you using the modesetting driver in X?  If so, with glamor I 
presume?  What version of Mesa?  Any distro patches?  Any non-default 
xorg.conf options that would affect modesetting, your X driver if it 
isn't modesetting, or glamour?

Thanks,
-James

On 6/30/20 4:08 PM, Kirill A. Shutemov wrote:
> On Tue, Jun 02, 2020 at 04:06:32PM +1000, Dave Airlie wrote:
>> James Jones (4):
> ...
>>        drm/nouveau/kms: Support NVIDIA format modifiers
> 
> This commit is the first one that breaks Xorg startup for my setup:
> GTX 1080 + Dell UP2414Q (4K DP MST monitor).
> 
> I believe this is the crucial part of dmesg (full dmesg is attached):
> 
> [   29.997140] [drm:nouveau_framebuffer_new] Unsupported modifier: 0x300000000000014
> [   29.997143] [drm:drm_internal_framebuffer_create] could not create framebuffer
> [   29.997145] [drm:drm_ioctl] pid=3393, ret = -22
> 
> Any suggestions?
> 
