Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58641C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DDB420722
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PUej68Gv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgENMmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726037AbgENMmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:42:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E823C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:42:20 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id v12so3828434wrp.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=RYXkSbdkaYS0HD6sD2srwSa0yD5xgdLjeJ3UTD5KQPE=;
        b=PUej68GvhGXkj5/yl5NyhfK/voCKQpakrN7HKCPzIQjOt6F945DaSylZwXQBMzforn
         0HE8g5katI4JtKzFYGcB19N5CLjHxMKPC6ESpdN0NCWoyDSttL3NS35kCz+rVLZxe/zX
         gmC6WepMylg8feXNOv3fwnXjfZEcR3xiqr1kBgAbItxReibivx9UGWT3JIlAw6znfAWo
         tyeWRk0D/5TGjx1zo4bji2P3f3MYgOHecw5BPrKQOqbhc9XNWMVrk5OixpV+7Mzo7xKY
         +ZnqfRM/3aI5R9BdmtpwVTDKKlF8G+df4YQL6f36b87HsF41fF5lB+heduLx4ctKyInp
         pZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to;
        bh=RYXkSbdkaYS0HD6sD2srwSa0yD5xgdLjeJ3UTD5KQPE=;
        b=Fc9krpAAAAnO8Sw4lHKG5dzHbSgYWg/U/yrS8TekmRZnSMaFtRvV9iPGDYGq+Y/97c
         CZ0T6BqmnUuMiyCxkti58mF9lgqu9GetPG4HzVxD7v4PFBkl/eIn7vGM4U+h4z4jXGSQ
         uFDbI/bq5sEh5PWDgBFkql55t/PizRdfPosfOVoDIhbLW1+Q/nTIdv/AjDlUpr7imSHt
         rEjs6ACkbuQrbZgSFZeIpH9gzd0qDu7wol/Pfn4eUfskL6+cW7W3jI4jFXjx0VWshSKX
         4uqrtOQA6ZTNsxW0fSGtNwo0Rldm1jC+t6CuQNbQoCACChz3+lVLr0B3tXVdKlyIlayh
         8ImA==
X-Gm-Message-State: AOAM532zkwYKGvJ4+h8JK0fbvSLlOLWPckN+BAoJjQAcQN9LWo5N4wI8
        7Hzgh5FmvHnNPWT9eWcGLSjvWekINoAlfw==
X-Google-Smtp-Source: ABdhPJxm/nuOjCefCUH7msAvIZFA/xeXxhnOVfc7AEdd/jTTxvaLQiILC6+6yq4XGkBlVLEydqkwVw==
X-Received: by 2002:a5d:6283:: with SMTP id k3mr5257382wru.62.1589460138674;
        Thu, 14 May 2020 05:42:18 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:4460:3fd3:382:4a71? ([2a01:e35:2ec0:82b0:4460:3fd3:382:4a71])
        by smtp.gmail.com with ESMTPSA id a7sm38682417wmj.12.2020.05.14.05.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 05:42:17 -0700 (PDT)
Subject: Re: [PATCH 00/13] usb: dwc3: meson: add OTG support for GXL/GXM
To:     Felipe Balbi <balbi@kernel.org>, kishon@ti.com,
        khilman@baylibre.com, martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200324102030.31000-1-narmstrong@baylibre.com>
 <87369rfo7l.fsf@kernel.org> <87r1vm4xyq.fsf@kernel.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <8404c7a0-fca7-9e28-b65a-312ed09ecdd3@baylibre.com>
Date:   Thu, 14 May 2020 14:42:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87r1vm4xyq.fsf@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="K4f1yUDMdsuo8nAqC8e6zqnxTIdRv8BgF"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K4f1yUDMdsuo8nAqC8e6zqnxTIdRv8BgF
Content-Type: multipart/mixed; boundary="3dbdY59dTGe2VUyam33gsuxAHSaa8XozU";
 protected-headers="v1"
From: Neil Armstrong <narmstrong@baylibre.com>
To: Felipe Balbi <balbi@kernel.org>, kishon@ti.com, khilman@baylibre.com,
 martin.blumenstingl@googlemail.com
Cc: linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <8404c7a0-fca7-9e28-b65a-312ed09ecdd3@baylibre.com>
Subject: Re: [PATCH 00/13] usb: dwc3: meson: add OTG support for GXL/GXM
References: <20200324102030.31000-1-narmstrong@baylibre.com>
 <87369rfo7l.fsf@kernel.org> <87r1vm4xyq.fsf@kernel.org>
In-Reply-To: <87r1vm4xyq.fsf@kernel.org>

--3dbdY59dTGe2VUyam33gsuxAHSaa8XozU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 14/05/2020 12:23, Felipe Balbi wrote:
> Felipe Balbi <balbi@kernel.org> writes:
>=20
>> Neil Armstrong <narmstrong@baylibre.com> writes:
>>
>>> The USB support was initialy done with a set of PHYs and dwc3-of-simp=
le
>>> because the architecture of the USB complex was not understood correc=
tly
>>> at the time (and proper documentation was missing...).
>>>
>>> But with the G12A family, the USB complex was correctly understood an=
d
>>> implemented correctly.
>>> But seems the G12A architecture was derived for the GXL USB architect=
ure,
>>> with minor differences and looks we can share most of the USB DWC3 gl=
ue
>>> driver.
>>>
>>> This patchset refactors and adds callbacks to handle the architecture=

>>> difference while keeping the main code shared.
>>>
>>> The main difference is that on GXL/GXM the USB2 PHY control registers=

>>> are mixed with the PHY registers (we already handle correctly), and
>>> the GLUE registers are allmost (99%) the same as G12A.
>>>
>>> But, the GXL/GXM HW is buggy, here are the quirks :
>>> - for the DWC2 controller to reset correctly, the GLUE mux must be sw=
itched
>>>   to peripheral when the DWC2 controlle probes. For now it's handled =
by simply
>>>   switching to device when probing the subnodes, but it may be not en=
ough
>>> - when manually switching from Host to Device when the USB port is no=
t
>>>   populated (should not happen with proper Micro-USB/USB-C OTG switch=
), it
>>>   makes the DWC3 to crash. The only way to avoid that is to use the H=
ost
>>>   Disconnect bit to disconnect the DWC3 controller from the port, but=
 we can't
>>>   recover the Host functionnality unless resetting the DWC3 controlle=
r.
>>>   This bit is set when only manual switch is done, and a warning is p=
rinted
>>>   on manual switching.
>>>
>>> The patches 1-8 should be applied first, then either waiting the next=
 release
>>> or if the usb maintainer can provide us a stable tag, we can use it t=
o merge
>>> the DT and bindings.
>>
>> it's unclear to me if this series is ready to be merged. Can someone
>> confirm? If it is, can you resend with all reviewed by tags in place?
>=20
> Are we getting a v2 for this?
>=20

Yes, even a v3 with reviews on all patches:
http://lkml.kernel.org/r/20200416121910.12723-1-narmstrong@baylibre.com

Neil


--3dbdY59dTGe2VUyam33gsuxAHSaa8XozU--

--K4f1yUDMdsuo8nAqC8e6zqnxTIdRv8BgF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEPVPGJshWBf4d9CyLd9zb2sjISdEFAl69PKUACgkQd9zb2sjI
SdFBQQ/+JLx9FF4UXy50yaEgc7SCijzfX2lBC9YteQ/H5pqPlzfwb7BGxQgbWiIa
iGRNoZF6EPyL+oAnRuY1gzsBDC/F7N39UPqvBiXTa/Je0DNMKD4YbGdkl/DIC+1M
nhM7fGW5O+LDyiAZmVjCsRfjyReSZKQY0kDaYV+FFtCaEFednPa8YdJW5lckrQB5
56sznj1QeuQJ0FYcmh42NVs53Zl2Lot8hVaLiCDgAFUx913kajXeq+BeLRJDjcos
LQjpeN/SfNqQJmejyQzS9GqEAxvZP7SXM+necPD4maQ7Iep0thH83D7xvoV/TVBy
0ucTVe2ocyT40w6svz4lSOV+jtRHF9S0VBscf6y9aagTcD3dZQa7QwbFyG+b5hCm
uEIRJj8i2N/WFzq4HdYyMiXBJSaLFWrPOVAh+MKlcH+CiezKeBGvypfTu9Yb/Kv4
obWj146nWsxWKlNTNYsrh+Lj2UD+7iUFEbFTnufeutccwJvnk51a5z4gSsBWNYeY
qMuOvsES0eZKAo5fcdqrVnZZbmjZMNj8T8+tMI5wWTfslyyEJx8O/Es4aemi9kkq
dS5IVyJOCv1aTZ/BqB8WMW6fjZDLEG7a80OqEHlIFcZPIRsJkBx793GliZrNR0qr
NIj0IwInjPGU+EC2XlQ1jSymlsMpJS3+akPh2TCpMVXyb39UZOc=
=eI2c
-----END PGP SIGNATURE-----

--K4f1yUDMdsuo8nAqC8e6zqnxTIdRv8BgF--
