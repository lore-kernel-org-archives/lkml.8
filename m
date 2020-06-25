Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4EBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B4920781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJ+Kn2vo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406694AbgFYTgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405815AbgFYTgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:36:04 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3A0C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:36:04 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so833683pgf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4GyWptTEsbmUs5nn7vZbOukBmjJMFIOBkkSnrY6WZc=;
        b=LJ+Kn2vomVBVY/RT6eQyr/9kVYKfgF/cMX4MADV7jwj2jlyNxVxWbuAKOFovUB1Yy0
         7Lcv7jAqkqs6UCEZGpizFTgkUn6geQI7j22ke/W6ipvIx2YfgsL+gw7Qc/ZpuejUXuwF
         U9s7w4M/4638yVJDzrJJSEw//98T0Q3Pef/F7Zx9zbf9ARgsAjk9lRG0hPam7hJdcEPN
         gmpN2V6KCHOuO2Xmg3KYmdP13fvgwUZVs7cs1HMg+NAOxs9YOjhIJ4g3XVGSU9fDZUKO
         NfbaS8Goa2JC1o9mXwT1qgoAUVNd/nYqItTOBV0NNZbuVjXY7SGef7h+YBVyee0ASYFG
         aKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4GyWptTEsbmUs5nn7vZbOukBmjJMFIOBkkSnrY6WZc=;
        b=emfMDV8Gn8KFrCme7UdH/j+D67Ob4dr1jsvJ7ldBb9Yp3LiWhtD0BF7gHnyIjG6a00
         JPKCSdV2WPAqK1JkleYgg3bw8dDw0GkzQZF48F1t0ewOp/AJnfOmxB9VDfNGiTdjCcOI
         pUTJSnUDY8SNrns4yhZ3e2+JWyYjvyhG2fq66ebWJ3n6j7COeLQROH7dbjii2bhGzKNb
         d03qLGxMP86ba25oDFK6Mvw0XR6/ztAfNDfnAvoq8+gGaM8Qfj4OpV4jEBK9R3dmZsK+
         H//Qnr3JmoBclhoPH/N25BUZk0wK09O3GTll3AZYhSebW52BV9L8AkgX5Ac7o9Hw0XoH
         z3UA==
X-Gm-Message-State: AOAM532bZ6XhdizcFexUdTHB0sdSuR2A4k27U1yKrEU+Xrt6KVhtu3Mb
        LxnoWdnmbVqruY7D1tg2ht2vU24Lt1KC246S9yU=
X-Google-Smtp-Source: ABdhPJwB2B7MeuUM36quIzPe2o5X/TGGEQydyHN1dn+nCAOKcnc+OK0FlVHelf+hr5SPt7tgKR9ta/2rmBPQxU2UiNg=
X-Received: by 2002:a62:7657:: with SMTP id r84mr7164384pfc.130.1593113763858;
 Thu, 25 Jun 2020 12:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200625170356.225136-1-enric.balletbo@collabora.com>
 <CAHp75VdY4TEKfZXDb-f-KC4G2XRJOdB-w4vegSWG9vULLqcUKw@mail.gmail.com>
 <026b38ff947e338a468567dfd20fbde1419bb094.camel@perches.com> <CAHp75VcFeCf0vnk2Ea_-QdTW5gyRZvgEXwX7-VSd3rKch7pSwQ@mail.gmail.com>
In-Reply-To: <CAHp75VcFeCf0vnk2Ea_-QdTW5gyRZvgEXwX7-VSd3rKch7pSwQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Jun 2020 22:35:47 +0300
Message-ID: <CAHp75VeZj72VDHSm48Diomz4q0+dJ6gjknqHQpfon3PU9Te5-w@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: Clarify SPDX license with GPL-2.0-only
To:     Joe Perches <joe@perches.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bernardo Perez Priego <bernardo.perez.priego@intel.com>,
        Daniel Campello <campello@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nick Crews <ncrews@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yicheng Li <yichengli@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 10:33 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Jun 25, 2020 at 10:29 PM Joe Perches <joe@perches.com> wrote:
> > On Thu, 2020-06-25 at 22:06 +0300, Andy Shevchenko wrote:
> > > On Thu, Jun 25, 2020 at 9:25 PM Enric Balletbo i Serra
> > > <enric.balletbo@collabora.com> wrote:
> > > > Remove the ambiguity with GPL-2.0 and use an explicit GPL-2.0-only
> > > > tag.
> > >
> > > Is there any? Last time IIRC Greg told me that in the kernel the old
> > > and new variants are okay.
> >
> > If there wasn't any ambiguity, the older license
> > style wouldn't be deprecated by SPDX.org.
>
> They are _not_ deprecated according to kernel documentation:
> https://elixir.bootlin.com/linux/latest/source/LICENSES/preferred/GPL-2.0
>
> So, fix documentation in the kernel then.

That said, NAK to the patch as long as in-kernel documentation says it's valid.

-- 
With Best Regards,
Andy Shevchenko
