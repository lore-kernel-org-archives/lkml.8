Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A11C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA1B206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="Jhuq7dRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgGOLfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728970AbgGOLfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:35:07 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA519C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 04:35:06 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z24so2167279ljn.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 04:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NyvuHuxxjvWixAHxdaLAwZ6ZtVOaOESx6JTIlYQ1UFI=;
        b=Jhuq7dRptRZ5adddt0e2fWxQLeRIVq1FjdGY4ntX0JfABPLOpttj04c173B1lrBZ4g
         8uXkwo6UzwFqC5hkEEDc2a9n1T8mJMGUYndW26RFbW6Pg2itghKVqj/cXxheuqv3WuqN
         iQgp70k8raExTKpMc6nuIxP+yg9EbrRXbvf/YYpT6b1XPq3F8/KhTWzGaQekYAN5yzw5
         GJrP5cHIwNuQeKV7CzsgoOqSfcKTqfvRpPrepD5YhJR5jlCFoDd09AaqahvS5Zp5BuTZ
         XVyrf6rU2CTqnb0SApTvqQKPcc5rigrHbpyVuTnDI7tvxBdfySGEuT40Mv2PYai+B1hq
         QX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NyvuHuxxjvWixAHxdaLAwZ6ZtVOaOESx6JTIlYQ1UFI=;
        b=VyZrXmPUiU1w3GJW1vCbjnqW2QJ5uFfb02HEU6i8ZsXjPfHUZoLaoqLltB9zPwl+4t
         xsY6mmiBj7wiKNoKL5BEM1eSaeKi8KPN2VwE8WaB43IBruBQXwmyZhp++ArzYswQn+bI
         ieigMFFf8p6E9tq4cctZTk12y/abTu5Ri+6ZnzGdk37nWedJssOIsUTZ5PULhdtaTncy
         QKv3yE0n/KGEZBtkqpxi1ETVFCX7TpUie1Iq2PuwBOgO8QwGKD/biNWk3pSPw7sVtbfJ
         apEI5HMvv9XY1jqk4p36RWNjDB4+Kkaj7klBhCX4akc2UE26FPQAcDcO6DFSVepoz3IF
         VkUg==
X-Gm-Message-State: AOAM533nkMqcDPMUmyFFZtb17oEY3mVXX2q6BMa1rC2IXZoYGRNDbBov
        LaAyZh8wX0sT91FYjBPgZJBuZDENX1UtkYi7Kq/AnA==
X-Google-Smtp-Source: ABdhPJypBz7OPH34QSSqjFhSDKduQLyFK7h7ytCItXKjSyyGAdzJH56C7G4s+wNbRfW9+iKL7RwMwzST90cJjgc3/Y0=
X-Received: by 2002:a2e:b4ed:: with SMTP id s13mr4678829ljm.296.1594812905302;
 Wed, 15 Jul 2020 04:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200715044813.fww3regsgsbgyp7b@pesu-pes-edu> <4aa4d949-7ef9-ccfe-bf5c-11a380c8f542@mev.co.uk>
In-Reply-To: <4aa4d949-7ef9-ccfe-bf5c-11a380c8f542@mev.co.uk>
From:   B K Karthik <bkkarthik@pesu.pes.edu>
Date:   Wed, 15 Jul 2020 07:34:53 -0400
Message-ID: <CAAhDqq0NYcX+UJi+GfbLP7q-MqrXfDaoB5z64GmgO3L7zpCMjQ@mail.gmail.com>
Subject: Re: [PATCH] staging: comedi: comedi_fops.c: changed type in
 assignment to unsigned int *
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Wed, Jul 15, 2020 at 7:19 AM Ian Abbott <abbotti@mev.co.uk> wrote:
>
> On 15/07/2020 05:48, B K Karthik wrote:
> > fixed a sparse warning by changing the type in
> > assignment from void [noderef] __user * to unsigned int *
> > (different address space)
> >
> > Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> > ---
> >   drivers/staging/comedi/comedi_fops.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
> > index 3f70e5dfac39..4cc012e231b7 100644
> > --- a/drivers/staging/comedi/comedi_fops.c
> > +++ b/drivers/staging/comedi/comedi_fops.c
> > @@ -2956,7 +2956,7 @@ static int get_compat_cmd(struct comedi_cmd *cmd,
> >       cmd->scan_end_arg = v32.scan_end_arg;
> >       cmd->stop_src = v32.stop_src;
> >       cmd->stop_arg = v32.stop_arg;
> > -     cmd->chanlist = compat_ptr(v32.chanlist);
> > +     cmd->chanlist = (unsigned int *) compat_ptr(v32.chanlist);
>
> That should be:
>
>         cmd->chanlist = (unsigned int __force *)compat_ptr(v32.chanlist);
>
> >       cmd->chanlist_len = v32.chanlist_len;
> >       cmd->data = compat_ptr(v32.data);
> >       cmd->data_len = v32.data_len;
> >
>
> A reverse cast is required in put_compat_cmd():
>
>         v32.chanlist = ptr_to_compat((unsigned int __user *)cmd->chanlist);
>
> Those changes will get rid of the sparse warnings.

Thank you for the clarifications Ian. I will make the changes and submit a patch

thanks,

karthik
