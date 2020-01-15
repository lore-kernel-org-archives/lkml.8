Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A509C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C99A2081E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579079193;
	bh=TlipcFSkPnB+rn8eJxZApV6GeostnJsb/5QfdM7+XD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=OlBoaQf6YBEU+zcd5xlUJHCy9LJFd3Xa2gopHlmFAI9Q9CkQmVot54IydgAYRnz+3
	 ILsVii2SlRfRCMjGh3tgo4wfB7CovPedqNcsqx7bvGvCr0CEGkXoeuYKkjyNtzvQPa
	 tmxtM3Hhp1MdVzhS6DC/aPa/CCHEP2INwg/cR32A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgAOJGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 04:06:32 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44825 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbgAOJGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 04:06:32 -0500
Received: by mail-lf1-f68.google.com with SMTP id v201so12088178lfa.11;
        Wed, 15 Jan 2020 01:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=6AldIE67S8Ag3ULVZL8qb57JXlXSeD4TiXfBseUC3zw=;
        b=Z+5x34kwyxz0nFpBsx92Q0nKhwW1ETXv7xfMI+K8Nl3cSq41eC3BGxeHUTT6fCUCbQ
         6jNd8CJezyj8xVX7NnV6rbbb5qet5llzNyBEASl+wWtjcXJ1J09i/BQjVRlin2Z8/WxX
         px9rQzg8KVyI4utYsMUzfQ/PT7GSO5w3zbqIMPla5Sop3hYyW1LwLVEmkq2GqnCiPFki
         gUEzi/QznEr68+sYeKDSh36ogDWMIknLloOkqKEmEa0WiBq7opTtaNNCsVP0XpIPgcNk
         anCoMtEfCP5Y5KYcanfqi/4QQjuhTvTWAoZ8qjhGVnN3PQ9LdggIpuU/RdsIXBVr9W72
         qIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=6AldIE67S8Ag3ULVZL8qb57JXlXSeD4TiXfBseUC3zw=;
        b=ta5Npbz+SCxmk/AQyLRqzkckvmYKx1X/+diAgjyjqW2sWCG5+ehonNyUQ/NvpvWj0/
         RO9eXz8qGZasC0sx4tOsF8lfuIOTi7bAdGgpDe4Zv/h1iCz+RLZVSe9FWw3BE7YOrT8x
         BEHo/ABEAwEDbpngzrKBYYfHeTk3pGTW1Ce1tharVxWnih4hHhJXG+zKJ9IuMfk/HZI7
         r45UlwCAL3W5MLovoVlqjNWsVpKA8sCqOLSXnBzKQ4s7TalYqnucccIlGYEdPIDrAjgA
         Q7NYhPuqBrkSr5XF20+ZYvwcJv9oKf59RYVNiox3Zic+LC+Pc7Ym1vpszpsywc8Ff38w
         ckDw==
X-Gm-Message-State: APjAAAUWeLMMgU7m7b0reng6MIrL9vpxMO8po79p/yM8b4JuPaBLvQwF
        p3jGePnV3iWE2aoSqVLY7x0=
X-Google-Smtp-Source: APXvYqzEcr7K/+984fd8BDcQrV2NM9ZufnTiP/jJatQSOrRYDNtGwYh4PyRjMXSiJ/90sron88cdgQ==
X-Received: by 2002:ac2:46c2:: with SMTP id p2mr4030621lfo.139.1579079189701;
        Wed, 15 Jan 2020 01:06:29 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id f22sm8879991ljh.74.2020.01.15.01.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jan 2020 01:06:28 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     Jayshri Pawar <jpawar@cadence.com>, linux-usb@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        rogerq@ti.com, linux-kernel@vger.kernel.org, jbergsagel@ti.com,
        nsekhar@ti.com, nm@ti.com, peter.chen@nxp.com, kurahul@cadence.com,
        pawell@cadence.com, sparmar@cadence.com, jpawar@cadence.com
Subject: Re: [PATCH v2] usb: cdns3: Add streams support to cadence USB3 DRD driver
In-Reply-To: <1578733666-354-1-git-send-email-jpawar@cadence.com>
References: <1578733666-354-1-git-send-email-jpawar@cadence.com>
Date:   Wed, 15 Jan 2020 11:07:30 +0200
Message-ID: <87eew16qb1.fsf@kernel.org>
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

Jayshri Pawar <jpawar@cadence.com> writes:
> This patch includes streams implementation changes.
> The current changes has been validated on FPGA platform.
>
> Enabled streams related interrupts only for streams capable endpoints.
> Processed  PRIME and IOT interrupts related to streams capable endpoints.
> Based on PRIME interrupt prime_flag is set and transfer is armed
> otherwise just adding request to the deferred request queue.
> For streams capable endpoints preparing TD with correct stream ID.
>
> TDL calculation:
> Updated tdl calculation based on controller versions.
> 1. For controller version DEV_VER_V2 :We have enabled USB_CONF2_EN_TDL_TRB
>    bit in usb_conf2 register in DMULT configuration.
>    This enables TDL calculation based on TRB, hence setting TDL in TRB.
> 2. For controller Version < DEV_VER_V2 : Writing TDL and STDL in ep_cmd
>    register
> 3. For controller version > DEV_VER_V2 : Writing TDL in ep_tdl register.

> Writing ERDY with correct Stream ID to ep_cmd register.
> Added stream id related information to trace logs.
>
> Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> Signed-off-by: Rahul Kumar <kurahul@cadence.com>
> ---
>
> Version History:
> v2: Patch generated on top of linux-next.git master branch
>
>  drivers/usb/cdns3/gadget.c | 533 +++++++++++++++++++++++++++++++++----
>  drivers/usb/cdns3/gadget.h |  26 +-
>  drivers/usb/cdns3/trace.h  |  93 ++++++-
>  3 files changed, 596 insertions(+), 56 deletions(-)

This patch is enormous. Are you sure there's no way to break it down
into smaller pieces?

(Hint: there is)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl4e1lIACgkQzL64meEa
mQYVOxAAxyx6gyof7t4YhI8gU6cxEASdvVcAhH1XX/0RYvzuGiWC1YrfS2c/rjMh
ieX6K+QHUmi46cL8T4HosQoHgd6X8cRQKMk8y2ovvgcEi7tXj7uMMMA4UJ9eso0x
iv1qxVX+nPZ0S4Kde9rYEhwArOYj98a4vrevT1wHbjJX7Iz0HV5U+m+qV2mLUukJ
DlvRXmh/xJB/6O69SmW0iZe97+5EWC3nJoicKLvE8X4wPHQKbok1rGA8/K4wgjr9
jxOmOvdvGbGQWT46Dha2OYtfhzOCd9wr00eFgtSmguIt9ZHGtMT6r4z32uKadI6b
g4bgvrY6b+IfU23eLu5UfG+/YxeZ5mZOH0j2lG9abG27p4xb43P3p9ljVMeeOFm9
JccVxY1IxHaYx0wgn+nyugow2YW2l+Iu9Mw6XyEcjdd2xrUMPt1+Os4USpvkOWFr
eJPO711lQtF9SWuTqqrtEi6QMuqpXKqOgPJROHYru8sOEmMQWmD9DcrTNca1WOA0
ks1zfCn+SfN8wxSQUkF/SEHD8XQTYAljuIpQgesp/L+Ld7xbCWM/CLgl7GcIjLQ9
TDIbYpktx4hiLKVcfmIVrMknxe2A46nRXlYIitPdfYQeWbLFQH4tNS2TSr1FS9iQ
Aa+09zKLoxZQ0jXwWggoXqC/60cjm4kjzDrXJ4mzlOGV2mhgJlY=
=BZ2r
-----END PGP SIGNATURE-----
--=-=-=--
