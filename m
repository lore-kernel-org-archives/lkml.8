Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F172C433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78BCE2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="zzE/SG3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgGOIsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgGOIsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:48:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39606C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:48:02 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so1673692ljp.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z3hVhufvufXQboj6QREMdbRyVrzG4VOiVEWo0NmaKI8=;
        b=zzE/SG3GryrZi4INSREvj2bwX++iDiohWUBB1r3DGukCDT0xsnKV+KXePEyUBQWbgk
         moo0vW2i9w14X/d7AOnBSnD2IeuTtzeH8Ovno4lQ2UO0JxnKYD2z8hk4jYHLnYvKUPOr
         gmBnaXBrPhucb+aEIg6jGmuJRtgQr6EamgUoutHVqpbaNd17ywxcu2g+t3/M/z0AYKtq
         lI1Z6EEDSnGhsZNnY0Tu4qURv/4V+jwLcRIBFtfwchcIJxFVUR/5bHnc89uaZPHNa3FD
         yi2uqWDtAt9S2N6W5ZBgGpd8Q78iaZxXPAURcaCq/KjeZ69R5M/7F1C5xy9gL0KQPODQ
         +lDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z3hVhufvufXQboj6QREMdbRyVrzG4VOiVEWo0NmaKI8=;
        b=QNc8Nh5mBeCcCQGdU4ItniX6yO4DJkaYp8vvNT01MV/fnttTjK3+hg+cYwAA9pGE3v
         OBLSHOJnM/3oNqFQcecxL0xKhsgRlBgVr2yVmNEXu3xl4+M+OgqWjzn44NaJ1hGPBlH3
         QqvP/X7AGmtursSb9Ip7PwZd1ePBo5LIQ0GD6HeuD+r2QAC8L90cSaUZ/f50J7n9GXID
         0PJI9VzHQcbfQqr+axNeGzVuvNkmo62vL6cVj84tM0MnmsGnl3RFOB6qfsSnwURJkPGj
         3fgtvf5RS3aZU6M3F7U5E/ixVCIMXc2BJfPu2xUCCSHtQBl+C22CkdkvwQJ5szWZQXkH
         F8Ng==
X-Gm-Message-State: AOAM532FqsMl/uqvdLqLQ/fa0ObMKByiejfAFbvbmGFnB4RlTNhfRYbX
        mZOW35bPOVo4mpGeSBsJKZ/FDjA0BDFXu6EdoU5u+A==
X-Google-Smtp-Source: ABdhPJxseDK1Uqjj1tMP0opgQSRwRNbFmW6KqOplfOiIfoUj33UA7GFRoAo7UG+GqxmMubfTzKeDkQOC3uks2+v63zQ=
X-Received: by 2002:a2e:9c59:: with SMTP id t25mr4172548ljj.402.1594802880625;
 Wed, 15 Jul 2020 01:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200715044813.fww3regsgsbgyp7b@pesu-pes-edu> <20200715070842.GA2303720@kroah.com>
 <CAAhDqq3u_0wCRGDaWRGgtC6bkx6t+AubAXfnX_f7V0t10BRuuA@mail.gmail.com>
 <20200715083144.GA2716443@kroah.com> <CAAhDqq1hwtgqyOnfx__OFgTkm9QDs0or-Zg76cMojShCYRAN2w@mail.gmail.com>
In-Reply-To: <CAAhDqq1hwtgqyOnfx__OFgTkm9QDs0or-Zg76cMojShCYRAN2w@mail.gmail.com>
From:   B K Karthik <bkkarthik@pesu.pes.edu>
Date:   Wed, 15 Jul 2020 04:47:48 -0400
Message-ID: <CAAhDqq2y7wn5zX1zg1LN19zYBsf_EiuOmHEL-ivNP5C4aH63Pw@mail.gmail.com>
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

On Wed, Jul 15, 2020 at 4:41 AM B K Karthik <bkkarthik@pesu.pes.edu> wrote:
>
> On Wed, Jul 15, 2020 at 4:31 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jul 15, 2020 at 01:56:45PM +0530, B K Karthik wrote:
> > > On Wed, Jul 15, 2020, 12:38 PM Greg Kroah-Hartman <
> > > gregkh@linuxfoundation.org> wrote:
> > >
> > > > On Wed, Jul 15, 2020 at 12:48:13AM -0400, B K Karthik wrote:
> > > > > fixed a sparse warning by changing the type in
> > > > > assignment from void [noderef] __user * to unsigned int *
> > > > > (different address space)
> > > > >
> > > > > Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> > > > > ---
> > > > >  drivers/staging/comedi/comedi_fops.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/staging/comedi/comedi_fops.c
> > > > b/drivers/staging/comedi/comedi_fops.c
> > > > > index 3f70e5dfac39..4cc012e231b7 100644
> > > > > --- a/drivers/staging/comedi/comedi_fops.c
> > > > > +++ b/drivers/staging/comedi/comedi_fops.c
> > > > > @@ -2956,7 +2956,7 @@ static int get_compat_cmd(struct comedi_cmd *cmd,
> > > > >       cmd->scan_end_arg = v32.scan_end_arg;
> > > > >       cmd->stop_src = v32.stop_src;
> > > > >       cmd->stop_arg = v32.stop_arg;
> > > > > -     cmd->chanlist = compat_ptr(v32.chanlist);
> > > > > +     cmd->chanlist = (unsigned int *) compat_ptr(v32.chanlist);
> > > > >       cmd->chanlist_len = v32.chanlist_len;
> > > > >       cmd->data = compat_ptr(v32.data);
> > > > >       cmd->data_len = v32.data_len;
> > > >
> > > > Always run your patches through checkpatch before sending them, so you
> > > > do not have a grumpy maintainer telling you that you have to run
> > > > checkpatch on your patch before sending them.
> > > >
> > >
> > > I will. Sorry for that.
> > >
> > > But the error that's being shown in this patch is something that comes up
> > > on its own.
> >
> > No it is not.
> >
> > > git format-patch leaves trailing whitespace in blank lines.
> >
> > It does?  Where is any trailing whitespace here?  That's not the issue.
>
> To give you an example,
> https://lore.kernel.org/lkml/20200714132350.naekk4zqivpuaedi@pesu-pes-edu/
> was a patch i submitted recently.
> This is what checkpatch has to say:
>
> $ perl scripts/checkpatch.pl -f
> ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch
> ERROR: trailing whitespace
> #21: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:21:
> + $
>
> ERROR: trailing whitespace
> #23: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:23:
> + $
>
> ERROR: trailing whitespace
> #30: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:30:
> + $
>
> ERROR: trailing whitespace
> #37: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:37:
> + $
>
> ERROR: trailing whitespace
> #44: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:44:
> + $
>
> ERROR: trailing whitespace
> #51: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:51:
> +-- $
>
> total: 6 errors, 0 warnings, 53 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> NOTE: Whitespace errors detected.
>       You may wish to use scripts/cleanpatch or scripts/cleanfile
>
> ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch
> has style problems, please review.
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> Does this happen only to patches I make? Am I making a silly mistake
> while making a patch?
> I use 'git format-patch -1' to generate the patch file.
> If I am going wrong somewhere, please let me know.

Also, The patch I sent (this thread):
$ perl scripts/checkpatch.pl -f
./0001-staging-comedi-comedi_fops.c-changed-void-__user-to-.patch
ERROR: trailing whitespace
#29: FILE: ./0001-staging-comedi-comedi_fops.c-changed-void-__user-to-.patch:29:
+-- $

total: 1 errors, 0 warnings, 31 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

./0001-staging-comedi-comedi_fops.c-changed-void-__user-to-.patch has
style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

Am I using 'git format-patch' or 'checkpatch.pl' the wrong way?

thanks,

karthik
