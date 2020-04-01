Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31810C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38BD207FF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LSe3YHd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbgDAIUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:20:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43772 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731995AbgDAIUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:20:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id g27so24737875ljn.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 01:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xIxdPs3PCWGrE1rhEKnhI29WwowDoOmXYLKku7/kqhU=;
        b=LSe3YHd9F0nJBdAnd2M0pbyKcOUuxrYfkAZbfzzavXnm/vf5pui4cy40QMGXuBXw6O
         PtrWohZnOdZ5krIl66URyEvd+OREL2CCVHPq3aJhrnE7VYL8cTw47hQYwd7LNrnRCavU
         w5eDZW8jjfLCVT0Qr0E7O62Mi53S6BDadlRiF4lFbbj3gfbQFi33oDyCkfXpM872Rhh+
         KryuliO0WWpRTdwZgUuuc/rmxL7yAg+ewDy6Oq7ezq+1WpxSooKL86cQgsvUwFNha6Gb
         6ZTdxkV0KXDMKrvrtH05Rrk7LO04sSRZ4oKfy05jk/m20jxdgdeth3GxA0TMZPVS8zX+
         g3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xIxdPs3PCWGrE1rhEKnhI29WwowDoOmXYLKku7/kqhU=;
        b=WzYeOU08M2HGqJS0dz2iBH+hr7FXHK22NtKFckyO7jie9Q136z1eFNanhE/JDDN8GV
         Ji4XFVvrdd+baA1lGeBVZeX9FSLixMILkuc8eWwjdspfu+Y2/2ylGjMMJbAqQweHQ8bB
         RPxXtHF3vjZg2dhrqyKYJmCBU9aYJhe6FoAP4KHZ+ZH8iTxDJro/t30nzpkpW0F73opT
         mF/1G6m05k74Bq4Zw9Nm1K/9HJq5Lg0JB/lgDaLEcuFkIu3eJLL2DpD+fuuc2MkoVusA
         eX0jVifdRPT24mD3cSzrQj0SmutnjnqSDKbxnpdkV62a6dK7iHAC7wPHKlqtEwt7+SG0
         zIfg==
X-Gm-Message-State: AGi0PuYy2k2PQrUyaORTtrW//yy4pOatWYdI1sV85k7jUoG04hCEz9AV
        yZTnl9s/Vj7hcEcTTYxYWTMwxWfA6nmMfVzYT8Jadw==
X-Google-Smtp-Source: APiQypJsnLDmKh1yBBjZBhguP/v9RUaTCpgsNrdRcuHpGcqAeZsCIOj74BvrzWIRMq/PR8riGPHyMNgylYL7/zlVGPE=
X-Received: by 2002:a2e:9d85:: with SMTP id c5mr998983ljj.168.1585729237735;
 Wed, 01 Apr 2020 01:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200401190810.7a2cfa07@canb.auug.org.au> <20200401191810.1c06ead6@canb.auug.org.au>
In-Reply-To: <20200401191810.1c06ead6@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Apr 2020 10:20:26 +0200
Message-ID: <CACRpkdaHdr_TwVES2+hZ9PMTryybHrbYgi0RL3ihkRERsTmV2Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: turn of_pinctrl_get() into a static inline
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thierry Reding <treding@nvidia.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 10:18 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Wed, 1 Apr 2020 19:08:10 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > This avoids the overheads of an EXPORTed function.
> >
> > Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/pinctrl/devicetree.c    | 6 ------
> >  include/linux/pinctrl/pinctrl.h | 9 +++------
> >  2 files changed, 3 insertions(+), 12 deletions(-)
> >
> > This is not even build tested, but is this what you meant, Geert?
>
> Actually this won't work because get_pinctrl_dev_from_of_node() is
> declared in the private header file drivers/pinctrl/core.h :-(

No big deal. We keep your other fix for now.

Yours,
Linus Walleij
