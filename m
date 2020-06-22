Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E79C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B016A2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="n/qE7cWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgFVVBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbgFVVBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:01:50 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349E7C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 14:01:49 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id fc4so8687965qvb.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/vOKxV6y/efpAYjruCvKnWf3QtEjGeNBbml5tfntNuo=;
        b=n/qE7cWOYE+ZljhVhmE5P7IWa3iZotxOpCdjCXFpENbNVcDfNpDW3X5Prpr/oQiPCg
         2XYKrwISyA1cSNT7dfxzZl1f//qI9Z42nQt2Ft0O0kKPV/zZ+E1PYpjOJhnsd/olQfjV
         qJeNcDr3q1m1Xm8PHJ5esaHrWjM5cmrRFUeXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/vOKxV6y/efpAYjruCvKnWf3QtEjGeNBbml5tfntNuo=;
        b=XjPppPl8yBFeoep97NaiL8km5k7YYOJ+D7cNrU1Hy/krJ1dfIUuCEIwuC7kAvfTUIQ
         koeb3v5hMrQ6I/zxnmuCWSgQzha6+M2LMvKv5/8ULJNbJt6tbC0H7wwueypdfFtbngmT
         uf0RmvZQVTFOOlqd+zg31cmrG4FcT1SmED3BdjRNvaFRdTcIEFH8xPLNzDv69yEI5xrD
         N6BGjhnabFHsK2nRl4O5ZZcKnYdQrblIwW9yj0u1fXNFojMUl6RVV9UsRZPnVHTJWpgA
         swbHcn9YI+MQq95PAVrEs3wfECIkfgx2qsZAAX8oJ+qFafEoduNGWbN3taU5T/HqwS/+
         8XtA==
X-Gm-Message-State: AOAM532ySMPzrwPl6l8Lgcvxs5Q3pbtrbWev1YC1pcpOYIYz8yTg7994
        5GzvuXwty8HJ4GZ9pZd1CTBARg==
X-Google-Smtp-Source: ABdhPJzmZpg+quIM3l+stzmOaK8UVXlUYcV0c+jqb2LvV+9yMOtZTtmo5ScApvCti6eJ9RiBWNzxlg==
X-Received: by 2002:a0c:bd88:: with SMTP id n8mr5733018qvg.194.1592859708411;
        Mon, 22 Jun 2020 14:01:48 -0700 (PDT)
Received: from bill-the-cat (2606-a000-1401-8080-e5dd-5747-7916-11ff.inf6.spectrum.com. [2606:a000:1401:8080:e5dd:5747:7916:11ff])
        by smtp.gmail.com with ESMTPSA id i3sm14484388qkf.39.2020.06.22.14.01.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 14:01:47 -0700 (PDT)
Date:   Mon, 22 Jun 2020 17:01:45 -0400
From:   Tom Rini <trini@konsulko.com>
To:     ron minnich <rminnich@gmail.com>
Cc:     lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] initrd: Remove erroneous comment
Message-ID: <20200622210145.GM27801@bill-the-cat>
References: <20200619143056.24538-1-trini@konsulko.com>
 <CAP6exYJ64Hy9y3Dzh9Asrq8Y0oDWYk+tf4UAcasEc-ZxTY8DAw@mail.gmail.com>
 <20200622204034.GL27801@bill-the-cat>
 <CAP6exYLd0uFbVSbn28iS1OV=jULtg2f+7t1DAn-fvGoRSd5dng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W9OqCIgVwV7zeaDP"
Content-Disposition: inline
In-Reply-To: <CAP6exYLd0uFbVSbn28iS1OV=jULtg2f+7t1DAn-fvGoRSd5dng@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W9OqCIgVwV7zeaDP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 01:56:24PM -0700, ron minnich wrote:

> So, let me first add,  the comment can be removed as needed. Comments
> offered only for clarification.

Noted, thanks.

> On Mon, Jun 22, 2020 at 1:40 PM Tom Rini <trini@konsulko.com> wrote:
>=20
> > But what do you mean UEFI "consumes" initrd=3D ?
>=20
> What I mean is, there are bootloaders that will, if they see initrd=3D
> in the command line, remove it: the kernel will never see it.

I'm picky here because, well, there's a whole lot of moving parts in the
pre-kernel world.  In a strict sense, "UEFI" doesn't do anything with
the kernel but based on hpa's comments I assume that at least the
in-kernel UEFI stub does what Documentation/x86/booting.rst suggests to
do and consumes initrd=3D/file just like "initrd /file" in extlinux.conf,
etc do.  And since the EFI stub is cross-platform, it's worth noting
this too.

> >  I guess looking at
> > Documentation/x86/boot.rst is where treating initrd=3D as a file that
> > should be handled and ramdisk_image / ramdisk_size set came from.  I do
> > wonder what happens in the case of ARM/ARM64 + UEFI without device tree.
>=20
> it is possible that the initrd=3D argument will not be seen by the
> kernel. That's my understanding. Will this be a problem if so? It
> would be for me :-)
>=20
> >  And it doesn't provide any sort of link / context to the
> > boot loader specification project or similar that explains the cases
> > when a non-filename "initrd=3D" would reasonably (or unreasonably but
> > happens in reality) be removed.
>=20
> But it unreasonably happens as I learned the hard way :-)
>=20
> Anyway, thanks Tom, I have no objections to whatever you all feel is
> best to do with that comment. It was a failed attempt on my part to
> explain the state of things :-)

Booting up the kernel is quite the "fun" area indeed.

--=20
Tom

--W9OqCIgVwV7zeaDP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl7xHDIACgkQFHw5/5Y0
tyykrwwAsipqFRwbV8H3aKv+J9PHEPFRTFClvSda5kTfojpnqbRqpOVQSoHiDYTs
R35RMZZ8DjYl45u0qbmPPEWEw1zP+zxjBosWuZn9/82fMg9QgRg+H6Z8D0VZPfmv
fGSheF8bMhIhEpEJc8yTMW41cEUmm4rotSlULa0eThB7DK8CHxnemQsTvRTv8VJo
5N/djHA0MLmjFclUhlOZ0hFfGSS6MtxBLFZjho8iA5nHbYdQsNj3UxuQ/7AdJiyI
+h0+M/nWEc55vDWL8cJX2Q3o39OFx0ev6iHdUQDHG0RCHSRKY4D+/lIXfxjEQQb5
CtVRIFNeT8cpMghICMcLMPi+ntT3Oel/DbpLovSf5D9SGY1KmWq09tjmuIs98kRT
qNZzc0ehLMBPX0ZpXmyJ5BwtAnO5JfSnuN1I00ufElz7rADa6GH27f15o1QWXv/V
EfM/ueDIEA0nhu1sJY+hAyBX0O1YfFFlDbAGjVjBtSRUDp0LFjMT7Zr+w8Xh7qYq
BEUubv5G
=kliK
-----END PGP SIGNATURE-----

--W9OqCIgVwV7zeaDP--
