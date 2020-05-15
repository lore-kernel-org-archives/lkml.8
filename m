Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99577C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB7120767
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589550256;
	bh=r+eQELqrjBFddckG+Gt03LDcdnmhomqDE2Tftv04Fr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kzsq9Z2hFK6Dj9pJJlFHVk8rGqV6N7z/wsNunThrcXF8BEGarHSdJgXy5xz1Pdrkc
	 gmx0KLzYcrIu7j6KC2ofBFqN69+wL1T0C3QGeybqNfLVrbywZRaHUuiy7XAm8LtIPM
	 RU2n1wsLcInWklc5Bj36s/05g/MGIrvYC3jHs3OY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgEONoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:44:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgEONoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:44:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FED420657;
        Fri, 15 May 2020 13:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589550254;
        bh=r+eQELqrjBFddckG+Gt03LDcdnmhomqDE2Tftv04Fr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dMa9Tj35qNPBPJTGs1EME9EvNtrPJWYTB9yUNjyyWX7vjz+zVlSeWKP9QlqDJ342d
         paRbvUDpSJsMiQ/hguOnmnqH4SuxjgKwnFwTE/b7wDRrVMi3T4JordOKtzxdgKSXHt
         3WgzAimPEq2T2kXGisLnbuwstRyPHQocD5xePv2g=
Date:   Fri, 15 May 2020 15:44:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vaibhav Agarwal <vaibhav.sr@gmail.com>
Cc:     Mark Greer <mgreer@animalcreek.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] greybus: audio: remove unused code
Message-ID: <20200515134412.GA2083757@kroah.com>
References: <20200507212912.599433-1-alexandre.belloni@bootlin.com>
 <20200513174530.GA32096@animalcreek.com>
 <CAAs3649-3dAmUqjLiEP8Ar3dKamp7ek1o0R5WN3g8kxTgz6fFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAs3649-3dAmUqjLiEP8Ar3dKamp7ek1o0R5WN3g8kxTgz6fFg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 01:07:36AM +0530, Vaibhav Agarwal wrote:
> On Wed, May 13, 2020 at 11:15 PM Mark Greer <mgreer@animalcreek.com> wrote:
> >
> > On Thu, May 07, 2020 at 11:29:11PM +0200, Alexandre Belloni wrote:
> > > GREYBUS_AUDIO_MSM8994 is not an existing configuration option and as
> > > reported in September 2016, it depends on an "out-of-tree qualcomm audio
> > > driver". This driver never made it upstream.
> > >
> > > https://lore.kernel.org/lkml/20160921073905.GA31263@kroah.com/
> > >
> > > Moreover, there doesn't seem to be any interest in actually fixing the
> > > driver as it uses ASoC APIs that have been removed from the kernel in 2018
> > > as shown by its use of snd_soc_register_codec and
> > > snd_soc_codec_get_drvdata, removed in commit 999f7f5af8eb ("ASoC: remove
> > > Codec related code").
> > >
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > ---
> Hi Alexandre,
> 
> As mentioned in the mail archive referred, the GB Codec driver that is
> currently available in kernel tree is dependent on qualcomm audio
> driver. And some time later I made some minor modifications to remove
> the unnecessary dependencies. However, I missed to share the same with
> the community :(
> 
> Thanks to you for triggering the thread. Now, I could retrieve my local
> changes and I have been in the process of updating it again to make it
> compatible with latest kernel.
> 
> I'm planning to share the same here in the next few days.  I'll mark you
> in CC to seek your review comments as well.

I'll give you a few more days for that patch to be sent before I apply
this one...

thanks,

greg k-h
