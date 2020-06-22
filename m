Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C19BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D56F3206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="PViZfFut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgFVUkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgFVUkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:40:39 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC09C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:40:37 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id d12so8645454qvn.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dd3K3zzJF+yvAk8TDWakFKiRtbHRFGEXn9KCJgGenGU=;
        b=PViZfFutFFoUw307mqKCN7HcuEzTsBawFfG6ePmyfJgMcAF+EuCW83JlDWsQg0A6yD
         7lnB85dzIbRsf+wjuHZ43uxZV5zsNZ0DfyjyxS6IjAu8/BwaYnzKircWUPOID2Kjp1EV
         rDqJJS4rKI8k6PV531LThbI5zMk5jfb0UI9zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dd3K3zzJF+yvAk8TDWakFKiRtbHRFGEXn9KCJgGenGU=;
        b=AWLYPIVLfDQypvvWgB/ofZIEPDJxf6Jwsef1ZovufaLZq1jWVDiMhD7BsJe68+unlG
         cF4z/uqmZcc4xUvxXRQxSGQmvbqAs7aik/Zj9dUc4AqhQUwpF0ZCbrUK1aDDyAtOiIVN
         uWcO+uZ9Yq95V5tJFyaQsVoOjJoMIFlBuLBU1plhq2Xhord6nWbOexmePktm1qWnJmU0
         o3SRIPAM/7YKe2E52RwPD6os0nLoUAs9d+ShB/yCPe3qzqrZkJaXMvAK8kFKt7Y+0s1L
         nEELHO2eWjn8lLyaemkNsdMlIJ3P5gALRnLLymC4qYV+r2BhI2VO2P8FztA63mFgWGvu
         z1Ww==
X-Gm-Message-State: AOAM530EtkXzEVo8UPYuGdhGmggHZXgFEwqAVpH5x9Xrz2R4JZdVcQmm
        LKqH1pw7SG3vUoa7mxjLn4/RTbKpX1SrnA==
X-Google-Smtp-Source: ABdhPJyZZ/DfoF/7ARRH29uxPkTzmXtNkiH6H9ZvnEsfUO5ZCZ5L6eS+9rfCaluC75FfnGKL64YguA==
X-Received: by 2002:a05:6214:1447:: with SMTP id b7mr24125944qvy.83.1592858436979;
        Mon, 22 Jun 2020 13:40:36 -0700 (PDT)
Received: from bill-the-cat (2606-a000-1401-8080-e5dd-5747-7916-11ff.inf6.spectrum.com. [2606:a000:1401:8080:e5dd:5747:7916:11ff])
        by smtp.gmail.com with ESMTPSA id o145sm3531599qke.2.2020.06.22.13.40.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 13:40:36 -0700 (PDT)
Date:   Mon, 22 Jun 2020 16:40:34 -0400
From:   Tom Rini <trini@konsulko.com>
To:     ron minnich <rminnich@gmail.com>
Cc:     lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] initrd: Remove erroneous comment
Message-ID: <20200622204034.GL27801@bill-the-cat>
References: <20200619143056.24538-1-trini@konsulko.com>
 <CAP6exYJ64Hy9y3Dzh9Asrq8Y0oDWYk+tf4UAcasEc-ZxTY8DAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZGfVcqCQYT4RlWas"
Content-Disposition: inline
In-Reply-To: <CAP6exYJ64Hy9y3Dzh9Asrq8Y0oDWYk+tf4UAcasEc-ZxTY8DAw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGfVcqCQYT4RlWas
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 01:02:16PM -0700, ron minnich wrote:

> The other thing you ought to consider fixing:
> initrd is documented as follows:
>=20
>         initrd=3D         [BOOT] Specify the location of the initial ramd=
isk
>=20
> for bootloaders only.
>=20
> UEFI consumes initrd from the command line as well. As ARM servers
> increasingly use UEFI, there may be situations in which the initrd
> option doesn't make its way to the kernel? I don't know, UEFI is such
> a black box to me. But I've seen this "initrd consumption" happen.
>=20
> Based on docs, and the growing use of bootloaders that are happy to
> consume initrd=3D and not pass it to the kernel, you might be better off
> trying to move to the new command line option anyway.
>=20
> IOW, this comment may not be what people want to see, but ... it might
> also be right. Or possibly changed to:
>=20
> /*
>  * The initrd keyword is in use today on ARM, PowerPC, and MIPS.
>  * It is also reserved for use by bootloaders such as UEFI and may
>  * be consumed by them and not passed on to the kernel.
>  * The documentation also shows it as reserved for bootloaders.
>  * It is advised to move to the initrdmem=3D option whereever possible.
>  */

Fair warning, one of the other hats I wear is the chief custodian of the
U-Boot project.

Note that on most architectures in modern times the device tree is used
to pass in initrd type information and "initrd=3D" on the command line is
quite legacy.

But what do you mean UEFI "consumes" initrd=3D ?  It's quite expected that
when you configure grub/syslinux/systemd-boot/whatever via extlinux.conf
or similar with "initrd /some/file" something reasonable happens to
read that in to memory and pass along the location to Linux (which can
vary from arch to arch, when not using device tree).  I guess looking at=20
Documentation/x86/boot.rst is where treating initrd=3D as a file that
should be handled and ramdisk_image / ramdisk_size set came from.  I do
wonder what happens in the case of ARM/ARM64 + UEFI without device tree.

That said, no the comment is wrong.  It's not "since 11/2018" but "since
the 1990s".  And it doesn't provide any sort of link / context to the
boot loader specification project or similar that explains the cases
when a non-filename "initrd=3D" would reasonably (or unreasonably but
happens in reality) be removed.

I would go so far as to suggest that adding special handling for some
x86 setups is the wrong to place to start / further deprecate how other
architectures and firmwares handle a given situation.  I'm only chiming
in here as I saw this commit go by on LWN and wanted to see how this was
different from the traditional usage of initrd=3D in the rest of the
kernel (it's not) and then saw the otherwise unrelated new comment being
added.

--=20
Tom

--ZGfVcqCQYT4RlWas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl7xFz4ACgkQFHw5/5Y0
tyzDqwv/Q4YjI0nwVltVEupqLyeqOBD765TmWdoXzJ69K42gTsYDHTN4qXT+RRX9
2zxJwh/9egkyuuI05VXRY+NzkqVcmkyAoYnZg648G4bn8DTfPg4vYFMAVDy1lNS8
HpnVJjAzDHD4O6yaAMDBP4O9WOp5K55yXyoSv04bY8wa7Bf3B2SoSxppZjVbwdxV
RKzn0ypZXfYJ3Ob7hrS25o8Q+MCk2KcJqSg3dkYpDnud2TI40Ltwm0EdEQJHeN3s
qVr5J22V3fIJnkPKiROnqiUhSEA8H+fuQrBFQKjLN09pZHMtTkpFHQxiI6ATjE+s
/6xGBwtu9X8ipBiIe+uoiKmBXzSX3KEKLrtthTqzPnWmlPZZhtzfDRoAWSztj02s
PE1zkN++35i6dczldwaPqCUcsUpcgHaftsmty4bH7IGLYb6EAYJL5GP7fEm+KIow
ye44TLLSdPu9RAMRd3EfnKwFGgjC+AQxV5DE0egkqjbEKugCmL3iSQZ6MnC+8mGK
bZc7OZbi
=NpoE
-----END PGP SIGNATURE-----

--ZGfVcqCQYT4RlWas--
