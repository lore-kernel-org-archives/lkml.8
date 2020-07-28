Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBF5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E2CF2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qtJfTQPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgG1WJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729437AbgG1WJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:09:43 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFECC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:09:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BGW774wLsz9sRN;
        Wed, 29 Jul 2020 08:09:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1595974180;
        bh=GtQKqS56rbGuEngoZZl9eSmyomkOxGE6oG7NCzMdBqI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qtJfTQPCxoUA7nC6yDpixO62T3rDnRoO/rxAdIOkMdZeu3h5TkBDEh01+uXfuqKlN
         IWKuTnZwa6gNYwI7Q3qmL7SCfrYZRo93jLKF/tLDQBd0I74//7K1ObsAIclVUispwi
         WO2B7Q1ZTNXZJrEGrrCM4z9/76i/UIVLHitSLNbS7rNTj83+4ju/kx6zyfHJUlav0k
         Jx6f4DJRfx+ghJ5DZ1iTdTwi8BjxYxaqxuCObALPqW/whAwgSzwQpohdqbgwIn/8nE
         U2rR2Df7V9tXtF8QC0aejDcGy9QskjYbsw4GOAOeA7QElFD2Uf2zdw5lmghuWD9+2j
         XUYhteqcFL2gw==
Date:   Wed, 29 Jul 2020 08:09:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Oded Gabbay <oded.gabbay@gmail.com>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Moti Haimovski <mhaimovski@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        Ben Segal <bpsegal20@gmail.com>,
        Christine Gharzuzi <cgharzuzi@habana.ai>,
        Pawel Piskorski <ppiskorski@habana.ai>
Subject: Re: [PATCH] habanalabs: fix up absolute include instructions
Message-ID: <20200729080938.29fc5ef8@canb.auug.org.au>
In-Reply-To: <20200728171851.55842-1-gregkh@linuxfoundation.org>
References: <20200728171851.55842-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ugKFdQ_8UHjUMU/F0Ie2JVx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ugKFdQ_8UHjUMU/F0Ie2JVx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, 28 Jul 2020 19:18:51 +0200 Greg Kroah-Hartman <gregkh@linuxfoundati=
on.org> wrote:
>
> diff --git a/drivers/misc/habanalabs/common/Makefile b/drivers/misc/haban=
alabs/common/Makefile
> index 97d03b5c8683..b984bfa4face 100644
> --- a/drivers/misc/habanalabs/common/Makefile
> +++ b/drivers/misc/habanalabs/common/Makefile
> @@ -1,6 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -subdir-ccflags-y +=3D -I$(src)/common

I've seen oter places use

subdir-ccflags-y +=3D -I$(srcdir)/$(src)/common

which would probably work as well.  i.e. just change this in the
Makefiles rather than every source file.

--=20
Cheers,
Stephen Rothwell

--Sig_/ugKFdQ_8UHjUMU/F0Ie2JVx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8goiIACgkQAVBC80lX
0GyaYwgAgAW+KEyAuc28guqGjeCvUyRJVlpD8HWEdlCPWaJQMtJzi4R0+atPiXH8
njEsTWzUapSOeVZvaFVtSCJLY1UPEkG6fqu2gOvZRgK28dyUAmkc4UkQFMdIG5R1
RWbBRiVdLGHrPXOQVmEXHiwI7A1msvUTNGI/Od8UI/6GqA/raqkJZzJ+p1JQZYV2
JXiLUi4cbQTgq8HQ2uRJL2BU5zvh7tRaIY9B9stNUw2RQu+npu/JLSMO5jViI6dv
6V7bvtwK96jAAXZBUACD462Nw/DDDCdcJbOAjYPMDrh9rigndkNDWJ5765M/IWYw
wpDsf/UWMFi/vwZuWL17PKSSp9NtTQ==
=vgr4
-----END PGP SIGNATURE-----

--Sig_/ugKFdQ_8UHjUMU/F0Ie2JVx--
