Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3AFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62FA420739
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwSit3Gf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgGFKvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 06:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgGFKvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:51:53 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E53C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 03:51:53 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g67so17309057pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 03:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=R/RUPCaSPqzoFwBjt5s1qtV4yHRYyUYf0BU1jozcpBU=;
        b=AwSit3Gf5PYGY93Tmt+Kj7h2kTByWoVXR81moWArdR2ge4xAna+YOKUPxH+tLQb9bR
         jyqAuOnY7kjQvo+HZJG3RZnt5NLWZEKwBYoctlk2WLLnWOv5mlQ8yf2gmu+YcYIgVICE
         5Y6f4RN015nD7DvyubGQt+dKlb6K9vnCjaFvz8EBFg+jHWDDbR95ZZTEhvSc1x5MKRaS
         2wK7ouj/aNaZ4wQGaoN/D1ThobsjB8kSrAIcjyYxlux6AACrOi5ftT417K+xRdVAfb7h
         QNrSRnC4yJxZwkqkwhKI7tWguUjJwpmI3TinyGmrFLwAuEG3yo+IjbhRHifFTHuSPMRo
         kUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=R/RUPCaSPqzoFwBjt5s1qtV4yHRYyUYf0BU1jozcpBU=;
        b=i0XJrOQT+QsrOmDxHwbKeKz6jq8foCX9AT7s03pi07sTX74UfFVkWrXiqA8ByHr7RL
         yQq0TdXqw9DtYMPGQMvb+5xu10LY7N/KWDipPNmUdGddBfyQbTvzAnvMvsyZzx/TVYm+
         jY5zdfVO7kDY3TZ5/3qME1obvjbyDUaqPPOqEMq9hNULYERPKT04TEmMg78CWvCtNrMi
         zGRcl7EYf9XUa7W0zZUYDLGLA3PCVeAXxop6Z0tD8GS/aXxQLSbllQ7HhdTaG6OgUtw5
         9Y9Osj/4OpoNEBiP2ahz8YR3/wr1oQ35J1jeJgp9QSM3DNNJCqTXu2zsi/SRhGaGy4ZQ
         PCrQ==
X-Gm-Message-State: AOAM530zEglmD7Avtnvwbwq744E+Fq8RDd6u3KnxkGMc7v4TePzIC+jE
        KEcEKrp+78AgvhAvDkCWtYA=
X-Google-Smtp-Source: ABdhPJzo2KxljopNGnnYYgVtn6J6oNotuUUuKIWxrB4m4Qan2wouJie6csZ3xM0wnNm954jMLKNnNg==
X-Received: by 2002:aa7:96d1:: with SMTP id h17mr15164848pfq.141.1594032712827;
        Mon, 06 Jul 2020 03:51:52 -0700 (PDT)
Received: from blackclown ([103.88.82.87])
        by smtp.gmail.com with ESMTPSA id a16sm19112710pgj.27.2020.07.06.03.51.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jul 2020 03:51:52 -0700 (PDT)
Date:   Mon, 6 Jul 2020 16:21:38 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Subject: [Proposal] drm: amd: Convert logging to drm_* functions with
 drm_device parameter
Message-ID: <20200706105138.GA10722@blackclown>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hii Maintainers,
	I recently came across this list of janatorial tasks
for starters on DRM subsystem [1]. One of the tasks is replacing
conventional dmesg macros (like dev_info(), dev_warn() and dev_err())
with DRM dmesg macros [2]. And I need your input whether the
conversions to DRM dmesg macros are worth it or not.
I would like to start working on this task if this needs the change.

Thank you,
Suraj Upadhyay.

[1] https://dri.freedesktop.org/docs/drm/gpu/todo.html.
[2] https://dri.freedesktop.org/docs/drm/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-paramater


--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8DAjEACgkQ+gRsbIfe
745WZw//YOzOBQIp/VcMTmvfWL5OMXrDiO1HUDdlbKkXY9udgjpKya2Wd2KOaZ8y
bzONIfbS8u4uizmAUXktdrZRpCIkOAGQuCReHUzzfDNHWyTBlQHkXn5gSFyIq+Er
qprmLOVEgXNRRvniO6iQ41RqmdgihzMqPW5XGR3NuVeG8bw3DC56C/7W/kKjK4kL
jOLc3DDzH2G+n0gxFCSV5uCSk2XIese21nvCx+xS3ohsOTtCCggM0SH/xZ9WTaPi
zCuXJKN3ItLqseba/4b5kB23oWFM/nZPzvPkeEv1xzN8u3QFJgVKh7Rc06+mKvWp
DD6V4d+YYTspxnVsyga/uB+LWCB2JA/o4Wa9SZl49vy4R32lZJKilMdGcOrjNIUQ
m/YPeu6rpFUluPMnxGB+Shlrn3iHjBC6NQdV52lTFAoExt5pCZN1v/35QZWFrCPN
RlFxDHjMffSstnwdKHua6nGfxe+MPscvlp3B9NAVrTlBPBNckLU3hzzTCgRxg4Wo
a1FvlCO90AvZ5BVllnZQUhjiz5lvwlphvjnpuuD6ziYZeKrqOO0r1Tvqd1HipE6F
ovvf6fHhnQleMHumiy1g9uChAHkS9oxvrKqBVjYEBhaN4bjUUf9huSEXaoP2y7qb
5Ql8JdkqzhK2cxUbnvnZMya9dsiZPhG8e7rkR2TTsq8B5FxfYqc=
=fw+t
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
