Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760FCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47CC820671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589449178;
	bh=iF5w3uiAz5yNOaoT2817M/aTcW3MOYplHWjH16XDlpA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=KRtl2SHL6g+hMHpHrkiRYWjY1g96iTP0IWKUp37fr+VvOg9iwtrLaceTERwefx+iv
	 WxgGMDuwBIBmHRBlcsXYiVZCNFL39F4bfePL3ScAkXL0RgyoVSwPrBCqm8FO+sx7C5
	 7v4egRsdCmFehSN04JCOnBCzApto8qd68sKu4GN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgENJjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbgENJjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:39:37 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51DFC061A0C;
        Thu, 14 May 2020 02:39:36 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f18so2715711lja.13;
        Thu, 14 May 2020 02:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=OxS8vqvqj5Tr0ZkdHwRMNglsDe3G/PVMMHh5u2SO1wo=;
        b=L1GlHQvutJlPEE4AR09vwVJi8jWRZBU0NQVjrR5YB5TTlYhyRu9f7l2D1IIcYDLrD1
         CCH7HejECVIeADMWwdFi0UJm2fI47wg22JlnDZmnwQZ9cN0tCQXnxcnCStbL7NzbLxIz
         Cp0iBciM+bDOx1JdlrEaYYEaQLyu/i9gwmRdcORbEJIdYfp6qEuE+gyNts3eQxtTjA1M
         bKJ8PBhKpIOhgw5lNEpob0i6jWIYCySaZC8NhRkACOUAJg7ju5aiEtJZXRB2UufO3KSh
         zbLzQzBBaPm+yHGVGXfkVeCV7BKeyyqFTa2jL4hMoMmliMHLuSNcuj2/cYP4OW0OTvLi
         4GZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=OxS8vqvqj5Tr0ZkdHwRMNglsDe3G/PVMMHh5u2SO1wo=;
        b=DIwioWobLwKFBqyA0eg5dmt7V5rVnosSoAgsXW3mB4ThJUlkHdKWGpaGgDijeo3jGp
         lF4/x4h03X9GDhMs5VzIe+5EiwF7FujrT2dieb4JNKBYB9dfJeysubZ7Cvx04oTTXMCT
         Z5Oy25aK4hJyFvbxk7D9R/RK285YmEehqgvKU5L8FzPXZyZY9VLn7s/KCc3NDvchQbJb
         rwJGTNPyKTC+TELttNvvfPwsK0q7Pom2+r2duls0W9P6Zwm1L44bWSuhO9WvnLzCc8Gv
         MsCYSN/ZRw+p+ydw1o0O371RMI+ZC9fg2/BIxufhllp7DsJ1LZ6RmbgqAWWXewlRq8Rx
         8kOQ==
X-Gm-Message-State: AOAM533lLUkVvCy4rbkqGfPaVflLq3GUjHCofoSmqaLErG9sR3G78gP7
        TafU5yd0ibVsd5SaWRb28zk=
X-Google-Smtp-Source: ABdhPJzKe0N7VQTiyNc655mi0DwcdGzeeMa2U/AI657syJNtZDcKKI3Q3Ik/9qKXjxLpGxvQRXgPyQ==
X-Received: by 2002:a2e:9a82:: with SMTP id p2mr2240701lji.279.1589449175347;
        Thu, 14 May 2020 02:39:35 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id a24sm1189084ljk.10.2020.05.14.02.39.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 May 2020 02:39:34 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Nagarjuna Kristam <nkristam@nvidia.com>,
        gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, mark.rutland@arm.com, robh+dt@kernel.org,
        kishon@ti.com
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: Re: [PATCH V3 0/8] Tegra XUSB charger detect support
In-Reply-To: <1589437363-16727-1-git-send-email-nkristam@nvidia.com>
References: <1589437363-16727-1-git-send-email-nkristam@nvidia.com>
Date:   Thu, 14 May 2020 12:39:29 +0300
Message-ID: <87wo5e4zzi.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Nagarjuna Kristam <nkristam@nvidia.com> writes:

> This patch series adds charger detect support on XUSB hardware used in
> Tegra210 and Tegra186 SoCs.
>
> This patchset is composed with :
>  - dt bindings of XUSB Pad Controller
>  - Tegra XUSB device mode driver to add vbus_draw support=20
>  - Tegra PHY driver for charger detect support
>
> Tests done:
>  - Connect USB cable from ubuntu host to micro-B port of DUT to detect
>    SDP_TYPE charger
>  - Connect USB cable from external powered USB hub(which inturn connects
>    to ubuntu host) to micro-B port of DUT to detect CDP_TYPE charger.
>  - Connect USB cable from USB charger to micro-B port of DUT to detect
>    DCP_TYPE charger.
> DUT: Jetson-tx1, Jetson tx2.
>
> V3:
>  - Added ACKed-by details for PHY driver and DT changes.
>  - Functions and its arguments are aligned.
>  - Tabs are used for alignment of MACRO's
>  - For vbus_draw USDC callback, usb_phy set_power error is propogated.
>  - Fixed various comments given by thierry.
> V2:
>  - Added ACKed-by details for DT patches.
>  - All patches rebased.
>
> Nagarjuna Kristam (8):
>   dt-bindings: phy: tegra-xusb: Add charger-detect property
>   usb: gadget: tegra-xudc: Add vbus_draw support
>   phy: tegra: xusb: Add support for UTMI pad power control
>   phy: tegra: xusb: Add USB2 pad power control support for Tegra210
>   phy: tegra: xusb: Add soc ops API to enable UTMI PAD protection
>   phy: tegra: xusb: Add support for charger detect
>   phy: tegra: xusb: Enable charger detect for Tegra186
>   phy: tegra: xusb: Enable charger detect for Tegra210

Is there a hard-dependency between gadget and phy patches?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl69EdEACgkQzL64meEa
mQb8sA//arcV2sJenLAVwznTaumNZT/wFev4shUg+YBRJMGWcpGLvoSIDp1isgKF
RfHgWCgIywoyBulBpklhyz/aa1Z1g9ZAYMKnz08hbvmaTwrN3/YHArbi3nWhx1N4
nqM0M9D0qFvsuYUENE7vlaVRnKtEzjQHvDl0c8G4ACUYmT5A3RWuvo4JNvdkKPiE
52Apk0ccU/or8IGZIPO0DeYQR60KIr+hNjiBSPa7uY0RtyuRCvHJaiUrYw3PeIHg
rk+/6eNdKR1XFIuwoboS6vg8OMvcVg4Kozyr/v0duk0AzhB66o7LyV8XQbtoITVH
mizLxQvGas+dyi1PbcPOAuTuTjrrq1/Cpnwhkih/rZEDfJtBOUs5iud5ZQiz2+wz
+cvjKX5YF4UcfeFgAUi8536qnD+j5aKGgra9eWp+LgscTEYqOajZpK8QdvHqtcKK
o/hXvC6dM5MxFQKfj3xvSNeoDFf8/jMwhYHx/bnYIXP5IbgGuwQ7dmZbF0W6Snrn
zg8GEjjdjyzEB6aWVQ8EbybgqRoySodmDhXsNtbTzj9duGyc+I794FS2hsYw8Emy
HntxrKiyf58VTjwcRE4FTlHJizLnk+eGZFCOReYPx3rIxjZbint8pkm6s/nLwIyq
wJQezFji3PAJyJM8X1wB0iN1fA+QQKGuWeWmfcR3yivGaAgdJg0=
=DTUT
-----END PGP SIGNATURE-----
--=-=-=--
