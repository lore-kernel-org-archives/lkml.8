Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFD7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A46B32084D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596179466;
	bh=X/J2+wggs6Q/+dQEZBM7rPDCO1dMLe1HR5mFj7eHskc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sAjoPL53bqYbOcqzHzVaOVeKijWNzMD+Qd1YFaC2qqSlcqWfmgxm03zonyFTk4fRk
	 RVV2yEMqIrx+ATJGz9FfA+u3n8HnBUr+U0qnBlZKXd4S6kzQBIwa3feNinLYcqoz8s
	 GwWfFGpKFT66qwQ0riHhQ3H9iCwZvNW8P/esFnDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbgGaHLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 03:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731367AbgGaHLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:11:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01AEA20829;
        Fri, 31 Jul 2020 07:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596179464;
        bh=X/J2+wggs6Q/+dQEZBM7rPDCO1dMLe1HR5mFj7eHskc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l7mivUnGiCm8GPMsG0EUxQkqb4xEooddqGRjlQ/mXhi7+nGoyhXyGuXO13fhPdcxK
         rt2gRV96hVA2pro+AhT6fSb6Wc5jnVgcRKARXsj5aZWjStbLclPOFxzAGKjtQ9bCxE
         RIlwYW7LSBcD0ahRmmF22pI7zVbssTSi2S36k1HI=
Date:   Fri, 31 Jul 2020 09:10:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Luben Tuikov <luben.tuikov@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Xiaojie Yuan <xiaojie.yuan@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Marek =?utf-8?B?T2zFocOhaw==?= <marek.olsak@amd.com>,
        Hans de Goede <hdegoede@redhat.com>, Trek <trek00@inbox.ru>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>, Leo Liu <leo.liu@amd.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH] drm/amdgpu: Prevent
 kernel-infoleak in amdgpu_info_ioctl()
Message-ID: <20200731071052.GA1522097@kroah.com>
References: <20200728192924.441570-1-yepeilin.cs@gmail.com>
 <30b2a31f-77c2-56c1-ecde-875c6eea99d5@gmail.com>
 <CADnq5_NXOiAc7q5gQqF_wwtJD1o6nHjXM4O3gY6EwAQe9iOtXw@mail.gmail.com>
 <8c5cf518-12d2-7495-7822-c7ebf8e61972@amd.com>
 <20200731065322.GA1518178@kroah.com>
 <690213fd-d3d2-2253-dcb2-367a65b34f38@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <690213fd-d3d2-2253-dcb2-367a65b34f38@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 08:57:53AM +0200, Christian König wrote:
> Am 31.07.20 um 08:53 schrieb Greg Kroah-Hartman:
> > On Thu, Jul 30, 2020 at 05:09:07PM -0400, Luben Tuikov wrote:
> > > On 2020-07-29 9:49 a.m., Alex Deucher wrote:
> > > > On Wed, Jul 29, 2020 at 4:11 AM Christian König
> > > > <ckoenig.leichtzumerken@gmail.com> wrote:
> > > > > Am 28.07.20 um 21:29 schrieb Peilin Ye:
> > > > > > Compiler leaves a 4-byte hole near the end of `dev_info`, causing
> > > > > > amdgpu_info_ioctl() to copy uninitialized kernel stack memory to userspace
> > > > > > when `size` is greater than 356.
> > > > > > 
> > > > > > In 2015 we tried to fix this issue by doing `= {};` on `dev_info`, which
> > > > > > unfortunately does not initialize that 4-byte hole. Fix it by using
> > > > > > memset() instead.
> > > > > > 
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Fixes: c193fa91b918 ("drm/amdgpu: information leak in amdgpu_info_ioctl()")
> > > > > > Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> > > > > > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> > > > > Reviewed-by: Christian König <christian.koenig@amd.com>
> > > > > 
> > > > > I can't count how many of those we have fixed over the years.
> > > > > 
> > > > > At some point we should probably document that using "= {}" or "= { 0 }"
> > > > > in the kernel is a really bad idea and should be avoided.
> > > > Moreover, it seems like different compilers seem to behave relatively
> > > > differently with these and we often get reports of warnings with these
> > > > on clang.  When in doubt, memset.
> > > There are quite a few of those under drivers/gpu/drm, for "amd/", "scheduler/"
> > > drm*.c files,
> > > 
> > > $find . \( -regex "./drm.*\.c" -or -regex "./amd/.*\.c" -or -regex "./scheduler/.*\.c" \) -exec egrep -n -- " *= *{ *(|NULL|0) *}" \{\} \+ | wc -l
> > > 374
> > > $_
> > > 
> > > Out of which only 16 are of the non-ISO C variety, "= {}",
> > > 
> > > $find . \( -regex "./drm.*\.c" -or -regex "./amd/.*\.c" -or -regex "./scheduler/.*\.c" \) -exec egrep -n -- " *= *{ *}" \{\} \+ | wc -l
> > > 16
> > > $_
> > > 
> > > Perhaps the latter are the more pressing ones, since it is a C++ initializer and not a ISO C one.
> > It only matters when we care copying the data to userspace, if it all
> > stays in the kernel, all is fine.
> 
> Well only as long as you don't try to compute a CRC32, MD5 or any
> fingerprint for a hash from the bytes from the structure.
> 
> Then it fails horrible and you wonder why the code doesn't works as
> expected.

True, but the number of times I have ever needed to do that to a
structure for a driver is, um, never...

If a structure ever needs to have that happen to it, I would sure hope
the developer was aware of padding fields, otherwise, well, someone
needs to take away their C language certification :)

thanks,

greg k-h
