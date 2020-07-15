Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4031FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 148DC2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="panp4hN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbgGOJWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729912AbgGOJWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:22:36 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00516C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:22:35 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so1802987ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4paLmIU/CwBBLnLr52mkv/Y6S35wXBNCIlDRSWPLwtQ=;
        b=panp4hN8htxMyL8Po9aDofLEM6+3tWJMkE+qUwzG3GtJAj1jAseuWscgGV9uXybRC4
         SeFsh7OLxdItR27o0vGkbUGtGahAfQdGDeUxqZcMoIu+xcdPDqcg0+7R27DAjh5DJX4d
         O3K6d/bEC55qvAS0lzIANE8tsAQeIfw1oerVg9QacKr46GxgLLMK86GSP/I4SqufbQuj
         Gj31SSClXsp87GNoazsDRmKUBwuDK//U1UKo+9HtoJ+z7b3Qa4dFDdoztj48mJO+8Eab
         jJ138nDnsCEglJjTedkT60xyYTNc4WCL2wFVHs5LJv81neXSTMnpE+uXPEgZAmkq2EIi
         32RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4paLmIU/CwBBLnLr52mkv/Y6S35wXBNCIlDRSWPLwtQ=;
        b=BiifrwhMgkNzWX8s+X+moLNSEnCvuZEJpWw6gQ+1Xiag1J7EgZmCpjgKt5OK1rwvxj
         /kWBqY+XqRrosiLM0YmztZUXqBkyKZRsgIvCQeON7f2QygYvUE2KEfuiHq2x2pppySBw
         aJ4gR19CP4xpl2ugTyQOnMHSqpgAYC0Qr7xs4EjAnpcMTKtQvS6YPpFlYgy4DtKKQXhF
         HLPDGrmYvCs5s38lRcAzGo5Ih3hF3VX6u3NDcFvlO0Wg8GWCaecy4rouEvHMf58WCiWO
         EQ7q7XcegUjToH/HnZbSAGwqAcraBwzBJht2/BiaoNcpeHyi8EJoWKRh60KtZ0lsjrRQ
         6/Sg==
X-Gm-Message-State: AOAM5325T6ApUC73Hm8psSsq6Wv8PTVSrqHErQpbck2c3dZXKYnwISN4
        CKiT7241KlycxGAyy5UWaaNBvykkK+o06eQQvXGUGA==
X-Google-Smtp-Source: ABdhPJyHR06eMZhC3WpHJIHkz/93mfFHItr6ZqMXt+cGQfjAdksgwmr6l0mxxS0jsZoymJKKIGdg5nVHAM1D/l2Pz0U=
X-Received: by 2002:a2e:b4ed:: with SMTP id s13mr4423801ljm.296.1594804954409;
 Wed, 15 Jul 2020 02:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200715044813.fww3regsgsbgyp7b@pesu-pes-edu> <20200715070842.GA2303720@kroah.com>
 <CAAhDqq3u_0wCRGDaWRGgtC6bkx6t+AubAXfnX_f7V0t10BRuuA@mail.gmail.com>
 <20200715083144.GA2716443@kroah.com> <CAAhDqq1hwtgqyOnfx__OFgTkm9QDs0or-Zg76cMojShCYRAN2w@mail.gmail.com>
 <CAAhDqq2y7wn5zX1zg1LN19zYBsf_EiuOmHEL-ivNP5C4aH63Pw@mail.gmail.com> <20200715091922.GB2722864@kroah.com>
In-Reply-To: <20200715091922.GB2722864@kroah.com>
From:   B K Karthik <bkkarthik@pesu.pes.edu>
Date:   Wed, 15 Jul 2020 05:22:22 -0400
Message-ID: <CAAhDqq1WxZ2XwXe43mKkDRm0sMFgusso53kfG2EtWDAUZ1T+_g@mail.gmail.com>
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

On Wed, Jul 15, 2020 at 5:19 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 15, 2020 at 04:47:48AM -0400, B K Karthik wrote:
> > On Wed, Jul 15, 2020 at 4:41 AM B K Karthik <bkkarthik@pesu.pes.edu> wrote:
> > >
> > > On Wed, Jul 15, 2020 at 4:31 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Jul 15, 2020 at 01:56:45PM +0530, B K Karthik wrote:
> > > > > On Wed, Jul 15, 2020, 12:38 PM Greg Kroah-Hartman <
> > > > > gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > > On Wed, Jul 15, 2020 at 12:48:13AM -0400, B K Karthik wrote:
> > > > > > > fixed a sparse warning by changing the type in
> > > > > > > assignment from void [noderef] __user * to unsigned int *
> > > > > > > (different address space)
> > > > > > >
> > > > > > > Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> > > > > > > ---
> > > > > > >  drivers/staging/comedi/comedi_fops.c | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/staging/comedi/comedi_fops.c
> > > > > > b/drivers/staging/comedi/comedi_fops.c
> > > > > > > index 3f70e5dfac39..4cc012e231b7 100644
> > > > > > > --- a/drivers/staging/comedi/comedi_fops.c
> > > > > > > +++ b/drivers/staging/comedi/comedi_fops.c
> > > > > > > @@ -2956,7 +2956,7 @@ static int get_compat_cmd(struct comedi_cmd *cmd,
> > > > > > >       cmd->scan_end_arg = v32.scan_end_arg;
> > > > > > >       cmd->stop_src = v32.stop_src;
> > > > > > >       cmd->stop_arg = v32.stop_arg;
> > > > > > > -     cmd->chanlist = compat_ptr(v32.chanlist);
> > > > > > > +     cmd->chanlist = (unsigned int *) compat_ptr(v32.chanlist);
> > > > > > >       cmd->chanlist_len = v32.chanlist_len;
> > > > > > >       cmd->data = compat_ptr(v32.data);
> > > > > > >       cmd->data_len = v32.data_len;
> > > > > >
> > > > > > Always run your patches through checkpatch before sending them, so you
> > > > > > do not have a grumpy maintainer telling you that you have to run
> > > > > > checkpatch on your patch before sending them.
> > > > > >
> > > > >
> > > > > I will. Sorry for that.
> > > > >
> > > > > But the error that's being shown in this patch is something that comes up
> > > > > on its own.
> > > >
> > > > No it is not.
> > > >
> > > > > git format-patch leaves trailing whitespace in blank lines.
> > > >
> > > > It does?  Where is any trailing whitespace here?  That's not the issue.
> > >
> > > To give you an example,
> > > https://lore.kernel.org/lkml/20200714132350.naekk4zqivpuaedi@pesu-pes-edu/
> > > was a patch i submitted recently.
> > > This is what checkpatch has to say:
> > >
> > > $ perl scripts/checkpatch.pl -f
> > > ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch
> > > ERROR: trailing whitespace
> > > #21: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:21:
> > > + $
> > >
> > > ERROR: trailing whitespace
> > > #23: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:23:
> > > + $
> > >
> > > ERROR: trailing whitespace
> > > #30: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:30:
> > > + $
> > >
> > > ERROR: trailing whitespace
> > > #37: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:37:
> > > + $
> > >
> > > ERROR: trailing whitespace
> > > #44: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:44:
> > > + $
> > >
> > > ERROR: trailing whitespace
> > > #51: FILE: ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch:51:
> > > +-- $
> > >
> > > total: 6 errors, 0 warnings, 53 lines checked
> > >
> > > NOTE: For some of the reported defects, checkpatch may be able to
> > >       mechanically convert to the typical style using --fix or --fix-inplace.
> > >
> > > NOTE: Whitespace errors detected.
> > >       You may wish to use scripts/cleanpatch or scripts/cleanfile
> > >
> > > ../cbridge/1407d/1/0001-drivers-staging-media-atomisp-pci-css_2401_system-ho.patch
> > > has style problems, please review.
> > >
> > > NOTE: If any of the errors are false positives, please report
> > >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> > >
> > > Does this happen only to patches I make? Am I making a silly mistake
> > > while making a patch?
> > > I use 'git format-patch -1' to generate the patch file.
> > > If I am going wrong somewhere, please let me know.
> >
> > Also, The patch I sent (this thread):
> > $ perl scripts/checkpatch.pl -f
> > ./0001-staging-comedi-comedi_fops.c-changed-void-__user-to-.patch
> > ERROR: trailing whitespace
> > #29: FILE: ./0001-staging-comedi-comedi_fops.c-changed-void-__user-to-.patch:29:
> > +-- $
> >
> > total: 1 errors, 0 warnings, 31 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-inplace.
> >
> > NOTE: Whitespace errors detected.
> >       You may wish to use scripts/cleanpatch or scripts/cleanfile
> >
> > ./0001-staging-comedi-comedi_fops.c-changed-void-__user-to-.patch has
> > style problems, please review.
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> >
> > Am I using 'git format-patch' or 'checkpatch.pl' the wrong way?
>
> Are you checking the right thing here?  Here's what I got:
>
> $ ./scripts/checkpatch.pl --terse x.patch
> x.patch:19: CHECK: No space is necessary after a cast
> x.patch:25: WARNING: Missing Signed-off-by: line by nominal patch author ''
> total: 0 errors, 1 warnings, 1 checks, 8 lines checked
>
>
> I use --terse to make it more obvious what the issue is.
>
> Heck, check it yourself:
>
> $ b4 am https://lore.kernel.org/r/20200715044813.fww3regsgsbgyp7b@pesu-pes-edu
> Looking up https://lore.kernel.org/r/20200715044813.fww3regsgsbgyp7b%40pesu-pes-edu
> Grabbing thread from lore.kernel.org/driverdev-devel
> Analyzing 7 messages in the thread
> ---
> Writing ./20200715_bkkarthik_staging_comedi_comedi_fops_c_changed_type_in_assignment_to_unsigned_int.mbx
>   [PATCH] staging: comedi: comedi_fops.c: changed type in assignment to unsigned int *
> ---
> Total patches: 1
> ---
>  Link: https://lore.kernel.org/r/20200715044813.fww3regsgsbgyp7b@pesu-pes-edu
>  Base: not found (applies clean to current tree)
>        git am ./20200715_bkkarthik_staging_comedi_comedi_fops_c_changed_type_in_assignment_to_unsigned_int.mbx
>
> $ ./scripts/checkpatch.pl --terse 20200715_bkkarthik_staging_comedi_comedi_fops_c_changed_type_in_assignment_to_unsigned_int.mbx
> 20200715_bkkarthik_staging_comedi_comedi_fops_c_changed_type_in_assignment_to_unsigned_int.mbx:32: CHECK: No space is necessary after a cast
> 20200715_bkkarthik_staging_comedi_comedi_fops_c_changed_type_in_assignment_to_unsigned_int.mbx:38: WARNING: Missing Signed-off-by: line by nominal patch author 'B K Karthik <bkkarthik@pesu.pes.edu>'
> total: 0 errors, 1 warnings, 1 checks, 8 lines checked
>
>
> I used the b4 tool to download your email in mbox form from
> lore.kernel.org and then ran checkpatch on it.
>
>
> And the signed-off-by error is real, you need to also fix that.

I will check that. I am sorry for wasting your time.
But you have accepted a couple of patches from me before that were
created the same way.

>
> Try the above yourself to verify this.

I will.

thanks,

karthik
