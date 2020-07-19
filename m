Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1483C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 777A1208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="U41Vda3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgGSRGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 13:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgGSRGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:06:54 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF3BC0619D4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 10:06:53 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f16so8824728pjt.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=MLjtC61HYSvOf+jhzsi6BPvl1FWVwNc79Xe40qwtY0Q=;
        b=U41Vda3tSOPy5eB8woXXe/PejG8JZm9Xe5125xzrnmfCcyQ58+ztWnsdYMf6bEQG5C
         bpzfS0vhEBtolV69Z7n529C2DbfKpTTR2eJt9GTZjiwlmGXfncEAHPth6+bMShIkOPKY
         rSouedpXaiud3wJVLXcr+Gl+OUND0xYJ7hHlBxqFzTLJsAGI7cn5x2SwXox/l/HZhRtw
         NUnQcGr9WD24cQYgxxKA2agmWlehTmAsDsqedYjjpmuH4npAPaS8wQMyi52Ii2MEXApn
         /lAZjQn4MmWg+cFmARbxZYoACtxDoTEuZvNy2AN+XF7XZOKa1UivSIOnoBZEUI8Iw2Yj
         aPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=MLjtC61HYSvOf+jhzsi6BPvl1FWVwNc79Xe40qwtY0Q=;
        b=XbY3Tc4AhxsW970swAex360cOhBKbwmGA1iG5Dox0BbrW7Nq1N8hPMOEa8VS4ces4f
         OEfaWQIIHa30nWAyW+oBU/iKMKSa9jTAAFy8h9AE8UNXHufSuQZXHfeIMtipMYaMRDji
         tOGEfz7VRYV+Yw/upICSKbTtS5a6dqqyq2EZAON4SlFhnw015t2Oyb3LbQrRUC1I8Z//
         bKLItsEM5ISCUyZ/WTYDtzXzaCYOsBmZzqVhP3dcnAiu9HTEJxBQJxalp9XCUACfd3el
         o+MjV1CZ8VoqniSXJ3840j25s0JIn5DQm4trCciOd2fupEKGg2PNuYr6EQS/q53XoLBb
         n7Fg==
X-Gm-Message-State: AOAM530x2dDhup/r/OZEHgpE0yXJXAnvFJiCTlbxb0nh/KeB+wBkSgpm
        EtxtlnXKBCOhoinoa73dDhwRyQ==
X-Google-Smtp-Source: ABdhPJyVTys+buHF8gDW53G+5QMg8T9wLLTiwXtA4gWMRzjKOXraIgXEwEdEJYB9Esgo3lEvGPj13Q==
X-Received: by 2002:a17:90b:4c0f:: with SMTP id na15mr19211051pjb.112.1595178413225;
        Sun, 19 Jul 2020 10:06:53 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id n137sm14057376pfd.194.2020.07.19.10.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 10:06:52 -0700 (PDT)
Date:   Sun, 19 Jul 2020 10:06:49 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Suraj Upadhyay <usuraj35@gmail.com>
Cc:     davem@davemloft.org, kuba@kernel.org,
        linux-decnet-user@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: net: decnet: TODO Items
Message-ID: <20200719100649.3719add8@hermes.lan>
In-Reply-To: <20200717061816.GA12159@blackclown>
References: <20200717061816.GA12159@blackclown>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/67kLNtBinUv5gAT7xyHvtZI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/67kLNtBinUv5gAT7xyHvtZI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Jul 2020 11:48:16 +0530
Suraj Upadhyay <usuraj35@gmail.com> wrote:

> Hi Maintainers and Developers,
> 	I am interested in the DECnet TODO list.
> I just need a quick response whether they are worth doing or not
> for the amount of development happening in this subsystem is extremely
> low and I can't help but question whether I should indulge in any of
> the listed works or not.
>=20
> Thanks,
>=20
> Suraj Upadhyay.
>=20

The was a push to move decnet into staging and kill it.
But last time there were still some users.

--Sig_/67kLNtBinUv5gAT7xyHvtZI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn2/DRbBb5+dmuDyPgKd/YJXN5H4FAl8UfakACgkQgKd/YJXN
5H4Qmg/7Bfp66djrqY/B6Vs0QZ6ES66RICnqC9IMpObpfWfSBbqBvu54BloG3ZFp
HBF75s1Q2yn7ogvBKXF2eIhFuKmpJu81iXTXYBcC+0QOrTF6ObirKL+tno3mDWLd
aakjRxEdxGaIMKZ6DgfJahrx8GJKKbGIrCQQ7Z4RtLzQzHaK1ivz3MfO3jucIwD3
dBBr6/ecS1JbnVXn7CauE/gXCbOuqQ8rKFkcOOBP8oTPNxiVkUUT1QeIPiz+Xppr
gxXBSjNsJsknWJyRO9hNBR4V93WTW83+wjnR2YOrb74xQHYxK+ihRxPUSXqXWjiM
kzpBJPSZBjL32klq2P3F266yBF6EpbLGiTF0E1Iy+wDQogaOuwCCbgHGfs8BfdK4
ng5TZMD8zZyMW/R+T638UNgaBrx4S6J6swIBs9OdllpU7O9frV31LPzthkFiLiTy
4j8gTLx6kRZYqvNg8pCQ7IarWDDsRSexxAlEr2/JJb87Buxa5Z6qt9ISp2OTDQaq
QXcruNbuMCS/eH2Fx9345wVrGlb/kG8LrnXr7hcsIy689ZnwOjdcENNBUaopu/1r
mjJ4sfu7obdlHmWOk5ygOW6EGctJadja5nODmsQhXD4gN233QeWw2NgTKEijy+F2
SZI3fUG9XDV/1ehkgqiFOeyxX38DdlKCM2GsQda4bejhrIcrIJk=
=AfBp
-----END PGP SIGNATURE-----

--Sig_/67kLNtBinUv5gAT7xyHvtZI--
