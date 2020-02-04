Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C98C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5500720674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="awCeZKSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgBDRhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:37:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45906 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgBDRhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:37:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id a6so24134013wrx.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 09:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=iHJJgJ5GR1sAPa65Dsa/N4v3US9T+b/SNI+Egzz6VgU=;
        b=awCeZKSot6cpdUga34Vrfvqjoqgu7YkIzYEIYgfUDi/ijWJ5P4EtGFKu9zbkH5Z5Y3
         wvXv+/Q0ga+zvUXZ02KYSCQSzJsVwusKAVBOiJewT8GYtYfMaRtZ7beTLxpYEbDfSFqE
         kRCQ1u70TwiBPe2rPbt0DnNsYooaOuZYwsjuWwmMDkk9kNQMtJDu7UhTTfPVQl6ZkO1+
         oWKzU4CRZ3RRRC4L/br0aK/u2NK8khBcy8qgJQEQUo6u8lRty8oGfksl04X/jy7jyiFU
         dlxJHONOuuJpn5UHfzrywvteDntqx6kDG8Amo79dptug/IipcXXmx8sN7eFaCP/qfZFY
         NvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=iHJJgJ5GR1sAPa65Dsa/N4v3US9T+b/SNI+Egzz6VgU=;
        b=kbc1BtcXYUCjcTEnGfT3fnjArvUWHgFnJieqfI+NvlP7OcbbtNweuotr97ouGrouLW
         ExMBu10eMnQSt2odmDb1/JY7ZW5GFlfIGuEaU9ojNXTB6UVGDI3/BswRNa/DWcaUqRsK
         +FHL0wKiP0zwD5Y8bmsnnt4rpWg65H2N0pvwXTK0LyVWAH1xTTK0jRbTFqICUJDefDjZ
         pF1ukWiVSAXgUrHIEIVclX8ukLmvbj/xaFOqGXq+mf1BttUWdYBVfjZLyXDfQxeLsd+e
         qP2ifEJfTVbgsSvrBA81enKkF0iyiSg2Xw5hO9pYCt0vy9A5+xcUo9ISYi4lKxrDinsz
         RMjQ==
X-Gm-Message-State: APjAAAWUpcMc48TRIKmwqWwt4nEXSUiRW2ccxga1wNrXTLhhLuUTWMeG
        leuooxKAGQxj3dTsZMcqMZtEHA3su/vkjg==
X-Google-Smtp-Source: APXvYqxFpbX7iZeoOzf8oSDTGMJiwSd1KBM1WcAANTqOjo+u7t8q3ZEF8z0dEjTORFW7YAI60kiCJA==
X-Received: by 2002:a5d:4f89:: with SMTP id d9mr12478624wru.391.1580837853631;
        Tue, 04 Feb 2020 09:37:33 -0800 (PST)
Received: from [108.177.15.108] ([149.199.62.130])
        by smtp.gmail.com with ESMTPSA id c9sm4726278wme.41.2020.02.04.09.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 09:37:32 -0800 (PST)
Subject: Re: [GIT PULL] arch/microblaze patches for 5.6-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <92cc6617-e2c3-e3b8-cf20-c8ccf748d37a@monstr.eu>
 <CAHk-=wiFMsSnjERZno13XbTF6m3pk2beAH5R-9RGct7hXzG3ig@mail.gmail.com>
From:   Michal Simek <monstr@monstr.eu>
Autocrypt: addr=monstr@monstr.eu; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <f2b951c9-f904-58d7-0634-0a0d42f71066@monstr.eu>
Date:   Tue, 4 Feb 2020 18:37:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiFMsSnjERZno13XbTF6m3pk2beAH5R-9RGct7hXzG3ig@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Fxm3WmiV6R5I0MLcMWTEmFkmOpaHfxhYl"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Fxm3WmiV6R5I0MLcMWTEmFkmOpaHfxhYl
Content-Type: multipart/mixed; boundary="NXDRbW1yjA0BDXagWY4jJrHDXsXP0OW5v";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Message-ID: <f2b951c9-f904-58d7-0634-0a0d42f71066@monstr.eu>
Subject: Re: [GIT PULL] arch/microblaze patches for 5.6-rc1
References: <92cc6617-e2c3-e3b8-cf20-c8ccf748d37a@monstr.eu>
 <CAHk-=wiFMsSnjERZno13XbTF6m3pk2beAH5R-9RGct7hXzG3ig@mail.gmail.com>
In-Reply-To: <CAHk-=wiFMsSnjERZno13XbTF6m3pk2beAH5R-9RGct7hXzG3ig@mail.gmail.com>

--NXDRbW1yjA0BDXagWY4jJrHDXsXP0OW5v
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04. 02. 20 14:22, Linus Torvalds wrote:
> On Tue, Feb 4, 2020 at 11:08 AM Michal Simek <monstr@monstr.eu> wrote:
>>
>> please pull the following patches to your tree.
>=20
> Ugh. I only noticed after doing a couple of other pulls that you
> *just* rebased or created most of the commits in here.
>=20
> Why was this done? Why are you sending me stuff that was done minutes a=
go?
>=20
> The merge window is not for doing development. It's for asking me to
> merge stuff that was ready *before* the merge window.
>=20
> I've pulled it and since it's just microblaze I'm not going to do the
> work to reset and re-do the other pulls I've done, but if this happens
> again and I notice in time, I will stop pulling from you.
>=20
> Because no, this is not acceptable.

Sorry about it. All that patches has been sent and done till the mid of
January. Some of them even earlier.
I just needed to remove one patch from queue which we found is causing
the issue. That's why instead of revert I completely remove it and
rebase the rest of the tree.
I will handle that differently next time.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--NXDRbW1yjA0BDXagWY4jJrHDXsXP0OW5v--

--Fxm3WmiV6R5I0MLcMWTEmFkmOpaHfxhYl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQbPNTMvXmYlBPRwx7KSWXLKUoMIQUCXjmr0gAKCRDKSWXLKUoM
IbwVAJ90Oqnwc5PPWNiSvnCDDqYjBqg0NQCfX8yRPqzmTYVDKj0alkxDZ2jd0lA=
=d87R
-----END PGP SIGNATURE-----

--Fxm3WmiV6R5I0MLcMWTEmFkmOpaHfxhYl--
