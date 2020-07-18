Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A6AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 13:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C30F2070E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 13:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="rTV+fN6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgGRNe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 09:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgGRNe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 09:34:28 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455A6C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 06:34:28 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e8so15749263ljb.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 06:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PV7hHvU5WTJVLxmjDtytdt4i+Ojp5k4NkU4sJzhexD0=;
        b=rTV+fN6SCUZ/GEu9Vs6WW3JrFjNFu1XC/ZBSCEiNkL/2M5nt8jhGAJjafm4fYUq5kJ
         yWTP4jBeYEnOEdR1GDNp4bn/zGngGh3Ln+nHKgI7miC7SbLtf2Ua4vxQA6WZ3nVAhdn5
         BkCFvPNIO8zHhYDpw2mDUwZUFUEq1B/uhmZ3kuRRFmBeXP79l1ku7hTfsxg+Ru2u75Ur
         +n76KOf+GwEMIQp11ZHZy4sz0Pi36YrfodmH8JpQJsqy7GaqggIDp5MKaiNpnsyN9ZAV
         SFAOO4rVQCDhOyuAfJ7+qZr9YjYnoN5rtfr6G6utH1KKHLQQ8WGQBsx5Yyvp/ucQlRXP
         EyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PV7hHvU5WTJVLxmjDtytdt4i+Ojp5k4NkU4sJzhexD0=;
        b=iwtN3bhSAKjQ7k+mIISoFcJMggU7S6sas459F70ivqiwZCN4yEUYQzEISv8UNVO1Ct
         6zBDMhKNBoQMBDDFMQIHI6cTRSDB/MF0QiCBU9jL4jWrQeIT4pfwaoI2o+KbuNlYJlf4
         80Qe8nz5MQwS0V7UF1Bc5yUzX0c62Hc5yVeGeoThvwz7cgT7lRq//q4iXZ88SkLwqj3r
         akPY+i/FolgyD3BySHR8YpTiW4/h2pFJwPbbk90ibgzziqGqLiN1xu6lqgjXrWJfv3Mp
         oVrj1qpwx508lRgPnldVdP55zHGuFZAGccD3OHWDnEPJ6lPpyQE93J1HgRl8V05aWZb/
         hvVw==
X-Gm-Message-State: AOAM5331n3YIy7j+lgUqpmKOhItdfSciY9TvWkarh9dZyj634jJXc5Qs
        qd/8Ryu5j0ClPpZeY1WFlNRkIZcDQyxwpMzGScULRw==
X-Google-Smtp-Source: ABdhPJwJQoFDnmj8u12dbySuIPtpBhE37a9Y8QEazqGOg3WX/XNzDLTdbwZQqca/Uv3IRrV9tsnvXH+L2dU3ba0fKEs=
X-Received: by 2002:a2e:9b92:: with SMTP id z18mr7058455lji.364.1595079266712;
 Sat, 18 Jul 2020 06:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200718091857.quzs5sqvkjzngd6k@pesu-pes-edu> <560eeb7388164e58ac0e47277fe2aec798c45a5c.camel@perches.com>
In-Reply-To: <560eeb7388164e58ac0e47277fe2aec798c45a5c.camel@perches.com>
From:   B K Karthik <bkkarthik@pesu.pes.edu>
Date:   Sat, 18 Jul 2020 09:34:15 -0400
Message-ID: <CAAhDqq17xt5Q9JHPw9NDnFhbp=0gYS4PJWyRwvPYKXMrN_btPQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] staging: rtl8188eu: include: placed constant on the
 right side of the test in comparisons
To:     Joe Perches <joe@perches.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 9:17 AM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2020-07-18 at 05:18 -0400, B K Karthik wrote:
> > placed constant on the right side of the test
> > to fix warnings issued by checkpatch
> []
> > diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
> []
> > @@ -326,7 +326,7 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
> >
> >  static inline int IsFrameTypeCtrl(unsigned char *pframe)
> >  {
> > -     if (WIFI_CTRL_TYPE == GetFrameType(pframe))
> > +     if (GetFrameType(pframe) == WIFI_CTRL_TYPE)
> >               return true;
> >       else
> >               return false;
>
> Always try to improve code instead of merely shutting
> up checkpatch warnings.
>
> This function should likely be written:
>
> static inline bool IsFrameTypeCtrl(unsigned char *pframe)
> {
>         return GetFrameType(pframe) == WIFI_CTRL_TYPE;
> }
>
> and given it's used only once, it might be expanded
> in that place and removed altogether.
>
> Something like:
>
> (and the memcmp below could be ether_addr_equal instead
>  but I'm too lazy to find out if the addresses are both
>  guaranteed to be __aligned(2) which is likely)

Alright, I will try to do that and send a v2 asap :)
>
> ---
>  drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c | 8 +++++---
>  drivers/staging/rtl8188eu/include/wifi.h        | 7 -------
>  2 files changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
> index 7d0135fde795..a2994f9ecbde 100644
> --- a/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
> +++ b/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
> @@ -144,10 +144,12 @@ void update_recvframe_phyinfo_88e(struct recv_frame *precvframe,
>
>         wlanhdr = precvframe->pkt->data;
>
> -       pkt_info.bPacketMatchBSSID = ((!IsFrameTypeCtrl(wlanhdr)) &&
> -               !pattrib->icv_err && !pattrib->crc_err &&
> +       pkt_info.bPacketMatchBSSID =
> +               GetFrameType(wlanhdr) != WIFI_CTRL_TYPE &&
> +               !pattrib->icv_err &&
> +               !pattrib->crc_err &&
>                 !memcmp(get_hdr_bssid(wlanhdr),
> -                get_bssid(&padapter->mlmepriv), ETH_ALEN));
> +                       get_bssid(&padapter->mlmepriv), ETH_ALEN);
>
>         pkt_info.bPacketToSelf = pkt_info.bPacketMatchBSSID &&
>                                  (!memcmp(get_da(wlanhdr),
> diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
> index 791f287a546d..3998d5633860 100644
> --- a/drivers/staging/rtl8188eu/include/wifi.h
> +++ b/drivers/staging/rtl8188eu/include/wifi.h
> @@ -324,13 +324,6 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
>         return sa;
>  }
>
> -static inline int IsFrameTypeCtrl(unsigned char *pframe)
> -{
> -       if (WIFI_CTRL_TYPE == GetFrameType(pframe))
> -               return true;
> -       else
> -               return false;
> -}
>  /*-----------------------------------------------------------------------------
>                         Below is for the security related definition
>  ------------------------------------------------------------------------------*/

thank you for pointing me.

karthik
