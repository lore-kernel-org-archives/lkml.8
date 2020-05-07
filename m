Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C17C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BEE320CC7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKCgobvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgEGUHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726326AbgEGUHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:07:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEF3C05BD43;
        Thu,  7 May 2020 13:07:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so7934833wrt.1;
        Thu, 07 May 2020 13:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SIPxEGkoigO/RdOn28FMwPwqLB9D7Bf2pDVWj4s0qzc=;
        b=BKCgobvvRk12sNHbQdFp+jiN+mhqDLIsgN1BPt5/gOiz6w7q/RC36egt8JkAzGEfB2
         rmw4ZCtt4ohfBNhFThzB8aMSnGCBgUATdSDMswU0j9M7NqMYFhjSxTsl7+wf0XvS6KRP
         fG1xdg7y/0KiBK5yZMXDS4xFB5o4jIMi6Zv/5FLMDely/LqMO+GIoMPTyLC57O4ehli9
         lf3OvA5mjrsOue86jHJzdbdsmqGjuuH1xDP7+989AKT2RVoltDdc+C6qZjcTJzt3ndNE
         168Y43cITyDVhe7QmPGuIdO8MLIliZF6yB6sNWga9oyqdjMJw337OUCZsQeyLediPkHt
         T+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SIPxEGkoigO/RdOn28FMwPwqLB9D7Bf2pDVWj4s0qzc=;
        b=Cb0TCZScrH/D0epUkn+QqwJdhtNDc7qDY37K6I0OFo7Dfv+zvcCSw69doMh5Cp5CNu
         V2Me49vr/IRllWSE3WdIJwxwZUhV2Jop/Qu5n64H22RYLK93yvZ2QlYw9WFkviKpY/ux
         blaCOwUA9y20A6eilYtwmJ1kxZyOpfTOedtBqMyXq28hEo/QShUQUiVGRZuNsFHFiqd6
         eIvGBR+geZSsUsMKafq3i5aq7sijlK93UTGKs1oQg3MKoYdhoeWx4jcKPyPmUTs3Dd2d
         tQoDd14Smz4Z6RQNYlu/Ae4auZxGlBeWyFKVODCo5WbdSdd1JzPX6J249n1BkCkYpkhM
         J+2g==
X-Gm-Message-State: AGi0PuaEwiHMGownWr8uQmF2fMnc/uDFNJC7cKd03QltryPLC5Cbagmp
        PgfR3YVXSKZT3kjGxfmbRoRjVt2aing=
X-Google-Smtp-Source: APiQypI8cqMnwNEw1dPA8CPIiiM5LeFDJj/l6ggkxKJc3616ZPFx9eahE4EJ1H2wPJFUTJw/ziTj3A==
X-Received: by 2002:a5d:4447:: with SMTP id x7mr17126025wrr.299.1588882040490;
        Thu, 07 May 2020 13:07:20 -0700 (PDT)
Received: from localhost (p2E5BE57B.dip0.t-ipconnect.de. [46.91.229.123])
        by smtp.gmail.com with ESMTPSA id 185sm10472035wmc.32.2020.05.07.13.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:07:19 -0700 (PDT)
Date:   Thu, 7 May 2020 22:07:18 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Joseph Lo <josephl@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] memory: tegra: EMC scaling is not a clock provider
Message-ID: <20200507200718.GD2981633@ulmo>
References: <20200506123236.7463-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline
In-Reply-To: <20200506123236.7463-1-geert+renesas@glider.be>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2020 at 02:32:34PM +0200, Geert Uytterhoeven wrote:
> 	Hi all,
>=20
> The Tegra EMC scaling support code is not a clock provider, but merely a
> clock consumer, and thus does not need to include
> <linux/clk-provider.h>.
>=20
> However, drivers/memory/tegra/tegra210-emc-table.c relies on
> tegra210-emc.h to include <linux/of.h> through <linux/clk-provider.h>.
> Hence the first patch makes <linux/of_reserved_mem.h> self-contained
> first.
>=20
> Thanks for your comments!
>=20
> Geert Uytterhoeven (2):
>   of: Make <linux/of_reserved_mem.h> self-contained
>   memory: tegra: Drop <linux/clk-provider.h>
>=20
>  drivers/memory/tegra/tegra210-emc-core.c | 1 -
>  drivers/memory/tegra/tegra210-emc.h      | 1 -
>  include/linux/of_reserved_mem.h          | 1 +
>  3 files changed, 1 insertion(+), 2 deletions(-)

Ah... I should've read the cover letter first. Looks like I need to take
that first patch through the Tegra tree as well to avoid introducing the
build error in the second patch.

Rob, do you mind if I pick up patch 1 of this into the same OF branch
that I already carry the memory-region-names patches on?

Thierry

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl60anYACgkQ3SOs138+
s6EaEw/9EGmZ4wRdJQnZKEPfSrkI8ezYGzEWDNRp9OC17IzFf2+rDPyHkuM6zynx
sqWhXQeersjdUCJLMyRStJ47/ismsDY9Dsi/Y52S1Bhc9PibFbKO6GsEOUyiRaSa
FQJX/LstrlkGtTsymCp7rXw1SnneQg4StyPI7pXmoNBZafCEdRVHAUt5atl3dKO1
vPQolPeuzA9oaizomcnPKM2eY7JXxWw0J/ZnphMRcpPLkNXdGLcKb4IZocBS9DcX
Qd/4Ipk5jMR4lILYOHweJFHV3FagRj8GSO/cotDSDPlPdxYPQF1XDNTRau2FAuv0
fdft30qVrMr4XwZW5opTxafv90UZJXXtchexfUMx+SBgtQ8DGy1PLiNbKxyQjbcD
SqKNNKIoz3LdcKv3PTBSmIsdROOPoKtO0lSTR3lqsc1gMWt/RVdnIoffOupFFxU/
FLoXWUfbQojhjUg7NME0ViUVaJDrORqbbH6Wq7F7zNBTBJJPq+pC1G4jkvvuFmvG
0s//QGxgO8hoZOE8++1pw+F1fybzkGOiDATBCxFBllutuHq897y9sgIk6FquRud4
cf8wdwJ+fOAH1eHMTr/U3TXNMKm3YccLNYY6Iry8xDGU3/vAk8MsUrFkFKLSMIm5
Lxd5rMApw+T2sZX2BDThuWZN38gotqCZhJbgBl0b/P1PnclP1IU=
=qNDk
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
