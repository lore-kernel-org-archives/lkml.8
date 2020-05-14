Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE87C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F0A2206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589435724;
	bh=Gefkr/r0GHwqvUeH8jI0ZEqLMmeQpo78dIsv6zpJkSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GcI9+ttThs7Ev2nxWJMGI8+FjoNMgkdvxYcKjgb9pN/Ji2//o3ORWw1f8bL/pgv1K
	 q6hmh98eqvG5dyiyN0v1m6oW3bY998GMMHTekQJzysz8juTAX8PimAyGZThXP3Eyk0
	 fFxTQ2gpx8NlM6rfgX8ABxS1oF1YJe1Gsw2t9glA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgENFzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENFzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:55:23 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6375205CB;
        Thu, 14 May 2020 05:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589435723;
        bh=Gefkr/r0GHwqvUeH8jI0ZEqLMmeQpo78dIsv6zpJkSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCCr6Hz8L3mbvGDqVFfuIoxfA0tcFlEXAJMz5spHXGVmws2miwZ8zbJx09bUlDikV
         nm59qlRHX1A079MvMQkUW9Gqc5JMG/3LYu0VD0hOGYsgOaj6pL6PVV7K/5P40r19pF
         GC4JDsRPuFfHhER7apa2ZpBBnfLcI/mWw9/LJZQs=
Date:   Thu, 14 May 2020 08:54:53 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: linux-next: manual merge of the mlx5-next tree with the rdma tree
Message-ID: <20200514055453.GB4814@unreal>
References: <20200514125920.2c9a6509@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20200514125920.2c9a6509@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 14, 2020 at 12:59:20PM +1000, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the mlx5-next tree got a conflict in:
>
>   drivers/infiniband/hw/mlx5/main.c
>
> between commit:
>
>   2be08c308f10 ("RDMA/mlx5: Delete create QP flags obfuscation")
>
> from the rdma tree and commit:
>
>   14c129e30152 ("{IB/net}/mlx5: Simplify don't trap code")
>
> from the mlx5-next tree.
>
> I fixed it up (the latter change included the former) and can carry the
> fix as necessary. This is now fixed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.

Thanks Stephen,

The mlx5-next branch was merged to rdma-next tonight and this conflict
will disappear in next the linux-next.

Thanks

>
> --
> Cheers,
> Stephen Rothwell



--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQT1m3YD37UfMCUQBNwp8NhrnBAZsQUCXrzdKAAKCRAp8NhrnBAZ
sVp5AQCWsaVBheeQlJl3R/ExXhcUFhY6e0UK+ZtM+y2Zrn0f+AD/Wsb7L9MFNTqu
yTlb2xUeHe65os1kUqjxcCWtYhIdvQA=
=1tUC
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
