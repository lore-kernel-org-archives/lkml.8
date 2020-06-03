Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17CDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB8020734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591178072;
	bh=oeMBR71zS+pMyX9v0fj7F0CkiuWzgIrRNVOKUGSXlBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZavJf3xrI5UmPbq0ZI5suHt0NEu/BbzL5a1Tg0Hpg2C/MgyDk1cvvZnNuDvO7cD9U
	 EIR7P9sG4i49U/GIdxfxi7K3aUIUI/nxCqe/rSQbOnylmaoRjKsKzl9HnyDNxcoV5C
	 JT+Ndg312sIK+KAFABQDwNNLhhUVssH2AQPUrJL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgFCJyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:54:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgFCJyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 05:54:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97A49206A2;
        Wed,  3 Jun 2020 09:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591178071;
        bh=oeMBR71zS+pMyX9v0fj7F0CkiuWzgIrRNVOKUGSXlBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1j09JU8SfYxzcB1rwjgcwH0ZOPQVPHj6TI+nzcBNAFm7EjL8s1ouPqNgoWrY3gs+d
         n3350osjIgPNmYoinUdlA5il9X6PZJBitrjbEk1CvbaLGLPLWEZaKleJOO3XhfRSXB
         aan+nEcRRWKKhwD80fElz3jqPv1xqeZKSWnzM5lA=
Date:   Wed, 3 Jun 2020 10:54:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luigi Semenzato <semenzato@chromium.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        NeilBrown <neilb@suse.de>, Yang Shi <yang.shi@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: fs: proc.rst: fix a warning due to a merge
 conflict
Message-ID: <20200603095428.GA5327@sirena.org.uk>
References: <cover.1591137229.git.mchehab+huawei@kernel.org>
 <28c4f4c5c66c0fd7cbce83fe11963ea6154f1d47.1591137229.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <28c4f4c5c66c0fd7cbce83fe11963ea6154f1d47.1591137229.git.mchehab+huawei@kernel.org>
X-Cookie: Your supervisor is thinking about you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 03, 2020 at 12:38:14AM +0200, Mauro Carvalho Chehab wrote:
> Changeset 424037b77519 ("mm: smaps: Report arm64 guarded pages in smaps")
> added a new parameter to a table. This causes Sphinx warnings,
> because there's now an extra "-" at the wrong place:

Acked-by: Mark Brown <broonie@kernel.org>

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Xc1AACgkQJNaLcl1U
h9CkuAf7BQEahHNY2RtCJ0oStk4GzPzgDuhtsL9o2vxq/A5/CNTfmJ6l3lwIzV6p
RTSoNwkaoN8gXO+tYG14vho8aO4FKLeJKZLUHbwbJkcLDdtDO5uDIH0/Kq2pwJOM
fB6OEiVinHkdFwCmeOClv51/2hX0QzfJpzEo0AsPiOryDA+Rbv/KvuKk/W69lZw/
E0unmZ9MEH7Dq6zssY/Q+ORvpaSmu7MnbUnRpHDmjtqavrnYfCVnZWUF+GhyjO1E
Z9W9iD3N/pIpvUInOfhkGsFjKxZtwX+tKVoYJ3B5/gFjg05wrJXNKqY0Z5CmLsgw
s7dSHPu0BPmIpaCy/6HTAsu5jtgynQ==
=XRbF
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
