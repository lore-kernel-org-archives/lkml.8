Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C721C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63539208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587041263;
	bh=yeNw+BnMqyv/UFDWUbdbO4h/gsiD8l2tqDtETFcX7Fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HGLCrUjzywOJC1y95Jq03zq6EJPSoY9QbfZvT6Y7n8olwV14+dNDoLPuZ8Sov0TJp
	 BUxLtBcQxjhNjSfGTY3zA7PZLq/Jnqnq3el5B7N06mCBebyhh5OmOyI4od+xXamlds
	 yPRi1CPk+foHI9gHszn7RmOBPiDJDErm0ed2WOJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894463AbgDPMrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:47:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2636225AbgDPMr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:47:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2B98208E4;
        Thu, 16 Apr 2020 12:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587041248;
        bh=yeNw+BnMqyv/UFDWUbdbO4h/gsiD8l2tqDtETFcX7Fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RvnUAyD73hLM80c4og8KrGZoj0ybOuXtMCq++hwTZDigwSwOjOac7TRBkwyF7u97g
         xjYuUKpwGSeLjWdL4jSkc/RDRmU0tIs4LjJnhP0L9hhFRYNuU+D/ZwOKXqtG/nx+HU
         XB4au4bwitI5L3sTe0diTIXpcmI32Av6m1mzYQtU=
Date:   Thu, 16 Apr 2020 13:47:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment?= Leger <cleger@kalrayinc.com>
Cc:     linux-spi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] spi: dw: remove cs_control and poll_mode members
 from chip_data
Message-ID: <20200416124725.GI5354@sirena.org.uk>
References: <20200416110823.22565-1-cleger@kalray.eu>
 <20200416110916.22633-1-cleger@kalray.eu>
 <20200416110916.22633-2-cleger@kalray.eu>
 <20200416113539.GG5354@sirena.org.uk>
 <622416308.15749883.1587037855167.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vs0rQTeTompTJjtd"
Content-Disposition: inline
In-Reply-To: <622416308.15749883.1587037855167.JavaMail.zimbra@kalray.eu>
X-Cookie: Tempt me with a spoon!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vs0rQTeTompTJjtd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2020 at 01:50:55PM +0200, Cl=E9ment Leger wrote:
> Hi Mark,

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> Sorry, maybe the commit message was not clear enough but actually
> these fields were not initialized so it does not break anything
> (ie, the default values were always used).

When you remove the definition of the struct and declaration of the
variable pointing to it then the code won't compile.

> > This means that your first patch will break the build, to keep things


--vs0rQTeTompTJjtd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6YU9wACgkQJNaLcl1U
h9CynAf/cERHw1lDgcjGpWKP29Y6t9qpmuSpunVEQfNALtsXedN0p45TjOiIbLK+
AtwUukszTHyTRJSlerBi2WrcIJCbW6iWJFDAqP05OGfIaDsZM01ZE90Z4jETXK6+
adrBGEQYPqbiCjOyHQhOp2mKTdf7rW9DRVvZiN1AEFVSpwX+XnOULanFl62urimI
IvMAND8D5gPOvr0c/1T5tqXjjpte22V1H9C6ym074dHOKmUYjSkMbx0qGcqo7/Il
QKIs1vLX6ZQ2096YEdBvYb9TQ0XHWDucjediRVodoiuMbiKpeLIxVOrfaOuYOQ2g
bl2IYJ1DjmI9U36oShXwn1cEjVpzEw==
=2I3/
-----END PGP SIGNATURE-----

--vs0rQTeTompTJjtd--
