Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B646EC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC54246A4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN6thxEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbgB0Rce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:32:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36704 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730168AbgB0Rcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:32:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id f19so258417wmh.1;
        Thu, 27 Feb 2020 09:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bOM9ZguY+LlfPuZces6tFRfvNJKyFJIl4Ch9+iWS3ek=;
        b=lN6thxEPJeeGHigyjJNMQ8pPcMnBjMfnUPj0B458IHVV4xSU4V5efLpUhpsDZlbygB
         qKLRrxN046Fwl3/LPG0XrB3J7XHahTJvgQJYpd/lXh/Xii/kSw7wEujObkB/4eOZ/rti
         XtZCz9CtI75qNFaobEl5008mYB28Qg83kz88DaFQ2uy7cjQaha+MktXZHXNjPDyxVblx
         J+dUD6TedBLe4BSrO7BAUvJe+tUJlWjjucJoXTjftHNBiLPFFCXiULL+v1VlQXKcuQBs
         yJMdPpHpXcGO72LlsO+mFfJSEAM12aBdALguL96+3QVy6oOJtDVe2yV/fv/HRy+AcDTm
         nx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bOM9ZguY+LlfPuZces6tFRfvNJKyFJIl4Ch9+iWS3ek=;
        b=IpwwFR38qY6wSK2MFDUshoc7tZUrFzEbn9+LWyHYwuTy/Eoe1aOPL/B4DLJ6wA2Aj1
         ykyHjr9hC5ZLzp4oAxQYvv7kIcGy9PYo+BPzYZzsLjMEHU7MRTez7+EJwEBNgiaLVOXd
         KVuh5Bv8vAJKUKGmjZV9+ZDRzrnqOQptq90wp91jtDIxfOjcDnG+6gsRz/Zvv6NnAhoo
         jjhiiV/BGHVZTXomncPhRnwn0ccsUlIccEOXEyLRYNLpQYig6YJBPgGFnCBb4BFhHrtn
         YV0PMdGyeX5KGLwUWutZ090JxzBTc7bR3mnHhbcibOFIGOwMjHptT2BWCWmW7GqeLDFQ
         t9ZQ==
X-Gm-Message-State: APjAAAXQ+xYdrvQUWLjsIcOhNjEOdlQfZm9Z9MdOicoYDnMfASBuBMuT
        MbUHZhMS0uC6k25ET8YZqdg=
X-Google-Smtp-Source: APXvYqyYjLyY+cOxVx5++7yoIrsteDDJb3n3HKrVHlrladKrVpKxjf8hjlKjSAXULYfIGtOd0M+EIA==
X-Received: by 2002:a1c:156:: with SMTP id 83mr576898wmb.151.1582824750974;
        Thu, 27 Feb 2020 09:32:30 -0800 (PST)
Received: from localhost (pD9E516A9.dip0.t-ipconnect.de. [217.229.22.169])
        by smtp.gmail.com with ESMTPSA id z10sm8450261wmk.31.2020.02.27.09.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 09:32:29 -0800 (PST)
Date:   Thu, 27 Feb 2020 18:32:26 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Nagarjuna Kristam <nkristam@nvidia.com>, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V5 00/21] Tegra XUSB OTG support
Message-ID: <20200227173226.GA1114616@ulmo>
References: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
 <20200217085130.GJ1339021@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20200217085130.GJ1339021@ulmo>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2020 at 09:51:30AM +0100, Thierry Reding wrote:
> On Mon, Feb 10, 2020 at 01:41:26PM +0530, Nagarjuna Kristam wrote:
> > This patch series adds OTG support on XUSB hardware used in Tegra210 and
> > Tegra186 SoCs.
> >=20
> > This patchset is composed with :
> >  - dt bindings of XUSB Pad Controller
> >  - dt bindings for XUSB device Driver
> >  - Tegra PHY driver for usb-role-switch and usb-phy
> >  - Tegra XUSB host mode driver to support OTG mode
> >  - Tegra XUSB device mode driver to use usb-phy and multi device mode
> >  - dts for XUSB pad controller
> >  - dts for xudc for Jetson TX1 and TX2
> >  - dts for Jetson-TK1
> >  - dts for Jetson-Nano
> >=20
> > Tegra Pad controller driver register for role switch updates for
> > OTG/peripheral capable USB ports and adds usb-phy for that corresponding
> > USB ports.
> >=20
> > Host and Device mode drivers gets usb-phy from USB2's phy and registers
> > notifier for role changes to perform corresponding role tasks.
> >=20
> > Order of merging Patches:
> > Please merge DT changes first followed Tegra PHY driver changes and then
> > USB driver changes.
>=20
> Felipe, Greg, Kishon,
>=20
> Given the runtime dependencies between these various parts, I could pick
> these up into the Tegra tree if you provide an Acked-by.

Ping. Are you guys okay if I pick these up into the Tegra tree?

Thierry

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5X/SQACgkQ3SOs138+
s6E7uxAAwLgVZKM5o1rrps7EuTuKsMpZ5xxl3xBXrfsXA3ySvIC3W0H6sNDuQsD7
bKHID3zunA0/6EnDGEyn62wyo58e489dCiPseSTr/t0cSTks5f2dDM46BrTDug3A
iyAIH71LcFvd9+SoNNiIFwQxs3Qx6E+oU/uFqdgPKqO+uqjlI//V28syeVHCmeW2
50HLMU91gS/Wc7+nU/TMaSBDh98kayfyVihMSyVC1llle2O8ADhVrCY/ATO8Pno0
kKV/i7GCYnvhW6I/6260WLWrgOKaru5Yzo9oWGR02LPukuJMGsw/jci0MhhTZp7e
qj4Pa5oc9+hMkjXVEV6pcNmJBOVs3hfx9dR4Ipvl+KJBBQrCeeclKfPbFVFJI/mC
uMdJFc5ode+XmVDxc2VbEtwPN7/+UGrhwIN27gjPlVeVyVjwLS4tUt+hj0QOMgrS
p7q8ilN5VZ0TV4Kwa7aqUntx60yTDFsDSj+eFEUbp46QZzIBncUdpIqxFYqMc4Hz
Wa6QBAHjT4Pad9DviKRDR/71nZknkBbtAnq822gkk5Ax3gUShgZo37CbAim7su66
pwdQsoOpoJOmZHf8mcLB2t+99qAzBbZepOnQ1bw7iNo58q4SMXqTki5geomJ+JDs
wxFOqWQb8B+0Fw8J3VHS3X/j2KIRs9hEnl5qD+Z8g3CPZBlqpmo=
=u05R
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
