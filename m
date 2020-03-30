Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C333C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F48C20771
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SwpXIY2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgC3WQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:16:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:40360 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728857AbgC3WQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585606617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kFxQ6sa3As6Jtugci2z3HRdxNU4LPCC1zzYUuabLxUU=;
        b=SwpXIY2KsCtxK80s4Xiouq9O6YVlCYPI2SU1UyAhe+frHyJfECOq9NZcIK8GonWmh9CMG5
        VTKeKuNJwiTgAjtljg1NT1ahx8xESp56FBdawcDqAonrWBE3/XG6MRFsbfL9NdsrFEfmCm
        nNTuGrB8HPFIfwa7I4ZYiKO2iO49IsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-L_lh2rRnM8uuiqNlMRll3Q-1; Mon, 30 Mar 2020 18:16:51 -0400
X-MC-Unique: L_lh2rRnM8uuiqNlMRll3Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEB1A18A5500;
        Mon, 30 Mar 2020 22:16:49 +0000 (UTC)
Received: from elisabeth (unknown [10.36.110.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 180CF5C1BB;
        Mon, 30 Mar 2020 22:16:43 +0000 (UTC)
Date:   Tue, 31 Mar 2020 00:16:37 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Soumyajit Deb <debsoumyajit100@gmail.com>,
        outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: fbtft: Replace udelay with
 preferred usleep_range
Message-ID: <20200331001637.6bf108ed@elisabeth>
In-Reply-To: <53befe00af657428b591200b31b5349a4a462eb1.camel@gmail.com>
References: <20200329092204.770405-1-jbwyatt4@gmail.com>
        <alpine.DEB.2.21.2003291127230.2990@hadrien>
        <2fccf96c3754e6319797a10856e438e023f734a7.camel@gmail.com>
        <alpine.DEB.2.21.2003291144460.2990@hadrien>
        <CAMS7mKBEhqFat8fWi=QiFwfLV9+skwi1hE-swg=XxU48zk=_tQ@mail.gmail.com>
        <alpine.DEB.2.21.2003291235590.2990@hadrien>
        <20200330194043.56c79bb8@elisabeth>
        <53befe00af657428b591200b31b5349a4a462eb1.camel@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 15:03:55 -0700
"John B. Wyatt IV" <jbwyatt4@gmail.com> wrote:

> On Mon, 2020-03-30 at 19:40 +0200, Stefano Brivio wrote:
> > On Sun, 29 Mar 2020 12:37:18 +0200 (CEST)
> > Julia Lawall <julia.lawall@inria.fr> wrote:
> >  =20
> > > On Sun, 29 Mar 2020, Soumyajit Deb wrote:
> > >  =20
> > > > I had the same doubt the other day about the replacement of
> > > > udelay() with
> > > > usleep_range(). The corresponding range for the single argument
> > > > value of
> > > > udelay() is quite confusing as I couldn't decide the range. But
> > > > as much as I
> > > > noticed checkpatch.pl gives warning for replacing udelay() with
> > > > usleep_range() by checking the argument value of udelay(). In the
> > > > documentation, it is written udelay() should be used for a sleep
> > > > time of at
> > > > most 10 microseconds but between 10 microseconds and 20
> > > > milliseconds,
> > > > usleep_range() should be used.=20
> > > > I think the range is code specific and will depend on what range
> > > > is
> > > > acceptable and doesn't break the code.
> > > >  Please correct me if I am wrong.   =20
> > >=20
> > > The range depends on the associated hardware. =20
> >=20
> > John, by the way, here you could have checked the datasheet of this
> > LCD
> > controller. It's a pair of those:
> > 	https://www.sparkfun.com/datasheets/LCD/ks0108b.pdf
>=20
> No I have not. This datasheet is a little over my head honestly.
>=20
> What would you recommend to get familiar with datasheets like this?

Well, you don't necessarily have to, there are many subsystems in the
kernel which are almost completely abstracted away from hardware.

If you're interested, look around yourself for something simple chip,
or get something that you can easily plug on a "maker board", Raspberry
Pi, something like that. Perhaps via I=C2=B2C or SPI.

Some types of sensors (temperature, pressure) have very simple
datasheets. If you are allergic to hardware, try:
	$ ls -Ssl drivers/iio/*

pick the smallest sensor driver in the category that is the most likely
to spark your interest, and go through it, checking it against the
datasheet, at some point it will make sense.

--=20
Stefano

