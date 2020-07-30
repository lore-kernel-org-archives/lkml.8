Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE998C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A439420656
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnn2ECJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgG3Spi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 14:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgG3Sph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 14:45:37 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512B6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:45:37 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id l1so29257202ioh.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1M+mQosS53rR8rnqJ+wOq1od8dF70GSvNLfqjFKtb+w=;
        b=dnn2ECJVDMO+WGWX3kTgDJexFtgoLfprxeNovVCxUtS7jXjzesDr+4uAhaLiU2Ve3U
         Vq0wUFZU8UxDAxoZbCpPs+PAU39psgwwzYlKI1ZYmBSqh3XOywQ3Ddit8RJqOUfsom+S
         DGOPtMLSRb5w2Hd5iEFWqomAwX0q4aoCrnIo2r1w0kTmypujBaHXvKnAOQcdePIPdOjS
         vbP4saDH69ElaTRcJ+xWTL/KnMMtIyPaGNXTS7OVdN4a8Va83V6uwkMbs7DoJvaeJsbR
         N0oTZ0JeyM/ndJWcOS4JEpbaTLhC9b0dccIuTnIwbd3J/CF/n84n+V3P3ENpXirb9I/N
         RWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1M+mQosS53rR8rnqJ+wOq1od8dF70GSvNLfqjFKtb+w=;
        b=SgdMvgiVGhS91IG1Y695YUD5wdKBCTHbtaedxwTAbOqYgQ+1Nd0XZq/cJrzWvKbm0J
         tjSi+65xByyRHGajEn5P0FViK829Xz6+vU8jt4OzwFW6w/XT6o03fpQlwqw5/Ytvn1Oo
         i6MWonPxvUi078JcT6Gy+ATyGJ4dlcwRlunjy/QKYhQHKxhkOzdx1Nx7y5gysH7UbnPt
         y+FFjUxN74BrInBjrDV86pW1h0gwk3bF9JsZuHqylkHb5LQv/ABVofRDUea17emmzT/h
         in/Z9sygZswW1C+WbBL/41Zq0FXZPQ3ETQdWFkOwuSAd8kkD9ybLXI9I9mMkRvccLEw8
         Xwfg==
X-Gm-Message-State: AOAM5308SURg7H3i8YBXu6iort2S0YhorOr/gZMv3qVP0vMG5wI/FO95
        lVG3Gv62891NpOS/av4yTsSa029rGKOPhkUTAH0=
X-Google-Smtp-Source: ABdhPJyePUmV86fwPoIT2w0lFQuKXuE+2i6wYo+AAjl0IXq3XELDfg7qMjjDf6BiJmMlAYOVZXaDgNcncxLDT9NlbG8=
X-Received: by 2002:a05:6638:2601:: with SMTP id m1mr620541jat.141.1596134736322;
 Thu, 30 Jul 2020 11:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200713144331eucas1p25911c4ffa9315f632d8f6dd833588981@eucas1p2.samsung.com>
 <20200713144324.23654-1-a.hajda@samsung.com> <e55a23bf-59bb-43c6-f7d7-467c282b8648@samsung.com>
 <20200730070832.GA4045592@kroah.com> <CAKdAkRTKjHg2y8yTFgxr4yY98M8D2noutDBfB1mh7wwLLQrYbw@mail.gmail.com>
 <20200730164845.GE5055@sirena.org.uk> <CAKdAkRS+QooavPaKMcsaUQdRJGky_6JYq1EiUbyT_gcU3ZYeJw@mail.gmail.com>
 <20200730181639.GG5055@sirena.org.uk>
In-Reply-To: <20200730181639.GG5055@sirena.org.uk>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu, 30 Jul 2020 11:45:25 -0700
Message-ID: <CAKdAkRSaF3q1MJ7mteD-4C4O58LL4FP6xpTovVOdu0v2VD=sAQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] driver core: add probe error check helper
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 11:16 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jul 30, 2020 at 10:46:31AM -0700, Dmitry Torokhov wrote:
> > On Thu, Jul 30, 2020 at 9:49 AM Mark Brown <broonie@kernel.org> wrote:
>
> > > The error messages are frequently in the caller rather than the
> > > frameworks, it's often helpful for the comprehensibility of the error
> > > messages especially in cases where things may be legitimately absent.
>
> > Not for deferral. All you need to know in this case is:
>
> > "device A is attempting to request resource B which is not ready yet"
>
> > There is nothing to handle on the caller part except to float the error up.
>
> You can sometimes do a better job of explaining what the resource you
> were looking for was,

I think it is true for very esoteric cases. I.e. your driver uses 2
interrupt lines, or something like that. For GPIO, regulators, and
clocks we normally have a name/connection ID that provides enough of
context. We need to remember, the error messages really only make
total sense to a person familiar with the driver to begin with, not
for a random person looking at the log.

> and of course you still need diagnostics in the
> non-deferral case.  Whatever happens we'll need a lot of per-driver
> churn, either removing existing diagnostics that get factored into cores
> or updating to use this new API.

The point is if you push it into core you'll get the benefit of
notifying about the deferral (and can "attach" deferral reason to a
device) without changing drivers at all. You can clean them up later
if you want, or decide that additional logging in error paths does not
hurt. This new API does not do you any good unless you convert
drivers, and you need to convert the majority of them to be able to
rely on the deferral diagnostic that is being added.

Thanks.

-- 
Dmitry
