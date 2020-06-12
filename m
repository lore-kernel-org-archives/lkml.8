Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F89C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F5352084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="TI6S+Mwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgFLRNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFLRNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:13:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED370C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 10:13:37 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l10so10458708wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 10:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6/WKj2RP2D9n4+fw5DYObbawXZCZEXk2atts5/6vXZA=;
        b=TI6S+MwlPkt8KC/tPABYYKsT1TobgOSEYvn7gfp61hj7IWbDiaISOUSExWX249s6fi
         EIYHO6hkn1K1f6HNJlpcgTM7TC6HcJ9Bz/i/U+52KQ4SDr9GmgcRXdjV7av4HWETWXxM
         fxu5PbxWzUePUak1TSIszwbrfNsSF2Mef0XA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6/WKj2RP2D9n4+fw5DYObbawXZCZEXk2atts5/6vXZA=;
        b=rVqqCFmG4SQXb3Qn/FFGzS9KHNoxro5NBRYncjCRZkJYdsrekdN2XrbAujvYA0rnKy
         x+2mEBKMV3T1jCQEYiey5ybGPm2BdDqgpHJtSAR62QgSZaD4+4FCdU0LgN6K2lhtqRJe
         Bvu3gj+MLjfiGUgktcIG/BQdINYPKa2iAhV3BpiPHAlM7uQW346ISYk/V1AajkTdpCrI
         0LbD3tE3CjwaVD6hSVKfKO5OaGI/94abvHtQqfhQq1BMs7U3n7A3XIkWZPz3QiMomcZL
         ihfPerQOdNBccp50IH/fFbrybx9hwSn/iF/xqCAjCeIZZ62zSN+N6+xZ44xgg5u5IJej
         j99A==
X-Gm-Message-State: AOAM533JZluhG4MFJzJJyWAUmnPh8FgOuKmF5DckaWjZzE53Ziv9v8rl
        VdURj9sTcVZ5s8PReojHFyhIrg==
X-Google-Smtp-Source: ABdhPJzlc5PIQbzc9wrrQMNksbeyPR5ziC+iT8uaWIdBJcsqaBBESl71xk5jFNvubBzbMwIi3XoqOw==
X-Received: by 2002:a5d:4404:: with SMTP id z4mr16439075wrq.189.1591982016383;
        Fri, 12 Jun 2020 10:13:36 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id b185sm16603283wmd.3.2020.06.12.10.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 10:13:35 -0700 (PDT)
Date:   Fri, 12 Jun 2020 18:13:35 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/6] mm, memcg: Prevent memory.low load/store tearing
Message-ID: <20200612171335.GA341094@chrisdown.name>
References: <cover.1584034301.git.chris@chrisdown.name>
 <448206f44b0fa7be9dad2ca2601d2bcb2c0b7844.1584034301.git.chris@chrisdown.name>
 <20200612170352.GA40768@blackbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20200612170352.GA40768@blackbook>
User-Agent: Mutt/1.14.2 (2020-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michal,

Good catch! Andrew and I must have missed these when massaging the commits =
with=20
other stuff in -mm, which is totally understandable considering the amount =
of=20
places being touched by this and other patch series at the same time. Just =
goes=20
to show how complex it can be sometimes, since I even double checked these =
and=20
didn't see that missed hunk :-)

The good news is that these are belt-and-suspenders: this avoids a rare=20
theoretical case, not something likely to be practically dangerous. But yes=
, we=20
should fix it up. Since the commit is already out, I'll just submit a new o=
ne.

Thanks for the report!

Chris

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAEBCgB9FiEECEkprPvCOwsaJqhB340hthYRgHAFAl7jt79fFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDA4
NDkyOUFDRkJDMjNCMEIxQTI2QTg0MURGOEQyMUI2MTYxMTgwNzAACgkQ340hthYR
gHAerQ//Zf+6DzdEaZvfnvPNq5+6NbmAAs+Pw1AZn2s81dipkRY38MGPNTqY8oBL
qd46ZDJ24zSUPAcHvu6E3UGwpjO8VSynvP+CfEoFlS+R5k15oEqTe36C7l9eA+IY
zTDyLj9LrFhy5qD2V2GKH9Dp9ZQC9BrIls1Gc0J+XaB7h9umEc2g1Ybadj1d3ouk
xAX/6iV19fAW4uFgXVOq70BhYGXGXvWCX0NYQ3Yz18Kkr5bSnjzTz2irIxCbaWZ+
q2Gj+Q1JFN/yhkRUt+m+8qtJZAb/i4cXqDJp9kqJ6t9cLjIhybFNRnXMueGr1Puc
byWoWK7i9+vEjnY6VbjToicAWQPeId063wxJzzhp/uqQ+zoCMDX+P7Iz4s1u+6l6
R3nXQSRcrw9VNc3ZOfJjXy1R/hIwGBbeGt/ndPnyNrznWu8yYJJr7qZirk8Uy4lp
wTmv/5QTkal+TiVXOMW6VwXMLLvu50Q+E3/7dIz4waKt98kfM8hd8zjB676rwcGD
olHRJHD956i7HOAU3uzFrijiMOgOnXAiJIDj1+MxLXdTL0ZidJizBh6eeSbxUrcg
egr+KPJSKcxuZ+K8c+yZD8MoCLJX84xTU1LdtTwQC9x10M1HnT1OMFLrfso4yWTK
SYtQxYe6sGiKMLvN3tYD5Ql63m8D2CIK5NDiK/hxG9hZtiYOH9k=
=2HeI
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
