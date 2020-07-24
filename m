Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC4AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D59420656
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595598648;
	bh=kUQlJC47iSe6M2DGwLKnxLxm68K3q0yDXR5BlVZeOq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=rapZjMUkV/QLG/XjIoS9csLNjlIOb9T+JPnBT0sle6xerY0Zfl3MPx/BjWNdZv6Mg
	 9DCeSp8D9TUMSlUNP6UwQwxGJxjJ+mJizZbZnHFXIYWVYzqx79khIj/UYLSJqNLCG/
	 sg61u8+j+vyIXejB3hjEF94Gd5rzuGB3i7saXv7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgGXNur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXNuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:50:46 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800C1C0619D3;
        Fri, 24 Jul 2020 06:50:46 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f5so10036818ljj.10;
        Fri, 24 Jul 2020 06:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=kUQlJC47iSe6M2DGwLKnxLxm68K3q0yDXR5BlVZeOq0=;
        b=dPeXe6/UQ2wtvXiOKUEL6oqdDQbEH/zbCoWiNrdkxWowO5Vxf33tTLJRFpdLpalJR2
         AXwGuP3JkyAzYQH3bqeQL9NXUfITrspiAzjXS1yf/UKntbrztz36jWgLBEdDuoGlo6Py
         Pxe99WmG4/sEUjkUz7XhiH3gGVvaavsNmxyoyJtqrNI5FIOxrjJxy939JG+YxVaFvJhJ
         SuQ3HnCGBy24g6AZlZ2/e94yEt6jxU4HBzDQH5DFH+SSK8FyXbKkVk9HlqkRcTjqgGao
         iQDYlKQD4PZppjpd1Wu0TmpHlhr8bCRIEoOe8a5mK7eSmUBTPOrXgqi657+j3nhJddAL
         CMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=kUQlJC47iSe6M2DGwLKnxLxm68K3q0yDXR5BlVZeOq0=;
        b=piXWqOMEzsU5PHJBP+5+noMC2SlVorcLj7OtoNhAs1T0PnBphGU5vYpezmPRmxx6J2
         f/6IAlZ1hegcFy2vBtagykQaIjEREuiFgEdNQz/eo6VPnYbTGFQI0WL9AmGnJB3JfZ5W
         JyWRa/gPetfLOKzXj7Oa8/uzEEd6YDxIaCmK2H7cfZen+l45Usf0/e94OG6UcJWDk6JC
         NWqJf3auQ3KqIjUDHE8tSscwEZjP8VuXn+l6+9ukYkvrtcY/TZwLXsPh39w57Bvd6l8/
         kgT4s5RsqUvns+go3ntJLDEAR5q0QqCWsMUaq9TxEKqts8YO73KKFKesex2CIHICjJqx
         HV2A==
X-Gm-Message-State: AOAM531UyAdqC86HC7t6WhzM1WixtlSEp+qljkfza0Cp06LR43aB1B+1
        ugtT3GQYvMTQZL8CzNjfi88=
X-Google-Smtp-Source: ABdhPJyxuqN2HEdFLAc+Q3u9eWCvpysSuKBqPGUda1JPOw+Hfp2im3d3RLNxHHtDAEIxAxjOTsvkRA==
X-Received: by 2002:a2e:7601:: with SMTP id r1mr4719977ljc.111.1595598644870;
        Fri, 24 Jul 2020 06:50:44 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id i3sm262139ljj.64.2020.07.24.06.50.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jul 2020 06:50:44 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Amelie DELAUNAY <amelie.delaunay@st.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3 0/3] Add USB role switch support to DWC2
In-Reply-To: <4c44f596-d2c3-6d2f-bf28-9e3964b6e6f1@st.com>
References: <20200724104711.5474-1-amelie.delaunay@st.com> <4c44f596-d2c3-6d2f-bf28-9e3964b6e6f1@st.com>
Date:   Fri, 24 Jul 2020 16:50:39 +0300
Message-ID: <878sf9owcw.fsf@kernel.org>
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


(no top-posting, please)

Hi,

Amelie DELAUNAY <amelie.delaunay@st.com> writes:
> Series dropped.

what do you mean with this? Should I drop all patches related with this ser=
ies?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl8a5y8ACgkQzL64meEa
mQZwdw//cL+ayhQjvZnVUc/UnTmN0Gz5U4rAtml72uI2Db/O46+5Q6rNYt0SiPIF
+uiB7fPCPAuYc6zUGLUBp0VelHkN9J6S92LG2TVDWw1Lry/AHVV9exuMcpxJJQxF
P9qkqx58LJgXCYcqh6fEaMcda5sE8YwSquQb8NSAxtQbX2sZ131CDEH+jlprRREh
Nlkg5rYqlH2t17wa8rZ/u8SVpiAJ1OXwP0hH+GqXvBm4tgOc6K2FVRYGvqm1fHM2
BuQvNKCWAE6OkXeia8NxrAl7ME75zlyACkW6jDkVrTUt53QcLx6csjzElLiOmEpS
t1z4iPud5bzBlHFn4/251TaojqP2SNXHpDGjaQ8lCeBPeqLTtH+SryxQSvpO3Jib
F6a2a8Rue4GshKF/nCOkyHDbEVmUBo9Q4IFYL7DbHV7xJUfevfSne+Lp1a6DmDXm
BdvqFvdLXlnrK/Q1Ym83E+VCWz19xJcDawUOMNeZI5llrl5QoMj/4r1uSjrg2Dez
U8sXUoApM3s+9gUrU+rpgu4r10O0vRKgcoDIEj0N5+pGH1q0Ob+CvUmH/M4kOckV
vkRkwgMWiGs94k2cI0XitObHTnh4PGZYkhPPIE35KSjo+lIub+1VwG/sZ+J5B0Q0
Lak7Px3WwyvEXLJu50hshf94FTzduEx7ZiXrWD4hCYDWVr4ba3U=
=Q6yp
-----END PGP SIGNATURE-----
--=-=-=--
