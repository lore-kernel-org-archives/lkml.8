Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5FBC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 02:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A585220768
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 02:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJFrkbUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgDJCPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 22:15:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43834 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgDJCPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 22:15:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id k28so351540lfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 19:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHp6kWdblV62fFQJszl1KhtVeREya2XQGoR7Z3Ctk6Y=;
        b=iJFrkbUJnTySpOhDp4yoyBmUb3UuG3oACOXrNZRqkUH+XGjwxA8DR65JI7GNpR+l2m
         qOZnt+e4jshk3lLgb1AbSo53mixeKjd3pjW45jJYN1J2BJDYxfspx6uu6u060D1DjGqY
         +nZ8KuK0Z9rVktkbIs2LLT3DaGwlW1H7vtzc/2/aPj18Bk9uctn+3/8jxXqT0HgN0uVX
         cCXMNybZkNokyyx8bpO/JKMiG4OLhGeS0MPS6TngDREhg+ckTCvqi/9Cc5CNoACbk/8u
         mWd5Oy/5cYph2quUrEwZtyBlgaIJKk8OGZdhs90H8XGRlcQcCTXAZI1zElovy5xJD5gn
         SAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHp6kWdblV62fFQJszl1KhtVeREya2XQGoR7Z3Ctk6Y=;
        b=DFol3PN7Wz0fuJu5xiFFdDpxKDFXKG5+heRL9Ldz8iB5hbVbNahr2jyw+3e+td6I7Q
         7D3kykUnWjhZLD/rlsQRc/1PEWp9E5wBao28XF7nQxaWAIardtjLKn/8YwY6tyJzHhp4
         gAD0oo1WWtg7mEz39wGHxUPLkP17zX2ROhJIrBuJO56vm2/4GkW5Ox41eOcOB2blFsKF
         A0QfbWJcroXh/dPmTmlqMpJ6wCFN3c+l6NEVbMV3D2/A3xplPqqcqK1ADBZEZMgfqDlk
         w358I5qBfFj820iePft0yCGd4l7iSYszRDVsec+96lCpSAgvWZwyMwvrnrDJ/DerP0cG
         xeBw==
X-Gm-Message-State: AGi0PubvPQm1PCjgMxm6Kv+kbEvl3hn19/IFLIN6Xm7p80GZVB7OEMww
        1eYwmCqcMdGclAd7u1e/3j+dXT/V1J08mdblBbI=
X-Google-Smtp-Source: APiQypJlddnNYS1LT0mLY4bEF+OzEhS2mP/hs1+7huPUqu5ol368qntbMXFNQ1dqjBzg8CMPpoGAesnfTE42r3FUfms=
X-Received: by 2002:ac2:57cb:: with SMTP id k11mr1235147lfo.19.1586484931222;
 Thu, 09 Apr 2020 19:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586422035.git.baolin.wang7@gmail.com> <759f7471d03946ae273a06f7bcca8a54528ec08c.1586422035.git.baolin.wang7@gmail.com>
 <20200409104802.GB5399@sirena.org.uk> <CADBw62oh6juAqUR1-U1D73H0oeW1x0gk0XJ01h47ko_Dxy7eEQ@mail.gmail.com>
 <20200409142715.GF5399@sirena.org.uk>
In-Reply-To: <20200409142715.GF5399@sirena.org.uk>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 10 Apr 2020 10:15:19 +0800
Message-ID: <CADBw62qtpnnmsSmfnHBL_ntHyM9fZHohxghXv1Wgg-mCgbEnYA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] mfd: syscon: Add reg_update_bits() callback support
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 10:27 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Apr 09, 2020 at 10:13:58PM +0800, Baolin Wang wrote:
> > On Thu, Apr 9, 2020 at 6:48 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > > +     int (*reg_update_bits)(void *context, unsigned int reg,
> > > > +                            unsigned int mask, unsigned int val);
>
> > > This is fine, we already have this operation for buses, but why is this
> > > munged in with the MFD patch?
>
> > Originally I want to show a example usage of the new callback, but I
> > can spilt them into 2 patches as you suggested. Thanks.
>
> Yes, it's good to have an example user - just not as part of the same
> patch!

Yes, make sense.

-- 
Baolin Wang
