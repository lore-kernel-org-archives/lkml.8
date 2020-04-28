Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D89C83009
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40989206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pM7rz3M7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgD1Mzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726827AbgD1Mzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:55:31 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845BDC03C1A9;
        Tue, 28 Apr 2020 05:55:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49BM7g0ggCz9sP7;
        Tue, 28 Apr 2020 22:55:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588078527;
        bh=Y47UAgUAwN2altZxsVR5r8sQ2CymmGxOKr3zUKWNfCs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pM7rz3M75dursj3FH7FuoCZxCoThX5DOFVapWQlX70HObHiZjpIoLtK4QSyWlDRr2
         90RWNMbArJWXCYbrFyj539JZRUi4uiqFOuFnjH3Ii4plLWwf094SSy8Ya/24w+Gs+X
         WixajLCBFtb6y1qN3ybk9K93FuYOMqv3kd+keptlaowLNDIssrt0bM4QcIzsrgA2kO
         1Lxc76220fHALnEO2HJIws620fuu6GjvDyQ+vQp3a7ryVq0cU61cVXHtnwhQnW8CvK
         usOImGfniilwRPklwvI+OulpGxPQaHGzjtAg7VGBWMQGmoccyl6fHGjsIbD7cCXYpi
         IxkF3cDIIaelg==
Date:   Tue, 28 Apr 2020 22:55:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Malcolm Priestley <tvboxspy@gmail.com>
Subject: Re: linux-next: manual merge of the staging tree with the
 staging.current tree
Message-ID: <20200428225516.59ad9812@canb.auug.org.au>
In-Reply-To: <20200428121545.GA1234722@kroah.com>
References: <20200424151546.4dea83cb@canb.auug.org.au>
        <20200424064555.GA143960@kroah.com>
        <20200428121545.GA1234722@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/c3I6eY74TZKPZPf/lkB_W+z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/c3I6eY74TZKPZPf/lkB_W+z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, 28 Apr 2020 14:15:45 +0200 Greg KH <greg@kroah.com> wrote:
>
> This should now all be resolved in my staging.next branch.

Yep, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/c3I6eY74TZKPZPf/lkB_W+z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6oJ7UACgkQAVBC80lX
0Gwh/ggAnC9mj602XOfR51MrtWaeI6Ip4h0HXHl30uqP+S5avDzQquZz6nPQyxFj
Sqm+DUAWGYteq5pXIbTbB8BIVn7t3RqSLV4QswkJAZ8gTet/Er3fjJwBMhnFds//
eCDGlEeWgqrWpbvIhL8P9p+57O96ZtSgZGiKuTLzZQn8kavB7lj3Kq03mK8cIH96
w0aGkFaw3WqRukOrBtCeW3kQ91xPHsouXwyZF/a2km0pKEFfa7SJKHhPndK81Tl7
7Zrq6VNqLt8otmhNaokvTVrFMr8r4rn9e6eqJgMsfgJSn0rAD6L0bANYVwyHjjJI
mDkzBXEzCHQydPcG0T26jRnyv0dobw==
=DDYk
-----END PGP SIGNATURE-----

--Sig_/c3I6eY74TZKPZPf/lkB_W+z--
