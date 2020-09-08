Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5B2C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2500B204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbgIHUF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:05:29 -0400
Received: from shelob.surriel.com ([96.67.55.147]:42312 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730359AbgIHPV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:21:58 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kFeo2-0006cU-Li; Tue, 08 Sep 2020 10:41:10 -0400
Message-ID: <7ed82cb06074b30c2956638082c515fb179f69a3.camel@surriel.com>
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
From:   Rik van Riel <riel@surriel.com>
To:     Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>, Roman Gushchin <guro@fb.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 08 Sep 2020 10:41:10 -0400
In-Reply-To: <20200908143503.GE26850@dhcp22.suse.cz>
References: <20200902180628.4052244-1-zi.yan@sent.com>
         <20200903142300.bjq2um5y5nwocvar@box>
         <20200903163020.GG60440@carbon.dhcp.thefacebook.com>
         <8e677ead-206d-08dd-d73e-569bd3803e3b@redhat.com>
         <7E20392E-5ED7-4C22-9555-F3BAABF3CBE9@nvidia.com>
         <20200908143503.GE26850@dhcp22.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-HmZ0JwxcSySelV603cbZ"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HmZ0JwxcSySelV603cbZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-09-08 at 16:35 +0200, Michal Hocko wrote:

> A global knob is insufficient. 1G pages will become a very precious
> resource as it requires a pre-allocation (reservation). So it really
> has
> to be an opt-in and the question is whether there is also some sort
> of
> access control needed.

The 1GB pages do not require that much in the way of
pre-allocation. The memory can be obtained through CMA,
which means it can be used for movable 4kB and 2MB
allocations when not
being used for 1GB pages.

That makes it relatively easy to set aside
some fraction
of system memory in every system for 1GB and movable
allocations, and use it for whatever way it is needed
depending on what workload(s) end up running on a system.

--=20
All Rights Reversed.

--=-HmZ0JwxcSySelV603cbZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl9XmAYACgkQznnekoTE
3oPusgf+KYtjStpu2k6nGhAuqUIseqcegs+043d5sH5mf1WmjXjYBhXiW678SiXK
J137Qohunxq1FcxOp6kiTjvh7PUotCSD4pa90valFEt4jkZz8G1EXk1aumwBp03W
KKEafjxD2lBm29k8vujhDI1+SUiH6tqi5iNENXgkpm19ytGU7/4uwUgcOhojT5tX
c+tZM0a17pCICjWBmHkUMxflUpkOFg2uLRrceWnH7Tlb4dJzGvkp2XMmbj9/k0Zt
k2tfQqGRgi6VKEziAQ3J3cVbudHXXkOx/3wlp2iCEzhdSugFNgnkxWXPaRWEvGlr
22DoGnG2WXhCZFDcNu/BC/NkAQ+ucQ==
=h2Ab
-----END PGP SIGNATURE-----

--=-HmZ0JwxcSySelV603cbZ--

