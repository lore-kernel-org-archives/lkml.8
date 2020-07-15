Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342BDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E53AE2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="pTGGcTrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbgGOJVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730611AbgGOJVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:21:15 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE653C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:21:14 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u25so689851lfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fAa66qSxxTkHpaU1a+wWnKzvqfUlXY5s1qoqkzEmAqY=;
        b=pTGGcTrPWXeGbi3cjOJvnFPo7gOdGucC550stbndC7KCTBfXpz11Q5jdl7CFCD0Jtx
         rKF5b+dEKXrOBcsfR8ebIKoJNs6bhvgww71EdB8f286gLPxTpI6PhsWW6RszDu2pzgTz
         3nlJntE7Un8EDRPMYE0AVvFSKm7rF5gUR0ozmH95Zq3l3vbM/Lp+L58zebp4mnZBJK2F
         DUEnCvZGEV8bAVIn+jSyHnuCY0GsREbsGU/jRv+foxoiT6+z2lyJsncasP/JY1J5OEny
         QxmYz2Pt5eUukqYEaoVhcmVb6hPctzZNZ7W77mJZHG7iu2m9T9FnYULwbdcBUDtChAMQ
         1fpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fAa66qSxxTkHpaU1a+wWnKzvqfUlXY5s1qoqkzEmAqY=;
        b=YPhOolxkE27XaF10hs3VeZoMNQRg4qW7P6GrkWfYiMGxmtjs32sFYG2IVrb4+lFnw2
         VzW8hxKUOOxq+EFoenOdw07nWoaFttPje451qsz9Z/hG8xVi64qzJ7y1V2687vl3Jc3f
         T01VYf9jlTGGX45ZPrsc2WNFD0wDrtPFgpxFycU9uHk9GYQgyxYTxl7iK/2TCTbm8MoM
         KBhLaOsfRDVNQoXksDe45SItYDfWNelor2KgeCWArAd9OIv73vgJxaRVRbOxCTbNWl9Y
         Y5m1J8/48JaSHAtLaEAIutpGaA6do/Pi1mNZ16+sCnJ+C8m9lFmxfpYf+vrvSeH+raqE
         8F7A==
X-Gm-Message-State: AOAM532IZaVmkxuYjggio30HHYBZ4Lp3AJmf5VFCW3W1snyAHG+h7+DZ
        onCZUTL4LhnoB5M2uZfP3r9f0B89c2K8gU+Yqj6stA==
X-Google-Smtp-Source: ABdhPJxh9TZPVrwjX0LQQDIThVSYRuVMTSRiLs0z4Wszk+p7wCi2FnJZmS4SO+xkn/CQMmLQA2369KWPxbbiGwLmnjg=
X-Received: by 2002:a19:50b:: with SMTP id 11mr4521472lff.154.1594804873108;
 Wed, 15 Jul 2020 02:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200715044813.fww3regsgsbgyp7b@pesu-pes-edu> <20200715070842.GA2303720@kroah.com>
 <CAAhDqq3u_0wCRGDaWRGgtC6bkx6t+AubAXfnX_f7V0t10BRuuA@mail.gmail.com>
 <20200715083144.GA2716443@kroah.com> <CAAhDqq1hwtgqyOnfx__OFgTkm9QDs0or-Zg76cMojShCYRAN2w@mail.gmail.com>
 <20200715091446.GA2722864@kroah.com>
In-Reply-To: <20200715091446.GA2722864@kroah.com>
From:   B K Karthik <bkkarthik@pesu.pes.edu>
Date:   Wed, 15 Jul 2020 05:21:01 -0400
Message-ID: <CAAhDqq3g=G=T6DK+wRsZG=D3fii+ERnGJFGuU-560REvXXRbNw@mail.gmail.com>
Subject: Re: [PATCH] staging: comedi: comedi_fops.c: changed type in
 assignment to unsigned int *
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michel Lespinasse <walken@google.com>,
        Divyansh Kamboj <kambojdivyansh2000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 5:14 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 15, 2020 at 04:41:52AM -0400, B K Karthik wrote:
> > On Wed, Jul 15, 2020 at 4:31 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jul 15, 2020 at 01:56:45PM +0530, B K Karthik wrote:
> > > > On Wed, Jul 15, 2020, 12:38 PM Greg Kroah-Hartman <
> > > > gregkh@linuxfoundation.org> wrote:
> > > >
> > > > > On Wed, Jul 15, 2020 at 12:48:13AM -0400, B K Karthik wrote:
> > > > > > fixed a sparse warning by changing the type in
> > > > > > assignment from void [noderef] __user * to unsigned int *
> > > > > > (different address space)
> > > > > >
> > > > > > Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> > > > > > ---
> > > > > >  drivers/staging/comedi/comedi_fops.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/staging/comedi/comedi_fops.c
> > > > > b/drivers/staging/comedi/comedi_fops.c
> > > > > > index 3f70e5dfac39..4cc012e231b7 100644
> > > > > > --- a/drivers/staging/comedi/comedi_fops.c
> > > > > > +++ b/drivers/staging/comedi/comedi_fops.c
> > > > > > @@ -2956,7 +2956,7 @@ static int get_compat_cmd(struct comedi_cmd *cmd,
> > > > > >       cmd->scan_end_arg = v32.scan_end_arg;
> > > > > >       cmd->stop_src = v32.stop_src;
> > > > > >       cmd->stop_arg = v32.stop_arg;
> > > > > > -     cmd->chanlist = compat_ptr(v32.chanlist);
> > > > > > +     cmd->chanlist = (unsigned int *) compat_ptr(v32.chanlist);
> > > > > >       cmd->chanlist_len = v32.chanlist_len;
> > > > > >       cmd->data = compat_ptr(v32.data);
> > > > > >       cmd->data_len = v32.data_len;
> > > > >
> > > > > Always run your patches through checkpatch before sending them, so you
> > > > > do not have a grumpy maintainer telling you that you have to run
> > > > > checkpatch on your patch before sending them.
> > > > >
> > > >
> > > > I will. Sorry for that.
> > > >
> > > > But the error that's being shown in this patch is something that comes up
> > > > on its own.
> > >
> > > No it is not.
> > >
> > > > git format-patch leaves trailing whitespace in blank lines.
> > >
> > > It does?  Where is any trailing whitespace here?  That's not the issue.
> >
> > To give you an example,
> > https://lore.kernel.org/lkml/20200714132350.naekk4zqivpuaedi@pesu-pes-edu/
> > was a patch i submitted recently.
> > This is what checkpatch has to say:
> >
> > $ perl scripts/checkpatch.pl -f
> > ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch
> > ERROR: trailing whitespace
> > #21: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:21:
> > + $
> >
> > ERROR: trailing whitespace
> > #23: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:23:
> > + $
> >
> > ERROR: trailing whitespace
> > #30: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:30:
> > + $
> >
> > ERROR: trailing whitespace
> > #37: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:37:
> > + $
> >
> > ERROR: trailing whitespace
> > #44: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:44:
> > + $
> >
> > ERROR: trailing whitespace
> > #51: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:51:
> > +-- $
> >
> > total: 6 errors, 0 warnings, 53 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-inplace.
> >
> > NOTE: Whitespace errors detected.
> >       You may wish to use scripts/cleanpatch or scripts/cleanfile
> >
> > ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch
> > has style problems, please review.
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> >
> > Does this happen only to patches I make? Am I making a silly mistake
> > while making a patch?
>
> I don't get that error at all, here's all I get with that patch:
this particular patch or
>
> $ ./scripts/checkpatch.pl x.patch
> WARNING: Missing Signed-off-by: line by nominal patch author ''
>
> total: 0 errors, 1 warnings, 0 checks, 30 lines checked

sorry, you've probably done this a million times more than me, but can
you try "perl scripts/checkpatch.pl -f x.patch" ?
checkpatch seems to behave differently this way.

thanks,

karthik
