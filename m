Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2246FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1ED92080D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ImfLOYPi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Pg957yMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgGIQdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:33:01 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49050 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726408AbgGIQdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:33:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7282A8EE2B9;
        Thu,  9 Jul 2020 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1594312379;
        bh=+o15DNSiZ8Sr9PsZmCDjs8laU8OpdoFNPKkvUnrn3w4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ImfLOYPiXanR4Li+u0eqxVAkMNOpoOHx8W8yy/PXgdyxrnqFIXh1GHL1dP+EvhNeC
         nIqctrQPMTxAvypO5hbSmxQJV9wSV4yCG+qQIxpDuK1U68i5QTsPI/ykdp60NIB34e
         QAf6YQuGIrsnj1yZZxLavmM8NXIB7/sLzs8GFqSA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WXVlrLr6uDsZ; Thu,  9 Jul 2020 09:32:59 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6FDC18EE116;
        Thu,  9 Jul 2020 09:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1594312378;
        bh=+o15DNSiZ8Sr9PsZmCDjs8laU8OpdoFNPKkvUnrn3w4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Pg957yMR5J0H5kKGQbp+8OVHyS0RtnK3Uw+tWVlPRzPH3/V2ixOY6++uv51M84E95
         AA5Hv5ARWfb7ue7KIh0OEFy9FTA2RbUCtHXXqD/EN4Z5mLIIciRGerGCLVmmlDuR7M
         n3hvgHj151uNJ6y9Ab/m59OtsSmZ7jxO+5Dd8tzg=
Message-ID: <1594312370.10411.9.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>, Tibor Raschko <tibrasch@gmail.com>
Date:   Thu, 09 Jul 2020 09:32:50 -0700
In-Reply-To: <20200709161351.GF4960@sirena.org.uk>
References: <79214066-3886-e0ef-f26e-8cb3d53404be@linuxfoundation.org>
         <e41ded21-1432-afa8-2e42-e509539281c4@gmail.com>
         <20200709124327.369781a0@coco.lan>
         <93fc3afb-8c3f-0fb9-3b92-adfb6571e060@linuxfoundation.org>
         <20200709161351.GF4960@sirena.org.uk>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-zROEZHrj0k+UJe0IHmv7"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zROEZHrj0k+UJe0IHmv7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-07-09 at 17:13 +0100, Mark Brown wrote:
> On Thu, Jul 09, 2020 at 10:01:18AM -0600, Shuah Khan wrote:
> > On 7/9/20 4:43 AM, Mauro Carvalho Chehab wrote:
> > > For coherency, if "blacklist/whitelist" won't be used anymore, an
> > > alternative to graylist should also be provided.
> > What is "graylist"? Does it mean in between allow/deny?
>=20
> Yes.  Typically it's used in situations where you don't want to deny
> something but might for example want to do extra checks to verify
> that things are OK.

greylisting was originally pioneered by email.  It's where you
initially reject an email but remember you did so and then let it
through if the retries follow an RFC mandated pattern.  The technical
use spread from there since the technique (treating something as
untrusted until it proves trust) is very useful.  It has its origin in
the English idiom "grey area" expressing doubt or lack of clarity.

The etymology of "grey area" is a grey area, but I'd bet it has to do
with not having the clarity of black and white ... but is equally
likely to be tied to Yin and Yang.  Grey is also used in England to
describe the lack of clarity given by mist or fog (he woke up and saw
the world was very grey).  I'd say we just leave it alone as too
distantly related to any problematic uses.

James

--=-zROEZHrj0k+UJe0IHmv7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCXwdGsgAKCRDnQslM7pis
hWRRAQDBaOwf4fMhuRZ2OzU+UXPjddWGvKKqosk34PrEH9p73gD+POAP0bN+oRJt
IPmwxHhJaiP4NL/+tFCzSl96XdprHnQ=
=M6ph
-----END PGP SIGNATURE-----

--=-zROEZHrj0k+UJe0IHmv7--

