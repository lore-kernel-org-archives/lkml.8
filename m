Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29C6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB44420656
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGDu2rYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgFJKmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgFJKmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:42:02 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0A8C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:42:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s88so722663pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=egNrtEMPZzysG/UaqgwgCMuFAVovHMS8M2ijlG7YGtA=;
        b=dGDu2rYoKAtqU6Ch/2pV62cDDymzvCHV7JVzLoTHt0Q0rUfb6kt++ieo+Ksm5xrkP1
         R68t/FVG+KvIovrA0bpgoNVS8XUu6BMl85C2ydtz97jLE46k5tNPRxePE6xwIK9gAJu6
         WgBmXv2/4nAQ8Sf2kgH9so5L5Hx5B/TnMrWSolRlAykE0JYGZ7dCHZgDSQbuN03c8Pat
         cxExPg6O7F/BRTc3mDr2HAOzGVaAGdUAhGpyLKQAooij+xGNM6NU6aFzb5Wsr8Hck74E
         /oyhORieSWhcAm4eJ1HpElxvf+d4sIDTqPFaWAsybOrqFARrRIncylI24PBfjlNe+TC7
         QRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition;
        bh=egNrtEMPZzysG/UaqgwgCMuFAVovHMS8M2ijlG7YGtA=;
        b=D9pcSFwKA+2ZA+VGslT9SrZQc2OjqYH2qvg5bnjdX2AaBJ4XVOG3D7GljoY8xt2QwW
         FpNSGx79ZAgr1dj+Vp9BqKpC3gqWjGY0gPkzcJPkp8YMHr6hY3JuDDjin4ThxHH/WaOk
         uFQF52vD/FpQjL8PTTnH71rE0qlfBLvjqRu3HsN4zNbDn0YUvwd7HTbDvExzEshUxO8I
         YADKwpxrVFl1Vv3gDJOqEGPXOkvqYYXpBRCF4K7HyBh2yIs6oELKaa3YCT56ivoxViPg
         LinFi1xyq86KWy1vH8WIJWxTlFwhJozLONTMdiWw+nvPv+QrQxyjR+lRAZMp+lRTgk4j
         Tojw==
X-Gm-Message-State: AOAM533QxVg4EfOnvXy9vQsqqQru7/zH288HHsgoFOnzXIDyjxhPxOY5
        MC8BioDc9QJOdJAAtZi/DZ0=
X-Google-Smtp-Source: ABdhPJwZ9YbfB0NCPYARehjABNpnJp2Mf3ZSZw8sUQZCC8zsB5kod7UCECm/MnfQzV0B5G504BvPXQ==
X-Received: by 2002:a17:90a:e00a:: with SMTP id u10mr2424355pjy.17.1591785721453;
        Wed, 10 Jun 2020 03:42:01 -0700 (PDT)
Received: from Gentoo ([185.230.125.35])
        by smtp.gmail.com with ESMTPSA id q13sm13194375pfk.8.2020.06.10.03.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 03:42:00 -0700 (PDT)
Date:   Wed, 10 Jun 2020 16:11:45 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: License discripency in files,the words
Message-ID: <20200610104145.GA23025@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LinuxKernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greg/Linus/Andrew,

I am not sure how trivial it is , but if it is , please ignore it.

I got this on Linus's tree :

~/git-linux/linux [master|=E2=9C=94]
15:52 $ git grep "GPL-2.0-only" . | wc -l
14734

And ..

~/git-linux/linux [master|=E2=9C=94]
15:55 $ git grep "GPL-2.0" . | wc -l
49530


Well, aren't we out of uniformity??? Or is there any specific trace on
character? I don't know either.

Thanks,
Bhaskar

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl7guOUACgkQsjqdtxFL
KRU31wgAzZP2NRsTiLzUj+L+av9eK/1rHclUqqzgzI5SXzlvTmyXaDkj0q/+tNSa
SF6PRQhO1o/wCFfvRxfKLfN/x6QrAHxlkgHd/qdH/+OAgKObNiNhPvXwr7St84Pz
R6ZAUycIoI0u/Cqu+AedX+lp4nM/ONVX8zW3aAdgcYK9Nd8suHQnNBlmTkWMi1zc
mrRUy7JFXSbpwz+7Mk+j3gg9fN9+GcD+y0VFO22pXE5YSY5xdq8WIzTRniSxs9Tv
pcplcQxzyJjf2LzLx7MyljIpp1g5SH1xDE0JLnB9RqUgypwsUDPP6tQEfF9POxlU
yrPX5Zm1tz7Q81JKLsvm6ic8bO17xg==
=lhse
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
