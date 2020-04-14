Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77B3C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCCCE2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404966AbgDND4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 23:56:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:46666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728295AbgDND4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:56:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A30A2ABB2;
        Tue, 14 Apr 2020 03:56:32 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>
Date:   Tue, 14 Apr 2020 13:56:25 +1000
Cc:     David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: clarify __GFP_MEMALLOC usage
In-Reply-To: <20200413191532.6b234b50caea9134fb95a151@linux-foundation.org>
References: <20200403083543.11552-1-mhocko@kernel.org> <20200403083543.11552-2-mhocko@kernel.org> <alpine.DEB.2.21.2004031238571.230548@chino.kir.corp.google.com> <87blo8xnz2.fsf@notabene.neil.brown.name> <20200406070137.GC19426@dhcp22.suse.cz> <4f861f07-4b47-8ddc-f783-10201ea302d3@nvidia.com> <alpine.DEB.2.21.2004061626540.45667@chino.kir.corp.google.com> <efbdbe8f-f4fe-cfc8-4f15-1e19ee0bf416@nvidia.com> <20200413191532.6b234b50caea9134fb95a151@linux-foundation.org>
Message-ID: <87h7xmu3di.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Mon, Apr 13 2020, Andrew Morton wrote:

> I've rather lost the plot with this little patch.  Is the below
> suitable, or do we think that changes are needed?
>
>
> From: Michal Hocko <mhocko@suse.com>
> Subject: mm: clarify __GFP_MEMALLOC usage
>
> It seems that the existing documentation is not explicit about the
> expected usage and potential risks enough.  While it is calls out that
> users have to free memory when using this flag it is not really apparent
> that users have to careful to not deplete memory reserves and that they
> should implement some sort of throttling wrt.  freeing process.
>
> This is partly based on Neil's explanation [1].
>
> Let's also call out that a pre allocated pool allocator should be
> considered.
>
> [1] http://lkml.kernel.org/r/877dz0yxoa.fsf@notabene.neil.brown.name
>
> [akpm@linux-foundation.org: coding style fixes]
> Link: http://lkml.kernel.org/r/20200403083543.11552-2-mhocko@kernel.org
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Neil Brown <neilb@suse.de>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> [mhocko@kernel.org: update]
>   Link: http://lkml.kernel.org/r/20200406070137.GC19426@dhcp22.suse.cz
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  include/linux/gfp.h |    5 +++++
>  1 file changed, 5 insertions(+)
>
> --- a/include/linux/gfp.h~mm-clarify-__gfp_memalloc-usage
> +++ a/include/linux/gfp.h
> @@ -110,6 +110,11 @@ struct vm_area_struct;
>   * the caller guarantees the allocation will allow more memory to be freed
>   * very shortly e.g. process exiting or swapping. Users either should
>   * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
> + * Users of this flag have to be extremely careful to not deplete the reserve
> + * completely and implement a throttling mechanism which controls the
> + * consumption of the reserve based on the amount of freed memory.
> + * Usage of a pre-allocated pool (e.g. mempool) should be always considered
> + * before using this flag.

I particularly don't like the connection between the consumption and the
amount freed.  I don't think that say anything useful and it misses the
main point which, I think, is having a bound on total usage.

Nichal's previous proposal is, I think, the best concrete proposal so
far.

NeilBrown

>   *
>   * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency reserves.
>   * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
> _

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6VNGkACgkQOeye3VZi
gbmUqw/+IOvlNMYdYcojRcEW8VsmDaByc7Fki5Jdl5TdAVpGjzkO5hvJmpJ/kegK
Sp3MFIDL0ZKCSXLR5oMivlxj9fs3Kp0hSZKakT3HGb4rKOPtvrdOlEJwtK2n8QuZ
WG3gUivxitP/jVra95l0YMjWdByaks1A2LUuCkSRFXTbXxNCbTtsejOSQZ1nHNmw
aNDPza3HVLBTs/7C1ddI9yERlangq2OpTRneubVRA8b92naJ7eszVnree/U0C+YK
LlhfsBoHe/VR6US2Ow5Z8O+d3S73+a71q+6RKfJFjwRRIkVih+j9aWMZS0kwvW5h
zavZiWweRw9naOvm2i4VR+09Lyo3GJmMDLAAvgdGTE8wR7bzQ3dh2pKG5llhnWvB
MFyyru3xl3kwcb7MnAU9wPTraK17P6IDzjHdIHfYv/hge5QvO6kvJUpYkOaRke1c
ZTK9pzNsaFn16d0mbktyAadIXZ05md0DZ4uFr0Yz36RoOWL4YP7mo5TMM/ZXkTPc
AXlAY2YnXrEhGazhNTv8cJFqgmpaydcYPDoFX6KbeUYXMtGlwDvTgN8O18bXruGr
Z7C/M5C4Xbxr5y/ZST5VrgY61oYQeOSMzQ0TXpH0OCEx7luaFQYs+KMU1QynsWDS
lS/vwruSb7QjUy5xSAUru2sOGgeEQe4tAALoCVaChEL0QU3e/RI=
=6JJt
-----END PGP SIGNATURE-----
--=-=-=--
