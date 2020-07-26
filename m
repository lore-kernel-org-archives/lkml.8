Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3ADC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B74520719
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1SPzlPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGZJXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgGZJXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:23:48 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF03C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 02:23:48 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id 88so11980036wrh.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 02:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IRifPYsK+NVyPH264FNNiwkh83/Nree/BqnQLiW9d1c=;
        b=l1SPzlPpdGPY8mrIuX5HzscI1H+iU0B77BLfrJ+HTsHQpZ1CbpuBaxo5y5BQLbagzm
         ahNVMJV+XFViXN0810WuF+oXTSEuAjFRZhMh2tX3oEli8/sF1GKeQPjS6VaRloWiTwuG
         y28IJVlcYcob0iUkzDfsBzo05H/rOvI53pNhD1S2chvYHphbQ4iHLuLaPyzs56xv4OLc
         6pfF9Wcu7iZuNQsIs6oPa6CnupttvnAt/OeUwZWZ83le+KxxKXux0cyCTCSCl+fFdFiW
         GwYoF5CJC6VfOatv4g7JgtRHpXYViK+a4HWo2sNzcTPHAfMwo01uEIaCMjb6MMXPJypI
         QJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRifPYsK+NVyPH264FNNiwkh83/Nree/BqnQLiW9d1c=;
        b=ELAj3ftmP1a+pIov3Lq6oXqTAEV28dQFzSvvLmhMQTd5HkpME3BbHhhiqMv1xuEf/d
         GhHCdvNG6OtWkiC8N04HyfB8BhIGN7Y3aCDhfeL4fQUM7hihTUYOEx83tiOZCsP/nRxW
         02LCH49WW44Prt7zzXwcWFkjI6j8dVWG89k6NEIGOPc6yfw+fOEWHtmDw9IOuOmTVVc3
         t6OmYDZvp69eLLWKyj2EO1OcuZekbJ7RkP3fdyknWhGw9tvVODvELqRyUSqH45gqzCUQ
         OMOYOzfUUr18Z+XVDEqZ/1ivhdPFEexlMluLnEvF094q8Rm0E4h0OfeoMNXMQIeyxkrN
         s8Og==
X-Gm-Message-State: AOAM5306VLmztkiWC3DqdPnG0sR0A/49a27ZLOYObWYz1Ex4tAWDNvix
        va3giMIua+M+qW9X2ozSbToQ2HI6WIIIIygMvlo=
X-Google-Smtp-Source: ABdhPJzmRnX9GtgCQQSUsd47l+Xrw14S4/+hUnnzUXCooTdht3nSiu4kVe23GlLgaRmrU8M/CgnSsMp2RdaYTRNllqs=
X-Received: by 2002:adf:dfcf:: with SMTP id q15mr3987406wrn.345.1595755426875;
 Sun, 26 Jul 2020 02:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200726080215.41501-1-aditya.jainadityajain.jain@gmail.com> <20200726082636.GA447282@kroah.com>
In-Reply-To: <20200726082636.GA447282@kroah.com>
From:   Aditya Jain <aditya.jainadityajain.jain@gmail.com>
Date:   Sun, 26 Jul 2020 14:10:58 +0530
Message-ID: <CAJAoDUjVBon2iiztdER82mHgJtVS6s5XYSajbCTne0KWAzoLvg@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: include: Fix coding style errors
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 1:56 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jul 26, 2020 at 01:32:15PM +0530, Aditya Jain wrote:
> > Fixing ERROR: "foo *  bar" should be "foo *bar" in hal_phy_cfg.h
> > as reported by checkpatch.pl
> >
> > Signed-off-by: Aditya Jain <aditya.jainadityajain.jain@gmail.com>
> > ---
> >  .../staging/rtl8723bs/include/hal_phy_cfg.h    | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
> > index 419ddb0733aa..fd5f377bad4f 100644
> > --- a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
> > +++ b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
> > @@ -42,7 +42,7 @@ u32         Data
> >
> >  u32
> >  PHY_QueryRFReg_8723B(
> > -struct adapter *             Adapter,
> > +struct adapter               *Adapter,
> >  u8           eRFPath,
> >  u32                  RegAddr,
> >  u32                  BitMask
>
> Ick, these are all horrid.  How about just making these all on a single
> line like most functions have them instead of this one cleanup?
>
> Same for the other changes you made in this file.
>
> thanks,
>
> greg k-h

Agreed. I'll clean it up.

Regards,
Aditya Jain
