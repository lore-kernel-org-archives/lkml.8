Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2049DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E96D420657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="dC/womSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbgGOImG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729227AbgGOImG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:42:06 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D04C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:42:05 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so1677405ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dh5uuKPcBQ93XIoeGbLQVCWZw7SmH2LeLngrc8vlsaU=;
        b=dC/womSB6cUdKgWDALcDXJkLV9BDxtnTs6Du7QkX55kbmyMDsyfJzp5k08+776L3EP
         0hgwoup0xhvtZSjtIhd5b8EN/2nsdCOCrCGpK1CyKPZ9zWGZUflzTmmuzVyXyqAe82uf
         VwUhAhnWIl5EJDOgulV/wUisMuBrTALhfoMbFLsolnmz4BLD5dalR3eZTkmtZU9JiLZ3
         bo/nmcjPVx34CxJENRA5ZfqEw7G2jIEWonD7flW4aoK83MMGi9njwCrD/5RxS9l1s/jn
         8yFhRbOHUCXzzaH0s2vwNJRIB9sQ9i24yiMgFIYnem1++kp9QVtphW77oro/UFO/CmLB
         50mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dh5uuKPcBQ93XIoeGbLQVCWZw7SmH2LeLngrc8vlsaU=;
        b=i6b43c0ksm3hvFRcOpDK50e8oyrVHNSxKc3s8pftGc5YFE51JGag06Gga2pBitTMTM
         BZvjp2LtnKnbutLZqTadEaDpiJNMhvsdSf+twu9JJc6mf2/cyhHpG7f4O79qrjrduOCr
         ywU+u5sDz6DBqtS5gXbgOEgKF+lD2WoG/ICetEL7Tvr3QwyiKXI+Gxxxkc1zNe2GKqYe
         z7wp21CuVKziO+l8n2N8O3FYQ9uvfr6IcpGPL/UppzUDVVnBG+hLKlotQQBUvM4I4Z4C
         8bmT2qcgLQkPSH4hoHtDMuCKsyAj9g/WlG/S5jAlXQCY3PTzoz8pGKesm1bttqr5loHm
         hMdA==
X-Gm-Message-State: AOAM530WGJtc58ziJdiJw2rP3ylcDsuZBzfSStAhLb90mfomeDGsfJpJ
        mWHGd+PhV7QvcF6bdJab8XCUNwlkR30m1jgrTXpkXw==
X-Google-Smtp-Source: ABdhPJx5py6+AL8ZGheslkm2utmIviqSjjRR/GgkPHvC9Kn6qWBAu1xb6CamzJx5lBHZ+q2niheh19pjfq37cwwCwkA=
X-Received: by 2002:a2e:6f19:: with SMTP id k25mr4503553ljc.443.1594802524312;
 Wed, 15 Jul 2020 01:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200715044813.fww3regsgsbgyp7b@pesu-pes-edu> <20200715070842.GA2303720@kroah.com>
 <CAAhDqq3u_0wCRGDaWRGgtC6bkx6t+AubAXfnX_f7V0t10BRuuA@mail.gmail.com> <20200715083144.GA2716443@kroah.com>
In-Reply-To: <20200715083144.GA2716443@kroah.com>
From:   B K Karthik <bkkarthik@pesu.pes.edu>
Date:   Wed, 15 Jul 2020 04:41:52 -0400
Message-ID: <CAAhDqq1hwtgqyOnfx__OFgTkm9QDs0or-Zg76cMojShCYRAN2w@mail.gmail.com>
Subject: Re: [PATCH] staging: comedi: comedi_fops.c: changed type in
 assignment to unsigned int *
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Michel Lespinasse <walken@google.com>,
        Divyansh Kamboj <kambojdivyansh2000@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 4:31 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 15, 2020 at 01:56:45PM +0530, B K Karthik wrote:
> > On Wed, Jul 15, 2020, 12:38 PM Greg Kroah-Hartman <
> > gregkh@linuxfoundation.org> wrote:
> >
> > > On Wed, Jul 15, 2020 at 12:48:13AM -0400, B K Karthik wrote:
> > > > fixed a sparse warning by changing the type in
> > > > assignment from void [noderef] __user * to unsigned int *
> > > > (different address space)
> > > >
> > > > Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> > > > ---
> > > >  drivers/staging/comedi/comedi_fops.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/staging/comedi/comedi_fops.c
> > > b/drivers/staging/comedi/comedi_fops.c
> > > > index 3f70e5dfac39..4cc012e231b7 100644
> > > > --- a/drivers/staging/comedi/comedi_fops.c
> > > > +++ b/drivers/staging/comedi/comedi_fops.c
> > > > @@ -2956,7 +2956,7 @@ static int get_compat_cmd(struct comedi_cmd *cmd,
> > > >       cmd->scan_end_arg = v32.scan_end_arg;
> > > >       cmd->stop_src = v32.stop_src;
> > > >       cmd->stop_arg = v32.stop_arg;
> > > > -     cmd->chanlist = compat_ptr(v32.chanlist);
> > > > +     cmd->chanlist = (unsigned int *) compat_ptr(v32.chanlist);
> > > >       cmd->chanlist_len = v32.chanlist_len;
> > > >       cmd->data = compat_ptr(v32.data);
> > > >       cmd->data_len = v32.data_len;
> > >
> > > Always run your patches through checkpatch before sending them, so you
> > > do not have a grumpy maintainer telling you that you have to run
> > > checkpatch on your patch before sending them.
> > >
> >
> > I will. Sorry for that.
> >
> > But the error that's being shown in this patch is something that comes up
> > on its own.
>
> No it is not.
>
> > git format-patch leaves trailing whitespace in blank lines.
>
> It does?  Where is any trailing whitespace here?  That's not the issue.

To give you an example,
https://lore.kernel.org/lkml/20200714132350.naekk4zqivpuaedi@pesu-pes-edu/
was a patch i submitted recently.
This is what checkpatch has to say:

$ perl scripts/checkpatch.pl -f
../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch
ERROR: trailing whitespace
#21: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:21:
+ $

ERROR: trailing whitespace
#23: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:23:
+ $

ERROR: trailing whitespace
#30: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:30:
+ $

ERROR: trailing whitespace
#37: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:37:
+ $

ERROR: trailing whitespace
#44: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:44:
+ $

ERROR: trailing whitespace
#51: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:51:
+-- $

total: 6 errors, 0 warnings, 53 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch
has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

Does this happen only to patches I make? Am I making a silly mistake
while making a patch?
I use 'git format-patch -1' to generate the patch file.
If I am going wrong somewhere, please let me know.

>
> > It has been reported to the maintainers.
>
> It was?  Where?

I am extremely sorry, I should have verified if it was indeed reported
before telling it out.
It has not been reported (yet).
I apologise for my mistake.

thanks,

karthik
