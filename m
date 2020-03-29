Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72747C2D0E7
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 10:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F7020675
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 10:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585478112;
	bh=VZb1AfKfLRj9i2noeV282Qx0noCiipydqn+qVo/7/5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=qB0L7fE+CL2la8/nNKKrVKxbiDnLJ/ApQ0Uxwnx9vdnr26pQUh6FtG0vjNYJYHE3d
	 NrMf9BGWqAu1OkhxY/fO1ejOcUEsFLQY2O3Fg3QGLEV1Wk+mDJBIwRI8Epx3R0Tt2P
	 /kieXnL8/fY6wjEdTcUgBILIYKET3ocWErdBbVyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgC2KfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 06:35:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33062 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgC2KfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 06:35:10 -0400
Received: by mail-lj1-f196.google.com with SMTP id f20so14761259ljm.0;
        Sun, 29 Mar 2020 03:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=VZb1AfKfLRj9i2noeV282Qx0noCiipydqn+qVo/7/5Q=;
        b=nDMkANrF8lq0pvR1cZw6m71QuW1v/Qsxgva5CcrRtYJk2EdRpv23zGxomyVfvelanZ
         qGne3mDHTHhNLXrKWO0eFjqOnshQZBlgY4vM4pD8j2LvMt1BpYaqn6rAFPKqjao7rXsv
         dYrzqolHS6zxy8VKsb534noN/lrMMf2CdEWeNLbpmNG2GOXQOd5Pe+ZyA/qkEs3u/wOw
         pYd4r+jmI0W5CiZeyJJ143JlO5sDSNBKKWklcw5xzeB2whyYT/NNl7DxrhKvoNK26Rx/
         xQSLWCv7yR1hD0SrJ6H8QPawPf8nudVVVedtZFhp9KaF4vT8jwz47XI1IpWwyORH3nQr
         HTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=VZb1AfKfLRj9i2noeV282Qx0noCiipydqn+qVo/7/5Q=;
        b=LTWQWMX6bbt43OhKKo3orDtmTB7rimceKr3Q7Sz5NaH/sFbxGOYSDa0KwEyNnO0s5j
         GxDWtJWdu+O+2bv51G+51wJKew8ppoJeU0//ZbZ3WRbz6NPOQtJDS9rzsm5/j2wfrvU6
         qGqoVlGALIzLOrgOLRT+jTSrJWZsNrnsfVHzr0fPPruBwBvhSH0AdHcmlkj4Bfp6he96
         AVWB6KYOZd6QvN39eVVy1lFcgKcTZLrW8zZt1FelOdg4pXn0tKj5kyfw4rme3XD/7xaN
         tXLylKg0oCms4snC/+eRQ/SRzLX4XzxqtNTrdZCWLN5pHfHJ+YymRf723SNPL1oizgSh
         nseg==
X-Gm-Message-State: AGi0Pual86t1alm1yw08AN4e1XH6DB6IxNkaLPwn/KVnLSMOmyWRKXgv
        /ssf+HtPtDGk51TSI2h2d2YHDKpu4e7OKA==
X-Google-Smtp-Source: APiQypKBx3zbW5qwWIsqD9EM1rU4FvVNPAUSElOJ5CRSofQwV9r0M7sICdD307OhFZzVsNJNPXTzlA==
X-Received: by 2002:a2e:9586:: with SMTP id w6mr4373232ljh.133.1585478109014;
        Sun, 29 Mar 2020 03:35:09 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id z1sm1514968lfe.49.2020.03.29.03.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Mar 2020 03:35:08 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/14] usb: dwc3: meson-g12a: refactor usb2 phy init
In-Reply-To: <CAFBinCCVTP+MrLq1O0m1pcvLo6WSXyXpTtWMEQQxOuraN+yA0w@mail.gmail.com>
References: <20200326134507.4808-1-narmstrong@baylibre.com> <20200326134507.4808-7-narmstrong@baylibre.com> <CAFBinCCVTP+MrLq1O0m1pcvLo6WSXyXpTtWMEQQxOuraN+yA0w@mail.gmail.com>
Date:   Sun, 29 Mar 2020 13:35:04 +0300
Message-ID: <87zhbze9ev.fsf@kernel.org>
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


Hi,

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi Neil,
>
> On Thu, Mar 26, 2020 at 2:45 PM Neil Armstrong <narmstrong@baylibre.com> =
wrote:
>>
>> Refactor the USB2 PHY init code patch to handle the Amlogic GXL/GXM
>> not having the PHY mode control registers in the Glue but in the PHY
>> registers.
>>
>> The Amlogic GXL/GXM will call phy_set_mode() instead of programming the
>> PHY mode control registers, thus add two new callbacks to the SoC match
>> data.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> checkpatch reports that five lines need to be checked.
> these all look valid (for example: "Alignment should match open parenthes=
is")
>
> with these addressed:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

That's a CHECK, only shows with --strict. drivers/usb/ ignores those for
the most part.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6AedgACgkQzL64meEa
mQbodA//VwUAbPvOPF986Bz7VX5RkvL58wf09qnwm0ENuJKT1UA8iwdt+72lvoa9
Nbj1TYTd3d4wT3Hd5MDRgPGb3HaOKUQ6ouQr6mSnWD9Qq2NbODKighWGl3UDYwCx
6cbe9lllE6yoenGtJ9R4VUMa+UnlHetdg14ukiEMLFipgcmPALUkaghD38aZ0Fxo
/ARman65bgvoKBpJtD4KBzggm1Y93e3ckojM8FKiVFTrixq28hiZC2PqCLRnJ5SG
GfB9YSxJ5ONvrWeb8ReBd4LGCZvXOmniJtDbUGC7OAuAt6Aced5aGwT/xyQDJyCc
fGveU2syqx16Eb7kiIQ2ViQUZidpl78fQo0FNXz+vDRfg9s2cRKafgpnYEV+BG8G
WNiKVdLmB9tu+oRlSy2om0uxU3JcvpoVrWwIYivvppu7j+xgQM0ryzIgAMZ6Dz1z
H9F/7ttjyn0VbrkvIpzcRdS9Vkp+JYOch0zP/Ym7IePXD2N5WVsoWLECAgpnFitJ
cQvn3BX7zgJ+ZNTrMFkNqzuzUczAKXfKYMyfhfFtmG7IPvgmheABnLihkTQ4ezOQ
+zi58Uzewg6i+JYTNN2Myg9GaR34PoXT4/9iisjqvEv0hzF8Y8zpw07nqV3X7G6T
u0EP1/sS82rRixzko/l5L1JKJCspyUwdyyq7NZNHQ8usUhNrAa8=
=MQ9G
-----END PGP SIGNATURE-----
--=-=-=--
