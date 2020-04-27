Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087A8C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3138206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588017891;
	bh=m3jQiUHzkwqrgD6Uvyq9EGhqWeH+voB+Nd3N343ee34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=axUtoKxnIE6GzmcZTwrSkDwXPW/1MhTZJD3AEqk4iQGZlri3oJyQXag9wBs6wvYw8
	 eHRX0tojh/QAL6dY6cWt6HV5mziuXazd3OiXx0duflXPbzWwDJ4+VJJJ2BUrxuhgoU
	 pCJg8b3SFMFMYmEutAoYFQQY8T2fH1cqBlosE268=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgD0UEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:04:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgD0UEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:04:50 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9F8206D6;
        Mon, 27 Apr 2020 20:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588017889;
        bh=m3jQiUHzkwqrgD6Uvyq9EGhqWeH+voB+Nd3N343ee34=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HncrMfRPGvdCZBBl7tgqwXsHIwk7k7NCTKmuifYxmUGiy0HMMrRFM2Ws0s3lpvA8i
         aCVmvidD2ps7bR6qL191Uwn7r/kZ7RLGGsxiQdmg1oec4VjLTdnRfWS5LvicMBwAf0
         Ed3bMvNfuVnVdpRYEDavE0jEKCM2kxcrZp4PN3yk=
Date:   Mon, 27 Apr 2020 13:04:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh+dt@kernel.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: [PATCH] get_maintainer: Add email addresses from .yaml files
Message-Id: <20200427130448.74b75c3a6c91e5ede31542e4@linux-foundation.org>
In-Reply-To: <79ade7bc8ce57ef11f94011bad1842372c61fdd7.camel@perches.com>
References: <87d082jtfn.fsf@collabora.com>
        <20200420175909.GA5810@ravnborg.org>
        <CAL_JsqJXa8QxQmLfkCO8_SSsgYm2nTFW1J6wx4bGbZgAy8Sxog@mail.gmail.com>
        <9a32f150f85f851d04afd148b2a9a5cf203f7ce1.camel@perches.com>
        <7beaedfd63017973b910dd21cac13ecb42dbe503.camel@perches.com>
        <20200427055755.GA21898@ravnborg.org>
        <79ade7bc8ce57ef11f94011bad1842372c61fdd7.camel@perches.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Apr 2020 23:33:02 -0700 Joe Perches <joe@perches.com> wrote:

> On Mon, 2020-04-27 at 07:57 +0200, Sam Ravnborg wrote:
> > Hi Joe.
>=20
> Hi Sam.
>=20
> > On Sun, Apr 26, 2020 at 10:40:52PM -0700, Joe Perches wrote:
> > > .yaml files can contain maintainer/author addresses and it seems
> > > unlikely or unnecessary that individual MAINTAINER file section
> > > entries for each .yaml file will be created.
> > >=20
> > > So dd the email addresses found in .yaml files to the default
> >      ^
> >      add
>=20
> Andrew, can you add the a to this please?
>=20
> > Signed-off-by: Joe Perches <joe@perches.com>
> > Acked-by: Sam Ravnborg <sam@ravnborg.org>
> > Tested-by: Sam Ravnborg <sam@ravnborg.org>
> >=20
> > The patch did not apply on top of -rc3, but it was trivial to fix.
> > Tested and works like a charm.
> > Thanks for doing this!
>=20
> As most of my patches, it was done using -next
>=20

The patch assumes that we have

-	    if ($file_emails) {
-		my @poss_addr =3D $text =3D~ m$[A-Za-z_-_\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\=
{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
-		push(@file_emails, clean_file_emails(@poss_addr));
-	    }

but today's next has

	    if ($file_emails) {
		my @poss_addr =3D $text =3D~ m$[A-Za-z=C0-=FF\"\' \,\.\+-]*\s*[\,]*\s*[\(=
\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
		push(@file_emails, clean_file_emails(@poss_addr));
	    }

so what do do here?
