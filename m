Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDA3C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDE0208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="Rix8BlEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCEKjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:39:46 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:9732 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgCEKjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:39:46 -0500
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Mar 2020 05:39:45 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1583404784;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=lAG5oOfZYa0ZZc4Uadd+FIbLaL5zY+h9aowSlE+qW80=;
        b=Rix8BlEqNUpw/rhC0RenKg19D4PTTTY3qR8zkon2ki034WlVYz6UsGdCcnrHysL4wv
        lU09RfOsv+0nFXrM6cSv/QKoM83eEBWQ8xGPePJhieTCnQS9AMQD5OB3HpdLh7isLL9H
        pUbZcgwFHNpePIv1pqkaAjWRMbb17i3jCs1xHHwMbY2iENHtz3pj1tNB6Rfr4cYQfycq
        zXECcr/KCDFufQc3oWNvyPRazBLHeUEsHin600aov9yAm9kQLQemHkurc4bOKLsp4a5s
        gjPXWLITs8swYsFcZLAvdsR+Y6Ux9MxPiiKP9aF2PsHEhYDJeqrDp3sHRyUomPzWEB+Y
        V/ng==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDaJfScGJUh"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.2.0 DYNA|AUTH)
        with ESMTPSA id Q01030w25AXfWvr
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 5 Mar 2020 11:33:41 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Andrei Botila <andrei.botila@oss.nxp.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] crypto: xts - add check for input length equal to zero
Date:   Thu, 05 Mar 2020 11:33:40 +0100
Message-ID: <4145904.A5P2xsN9yQ@tauon.chronox.de>
In-Reply-To: <20200305102255.12548-1-andrei.botila@oss.nxp.com>
References: <20200305102255.12548-1-andrei.botila@oss.nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. M=E4rz 2020, 11:22:55 CET schrieb Andrei Botila:

Hi Andrei,

> From: Andrei Botila <andrei.botila@nxp.com>
>=20
> Through this RFC we try to standardize the way input lengths equal to 0
> are handled in all skcipher algorithms. Currently, in xts when an input
> has a length smaller than XTS_BLOCK_SIZE it returns -EINVAL while the
> other algorithms return 0 for input lengths equal to zero.
> The algorithms that implement this check are CBC, ARC4, CFB, OFB, SALSA20,
> CTR, ECB and PCBC, XTS being the outlier here. All of them call
> skcipher_walk_virt() which returns 0 if skcipher_walk_skcipher() finds
> that input length is equal to 0.
> This case was discovered when fuzz testing was enabled since it generates
> this input length.
> This RFC wants to find out if the approach is ok before updating the
> other xts implementations.

It may be a good idea to consolidate that. However, changing only one=20
implementation is not good.

All XTS implementations would need to be converted then.

Ciao
Stephan


