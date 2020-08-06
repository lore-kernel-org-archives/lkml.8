Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0596C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 22:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF9A9221E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 22:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eXS0ODOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgHFW00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 18:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgHFW0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 18:26:24 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21D8C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 15:26:24 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id a21so7270vsh.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 15:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YGajm5r6zR/+nNN2cQh50g5+7OFPlrf5M3DJ+xKFqMA=;
        b=eXS0ODOHzzEQ1IzMoshQkd+VJIREPpAPqqUAVJ/0iwT9+KpzNB6yj/GaIP4IFcrpWi
         xdi4QRl1tVx77MsqMHxlkWY8156sVNuuE63xbCFi3p3ws45NDiK5gwhGPQZ5wuQaCmtB
         zAptEl78v+Cnkvp7qQWbXGuJtWbZdjEMSVujA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGajm5r6zR/+nNN2cQh50g5+7OFPlrf5M3DJ+xKFqMA=;
        b=IzwEeUbVq1v7mzNDJdEhXhdiXpoiM07OSXqtNMW4rWeJlJxI6Qh8OPfuG5zo9XJxeA
         VjRvdEhM3sUzUnqVxXZqAm+/aXM0VMvq4c3337UjcMgoJopQqJTQ9JTZMdTOWJBg3XmF
         B+A1QBN7nfh4oC2CCq/N2U9ygDf33TYCKFBH+j8nZY7K9DxWGOh9Eq/td9R9wYFodsfj
         RvUcUnpo6ln83WIYSnngBHb+BlWPCeaDmYHY0s2Kn2bM5YlfKXqhJjWfQdJAr/2CLHWV
         6VYVCbOMD9B+X4d2pEmq25TjvG9i3CzJ6yhONLHg6+YODz2RXBEZy4mqFMvnzFpk90u7
         eSFg==
X-Gm-Message-State: AOAM532ZIfEkG18TUQC7xRuiFpX3z18975xxt+RPH88veDkVVJow39iz
        lpyniX4QmczXDaZv59bvmcsqtT+xzJc=
X-Google-Smtp-Source: ABdhPJyBlq99jf1/0Kpn6lqNn7Sz6WMUzFQP3+j09yDuKEcsDIFyz33Q+BDdC2NXXBMe4h829VjjJA==
X-Received: by 2002:a67:e189:: with SMTP id e9mr8549015vsl.3.1596752783380;
        Thu, 06 Aug 2020 15:26:23 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id s65sm1273572vkg.19.2020.08.06.15.26.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 15:26:21 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id n4so9231vsl.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 15:26:21 -0700 (PDT)
X-Received: by 2002:a67:d714:: with SMTP id p20mr8651126vsj.119.1596752781366;
 Thu, 06 Aug 2020 15:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191019111216.1.I82eae759ca6dc28a245b043f485ca490e3015321@changeid>
 <20191120191813.GD4799@willie-the-truck> <CAD=FV=Wntf0TCwdtNNvPY-CXX1VL_SZK8Y8yw1r=UfeayHfwgw@mail.gmail.com>
 <CAD=FV=WgoVN-scgT41R=6Toif2Zrskb3rNzZn_xbP_-ByZC1MA@mail.gmail.com>
 <20200806154144.GD1551@shell.armlinux.org.uk> <CAD=FV=XBinO0+uSt_sDTw_YFiZC4Gf8RMSC9ycDg+RWH=63Tog@mail.gmail.com>
 <CAD=FV=XAi6J1LZRZJacTVhX=PYCWs3-5MtS_bG2_ZTuQPfxstQ@mail.gmail.com> <20200806220241.GE1551@shell.armlinux.org.uk>
In-Reply-To: <20200806220241.GE1551@shell.armlinux.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Aug 2020 15:26:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UMc=YVpDRfWdtv_g5=zhCRg=y8JeszYQLUZbgtHC6dLg@mail.gmail.com>
Message-ID: <CAD=FV=UMc=YVpDRfWdtv_g5=zhCRg=y8JeszYQLUZbgtHC6dLg@mail.gmail.com>
Subject: Re: [PATCH] ARM: hw_breakpoint: Handle inexact watchpoint addresses
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        Pavel Labath <labath@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kazuhiro Inaba <kinaba@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 6, 2020 at 3:02 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Aug 06, 2020 at 11:28:09AM -0700, Doug Anderson wrote:
> > Let's hope this one works:
> >
> > https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8997/1
>
> Almost.  It seems that you must have grabbed a copy off the patch
> system, edited it and sent it back?
>
> The commit message appears to contain:
>
> Reviewed-by: Matthias Kaehlcke <(address hidden)>
> Acked-by: Will Deacon <(address hidden)>
>
> which is a transformation done for by the website front end to avoid
> leaking people's email addresses to web crawling spam bots.
>
> Provided I remember when I come to apply it, I could fix it up by
> looking at the original patch (8944/1) but I'll probably forget by
> that time.

Sigh.  OK, hopefully correct now:

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8997/2

-Doug
