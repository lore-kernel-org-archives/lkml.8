Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECA1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E841F2065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7KB80y7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgG1UDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgG1UDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:03:14 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAB7C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:03:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so19462125wrl.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ohmu0vMfdHex2xZPcqloEiP8YaJLK572pyUwrwcZ6J4=;
        b=K7KB80y7j7VxdM3l4Ffe2vwCHW7hkhWHpMpHYP8eEB3sm/QGVjG4PlAgSU+RkMzCRR
         a18FB+5kqWpmo8cUQuDq8FBBInqiTBszV57NxvPeNkiKP6Sn5RImHi8+f96EgBFNj0T5
         AdSMifwLG37EskhoPeXKbm57FR6M+6ixA3LY//InU8beSCmXAxbq2vHAvlQ1gDcyyAaS
         E7bL7mYA0DMpE3y1JHn9LPsnOaH4jghUaNZaWPh3S5URbA1GJT85pglkFYicv0EYxdae
         8vcGxjemYAu2Tl7QwfaJKi+aiWou4Lzdx7YL3kOBmRnuUpRc+dI/ZDPAos+bunasKGxK
         xRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ohmu0vMfdHex2xZPcqloEiP8YaJLK572pyUwrwcZ6J4=;
        b=ZzqKdXOJKiVVnCBp0nD+KddOY3rd8A35fnQsYve/6fC2sJSASWAatpX0S0oC14d/6s
         FLnopuZO+RN8akv9nxGpuKPNgTs8LH4r/cpoNoAhIXe85xZxyZ6+CtgzAVS0gQ+J3DaQ
         gItPnD9zgJ3fe/erElwyiFawwK+ajoMYSbv2DxrGxvq0K4FMy+J97Q3xy+drrvLXHcuH
         SW2jQYQDi7dkny4J3ibdxOwLk4h5vC2ltRO7TUgzbk93aMIE61Q2RVBM9e17NWo+RMJJ
         JSnSyPcI/O28+9gkwloJiZFw0Z67DmsyR9L/1vJCCs7/FI9dsBZOJv1XIdWicQ4G4EP2
         vNJg==
X-Gm-Message-State: AOAM530gjoxTIROapXw+h0XtLL43lh6RsaifvuqrRScc0d5BAbNzxNBA
        wOgWaTaBg4O9t2qs/QG/Z8fYv3ZYDFk1X82pwIw=
X-Google-Smtp-Source: ABdhPJy52DXVGn4HR6bSg2SgU93VxhjyIOqA2rpkG0SEKuDIQOBIQowUnerJP2o1ESdA/mdZ50ZiOfVas6U7logwU80=
X-Received: by 2002:adf:dfcf:: with SMTP id q15mr15043913wrn.345.1595966592536;
 Tue, 28 Jul 2020 13:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200726141831.2662-1-aditya.jainadityajain.jain@gmail.com>
 <20200726142013.2891-1-aditya.jainadityajain.jain@gmail.com>
 <20200726142013.2891-3-aditya.jainadityajain.jain@gmail.com>
 <20200726150244.GD452766@kroah.com> <1177f80aa848a294f65e305729304b76d1e5ee98.camel@perches.com>
 <CAJAoDUjRZTxcOJGs2wqPPYyVCYJJTs1NWtmD0+yMXLttgCCQyA@mail.gmail.com>
In-Reply-To: <CAJAoDUjRZTxcOJGs2wqPPYyVCYJJTs1NWtmD0+yMXLttgCCQyA@mail.gmail.com>
From:   Aditya Jain <aditya.jainadityajain.jain@gmail.com>
Date:   Wed, 29 Jul 2020 01:33:01 +0530
Message-ID: <CAJAoDUhcXmmVs1f30bcMrvLoAjoaM+UnFHqueQUqLWAy88bNdA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] staging: rtl8723bs: include: Further clean up
 function declarations
To:     Joe Perches <joe@perches.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 11:45 PM Aditya Jain
<aditya.jainadityajain.jain@gmail.com> wrote:
>
> On Sun, Jul 26, 2020 at 10:45 PM Joe Perches <joe@perches.com> wrote:
> >
> > On Sun, 2020-07-26 at 17:02 +0200, Greg KH wrote:
> > > On Sun, Jul 26, 2020 at 07:50:12PM +0530, Aditya Jain wrote:
> > > > Cleaning up messy multiline function declarations in hal_phy_cfg.h
> > []
> > > > diff --git a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
> > []
> Ok, I'll merge this patch with the previous one. Had separated the two
> to make the diffs smaller thinking they'll
> be easier to review. But yeah, I get the point.
> > > > -void
> > > > -PHY_SetSwChnlBWMode8723B(
> > > > -struct adapter *Adapter,
> > > > -u8                         channel,
> > > > -enum CHANNEL_WIDTH         Bandwidth,
> > > > -u8                         Offset40,
> > > > -u8                         Offset80
> > > > +void PHY_SetBWMode8723B(struct adapter *Adapter,
> > > > +                   enum CHANNEL_WIDTH Bandwidth,   /*  20M or 40M */
> > > > +                   unsigned char Offset    /*  Upper, Lower, or Don't care */
> > >
> > > Those comments should go at the top of the function declaration, in
> > > kernel doc format.
> >
> > Not every external function needs kernel-doc.
> >
> > This is a realtek staging driver that likely it will never be
> > moved out of staging.
> >
> >
> Should I just remove the comments then? Sorry, but I'm a newbie, and
> not really sure what the function is or supposed to do.
> I can try looking it up if kernel-doc is required here.
Hi all,

Any directions on how I should continue?
>
> Regards,
> Aditya Jain

Thanks and Regards,
Aditya Jain
