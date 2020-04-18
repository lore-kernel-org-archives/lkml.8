Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BF2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 01:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E7E221D94
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 01:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYLfnuAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgDRBxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 21:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725535AbgDRBxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 21:53:11 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABEEC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 18:53:10 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h6so3367185lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 18:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGC52WWd8zsxGRTgkjK197PZgUrl5OcPPncRci0F83k=;
        b=SYLfnuAsEuog7wgkeEdr2GTt087+E0mkCL2JPkgP+oKzuJt5Hwp15wVng1lHp1batH
         QWOLYmsYSk+7Qshz7nbobBnqhJMGf1cmK9CHkuNkdW0/UJyiPQILbsxT+ZBsECPm0An/
         gkYWfrnsDN5RHI/gV0Qfi9ubUjD1cPNB31SVTQX8SU9VO8O6x+/Db3nKC6X/FVhmKzJX
         Wi0l/M46TdFWqMpeXs8WXe4i5lnPFXpFcY7dyxcKXgmyZvoOt+QHSS/tSY/ErWfquOnq
         YmBw7rVC5VRepK2J8cuC7YU6oXkybVFPxugY3AY3nVZBRIwXMot9XTwAtmSAeE8ukDUs
         sn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGC52WWd8zsxGRTgkjK197PZgUrl5OcPPncRci0F83k=;
        b=c0A3UtUQrMLfG7PPqtziHbrPbRxmY337UB/mxIyzCI1bAoAAhPm8okqSLoP3nJrsF7
         qIcr0G51WV16xzzAAsZ+JJ6xXBXGQlJ1YUkyuqOVHMzrQ+bk4Q1VHkCIMOOaie/CpeNf
         XigMGqc7Mi2lbuJg+TzqTipTCBXuZX+mESC7bE7VtThsBcfL4ysySCZJ3/VK1wfDgVfZ
         xVmAB01U/DdT9Sls863Vphy1wxfq4b5awf5PlD5Ovbb5nnxSsMRBlFXM6Q6G3x+U6Yd4
         w+FcC41PBVFiPbbWf332ZmDiGqWLcXGIUF5efaGE4UyQOGpar6K6308rDbpz0CR49NY1
         0y0A==
X-Gm-Message-State: AGi0PubTPBXjIohmylgi455T7UFTnjYjKhmZFar5siyaNj7DxePUckw3
        QpsKmPCLGE7mGCRwvIX0Ftha9PVWfb/w/r47MhY=
X-Google-Smtp-Source: APiQypK/VxQQznkJrSj9sXWcD5xSXRjJQj8qx+ulg8v8yMCtyglr/83rSfKHeACBKtI2VvSNY6FwHOjefz+Q5RNcQtc=
X-Received: by 2002:ac2:57cb:: with SMTP id k11mr3782353lfo.19.1587174789139;
 Fri, 17 Apr 2020 18:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587088646.git.baolin.wang7@gmail.com> <dad648071fd163140f6534295cfce76562003b5a.1587088646.git.baolin.wang7@gmail.com>
 <CAK8P3a22NMzCQHDoE7Ed0a1_f7yOTO4x4PM6KArXJnaaig4ZTw@mail.gmail.com>
 <CADBw62q2+nWOFp+BLuNvpztyy-wYJYO=3024eBun4J=grqJhVg@mail.gmail.com> <CAK8P3a2-AQx6iuNeWOFfru3H21pv4Gg7Qt00uUghbnPDzwF4_g@mail.gmail.com>
In-Reply-To: <CAK8P3a2-AQx6iuNeWOFfru3H21pv4Gg7Qt00uUghbnPDzwF4_g@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Sat, 18 Apr 2020 09:52:58 +0800
Message-ID: <CADBw62r2+3DiUg4oFq6gWJTrCyCEnmekA5jqwHPwA=0zJauTPw@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: sprd: Add Spreadtrum special bits updating support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 11:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Apr 17, 2020 at 4:10 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > On Fri, Apr 17, 2020 at 9:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Fri, Apr 17, 2020 at 4:14 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > +static int sprd_syscon_init(void)
> > > > +{
> > > > +       syscon_register_phys_regmap_bus(&sprd_syscon_regmap);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +core_initcall_sync(sprd_syscon_init);
> > >
> > > This no longer breaks at runtime based on the changes in the other
> > > patch, but I still don't like how you have to manually load this module
> > > on spreadtrum platforms.
> > >
> > > What I meant to suggest in my previous reply was to add the regmap_bus
> > > instance into drivers/mfd/syscon.c itself.
> >
> > Sorry, I misunderstood your meaning before, but what you suggested
> > will add some vendor-specific things into the common syscon driver, if
> > other platforms have different update bits method, we will add another
> > vendor-specific regmap bus into the syscon.c, which will make syscon.c
> > more complicated.
>
> I think we can always deal with this once it gets too complex, as long
> as the DT binding allows it.
>
> > But if you still prefer to add these vendor-specific things into the
> > syscon.c, I will follow your suggestion in next version. Thanks.
>
> Yes, please do.

Sure. Thanks.

-- 
Baolin Wang
