Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C82C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B16920C56
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VejHABGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgGNHqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgGNHqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:46:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BCCC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 00:46:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z13so20128949wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 00:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=juNEK5b9L+0yKzNb5maOeM2KGMSltt59Y86Pmf72rh4=;
        b=VejHABGxvmoah3P28LG49prU0M7btgZ4loiSpJji8KLdhJ+v6pdU0dZ8oY6+txJnAW
         SBkObmS9TM2i9qer8oj66xGIKwCTabtcsEyyya7sm+vIwG7bC+Ne7m01Xhxi5gcdlDbr
         p3EMAAhHBjdm2xd2HBOAzTpz6a6GnQitlgssDOM8X8L127RC9dlDw7aEtLXNb0cclf57
         yP0hbBIqnbum+poxiseBsMSSp9CG+VF4DygZ//pVv7xxETDHj3P4bHFTwJkWVI1e1/6e
         7/77LBId7SzCZU6t2WVVpagHhEkNw3OcNkqNt2nYWT4BE3l0JYLInTwrhRNknCBs/s5v
         7+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=juNEK5b9L+0yKzNb5maOeM2KGMSltt59Y86Pmf72rh4=;
        b=Pdq57NuT7wvs3n9vr7yWnWdWe3tkHIZCfcZLHOi7NStvh/IZBTTmrnFWdb7Y8QW2rR
         SakS39h/k1WXsXy5fju2erJFdXucyzNkCuPCt1/fvu8zVIEQvuVSvNv+Sv5QQcNMWWPu
         VktYgG82AkQ+mt66Q1rJb/5XqkjSiN8w3J4rlmn98CW1EwfB5N7ezzC1cIUSVbWsmsRP
         7GToKMl2xT4jZArjVjRnDd2kaJVNMwvx3Mn3E+gKtfkskwty8BqnqIwgwm7mAG7u+cmc
         ZhOYLzZMaa8P2OrcZklZXNVsYVfwXeY4XbuZdbpbaO1FLqTIIOtI/h3WZNzIkGqwtCJj
         zjog==
X-Gm-Message-State: AOAM5300VAH58mZ/DvfBApUEb+SqmLsztmumavU5Bg3zWYetb3mkI+vV
        yUwbFk2jUlnzAhI40pAwd2PaqA==
X-Google-Smtp-Source: ABdhPJw5WQQZj56gPI2FmzjTVl8x3qwXJasJQvvPCehFylzRN1aAibGmzgyItBdsNTsG3kbkwPpuyQ==
X-Received: by 2002:a5d:42c8:: with SMTP id t8mr3495459wrr.23.1594712794961;
        Tue, 14 Jul 2020 00:46:34 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id f15sm3049380wmj.44.2020.07.14.00.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 00:46:33 -0700 (PDT)
Date:   Tue, 14 Jul 2020 08:46:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Eurotech S.p.A" <info@eurotech.it>,
        Rodolfo Giometti <giometti@linux.it>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 01/10] misc: c2port: core: Ensure source size does not
 equal destination size in strncpy()
Message-ID: <20200714074629.GG3500@dell>
References: <20200626130525.389469-1-lee.jones@linaro.org>
 <20200626130525.389469-2-lee.jones@linaro.org>
 <CAMuHMdVaO3gABJxRzBL+2U9axfAuBLRghSY0vCc9f8a6huiYZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVaO3gABJxRzBL+2U9axfAuBLRghSY0vCc9f8a6huiYZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020, Geert Uytterhoeven wrote:

> Hi Lee,
> 
> On Fri, Jun 26, 2020 at 3:06 PM Lee Jones <lee.jones@linaro.org> wrote:
> > We need to ensure there's a place for the NULL terminator.
> 
> But who's filling that space with a NUL (not NULL) terminator?
> 
> > Fixes the following W=1 warning(s):
> >
> >  In file included from include/linux/bitmap.h:9,
> >  from include/linux/nodemask.h:95,
> >  from include/linux/mmzone.h:17,
> >  from include/linux/gfp.h:6,
> >  from include/linux/umh.h:4,
> >  from include/linux/kmod.h:9,
> >  from include/linux/module.h:16,
> >  from drivers/misc/c2port/core.c:9:
> >  In function ‘strncpy’,
> >  inlined from ‘c2port_device_register’ at drivers/misc/c2port/core.c:926:2:
> >  include/linux/string.h:297:30: warning: ‘__builtin_strncpy’ specified bound 32 equals destination size [-Wstringop-truncation]
> >  297 | #define __underlying_strncpy __builtin_strncpy
> >  | ^
> >  include/linux/string.h:307:9: note: in expansion of macro ‘__underlying_strncpy’
> >  307 | return __underlying_strncpy(p, q, size);
> >  | ^~~~~~~~~~~~~~~~~~~~
> >
> > Cc: Rodolfo Giometti <giometti@linux.it>
> > Cc: "Eurotech S.p.A" <info@eurotech.it>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/misc/c2port/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
> > index 33bba18022892..80d87e8a0bea9 100644
> > --- a/drivers/misc/c2port/core.c
> > +++ b/drivers/misc/c2port/core.c
> > @@ -923,7 +923,7 @@ struct c2port_device *c2port_device_register(char *name,
> >         }
> >         dev_set_drvdata(c2dev->dev, c2dev);
> 
> c2dev is allocated using:
> 
>         c2dev = kmalloc(sizeof(struct c2port_device), GFP_KERNEL);
> 
> hence the allocated memory is not zeroed.
> 
> >
> > -       strncpy(c2dev->name, name, C2PORT_NAME_LEN);
> > +       strncpy(c2dev->name, name, C2PORT_NAME_LEN - 1);
> 
> strncpy()
>   1. does not terminate the destination with a NUL if the source length
>       is C2PORT_NAME_LEN - 1,
>   2. fills all remaining space in the destination buffer with NUL characters.
> 
> So c2dev.name[C2PORT_NAME_LEN - 1] always contains an uninitialized
> value.
> 
> Now, it seems the only caller of c2port_device_register() passes
> "uc" as the name.  Which means in practice c2dev.name[] will be
> NUL-terminated. However, the last byte will still be uninitialized, and
> if the buffer is ever copied to userspace, your patch will have introduced
> a leak.

Quite right.  Good spot.  I must have made the assumption that the
destination buffer would be pre-initialised.  Not sure why it's not in
this case.  Seems like an odd practice.

So we have a choice.  We can either enlarge the destination buffer to
*actually* allow a full length (32 byte in this case) naming string,
or zero the buffer.

Or even both!

Do you have a preference?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
