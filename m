Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB33C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 03:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBFE0206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 03:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVLaB/gC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgELDso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 23:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725892AbgELDso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 23:48:44 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF31C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 20:48:42 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x8so9900920qtr.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 20:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version;
        bh=5n6oxKBMVWx60og62lkJZft41oxpnNerVi+unngwoHA=;
        b=qVLaB/gCHZnYpvyak3zXsNxqXEbCRkuc8oJhxATrqS5TqrZcJqAdG8Fc2wVgnTqJNS
         peeEYBoyICAZ95H3eIAkBiEoIxNNQ2YkLBS78lx2pEWAB6q7pdXWp2YFrYQ9RO6PSM3B
         raQJgsuVlT0Qv5uhnyCI6hSWlKqyw3BdB+YXmS+Xjmy0nQLrxKCPUxTCCv6BkiuTq3jV
         TEd9RvZvvGjQ0UgVQAJ27Nt9XlOUnZI83vvAMmp6vjFzw1WYir+F3ODrlsWrGnST2xFX
         Uz444K+iVu9X7jae/3GCuME1uARtUsUbInj6TmXzRg3nVYP7VPavuTwKBa0rUyHK+QUb
         //9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version;
        bh=5n6oxKBMVWx60og62lkJZft41oxpnNerVi+unngwoHA=;
        b=JYOb9TZOyMJ4fHYoNDVNwgbX73rPVTs9Qga6q4iwhekflk0qqHMzG1e36zzBIk5Ncy
         sr3++MpApnK4+JND81X7NZ3dP7thWVBVnVvJ0rJFeowt5/GO5zdsH8w79cAbITWoWPlh
         BsAptNaQe01i3B/ctoUFWwdEsl2nPuQUu+M2wiRLw6KARMwEfoRFnqS3gtQz5mCSJ1j6
         1WC1pv1eoX1fncK71p24+UXB0myxNPL2LqJfhZgyv9hBGf3Xw2+ECOrQcK16jlHQHJRk
         PrCR8M4E6CChdSdse8168mzTsbl7q3hDWY0C+34Rk1ymZF9ZmG44/Dm54QpdtWKyknaK
         Xg5Q==
X-Gm-Message-State: AGi0PuaYBXiYUplribSQRlgDxMFdIOWjLDDs7zd5Tza4NyavBDJAINyN
        kJDIN/9fkxRd1/q6BmroSVbs1Gog
X-Google-Smtp-Source: APiQypIHxD9o4naWzpwiO7jiQkdx1FGK6nxiI2U65jKm3mAquoGEZw8ubeU7uvcDocVVsdGPh2jGPA==
X-Received: by 2002:ac8:739a:: with SMTP id t26mr19487947qtp.311.1589255321911;
        Mon, 11 May 2020 20:48:41 -0700 (PDT)
Received: from LeoBras (143-255-224-253.dynamic.desktop.com.br. [143.255.224.253])
        by smtp.gmail.com with ESMTPSA id d4sm10580366qtw.25.2020.05.11.20.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 20:48:40 -0700 (PDT)
Message-ID: <f967cab2b473406ee6427f40109c85d46b438271.camel@gmail.com>
Subject: Re: [PATCH v3 1/1] ppc/crash: Reset spinlocks during crash
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>
Date:   Tue, 12 May 2020 00:48:28 -0300
In-Reply-To: <20200409002726.GA5135@blackberry>
References: <20200401000020.590447-1-leonardo@linux.ibm.com>
         <871rp6t9di.fsf@mpe.ellerman.id.au>
         <02e74be19534ab1db2f16a0c89ecb164e380c12a.camel@linux.ibm.com>
         <1585895551.7o9oa0ey62.astroid@bobo.none>
         <fb98f346a4d6a9d689ae64dae33cbd45d2f8b0df.camel@linux.ibm.com>
         <87v9majhh2.fsf@mpe.ellerman.id.au> <20200409002726.GA5135@blackberry>
Organization: IBM
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-4yilsMbkz+4cNur9Wxoo"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4yilsMbkz+4cNur9Wxoo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Paul, thanks for the reply!

On Thu, 2020-04-09 at 10:27 +1000, Paul Mackerras wrote:
> On Wed, Apr 08, 2020 at 10:21:29PM +1000, Michael Ellerman wrote:
> > We should be able to just allocate the rtas_args on the stack, it's onl=
y
> > ~80 odd bytes. And then we can use rtas_call_unlocked() which doesn't
> > take the global lock.
>=20
> Do we instantiate a 64-bit RTAS these days, or is it still 32-bit?

According to LoPAR, we can use instantiate-rtas or instantiate-rtas-64.=20
It looks like we do instantiate-rtas today (grep pointed only to
prom_instantiate_rtas()).

> In the old days we had to make sure the RTAS argument buffer was
> below the 4GB point.  If that's still necessary then perhaps putting
> rtas_args inside the PACA would be the way to go.

Yes, we still need to make sure of this. I will study more about PACA
and try to implement that way.

Best regards,
Leonardo Bras

--=-4yilsMbkz+4cNur9Wxoo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQJIBAABCAAyFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl66HIwUHGxlb2JyYXMu
Y0BnbWFpbC5jb20ACgkQlQYWtz9SttQPLA//fKKlapt9WdFQ67p8gkh+h3LOaBKS
u1snYTTmKCwrvTt+MCvLADzcJRTEDOcQmfCP2qYbwOJ4eI1rwzND2NwpTZx1yVJ3
/oPkWaS8uW57rGC1cYUXYS6VxWwTYgNHSDqqV4+oqfKriuu2WuHZ93fN8C8yWxfK
EiL/DnyMCNxpuAelTuZI7SpLmbfYptqASCSHmqJNmU+SDyqxC0dCuAVsa+wutrTy
RQTtSPhSxJhGEy07wHJWwDPqFCj4s7L88JyCKpahIGszP/eodf5r90yqf4za+BzC
y+qAizOH0NhyIcCtzlMmXK3t2d6MheJgkAzmI+O02uRiAPf5x1GOOyE6aAj7qQcU
K9m+tcVIFPWry9oZVxhYWCQwwd6v4jmiIU4YvN4SD6gZxj3vWNvLbgFBwLw8PyGr
WcLccCQYhCWBhYFct7C6dC6DtBeoS6TNrMjh4nEEVTk9jeRLhI13/w06GAWlGXiP
nSfpf2VIrK/lHzCiM8kq4rg3NcVUHOewecxq0OlK3UzXEa8mkONXrcz648OErcGP
HdJq4ZHNzG7Nq7CM7EYtI0sxvcsMVanD8nSfIwxpo4SBq0fgWzZo3spiUL5QQB1L
3Db6YAZqt6MeCySwJAXnlvsHB8Nx+WasWNwhWqcsmbvDYB9xQnMWoSteaZb0yyeO
hCjbzahPdaxTPgM=
=1RoD
-----END PGP SIGNATURE-----

--=-4yilsMbkz+4cNur9Wxoo--

