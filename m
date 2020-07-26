Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8525C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C443820714
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmLMxf6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgGZSPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 14:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgGZSPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 14:15:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DF8C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 11:15:47 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 9so12117720wmj.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 11:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PiMm1yyj8Q6tWrjven5zlrS3Z6213SZfjWTHd4vlUEs=;
        b=CmLMxf6kuw6cGyk+BN9PWV10v+ZIuKboIGE4KjhBEWxLqJBNXjSI3lzOYhcEDLn2+I
         5gBkC+WleShAEybkvXkPE+M34ocghl9dpoyI9grS8J+/xnGSTfAtfg2o4j57uXxRaxzq
         sz7efvYjguxQiemKygzsreiedWNkvEyW5uJACcZUCa8CK8Dj3CDRW3wlAIMyyFPUUfzu
         shOycahC9xmGXJRnp7SeVGmlgKLE89yQxsyDJZsu42FUwE/1XIS4DsgohQbGTCWx1OC5
         yICgBnq0Q8arxcc5D4LXLSESoE6dzHIe2k+ZStnawTRkp9X9KX0DPtmENs6o27Sp0tLp
         VZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PiMm1yyj8Q6tWrjven5zlrS3Z6213SZfjWTHd4vlUEs=;
        b=RKNdD5D6c++WFLZk0q7EKrdJTxwrQKwc0Lv/rax5T0VA5eFWNiCPKS30Uftc2XaetN
         pYieuETCtP61UQ8XoYeudEEXVurU0xmK8DIDjxxYVQ4WtK8Bd1K3DHF6BEhHdVyR4GwQ
         HKy9zyYX4f7xFjRfK4Q3SKVZ2gbmADzQ4qeoTLrKF+ovXs23WlxNDMxS018+7MKnqsOA
         kLEYPgfxY5DgLMniGsVvr+uf4gCgGBnbQlfJ8bAx/L3ag0JjqS3whVFSYWJKGGqsz9Z3
         603ricEe669MGzzh1TTmXJSmjzpk2B/IpG1L2qnBYRimmimy2qp845GR7Cr+3zdDBJ9f
         Iu7Q==
X-Gm-Message-State: AOAM533jqXK1Lw6JFB37LZAxK3wLcj6ExMhv9An5vJ43D6/T6yX0ojpK
        aRHeMRlIOjvuG3Td38bliqLDWAHSzpOWl8gyrBI=
X-Google-Smtp-Source: ABdhPJwkNpZuNMVrZC51FWF7gZY8qO0E3BYnZEcsXKTs5g22I6lRW5H9rVnp97x89RgJscB5uaGUnmkuzahbN7KpyRY=
X-Received: by 2002:a1c:3b02:: with SMTP id i2mr16770291wma.24.1595787346092;
 Sun, 26 Jul 2020 11:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200726141831.2662-1-aditya.jainadityajain.jain@gmail.com>
 <20200726142013.2891-1-aditya.jainadityajain.jain@gmail.com>
 <20200726142013.2891-3-aditya.jainadityajain.jain@gmail.com>
 <20200726150244.GD452766@kroah.com> <1177f80aa848a294f65e305729304b76d1e5ee98.camel@perches.com>
In-Reply-To: <1177f80aa848a294f65e305729304b76d1e5ee98.camel@perches.com>
From:   Aditya Jain <aditya.jainadityajain.jain@gmail.com>
Date:   Sun, 26 Jul 2020 23:45:34 +0530
Message-ID: <CAJAoDUjRZTxcOJGs2wqPPYyVCYJJTs1NWtmD0+yMXLttgCCQyA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] staging: rtl8723bs: include: Further clean up
 function declarations
To:     Joe Perches <joe@perches.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 10:45 PM Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2020-07-26 at 17:02 +0200, Greg KH wrote:
> > On Sun, Jul 26, 2020 at 07:50:12PM +0530, Aditya Jain wrote:
> > > Cleaning up messy multiline function declarations in hal_phy_cfg.h
> []
> > > diff --git a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
> []
Ok, I'll merge this patch with the previous one. Had separated the two
to make the diffs smaller thinking they'll
be easier to review. But yeah, I get the point.
> > > -void
> > > -PHY_SetSwChnlBWMode8723B(
> > > -struct adapter *Adapter,
> > > -u8                         channel,
> > > -enum CHANNEL_WIDTH         Bandwidth,
> > > -u8                         Offset40,
> > > -u8                         Offset80
> > > +void PHY_SetBWMode8723B(struct adapter *Adapter,
> > > +                   enum CHANNEL_WIDTH Bandwidth,   /*  20M or 40M */
> > > +                   unsigned char Offset    /*  Upper, Lower, or Don't care */
> >
> > Those comments should go at the top of the function declaration, in
> > kernel doc format.
>
> Not every external function needs kernel-doc.
>
> This is a realtek staging driver that likely it will never be
> moved out of staging.
>
>
Should I just remove the comments then? Sorry, but I'm a newbie, and
not really sure what the function is or supposed to do.
I can try looking it up if kernel-doc is required here.

Regards,
Aditya Jain
