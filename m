Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0338CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3202075A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590600042;
	bh=BwfETRuJsL3qxCceuWp5lO2rCBH9kkdeXqZIQKna8jE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SJ7eNVYq06kaWB4CshOTWlnTgqbLilYQYdb+4lUpxVu3sr0IMcyCD0WoblV5S4PoM
	 FQiYRJt/VbfgjIgFEoEgw8EIkab0GC4mUpmw323MXzjgDRnublAyNfiIGnKMcGLqcY
	 MFkcRtpPb2BFq3QwuekR4Wla6m0/LJXuPCflPipo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387803AbgE0RUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:32992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730056AbgE0RUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:20:41 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC8692073B;
        Wed, 27 May 2020 17:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590600041;
        bh=BwfETRuJsL3qxCceuWp5lO2rCBH9kkdeXqZIQKna8jE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1sKXXvkamBoUL16wZ4XHWdwrTVmgmTBcJV3j3m57/HWK/XIH3YIkOGUNaIuQomyX6
         ntKTBzOgv4YDBU7y/4JAtsh4+0m1MD9J9RXVS6mxLfDt4tjyC40YsbxliF06Wn4bRv
         qTINIUYSgVbDIvsiXDsnXmp9GK/b+mEe1kVtSZRY=
Date:   Wed, 27 May 2020 19:20:36 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 0/7] media: atomisp: Address several clang warnings
Message-ID: <20200527192036.2575daf5@coco.lan>
In-Reply-To: <20200527164521.GA1239557@ubuntu-s3-xlarge-x86>
References: <20200527071150.3381228-1-natechancellor@gmail.com>
        <20200527104525.5e6cd93b@coco.lan>
        <20200527164521.GA1239557@ubuntu-s3-xlarge-x86>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 27 May 2020 09:45:21 -0700
Nathan Chancellor <natechancellor@gmail.com> escreveu:

> On Wed, May 27, 2020 at 10:45:25AM +0200, Mauro Carvalho Chehab wrote:
> > Em Wed, 27 May 2020 00:11:43 -0700
> > Nathan Chancellor <natechancellor@gmail.com> escreveu:
> >   
> > > Hi all,
> > > 
> > > This series aims to clean up the code while addressing the majority of
> > > clang warnings in this driver, some found by the 0day bot and others
> > > found by me.
> > > 
> > > There are several enum conversion warnings that happen, which I do not
> > > really know how to solve without understanding how exactly this driver
> > > works. I would appreciate some guidance or a solution. Below are the
> > > warnings, sorry for not wrapping them but they would be hard to read
> > > otherwise.  
> > 
> > ...   
> > > ../drivers/staging/media/atomisp//pci/atomisp_compat_css20.h:117:22: note: expanded from macro 'CSS_ID'
> > > #define CSS_ID(val)     (IA_ ## val)  
> > ...
> > 
> > I actually wrote a patch getting rid of this ugly thing:
> > 
> > 	https://git.linuxtv.org/mchehab/experimental.git/commit/?h=atomisp_v3&id=cf6a15543ace1e99364911c0b7a2f6b8f2f43021
> > 
> > This one was already submitted upstream (not merged yet), but there
> > are also lots of other patches on my working tree.  
> 
> Ah excellent, that makes the warnings a lot more readable. I am still
> not sure how to reconcile the differences, it might be easier to just
> change the types in the struct to int.
> 
> ../drivers/staging/media/atomisp/pci/atomisp_subdev.c:49:68: warning: implicit conversion from enumeration type 'enum ia_css_frame_format' to different enumeration type 'enum atomisp_input_format' [-Wenum-conversion]
>         { V4L2_MBUS_FMT_CUSTOM_NV21, 12, 12, IA_CSS_FRAME_FORMAT_NV21, 0, IA_CSS_FRAME_FORMAT_NV21 },
>         ~                                                                 ^~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/staging/media/atomisp/pci/atomisp_subdev.c:49:39: warning: implicit conversion from enumeration type 'enum ia_css_frame_format' to different enumeration type 'enum atomisp_input_format' [-Wenum-conversion]
>         { V4L2_MBUS_FMT_CUSTOM_NV21, 12, 12, IA_CSS_FRAME_FORMAT_NV21, 0, IA_CSS_FRAME_FORMAT_NV21 },
>         ~                                    ^~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/staging/media/atomisp/pci/atomisp_subdev.c:48:68: warning: implicit conversion from enumeration type 'enum ia_css_frame_format' to different enumeration type 'enum atomisp_input_format' [-Wenum-conversion]
>         { V4L2_MBUS_FMT_CUSTOM_NV12, 12, 12, IA_CSS_FRAME_FORMAT_NV12, 0, IA_CSS_FRAME_FORMAT_NV12 },
>         ~                                                                 ^~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/staging/media/atomisp/pci/atomisp_subdev.c:48:39: warning: implicit conversion from enumeration type 'enum ia_css_frame_format' to different enumeration type 'enum atomisp_input_format' [-Wenum-conversion]
>         { V4L2_MBUS_FMT_CUSTOM_NV12, 12, 12, IA_CSS_FRAME_FORMAT_NV12, 0, IA_CSS_FRAME_FORMAT_NV12 },
>         ~                                    ^~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/staging/media/atomisp/pci/atomisp_subdev.c:47:34: warning: implicit conversion from enumeration type 'enum ia_css_frame_format' to different enumeration type 'enum atomisp_input_format' [-Wenum-conversion]
>         { MEDIA_BUS_FMT_JPEG_1X8, 8, 8, IA_CSS_FRAME_FORMAT_BINARY_8, 0, ATOMISP_INPUT_FORMAT_BINARY_8 },
>         ~                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 5 warnings generated.

Well, I guess we should just get rid of the duplication there,

> 
> > I'll try to apply your patch series on it, once I'll be able to
> > fix a bug with mmap support.  
> 
> It looks like all of them apply to your experimental branch aside from
> patch 3, which you handled in a different way.

Ok. I'll apply your patch series on my tree.

Thanks,
Mauro
