Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B3FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AD22064B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="mJbrN5Eg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbgGOJfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbgGOJfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:35:43 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9EEC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:35:43 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so1755878ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hBACDjerLps7qaIhlduOfiyH7XhBBRJwygRHNV8vgmQ=;
        b=mJbrN5EgqV9Ewuft1mO+r83nzB5ZplvKZULHpiLg2KFNhjDYlXxMqU29wgyWMfc/uD
         lPcSfTu/KOsGDDNInW8zJK4Y+Caqz2ZHl8HcldVDMGELsqFriDjC7TMmCJEvYYzPE2Et
         dtoMdBupynReXxImqxxjhO9DtnXA19H/4/+3rRrInL4wHrOPrpprtS7OdE3xmiWT7wo1
         v4wCLOx0PbdN6TICqYVspp5ssVZdM05D9de3OXyzZiqXCDM4ciOgA2SislUigWo5znTd
         gKq9sa16mUvBD8xNCDHeqnh0oyWSMKmOlSsDnG2G3/dA1y6LeovZNdGuLC5yfdRbLT8S
         7JMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hBACDjerLps7qaIhlduOfiyH7XhBBRJwygRHNV8vgmQ=;
        b=rvGGCGVNN9NCP9otSPQSy566iMwREgPMkjKsJf9b80g6zjYxSvGArbX6/kDA2FdB2O
         ix2u4Lp3etRmQJreJmPicBOqFQDdyh1psta+n9qjkcMNmGobNAGoeAOPqkzI02NpSE9i
         3Gk/dhG6f/dlYFHu9Lyl8bVi2KovkzD4ypU/JCiZiOz4ErYaJME314UxAUPqFIBH2JZZ
         2SzgxrnSjZ3UPMZ6dBMo1YF49k0m5eSBwfdMefmR4gxF1DgfqO6j/8WvSjZRy9z03+s0
         wJ7zOTcWEurJkE/G2QKK/ptxUoYTadNOCDzV4t9VHG85NB8TAKhmVZESmDI3n9VS3IC7
         Z5pQ==
X-Gm-Message-State: AOAM533Ju6HdCYf+RnOtcvgI+yplL8gIDzdIkeQ1ej0mzmThTI3K47sF
        xFLtay18nurxXUxkKo5L18uqvEMhbx8WABvlqoFX8w==
X-Google-Smtp-Source: ABdhPJzHAjBMqAWtxseqSJ6F7H2g+k87FoUAKsvxah8aJzmLGH4ySQoclx9ywRNpQDi4cOGlitiiOdMq5RBmkDTAjj4=
X-Received: by 2002:a2e:815a:: with SMTP id t26mr4594844ljg.182.1594805741694;
 Wed, 15 Jul 2020 02:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200715044813.fww3regsgsbgyp7b@pesu-pes-edu> <20200715070842.GA2303720@kroah.com>
 <CAAhDqq3u_0wCRGDaWRGgtC6bkx6t+AubAXfnX_f7V0t10BRuuA@mail.gmail.com>
 <20200715083144.GA2716443@kroah.com> <CAAhDqq1hwtgqyOnfx__OFgTkm9QDs0or-Zg76cMojShCYRAN2w@mail.gmail.com>
 <20200715091446.GA2722864@kroah.com> <CAAhDqq3g=G=T6DK+wRsZG=D3fii+ERnGJFGuU-560REvXXRbNw@mail.gmail.com>
 <20200715092856.GA2759174@kroah.com>
In-Reply-To: <20200715092856.GA2759174@kroah.com>
From:   B K Karthik <bkkarthik@pesu.pes.edu>
Date:   Wed, 15 Jul 2020 05:35:29 -0400
Message-ID: <CAAhDqq1zYvfS2-Bhg+0mt0RYJF=RV7qaJ0hG=niUC8=matX26Q@mail.gmail.com>
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

On Wed, Jul 15, 2020 at 5:29 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 15, 2020 at 05:21:01AM -0400, B K Karthik wrote:
> > On Wed, Jul 15, 2020 at 5:14 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jul 15, 2020 at 04:41:52AM -0400, B K Karthik wrote:
> > > > On Wed, Jul 15, 2020 at 4:31 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Wed, Jul 15, 2020 at 01:56:45PM +0530, B K Karthik wrote:
> > > > > > On Wed, Jul 15, 2020, 12:38 PM Greg Kroah-Hartman <
> > > > > > gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > > On Wed, Jul 15, 2020 at 12:48:13AM -0400, B K Karthik wrote:
> > > > > > > > fixed a sparse warning by changing the type in
> > > > > > > > assignment from void [noderef] __user * to unsigned int *
> > > > > > > > (different address space)
> > > > > > > >
> > > > > > > > Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> > > > > > > > ---
> > > > > > > >  drivers/staging/comedi/comedi_fops.c | 2 +-
> > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/staging/comedi/comedi_fops.c
> > > > > > > b/drivers/staging/comedi/comedi_fops.c
> > > > > > > > index 3f70e5dfac39..4cc012e231b7 100644
> > > > > > > > --- a/drivers/staging/comedi/comedi_fops.c
> > > > > > > > +++ b/drivers/staging/comedi/comedi_fops.c
> > > > > > > > @@ -2956,7 +2956,7 @@ static int get_compat_cmd(struct comedi_cmd *cmd,
> > > > > > > >       cmd->scan_end_arg = v32.scan_end_arg;
> > > > > > > >       cmd->stop_src = v32.stop_src;
> > > > > > > >       cmd->stop_arg = v32.stop_arg;
> > > > > > > > -     cmd->chanlist = compat_ptr(v32.chanlist);
> > > > > > > > +     cmd->chanlist = (unsigned int *) compat_ptr(v32.chanlist);
> > > > > > > >       cmd->chanlist_len = v32.chanlist_len;
> > > > > > > >       cmd->data = compat_ptr(v32.data);
> > > > > > > >       cmd->data_len = v32.data_len;
> > > > > > >
> > > > > > > Always run your patches through checkpatch before sending them, so you
> > > > > > > do not have a grumpy maintainer telling you that you have to run
> > > > > > > checkpatch on your patch before sending them.
> > > > > > >
> > > > > >
> > > > > > I will. Sorry for that.
> > > > > >
> > > > > > But the error that's being shown in this patch is something that comes up
> > > > > > on its own.
> > > > >
> > > > > No it is not.
> > > > >
> > > > > > git format-patch leaves trailing whitespace in blank lines.
> > > > >
> > > > > It does?  Where is any trailing whitespace here?  That's not the issue.
> > > >
> > > > To give you an example,
> > > > https://lore.kernel.org/lkml/20200714132350.naekk4zqivpuaedi@pesu-pes-edu/
> > > > was a patch i submitted recently.
> > > > This is what checkpatch has to say:
> > > >
> > > > $ perl scripts/checkpatch.pl -f
> > > > ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch
> > > > ERROR: trailing whitespace
> > > > #21: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:21:
> > > > + $
> > > >
> > > > ERROR: trailing whitespace
> > > > #23: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:23:
> > > > + $
> > > >
> > > > ERROR: trailing whitespace
> > > > #30: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:30:
> > > > + $
> > > >
> > > > ERROR: trailing whitespace
> > > > #37: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:37:
> > > > + $
> > > >
> > > > ERROR: trailing whitespace
> > > > #44: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:44:
> > > > + $
> > > >
> > > > ERROR: trailing whitespace
> > > > #51: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:51:
> > > > +-- $
> > > >
> > > > total: 6 errors, 0 warnings, 53 lines checked
> > > >
> > > > NOTE: For some of the reported defects, checkpatch may be able to
> > > >       mechanically convert to the typical style using --fix or --fix-inplace.
> > > >
> > > > NOTE: Whitespace errors detected.
> > > >       You may wish to use scripts/cleanpatch or scripts/cleanfile
> > > >
> > > > ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch
> > > > has style problems, please review.
> > > >
> > > > NOTE: If any of the errors are false positives, please report
> > > >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> > > >
> > > > Does this happen only to patches I make? Am I making a silly mistake
> > > > while making a patch?
> > >
> > > I don't get that error at all, here's all I get with that patch:
> > this particular patch or
> > >
> > > $ ./scripts/checkpatch.pl x.patch
> > > WARNING: Missing Signed-off-by: line by nominal patch author ''
> > >
> > > total: 0 errors, 1 warnings, 0 checks, 30 lines checked
> >
> > sorry, you've probably done this a million times more than me, but can
> > you try "perl scripts/checkpatch.pl -f x.patch" ?
> > checkpatch seems to behave differently this way.
>
> Of course it would, "-f" means treat the next argument as a file, not as
> a patch.  This is a patch, not a full file.
sorry. I will make sure there are no errors the next time.
>
> So you are running this incorrectly and then ignoring the results?  :(

sorry.
thank you for the clarification.

thanks,

karthik
