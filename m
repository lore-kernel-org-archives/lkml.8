Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCE9C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 06:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3207920578
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 06:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="Oq/JKnUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgGZGM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 02:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgGZGM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 02:12:56 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38290C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 23:12:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v4so4212714ljd.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 23:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mjFcFPkYV6UQ15e1Sw/cnOMTT80K9lOv0sYuMsnpbg8=;
        b=Oq/JKnUlAX9SgNCIN2rS3ntngRStgdIT5wRDVT1qa5YLa6Xljk4gSLakcYqNbwrf4A
         rNXx4HHTqH0Jh2YjKKQi/eGniW+FMfKa74XyMOhhUKiBGr82wanEaf2ej/YPHZ84/MW5
         IHBmbmbvb1UHIJB1PK9YIzeRm6OE5HEoJJgJ8zslayrKOxWXPkl+goJIUta9pEsJw4PF
         gl3g15nkqfCCvCDV2tY9EKe6VG/4n5Fgzyi8abxE7bayEIU9QrSCUWM1V+jBAqIWoaYx
         jGT5pKGDbSu1KJX+0PtRUxOKXmPipyez2I/Qew4fXGDxujA6P6TVWTEg0HHlL3Q2D3DE
         P06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjFcFPkYV6UQ15e1Sw/cnOMTT80K9lOv0sYuMsnpbg8=;
        b=jU5Rt1+10QH241yFGe46i3r5US+pjgffdlk7xmnwXoRWSu0Cuk5eRzg3TRWRQZAz8B
         FRwfQuVSbUnlyUXH9ZqG9CCEiIpvSoAUEovKzkU8Un4oQ8gr1UAoQPp2qgz83WEOdSIK
         c1xYQ6BkRDvm7Cq+ls6DeOsoOI5UmUIN8Rrbrvimg6LSdirfxFZoK0F7WlVftI9v5brU
         NXNa+7M358607A2BXQbnvgkmS27rmHwRJwtaq9sZj3suMIgDeVzl/8qOrwe/wZx1PcUh
         PFOX5bN8ASqvZ2D4m1EkYOJv9wmFFPJhg8NPdms53DSsuwlEB57WZmBeW68a+OV+B1FG
         aOEQ==
X-Gm-Message-State: AOAM533P6pBRESwqKL3CLcF44n1vrldsAHDOPWqXS6llOUwMCzuhkwem
        FMojRht4fWSx+BtpAiV3AKn1P7TvcmZymrT8FYdByg==
X-Google-Smtp-Source: ABdhPJzLAZZeMuZM0RtO55UD2RjUIs4qLuxl6cAGSb+bhh8HpFUnkvUeSQFum4N/+Mm8ZHnpyXRsev9eXIbtReWvkS8=
X-Received: by 2002:a2e:9c59:: with SMTP id t25mr7286391ljj.402.1595743974346;
 Sat, 25 Jul 2020 23:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200726030855.q6dfjekazfzl5usw@pesu.pes.edu> <CAM_iQpUFL7VdCKSgUa6N3pg7ijjZRu6-6UAs2oNosM-EzgXbaQ@mail.gmail.com>
In-Reply-To: <CAM_iQpUFL7VdCKSgUa6N3pg7ijjZRu6-6UAs2oNosM-EzgXbaQ@mail.gmail.com>
From:   B K Karthik <bkkarthik@pesu.pes.edu>
Date:   Sun, 26 Jul 2020 11:42:43 +0530
Message-ID: <CAAhDqq28h9_ji=ANttUyx2Q1Md=bZD3-JVCwQRW06W7aikPN0A@mail.gmail.com>
Subject: Re: [PATCH v2] net: ipv6: fix use-after-free Read in __xfrm6_tunnel_spi_lookup
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 11:05 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> On Sat, Jul 25, 2020 at 8:09 PM B K Karthik <bkkarthik@pesu.pes.edu> wrote:
> > @@ -103,10 +103,10 @@ static int __xfrm6_tunnel_spi_check(struct net *net, u32 spi)
> >  {
> >         struct xfrm6_tunnel_net *xfrm6_tn = xfrm6_tunnel_pernet(net);
> >         struct xfrm6_tunnel_spi *x6spi;
> > -       int index = xfrm6_tunnel_spi_hash_byspi(spi);
> > +       int index = xfrm6_tunnel_spi_hash_byaddr((const xfrm_address_t *)spi);
> >
> >         hlist_for_each_entry(x6spi,
> > -                            &xfrm6_tn->spi_byspi[index],
> > +                            &xfrm6_tn->spi_byaddr[index],
> >                              list_byspi) {
> >                 if (x6spi->spi == spi)
>
> How did you convince yourself this is correct? This lookup is still
> using spi. :)

I'm sorry, but my intention behind writing this patch was not to fix
the UAF, but to fix a slab-out-of-bound.
If required, I can definitely change the subject line and resend the
patch, but I figured this was correct for
https://syzkaller.appspot.com/bug?id=058d05f470583ab2843b1d6785fa8d0658ef66ae
. since that particular report did not have a reproducer,
Dmitry Vyukov <dvyukov@google.com> suggested that I test this patch on
other reports for xfrm/spi .

Forgive me if this was the wrong way to send a patch for that
particular report, but I guessed since the reproducer did not trigger
the crash
for UAF, I would leave the subject line as 'fix UAF' :)

xfrm6_spi_hash_by_hash seemed more convincing because I had to prevent
a slab-out-of-bounds because it uses ipv6_addr_hash.
It would be of great help if you could help me understand how this was
able to fix a UAF.

>
> More importantly, can you explain how UAF happens? Apparently
> the syzbot stack traces you quote make no sense at all. I also
> looked at other similar reports, none of them makes sense to me.

Forgive me, but I do not understand what you mean by the stack traces
(this or other similar reports) "make no sense".

I apologise if this message was hurtful / disrespectful in any manner.
thanks,

karthik
