Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1FFC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65FF120656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="agnVKpBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgG1UPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgG1UPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:15:20 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA44C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:15:20 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d4so12745250pgk.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=tqZMz16pvW2AijIRQi4zUGCh+M0EN/UmSMDkjaIZOyM=;
        b=agnVKpBKvxL7cmQ2YRR6UlkjTqmr2v7BFp5jUSNqFj4eD46vMXV31Db3meKNfH7BJW
         4KVCWX7y8rKr3SrRZGkHZgVIVAZK6p8Q9b1VZpOQchmHZbx/jXxPnjVyyrBwPtm/NODx
         VlOFom+kFTlw0apOLdcp5w/6hiJ9GbyxcJxj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=tqZMz16pvW2AijIRQi4zUGCh+M0EN/UmSMDkjaIZOyM=;
        b=b15bANuxz0+br40xKbDyIFfx3wCfnmP5G8pUDqIYvJAQdKxkxdGpgH7I+nNP7fsNfF
         ZpzV5wOP9OvSSPxS3EIffTnOkXTEh2VylR18rx7/YWdk1nmhJGknBLXvDiCTKK99UE76
         /VanK+g92musu2AJ88IOBoTZFdHpa44ZVDS34LbvG7htIZ0oGwpeGdiTTRVCd+Q/Nnv1
         8alpS5GTW9BDa1JpwFx7jBCFMAPUoD7ttFyjwxP+jxJ2NRMUdCQzO7AFfr6NfK9zY2A/
         M9Wuz09pP0it0gHKVs3YBtbrkvW/knQIplNicDF7OKqm5yV5K2StLO9wbEHhsLklgv6b
         yv8Q==
X-Gm-Message-State: AOAM532pJY0l9k4ydFR1dbonKXVFXdfG3y8dAHLHnituEOKGDcO5cA+0
        w9g9ShlYn1po3tWUWiUNpIInyw==
X-Google-Smtp-Source: ABdhPJy1L3+1VlaDSMLSfdVxBXSlBNoRZxKyEwfJn034n/+sp9DsAfEYTBXzXsBl1zfgDMoSjm665Q==
X-Received: by 2002:a63:f1a:: with SMTP id e26mr26558253pgl.80.1595967320319;
        Tue, 28 Jul 2020 13:15:20 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id v78sm9204748pfc.121.2020.07.28.13.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 13:15:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHcu+VaDBj87stJ9JJkuerJkr8=-g68FhUUnKvfpN8uYaMBUhQ@mail.gmail.com>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid> <20200728151258.1222876-1-campello@chromium.org> <20200728091057.3.I2a1314232ace4323af96f9981c1e1a4f31f78049@changeid> <CAHp75VfOhoJrHEnC_Wh2qnOMX0pT1Jx92B0TFQ5=cfZsTSNSOg@mail.gmail.com> <CAHcu+VaDBj87stJ9JJkuerJkr8=-g68FhUUnKvfpN8uYaMBUhQ@mail.gmail.com>
Subject: Re: [PATCH 03/15] iio: sx9310: Fix irq handling
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Campello <campello@chromium.org>
Date:   Tue, 28 Jul 2020 13:15:17 -0700
Message-ID: <159596731796.1360974.3913058992312532558@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Campello (2020-07-28 13:07:00)
> On Tue, Jul 28, 2020 at 12:08 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Tue, Jul 28, 2020 at 6:14 PM Daniel Campello <campello@chromium.org>=
 wrote:
> > >
> > > Fixes enable/disable irq handling at various points. The driver needs=
 to
> > > only enable/disable irqs if there is an actual irq handler installed.
> >
> > > -       enable_irq(data->client->irq);
> > > +       if (!ret)
> > > +               enable_irq(data->client->irq);
> > >
> > >         return ret;
> > >  }
> >
> > Can it be a usual pattern?
> >
> >   if (ret)
> >     return ret;
> >   ...
> >   return 0;
>=20
> I think this way is more readable. The alternative would have to be
> something like this:
>=20
> ....
> if (ret)
>   goto out;
> mutex_unlock(&data->mutex);
> enable_irq(data->client->irq);
> return 0;
>=20
> out:
> mutex_unlock(&data->mutex);
> return ret;
>=20

I think the suggestion is

	mutex_unlock(&data->mutex);
	if (ret)
		return ret;

	enable_irq(data->client->irq);

	return 0;
