Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50555C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C0E12074B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="O8z8ttwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgDUHu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgDUHuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:50:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61103C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:50:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x4so2449834wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=YiceeYcWfp6dJ/RtflaMzhlWjjOPviw2ytlJMWOClhY=;
        b=O8z8ttwJR6dcJUhc+8LGb4hs/8vpWV5wPFNlwj3hX4sqjBlj9VCozgza7rmlmF0nyg
         sR9jdg0JlkqtNlqSxJN9MMyWEMQTSMQYd+y6HDqehioUuHLxxLvNUmzqAYqZtfYe7Nqo
         U9PVVibPNeDEdyQg8MLqcN4parA0PYSYGL1/vNbQKU+jCrLISFgcnKtUV8JZhuB/jfRn
         iujoqcl7KJCNIj/8ylAATrkXt7jsueUyKvryr8OmiVpc13WKbwslCYa9b/BbW0mexBzb
         gifbsGTI6kg1vPhkVFVdGt2P35dbyUhHFbVMxtQ6kSWlPs6pESfn4nx2MZtmYXlFKm9B
         eMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=YiceeYcWfp6dJ/RtflaMzhlWjjOPviw2ytlJMWOClhY=;
        b=P6v5q2lnlhWzPLLjSqEUXvY62nZs301jnvR915ofJ+SjcvNLAz1Dc9FmqBUsbV7OvK
         P5exbr+yv2ug5yiwtAsIHMgX4YoOmHRvpmXbfy548xL6/YvFblCnaHbyDQeMdSpbMGFe
         8PVDqbPR5+TK/olv6rWXqG0EWry5c9IgjEn5l0yW0YxIaCKd/T870oUwZtyb0OIwFM/3
         Kj0VA6DOtymurREMug2RkvVUpojxGLnX3NflHLanVJjT5vRUHI3tVLlc14rbr059CpvE
         FImOgQmzOsBDfArE+G5Ybs1PpAaM13VKG8luwciCoT8EExt9LvqXEPj5B7LWxWVppEhX
         AK9g==
X-Gm-Message-State: AGi0PubckH2AuhXZKzTabPerIG/t8xMoQ1v9AjNIspcvs8lEqKJzA+hp
        3Ma5oqc8d0N4Bu6bnpLD20Omy6YPuTmDew==
X-Google-Smtp-Source: APiQypJntnQXyUB7m8ZlLuci0rbNEL+5xcVIFduLSjrsBtszf6elR7Ic+ICBST6g+lkfywlC4LA+bg==
X-Received: by 2002:a1c:a4c2:: with SMTP id n185mr3719961wme.104.1587455453826;
        Tue, 21 Apr 2020 00:50:53 -0700 (PDT)
Received: from [173.194.76.109] ([149.199.62.131])
        by smtp.gmail.com with ESMTPSA id h10sm2698150wrq.33.2020.04.21.00.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 00:50:53 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] drivers: clk: zynqmp: minor bux fixes for zynqmp
 clock driver
To:     Jolly Shah <jolly.shah@xilinx.com>, olof@lixom.net,
        mturquette@baylibre.com, sboyd@kernel.org, michal.simek@xilinx.com,
        arm@kernel.org, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1583185843-20707-1-git-send-email-jolly.shah@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Autocrypt: addr=monstr@monstr.eu; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <358c6672-d22c-d892-779e-37ad2e1f3f65@monstr.eu>
Date:   Tue, 21 Apr 2020 09:50:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1583185843-20707-1-git-send-email-jolly.shah@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="56uosgCqsMvUwIcVzBzSJ7DTyA1fGmT6t"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--56uosgCqsMvUwIcVzBzSJ7DTyA1fGmT6t
Content-Type: multipart/mixed; boundary="uUbcrPOqrtwycs3ZOPy1uZYhM6duFt3P3";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
To: Jolly Shah <jolly.shah@xilinx.com>, olof@lixom.net,
 mturquette@baylibre.com, sboyd@kernel.org, michal.simek@xilinx.com,
 arm@kernel.org, linux-clk@vger.kernel.org
Cc: rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-ID: <358c6672-d22c-d892-779e-37ad2e1f3f65@monstr.eu>
Subject: Re: [PATCH v2 0/4] drivers: clk: zynqmp: minor bux fixes for zynqmp
 clock driver
References: <1583185843-20707-1-git-send-email-jolly.shah@xilinx.com>
In-Reply-To: <1583185843-20707-1-git-send-email-jolly.shah@xilinx.com>

--uUbcrPOqrtwycs3ZOPy1uZYhM6duFt3P3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On 02. 03. 20 22:50, Jolly Shah wrote:
> This patchset includes below fixes for clock driver
> 1> Fix Divider2 calculation
> 2> Memory leak in clock registration
> 3> Fix invalid name queries
> 4> Limit bestdiv with maxdiv
>=20
> v2:
>  - Updated subject for cover letter and patches=20
>    to add prefix
>=20
> Quanyang Wang (1):
>   drivers: clk: zynqmp: fix memory leak in zynqmp_register_clocks
>=20
> Rajan Vaja (2):
>   drivers: clk: zynqmp: Limit bestdiv with maxdiv
>   drivers: clk: zynqmp: Fix invalid clock name queries
>=20
> Tejas Patel (1):
>   drivers: clk: zynqmp: Fix divider2 calculation
>=20
>  drivers/clk/zynqmp/clkc.c    | 20 ++++++++++++++------
>  drivers/clk/zynqmp/divider.c | 19 ++++++++++++++-----
>  2 files changed, 28 insertions(+), 11 deletions(-)
>=20

Do you see any issue with this patchset? Or do you want me to take it
via my tree? I can't see any dependency that's why I think it shouldn't
be a problem to take it via your tree.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--uUbcrPOqrtwycs3ZOPy1uZYhM6duFt3P3--

--56uosgCqsMvUwIcVzBzSJ7DTyA1fGmT6t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQbPNTMvXmYlBPRwx7KSWXLKUoMIQUCXp6l0wAKCRDKSWXLKUoM
Ie8pAKCLJ9u1N02dTrwuXevPCS4f/00H9QCgmRblSZlAjRwa9lv60fA1pw1WYH0=
=35Mk
-----END PGP SIGNATURE-----

--56uosgCqsMvUwIcVzBzSJ7DTyA1fGmT6t--
