Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37398C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11F4E20786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txdPHnuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgGHQMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgGHQMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:12:02 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAC2C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:12:02 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d10so6338887pll.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=O8NVmCrn7rmWx/EasIgqaaIL2HEOytbX8KlkosnSljU=;
        b=txdPHnuKi8jNIzLrEJ2Jsanim9Gtuu9h9TVh3AYwbvPOiYex6jxnL4nHM29ZbFOItJ
         Kr4fPd2Uq6Uaw3WK2H9BUVYJHBbg6NrMs+N46T5+0LFmwGudJiC96NOw53nZXvnYuq9I
         kWdvNsWybDklGVbhpewXqhJuEicCtHfoSATA0m7hPt3I4Ity6uoBdvrcH7jPJAhCYyne
         qAHV1S6w7iGDGM4P1yVQ2kGMbfqM6Jb17TpP5z2XgFlAjj+bmJ9McBEPc4TnIhQVE2bX
         KTIsloHDtoldoaac6b/FxU9EMIbwPRkV7Qt/6mfPY7GqUzEELwKNgPZrcoAA/CtYyCv7
         Z7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=O8NVmCrn7rmWx/EasIgqaaIL2HEOytbX8KlkosnSljU=;
        b=p9aY17WTMPpbz4H6vUEnN1KyDBGvrZ96YAL7Ru3ACYCelfgLW0M9Wb5FFPEXRB+eHW
         gX899upxhjjw9mNt69YZT2l2Ba05T3Ys7quVWhQKymJkT8ifcJ31HqVW6zLSmyp7hSI1
         Gvm0CqwgpBdm7bOnBxHruGegX5Ru32iJqN5adTRK7l00a4DP9uZY2eTEfUVhbBTvKt0K
         gM8xpv3hmGiULBl/pUNWbiuz5Aqub40yR610R1BwLUoBu5GIdsixEVlvyPgY6n38dlRs
         49zS7YDhL7VEHz1NTJb9jj/QsvSgICJF9gn9cfPkDfoRaSPDgdg2fFgpZcGQYd2/tZjA
         6Fkw==
X-Gm-Message-State: AOAM533DdZfehroEfeDmN6hmTKs9nvOSGlubpNSp3NnkplkbF0rf8QAh
        lf81PZdLbV7EUmCpf17F3/0QY6cbaTAWfQ==
X-Google-Smtp-Source: ABdhPJwZK9rxp3LPxedGPA+AhLma7JOzuo6h4Jy9BY9kWGCtku96xzxKbMxxipK+Yo+nTV4wGra79g==
X-Received: by 2002:a17:902:934a:: with SMTP id g10mr40305193plp.83.1594224721738;
        Wed, 08 Jul 2020 09:12:01 -0700 (PDT)
Received: from blackclown ([103.88.82.67])
        by smtp.gmail.com with ESMTPSA id u20sm305267pfk.91.2020.07.08.09.11.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jul 2020 09:12:00 -0700 (PDT)
Date:   Wed, 8 Jul 2020 21:41:46 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [Proposal] DRM: AMD: Convert logging to drm_* functions.
Message-ID: <20200708161123.GA30962@blackclown>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hii AMD Maintainers,
	I plan to convert logging of information, error and warnings
inside the AMD driver(s) to drm_* functions and macros for loggin,
as described by the TODO list in the DRM documentation[1].

I need your approval for the change before sending any patches, to make
sure that this is a good idea and that the patches will be merged.

The patches will essentially convert all the dev_info(), dev_warn(),
dev_err() and dev_err_once() to drm_info(), drm_warn(), drm_err() and
drm_err_once() respectively.

Thank You,

Suraj Upadhyay.

[1] https://dri.freedesktop.org/docs/drm/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-paramater


--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8F8EEACgkQ+gRsbIfe
747q8RAAiRLWSZwsG5CBT/ZTm2IXpxxLmCcMsgTF6ntpL2WjPwHGgsECD1NPYR7T
Cdxs0Kc0OnpO/MZqoiaqXhPvfvX61zww/nWX3kl0aDhAh6nZlfQ758hO6bY//fNg
cKmF5WEj2xWxpMNCfvYet/8k74iAcZ/+LVMAo9AgWcWb3tFr/pUqAX+NrtpxEibc
SyOZOF2HuSjVsrQkUmbtcJ1plvhVQ6AUdn4UNIGXaPxxamQvNjXuorqELERoCXZH
GTtiAe3X68D0f3k5nwaE6yqiKwL5qlPMkulOqbW1qPmYB6vQZAdSaHhHVANuTwlS
A3LlnPHvnNtluOukB+obqxZw5MKLCderk1KfHESHudF9am/8IKI5YFSqJR4LtHBm
lJHyfc3b54kljwxTbs6KVP/o6lTjTBX7KuTvj9ZHIbTGRZ0Fip/E5gOkuwU9l2OA
WpB1Rqle/FB3mZFeNTB/Blk1y59aOsRDCqYU91xCDictW7ho8sd5F3h90llFQADL
qbQKhiveae0fcqApt84hjxdnpoc0EWRpcO0Cs4swRyngxu9KFv5LnWy6Zqh/EMJk
jrja2upJzZc7wNWtOQ/Fvn7CaBhhto940aBp/u+rrBg/Ow20sbh3KJdOKABdq2ZJ
FNR22+8vibUNaIJiae6sEx1DisK/izz0XJpf5PnU8ACnBvCEdK8=
=DuJn
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
