Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D14EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F39FA20732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="YnWyKIyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbgFVVGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbgFVVGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:06:49 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C708BC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 14:06:47 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l6so13288635qkc.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 14:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YTuna1EnT7RDtct6bub4kArUDUYRR6XYOsNVtwc/rE0=;
        b=YnWyKIyI0eDh1XQvAgIttxS0U+GfEMsIFjvjo5MtCV01TnhJlnplCYT2+i/ouWIbwO
         Onoqp8sX95Ju4/z1ffRDLUfveufh5BNRdg4Mc0HPAj05X7tDcQk4T1U3yFSIewQWxNmj
         92ApNhi6/bWcAW2nGz7q5dB/msgaXzB80jjN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YTuna1EnT7RDtct6bub4kArUDUYRR6XYOsNVtwc/rE0=;
        b=oHS3Md9Hfr9U4MK+zoOzkmgCDVKqoEk/nMrMFOQtBhCodi3UsNH6ehEScnw8ZFGXmw
         zvLwaW8/7YT8Lu0W83GLbRMm7PMwRK0/Foy4Ym8uhhPREgG0m4n8u/sZrUyA+4aNSG8Q
         /Q3Ga+5uYiRXSjg/dADW4Ptet3IYN5xfW3kTPBWbogWQXCtjoJx2ElDU7A82di+oVIAo
         9g+MRmaSm/6UMeF2vG+q56wiz87qU4goUmQzA9x2H3fQ/9grcrB09Ud306ZzgFILCeHa
         cBX4OIR6bgqGusRInAj4oqM03P/duWRg8FKkSxCn8qy8muX4E0kNLMOOYRtML07QaNvV
         HBLg==
X-Gm-Message-State: AOAM532Drc5R+Og3mocaK6yufE90otU/xnU7RkXUzFEqNqZRuE6bBLJx
        ZumxQjZLzTOPKNM6tFMC0rZDXA==
X-Google-Smtp-Source: ABdhPJw9DTcTkPITv1BFHTkW8Tekpz29S0Rdi95EPJOBrRMRiaUIWFEHBtbHZBsOtHlClHXFzWWslg==
X-Received: by 2002:a05:620a:b84:: with SMTP id k4mr17701211qkh.39.1592860006915;
        Mon, 22 Jun 2020 14:06:46 -0700 (PDT)
Received: from bill-the-cat (2606-a000-1401-8080-e5dd-5747-7916-11ff.inf6.spectrum.com. [2606:a000:1401:8080:e5dd:5747:7916:11ff])
        by smtp.gmail.com with ESMTPSA id o62sm14864975qkd.53.2020.06.22.14.06.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 14:06:46 -0700 (PDT)
Date:   Mon, 22 Jun 2020 17:06:43 -0400
From:   Tom Rini <trini@konsulko.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     ron minnich <rminnich@gmail.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] initrd: Remove erroneous comment
Message-ID: <20200622210643.GN27801@bill-the-cat>
References: <20200619143056.24538-1-trini@konsulko.com>
 <CAP6exYJ64Hy9y3Dzh9Asrq8Y0oDWYk+tf4UAcasEc-ZxTY8DAw@mail.gmail.com>
 <20200622204034.GL27801@bill-the-cat>
 <2455d1e8-d6b4-760b-9a4c-0071c5ae986d@zytor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uOSyunOxC/kgwQjk"
Content-Disposition: inline
In-Reply-To: <2455d1e8-d6b4-760b-9a4c-0071c5ae986d@zytor.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uOSyunOxC/kgwQjk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 01:48:45PM -0700, H. Peter Anvin wrote:
> On 2020-06-22 13:40, Tom Rini wrote:
> > On Mon, Jun 22, 2020 at 01:02:16PM -0700, ron minnich wrote:
> >=20
> >> The other thing you ought to consider fixing:
> >> initrd is documented as follows:
> >>
> >>         initrd=3D         [BOOT] Specify the location of the initial r=
amdisk
> >>
> >> for bootloaders only.
> >>
> >> UEFI consumes initrd from the command line as well. As ARM servers
> >> increasingly use UEFI, there may be situations in which the initrd
> >> option doesn't make its way to the kernel? I don't know, UEFI is such
> >> a black box to me. But I've seen this "initrd consumption" happen.
> >>
> >> Based on docs, and the growing use of bootloaders that are happy to
> >> consume initrd=3D and not pass it to the kernel, you might be better o=
ff
> >> trying to move to the new command line option anyway.
> >>
> >> IOW, this comment may not be what people want to see, but ... it might
> >> also be right. Or possibly changed to:
> >>
> >> /*
> >>  * The initrd keyword is in use today on ARM, PowerPC, and MIPS.
> >>  * It is also reserved for use by bootloaders such as UEFI and may
> >>  * be consumed by them and not passed on to the kernel.
> >>  * The documentation also shows it as reserved for bootloaders.
> >>  * It is advised to move to the initrdmem=3D option whereever possible.
> >>  */
> >=20
> > Fair warning, one of the other hats I wear is the chief custodian of the
> > U-Boot project.
> >=20
> > Note that on most architectures in modern times the device tree is used
> > to pass in initrd type information and "initrd=3D" on the command line =
is
> > quite legacy.
> >=20
> > But what do you mean UEFI "consumes" initrd=3D ?  It's quite expected t=
hat
> > when you configure grub/syslinux/systemd-boot/whatever via extlinux.conf
> > or similar with "initrd /some/file" something reasonable happens to
> > read that in to memory and pass along the location to Linux (which can
> > vary from arch to arch, when not using device tree).  I guess looking a=
t=20
> > Documentation/x86/boot.rst is where treating initrd=3D as a file that
> > should be handled and ramdisk_image / ramdisk_size set came from.  I do
> > wonder what happens in the case of ARM/ARM64 + UEFI without device tree.
> >=20
>=20
> UEFI plus the in-kernel UEFI stub is, in some ways, a "bootloader" in
> the traditional sense. It is totally fair that we should update the
> documentation with this as a different case, though, because it is part
> of the kernel tree and so the kernel now has partial ownership of the
> namespace.
>=20
> I suggest "STUB" for "in-kernel firmware stub" for this purpose; no need
> to restrict it to a specific firmware for the purpose of namespace
> reservation.

With a little bit of quick digging, yes, it would be good to document
and be very clear which things are reserved for (and how are treated by)
the in-kernel firmware stub or "kernel EFI stub" or whatever name is
best for drivers/firmware/efi/libstub/.  I forget the last time we tried
booting a linux kernel EFI stub rather than grub/etc over in U-Boot
under our EFI loader support but it's reasonable to expect that it work.
Thanks!

--=20
Tom

--uOSyunOxC/kgwQjk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl7xHWMACgkQFHw5/5Y0
tyyZfgv/eEDRB+L1hz5xlufmmY/0pN8LuByKat4/WhG/wKO7NOtfRXsnfNANN1H8
TKPbLiweM8o8zT9X2E92nthgLFnQ083Za1r79USPOXo9+uhLml2GQYZjHBhgWYj8
ARmfbj/2AojbkBgIOnHFCvuodmWH/kC2HYriFYNlG5inb5eLLOk/Q+PxzzQq7fPI
UBzrfAKp896UuwZ4rZLJ0/TviC1iXNWR9oKEQ68Do81Li0fjddcR2trW/CPQffWt
O7+0Alewt2Ino4VvqM9Y1j/++7Ibnj2ft6nKfalBZ4ofcr6ahjsn5/p4zNu38ylA
8qcn1b0JNYorpRa3+yz2MWh+6M5ldY8GLJjl9UxSiINH5v7F/46gMy0uY9SS6Ift
oMVBMgYQrJU1wF9QcklbBApnor0WGNxdgydP/sHJZMAHTAlz/9uhgNplICmde4Sd
JxD2ByRWPoxp3DLIvXFzV31Iwv+koX9b/gsPaZhk5Xs6iiYD1LYrzc53HDudGEsf
EZMi8UC/
=bFgS
-----END PGP SIGNATURE-----

--uOSyunOxC/kgwQjk--
