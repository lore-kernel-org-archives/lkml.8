Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A158DC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 04:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73CC52054F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 04:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hW0p/Hi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgEIEsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 00:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgEIEsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 00:48:42 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95140C05BD0A
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 21:48:42 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id k81so4136447qke.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 21:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1LjLC1s4sCP//+D9ivHb061ksMa6R7nzDgbCchd/Aw=;
        b=hW0p/Hi561SjkDi8KJwWBN/Sd1BQzn/AFk8N18aeXEHY1FmVbkQ74voXCXVYKv/Wnm
         z5oLDLRq1bPZigqeQHzi5ltNDWm0clHQTNNZTcR9z1lgLMHElWRVZWRgIyY9mHLa8tBl
         1zBBhaXWMaDQyKsIs8rp3sXK/jiQEE9BexXMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1LjLC1s4sCP//+D9ivHb061ksMa6R7nzDgbCchd/Aw=;
        b=afUcO6RnNwkRZnYmnVzE6wEyn4U35HIalnkNSTV9WhiHxpK6Z/XZM0PMx1+NtZIaJU
         5A02KXKx66vViUCzn1cff1aF1IfPtxLVwiaO3iXMtcRawTy0dsz2//pte57n1H+fhjN4
         IE7MLWmbEUCS1ntShrRGr2z6ZNiv8qFF0vJyJkibeRRyx2peXy7JT54kyjvfqs23GTqk
         +vZs3ZC/XZgHUwZDjR0+0iBWqgt9tXCQ82vkmhvrAcZ6hKO+7myJ+Kz7vDCAKUhD0Ji6
         pFfElRrr/WcGHR9hqEEhTQfscjuIffu4LqEIpPXrx/OvZiAMn9gMBKMoNY/+GWqg7IQ5
         ypAw==
X-Gm-Message-State: AGi0PuaOd5e5hvuW5PAjYx3Bgso4VgaJmGfV2m+uIV6PWRN14/gMZsW4
        yN9UVYPT2cx5DmEkIrD5IDIpX+nMXdN0vrpQNwx0Eg==
X-Google-Smtp-Source: APiQypIyMwru08xTnu+fFuU8vtzhTVdr50TwJ2cPHujqapbgnzcOUWJEfe7EXsEdE7dCmjUvzZrJH1wdZK19ZmFERZA=
X-Received: by 2002:a05:620a:688:: with SMTP id f8mr6019779qkh.431.1588999721764;
 Fri, 08 May 2020 21:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200508225301.484094-1-colin.king@canonical.com>
 <1890306fc8c9306abe11186d419d84f784ee6144.camel@perches.com>
 <160ce1ee-3bb5-3357-64f3-e5dea8c0538d@canonical.com> <20200508184814.45e10c12@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <fbd61323358554b00460c97ec303572189f99544.camel@perches.com>
In-Reply-To: <fbd61323358554b00460c97ec303572189f99544.camel@perches.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Fri, 8 May 2020 21:48:30 -0700
Message-ID: <CACKFLi=A_43O6OqNGfiybpnJyuQJFV0MjoG-mrRHD0RbNumQnA@mail.gmail.com>
Subject: Re: [PATCH] net: tg3: tidy up loop, remove need to compute off with a multiply
To:     Joe Perches <joe@perches.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 7:31 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2020-05-08 at 18:48 -0700, Jakub Kicinski wrote:
> > On Sat, 9 May 2020 00:31:03 +0100 Colin Ian King wrote:
> > > > My preference would be for
> > > >
> > > > {
> > > >   int i;
> > > >   u32 off = 0;
> > > >
> > > >   for (i = 0; i < TG3_SD_NUM_RECS; i++) {
> > > >           tg3_ape_scratchpad_read(tp, (u32 *)ocir, off, TC3_OCIR_LEN);
> > > >
> > > >           if (ocir->signature != TG3_OCIR_SIG_MAGIC ||
> > > >               !(ocir->version_flags & TG3_OCIR_FLAG_ACTIVE))
> > > >                   memset(ocir, 0, TG3_OCIR_LEN);
> > > >
> > > >           off += TG3_OCIR_LEN;
> > > >           ocir++;
> > > >   }
> > > >
> > > OK, I'll send a V3 tomorrow.
> >
> > I already reviewed and applied v2, just waiting for builds to finish,
> > let's leave it.
>
>
> I think clarity should be preferred.

Either way is fine with me.  I'm fine with v2 since it's already applied.
