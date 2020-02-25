Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B4FC35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FB920726
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="2IqeHqsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbgBYL0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:26:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41950 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbgBYL0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:26:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id v4so1412388wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 03:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=B/woJavrTbLqhC1ZU8xE1PAWg4YyAWLEB0RDFhgwYTg=;
        b=2IqeHqsbjTbi3WWfkYvGjT2QsNnosUcd8bH2c9si1oQCWeHPHHxoC1QlJZbZnNRsuQ
         f+E54cJkpQvDLE3w802zhHId10IXrjZ2Ed0LiQSthhIL0P1rDztzOi50Hd3Yog84edyZ
         tjUxbQ2wAzQ1qju7qAcmTrM1IJZNQAU8KfOwMjWgLvf8Ce5vmwfmMAv0sn6NuN0e/aOd
         YK8xtXpdA/nSdg/U4VRe2IXK2/uhbIo+lInOpMqRphIzk/uQWt0WsAI03VWS7//NsXay
         4PrxPhabzTazPyO7rxP9m9TLsiMcj8kzoDuS9pUHInUnoOuXy9bEo5VNPICy6qTR599e
         22lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=B/woJavrTbLqhC1ZU8xE1PAWg4YyAWLEB0RDFhgwYTg=;
        b=AX8vdXykQCnrqIThUvHbjchhXCE1ZHdi1ZTOKCR0Atb4Y4j12fRwHHjK3b9hrJD5gV
         Czops7Z2q+koNNByQnjlR1IQWKafamT/025u9iuo5tXSuWew2svhcXVRcAZ2a2vK/6Fl
         BxwgtvVqLOoYbfxAxckkr1iFTU6KCBMOOxV+1Lbhc+5g3T/VHWnnMPc70PI0teG01rYk
         S5WEqTdYesVZRWckcTON3p55v2ZBgy+0udOy6HgJJIS9SgK+DXcezHsCKsOa7bcG8cUI
         Y1forJsBBDiVr2H1oIGEG++L0DKMoHIAwieC82epCkoOIiVbdjIBNd8ush4Y5LS06eC6
         8yIA==
X-Gm-Message-State: APjAAAVPLdcCRQcdjHXA6RyAF5ZJ06jeXSAGIICyMMRorlOnr6P8KlPd
        U3nJhASwDuJTJgXdudgSXPup7g==
X-Google-Smtp-Source: APXvYqwOMnuW551A2Or4GBqZRx5xBZrBaMQ4Zj81TlDRhVaBsWsCcXc+ODNxAoMizsWNdgangtO1Ww==
X-Received: by 2002:adf:de09:: with SMTP id b9mr15616634wrm.160.1582630007529;
        Tue, 25 Feb 2020 03:26:47 -0800 (PST)
Received: from [74.125.133.109] ([149.199.62.130])
        by smtp.gmail.com with ESMTPSA id m21sm3617627wmi.27.2020.02.25.03.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 03:26:46 -0800 (PST)
Subject: Re: [PATCH] microblaze: Fix _reset() function
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, git@xilinx.com
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <ce58b2e6d0fbc8bf94d3cd986c068fbc4fda4d04.1581497006.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Autocrypt: addr=monstr@monstr.eu; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <efea364d-a3e5-c1ea-1719-15c64db4c03c@monstr.eu>
Date:   Tue, 25 Feb 2020 12:26:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ce58b2e6d0fbc8bf94d3cd986c068fbc4fda4d04.1581497006.git.michal.simek@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="0FGLkaG9aZDKGBB4Xw66GrQ2Mdh14TDyQ"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0FGLkaG9aZDKGBB4Xw66GrQ2Mdh14TDyQ
Content-Type: multipart/mixed; boundary="Ln6UBQxR8rdW7gtSaqeIhUv3Zu7KTt80T";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org,
 git@xilinx.com
Cc: Stefan Asserhall <stefan.asserhall@xilinx.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <efea364d-a3e5-c1ea-1719-15c64db4c03c@monstr.eu>
Subject: Re: [PATCH] microblaze: Fix _reset() function
References: <ce58b2e6d0fbc8bf94d3cd986c068fbc4fda4d04.1581497006.git.michal.simek@xilinx.com>
In-Reply-To: <ce58b2e6d0fbc8bf94d3cd986c068fbc4fda4d04.1581497006.git.michal.simek@xilinx.com>

--Ln6UBQxR8rdW7gtSaqeIhUv3Zu7KTt80T
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12. 02. 20 9:43, Michal Simek wrote:
> There is a need to disable VM before jump to zero reset vector.
>=20
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
> ---
>=20
>  arch/microblaze/kernel/entry.S | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/en=
try.S
> index f6ded356394a..b179f8f6d287 100644
> --- a/arch/microblaze/kernel/entry.S
> +++ b/arch/microblaze/kernel/entry.S
> @@ -958,6 +958,7 @@ ENTRY(_switch_to)
>  	nop
> =20
>  ENTRY(_reset)
> +	VM_OFF
>  	brai	0; /* Jump to reset vector */
> =20
>  	/* These are compiled and loaded into high memory, then
>=20

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--Ln6UBQxR8rdW7gtSaqeIhUv3Zu7KTt80T--

--0FGLkaG9aZDKGBB4Xw66GrQ2Mdh14TDyQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQbPNTMvXmYlBPRwx7KSWXLKUoMIQUCXlUEbAAKCRDKSWXLKUoM
Ic5jAKCGzz5v8KxoamQ6KTsJuQqt19rP4QCeL0XlL7vtgxdfxLhz8VRkUvOucK0=
=UfGP
-----END PGP SIGNATURE-----

--0FGLkaG9aZDKGBB4Xw66GrQ2Mdh14TDyQ--
