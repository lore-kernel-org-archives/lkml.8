Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6F0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4273A20672
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="tQqCdYlG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgGOIap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgGOIao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:30:44 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2DCC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:30:43 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d17so1661065ljl.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3ejnOQQmWzHP79lAAQ13IkNooDDg0zjPEA+y5ajSb0=;
        b=tQqCdYlGVkLA0Ex5TiEzuW15QH8ndclmX2zY537HleDy175mergZI0Vit13wECLCfM
         uDQc7A6zQFdzqF6OFVTjKw1u368mN6BOaN6oQ3DROu1GyJFJxuucJQBveTlVNY5TSpFd
         6hrrrf87ZbsyGY7gDGpjwKWUzgGDZNlddX5II8fUjxxV/VukTyr5cTiDn0kk9o1kNfqy
         Moj/5e49U6whIGBo3EdrG9U7hVd6E+VHyS6x/6CgNk4swNC83guuUZI4Yi9MC3dAdqnb
         G/bNwEZ3+nPMXVpxfX2Zm8+jKF3Ikzfgi/ckCQHp9HU0JKYRSnKIxV0ProUF271g6bff
         hqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3ejnOQQmWzHP79lAAQ13IkNooDDg0zjPEA+y5ajSb0=;
        b=IcpptBZ6PigiFSp3/ITS3I4B6sk7hewRaysMhRa6LFLcFLRGS/HiE7dQyai+8lIJ3x
         ykO/tgiR9IfQeNcyzyY64vQUij+EbxpTyiCj3OC8jT0aEIWziYSVWuYMdh1XOYwW/VIQ
         LjCWwcJNS7kfVNX0aBIkSEDPjCDpUggGOKAE1/UNRUF34TrygVjDjCrp5Rqh4JN+sNSm
         Khj8DrTI8LGSPQDnYvMbpnIar4XuUFOaysJlimKUHieqZUIu5NOHLM5jNTEvTVIPCa51
         mTC/B2P+T5acJUbtiipQMiJXiagsOY0h0BIMZPReGXcpnytXqu1Da8VslUcR+m7fCga9
         rCEw==
X-Gm-Message-State: AOAM5337Tnxd8jW1OE4sESnKAWT4FebfmupuJb9e9Zr4dESYNMIHWnqk
        ZkXwbsQzC8XWIEj0fUGPwE5EAP+CjiIHgJPHE/3ong==
X-Google-Smtp-Source: ABdhPJy/3vzGGaIc88bO0IRdpA4YoVp/+trw/nQY1R4popXldKj99HgF+jRfT2fOY4FBGKh56wwwmlenF5cSUCI0Wns=
X-Received: by 2002:a2e:9cd6:: with SMTP id g22mr4516750ljj.429.1594801841908;
 Wed, 15 Jul 2020 01:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200715044813.fww3regsgsbgyp7b@pesu-pes-edu> <20200715070842.GA2303720@kroah.com>
In-Reply-To: <20200715070842.GA2303720@kroah.com>
From:   B K Karthik <bkkarthik@pesu.pes.edu>
Date:   Wed, 15 Jul 2020 04:30:30 -0400
Message-ID: <CAAhDqq3_4=5J8oYpNVWu-M-JuLWDJSFQ89YDL5qmS6saDm_aFQ@mail.gmail.com>
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

On Wed, Jul 15, 2020 at 3:08 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 15, 2020 at 12:48:13AM -0400, B K Karthik wrote:
> > fixed a sparse warning by changing the type in
> > assignment from void [noderef] __user * to unsigned int *
> > (different address space)
> >
> > Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> > ---
> >  drivers/staging/comedi/comedi_fops.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
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
> >       cmd->chanlist_len = v32.chanlist_len;
> >       cmd->data = compat_ptr(v32.data);
> >       cmd->data_len = v32.data_len;
>
> Always run your patches through checkpatch before sending them, so you
> do not have a grumpy maintainer telling you that you have to run
> checkpatch on your patch before sending them.

I will, Sorry for that.

But this particular error which showed up after running checkpatch is
something 'git format-patch' does unintentionally.
It has been reported to the maintainers.

thanks,

karthik
