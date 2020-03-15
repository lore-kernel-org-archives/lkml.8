Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB1BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CC42072A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584263284;
	bh=y6+MMKtpoEZmXy95dogV64Elb9/FiBkAOb+wY0NQTiQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=cLf020S/zYCabgvFsOvq8zFW4pML+F422a81D4Wpve4idh6NeJJ/fjwvehhkDG6RR
	 PMwjo7MpQ+HSTqsqphywucOuktPnsJ/Sizsf8Gohi4i312EeLJ/4ZvWuaQv+GSDNa+
	 JbXXRgGA2SWH+cGpd1gUKPG+lisOjhYuBMkfqpcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgCOJIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 05:08:02 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:39971 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgCOJIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 05:08:01 -0400
Received: by mail-lj1-f180.google.com with SMTP id 19so15194544ljj.7;
        Sun, 15 Mar 2020 02:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=y6+MMKtpoEZmXy95dogV64Elb9/FiBkAOb+wY0NQTiQ=;
        b=GCmgHqZu2FiKQ9x5fdyChDRTbh5m6hACNY9cSE9p+G9yst/lxtrR6fu2HirmNmqCVD
         6ESh+qAyTC6D7/OTK9kCKHFntLtgo8FxwnZNGA+ez0uQrHBYvrh+1C+w/bMwQCdBK6Ui
         ++C98mbgoHIG1mrw6vah91ctjecktALiI9upUbaAgCZ7dJZS3vW9JbYIRLshLoCxQSNh
         zZMLUcI+/nA1Jn3i5LG1424xo9uSUswtciICs+Fwv6lME+7wAkKvR0biu7XYGh6DR0si
         92Kia2rDJHNVfBREXeeuSpXhjRgfAc/IJ+5BrWej7o7kN0VoO4nMb7jHDpfHAklFu1kA
         sv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=y6+MMKtpoEZmXy95dogV64Elb9/FiBkAOb+wY0NQTiQ=;
        b=HsowH3ssfMAT8bRdXEGIGfK7IKy3BVL5mwJJbEIENtVR632pLmVKocGyo9N/Exu8C3
         WewJ7CuCJax1UnPAFOAkWg4zgUF28sZA3696spMlaAIHD/S4LbnhfvADMihaNkewNrpx
         xusjvzVMRS7re8fo+lL+4/8q+0Xs1aJjxeVL+BihGfGvDZHcKrxx9g/N9U8SRwo/eFpt
         o2LK2e3PN4TAY7GjpCWuW9Njv991EYmcyvQQDwjslNQ2TWDPtf61QHHGhodHqA+1CQco
         hCcDVprnxvWZpWZ7wwWmIOPaLfyqG83JAzwkq0B6ak6QoumyNU89BSJ0r3rQjFeJN7RF
         zMFw==
X-Gm-Message-State: ANhLgQ2razJgbBiiQ+r/HHkaIiB8q+l+aUbMmPhPX10OTiocQa/3uPpa
        /t07l8P89+jdISAIHZ4VUfw=
X-Google-Smtp-Source: ADFU+vuUSjXZF4c+u/QwxIVHdBy2Qc8AarnVKoDp5c4eZz6oJTz+TOypteEeXK400S89WyQzo08rKw==
X-Received: by 2002:a2e:9ac5:: with SMTP id p5mr13400772ljj.200.1584263276934;
        Sun, 15 Mar 2020 02:07:56 -0700 (PDT)
Received: from saruman (88-113-215-213.elisa-laajakaista.fi. [88.113.215.213])
        by smtp.gmail.com with ESMTPSA id k203sm614368lfd.7.2020.03.15.02.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Mar 2020 02:07:55 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv3 1/5] devicetree: bindings: exynos: Add new compatible for Exynos5420 dwc3 clocks support
In-Reply-To: <20200310194854.831-2-linux.amoon@gmail.com>
References: <20200310194854.831-1-linux.amoon@gmail.com> <20200310194854.831-2-linux.amoon@gmail.com>
Date:   Sun, 15 Mar 2020 11:07:50 +0200
Message-ID: <87lfo2f0k9.fsf@kernel.org>
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

Anand Moon <linux.amoon@gmail.com> writes:

> Add the new compatible string for Exynos5422 DWC3 to support
> enable/disable of core and suspend clk by DWC3 driver.
> Also updated the clock names for compatible samsung,exynos5420-dwusb3.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

What is the dependency here?

checking file Documentation/devicetree/bindings/usb/exynos-usb.txt
Hunk #2 FAILED at 84.
1 out of 2 hunks FAILED

Applying on top of v5.6-rc5

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl5t8GYACgkQzL64meEa
mQZ5gw//fmJazamjVuJq52Gz3zIUmYUKhW/T27bH63LVJszVMLh4qdWsfS5siOsU
XQ5aozi1Djet7rUC8tPkW85WGs2J4/Mb8BiKZTCAX/XPVRprQHdZhUk3tkSYpdHE
xuXowbKt1rXkSS5lkJ792SOI6SlxISKDHmS5ELzA5S9dhHgRarmMioEcVySR6O0/
vw58f1r0jlU1MGjGOMkIeJ//tldiv+mK5gw1159zcSbj0KuLBwD0QnRG9uPYsUhg
TjO8bfdAnjdouYZtRTaB0CDcxU1c4v4UUgnVJ8BI4ABAspn6IC+CUnQkuqs7TXy8
Tf0f92uXywtUztxGTBGkx+IWy7aAutt+/L+FDoIc59VKibsBIOqFfZcBiHpk/oim
adfVmFrJ+6/HOKZ+56t/Et7NkhFJd+Qj1LN9VGcUSYt+1/0wJSppCEjN8iiXR+po
W9rdxgRROxFaxsquO09VFaFO/o35B+X7Pxa9aUQbL8Lgk5LztqxeXMS7J158WTVW
5WZGFq8Pn6P3F9oRIgy545hK9I/42UTlLRSEdVcyBTo9XmZ9USmBVzE5SkiZwYdb
wSbyfXxFSuu8mia3MzJIkMvjnsKpLm7MQlo35TKeGqW7TCgOmmwNLDpj2Rp7JdW3
HtzvRCKh93ytLgrfYMLVUjVKDewQBVc7v+aofdkagMprUcrNrlI=
=7hzO
-----END PGP SIGNATURE-----
--=-=-=--
