Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE01C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C24E20728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clKYIOnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgDXMtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgDXMto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:49:44 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5393AC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 05:49:43 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c21so2874454plz.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 05:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uC2/p4RFgTEv6gK1u1RWyAJblPPgS8/cfRxIcvP+Zmg=;
        b=clKYIOnj6AYWFVwxBITX0c2CMkW694tIL60wcNXbq/+dI2JbqlKLUMNfjP6VAAobbx
         gfVm7BJ33VOLjQ/b3enC3ejGD2qszGwLKiP4MMlEndEqghjr9s/r/U2/JX8Egf57DiCM
         9WA7Bf1qtekMoPfdHK9h0befHv23tlsJtZ86OeV/wqpXUsi3weA7xHOLIC6wdxjM6MBW
         VeVHEm1hjAtXzp1NqJztHViymF6DZxxcpEEzTaUXihJlyHG8l/c//Kfvdd3Ikao6QSii
         9y0awom544Yf2Hn6CTdFXL2/YkD7vpbf3gOw5qJonJzoyqhlsEEYIYLsi6/zfoPFxzlf
         fxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uC2/p4RFgTEv6gK1u1RWyAJblPPgS8/cfRxIcvP+Zmg=;
        b=jKhSrvbpvPQiDvvIGm67PrG/JAhVbAjjz+pajew6H72FhGty7Lvs+triYRZ6pkIlLU
         oOiQEKqeM5+XjCC5A43jSc8wojRGJ4MueqHotnmZJIxICJ1OY6Dz5qmwHwnMNpHX/gVU
         nFcZRsvhZYMU39IMaHunpOyJ9LgvqyTbLBadCSSj4esy3dq5qwim1WF+NhCF0tf3N1L2
         4vz8uL23BbW4BThNTkd481KgN5ePptKNQBTHgkaTed4ina735GfZXk98zRZRD1vQr5DC
         P6ir0BYkda71d3yxFGwNx9/LzApxOXCDcQ09Fed2GrmOxB5mDTAeZQ7BLYA48U2xtrb3
         UyMQ==
X-Gm-Message-State: AGi0PuaVDvcg05fM6ml+NtC4rVWnlsspCURvqwG6ObdSgVw9OzfUbg7Y
        VSTGOXeRPq9G1YT5yft8Xjc=
X-Google-Smtp-Source: APiQypJXCFnzC0T8S8VKrymEH2eJrMUjFHnHVDn/zH/MEdUUqEhsA1M/NKla1AzHQGAgogXRhiQCfw==
X-Received: by 2002:a17:902:d70f:: with SMTP id w15mr9109688ply.138.1587732582915;
        Fri, 24 Apr 2020 05:49:42 -0700 (PDT)
Received: from blackclown ([171.60.179.95])
        by smtp.gmail.com with ESMTPSA id u21sm4968911pga.21.2020.04.24.05.49.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Apr 2020 05:49:41 -0700 (PDT)
Date:   Fri, 24 Apr 2020 18:19:26 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     jerome.pouiller@silabs.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH] staging: wfx: cleanup long lines in data_tx.c
Message-ID: <20200424124926.GA17373@blackclown>
References: <20200422153900.GA6184@blackclown>
 <2253201.upfRyW1aZW@pc-42>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <2253201.upfRyW1aZW@pc-42>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2020 at 09:29:28AM +0000, Jerome Pouiller wrote:
> Hello Suraj,
>=20
> Thank you for your contribution.
This would be my first patch to linux-kernel :)

> On Wednesday 22 April 2020 17:39:00 CEST Suraj Upadhyay wrote:
> >=20
> > Break lines with length over 80 characters to conform
> > to the linux coding style. Issue found by checkpatch.
> >=20
> > Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
>=20
> Is this reported by checkpatch? The strings can exceed 80 columns.
No, it's not. Actually I am using vim with some plugins and it was
showing red their. So, I thought why not make these strings in a new
line.

> J=E9r=F4me Pouiller
>=20

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl6i4FYACgkQ+gRsbIfe
744NFg/+K7LCGsRpnJr/OgCb2VgMmZ4KWXENRA5AQ++9O6rqt484dVk9dztC3rhX
82GUJS4hyNpRWpqnREJiJSkklpo7nq9b98rGlBuTu4kEySEclq6ByU3ym4Xq6E3O
wcZazZUI7tuSw4J1qUojOwHhApgHAuK5d8hLoogsPOxk7Ymhlm/1fqXZss6IDOKb
potWtqhYn+ixL9e5/A5GQZGg2MZe+GVdb66/0yc2gIC6EtmSArY1JXsXBwcHaq61
B2se5WCqMkoBK0ZvZqW7IDKBHam6/VP0uhbCaf8SSUK8doKWEc1ALugueiZL+Nxm
oLGhY7Q0Cw2T5xwjxAZxOFU8CWbN+bwVCAens5b4ocamWhiVQ3SjRZQcv++XWsPz
ueKyoNy6zcoC5SfoZGc6zUAGRhrmBb4hROInd3pzuxYYdykynDjkis5rgg2XU1OL
GiKx/kNyN7zyTBHknwZBPAa3T6ZXgzK999R8Zq6BvG75ngf71jO+CcypSyDPuzmz
idDNHLNnxHbX7P7sZ0YbTP4P0pOG3nks/48v+0s75bp7btud+bcnBuVkw3qTE30t
hWXDwtl1qWetpnCy1/9d9RxeiPya28+nL/R9afBtiTqN73QNiPzSfbVS/oEmu3fP
gMQw/YZy2a/6ietO4a73UT7ceSmwL0HnDrqFPghv1lWp6bZSUFs=
=UOYc
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
