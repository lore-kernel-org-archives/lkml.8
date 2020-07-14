Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF864C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF886221F2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc+Jcvl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgGNGna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgGNGna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:43:30 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77C8C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 23:43:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cm21so1111609pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 23:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=svRq6Iqlrn/tFxtJY/DjGrWoqYIhD74lfdweZy6zFV8=;
        b=kc+Jcvl3OJXsMwC2pJGthFzMlIi4Z+p/EjQlp1fucAxYfP/P3JQyb1wmM+O36g8AbR
         Cn9GHBVqR0fXbfImOHjRSkvkMg6lR+FkkoKIYgfN2NzfvT9vwC8I+W2axg2Egl6gQ4DZ
         JgMQ0SpcaRot1GtHzP2/Ol/kuLQ/j71vDFBuMYg0l6riowcSLJW1dD/C3E55mU0/um/b
         KLulucPiDyoNTLMHEnssmvnmaT+/FGZ+mVq7Aan7R6gmFR8Z0qzXLYzoojREIumZ63Da
         5UYIP0pq5NOBzNYroTLSlsYL6BTO5hd/LhoCFeoWW/DMu/nV8iLT9Ya5+UaWjiGjbup9
         OrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=svRq6Iqlrn/tFxtJY/DjGrWoqYIhD74lfdweZy6zFV8=;
        b=EVz7vOvTu/vHwPuiSRCCCOGwvyXFNJoaXRip8S4KqgJO6VLwGdqYb/UlmQ77JDFJeR
         7mvVgPoU6aWsscCAxSJIrCnU6RORw3aq+GGLlhpqt0NNTvb0uJ/2t7nYAafjxpc8IFEs
         zLL/vpCSsgP1OOJ22l5uEKjy7K5zg3tAeum6JbqrRrNwjFjXdVbG67skXJxC+bQCJhba
         CZuAo5TlVX7rplX+4aiVyWVowLzLgIsTsiuL+t7XUkXU/FD386WVPNm83DR8EfC3B8zV
         6VuaBRadAJyERD25I58YZ1tH3b9vkkvh8Xum080qtecHp6F3usvsm7pFEzq6/K3hIKvK
         5meA==
X-Gm-Message-State: AOAM5309oZx1C8voL3aaAM+DlvtbQRuQcZ4TSPLyzuzeDEwO/mEChoM3
        dWkkjOa1ACQNxdOKAAVRbAE=
X-Google-Smtp-Source: ABdhPJyhi7ygvdZi0LQUqmE4M7wc2DNyyX3DF5F3w2YVzKer28wAcsaxjugomnADZYxvqoIkOSLTGA==
X-Received: by 2002:a17:90b:1b4e:: with SMTP id nv14mr3203899pjb.30.1594709009369;
        Mon, 13 Jul 2020 23:43:29 -0700 (PDT)
Received: from blackclown ([103.88.82.220])
        by smtp.gmail.com with ESMTPSA id q20sm16593653pfn.111.2020.07.13.23.43.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Jul 2020 23:43:28 -0700 (PDT)
Date:   Tue, 14 Jul 2020 12:13:23 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     Benjamin Poirier <benjamin.poirier@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 4/6] staging: qlge: qlge_main: Simplify while statements.
Message-ID: <20200714064323.GB12651@blackclown>
References: <cover.1594642213.git.usuraj35@gmail.com>
 <1bb472c5595d832221fd142dddb68907feeeecbe.1594642213.git.usuraj35@gmail.com>
 <20200714054137.GA49448@f3>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <20200714054137.GA49448@f3>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2020 at 02:41:37PM +0900, Benjamin Poirier wrote:
> On 2020-07-13 17:50 +0530, Suraj Upadhyay wrote:
> > Simplify while loops into more readable and simple for loops.
> >=20
> > Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
> > ---
> [...]
> > @@ -1824,7 +1821,7 @@ static struct sk_buff *ql_build_rx_skb(struct ql_=
adapter *qdev,
> >  			sbq_desc->p.skb =3D NULL;
> >  			skb_reserve(skb, NET_IP_ALIGN);
> >  		}
> > -		do {
> > +		for (; length > 0; length -=3D size, i++) {
> >  			lbq_desc =3D ql_get_curr_lchunk(qdev, rx_ring);
> >  			size =3D min(length, qdev->lbq_buf_size);
> > =20
> > @@ -1839,7 +1836,7 @@ static struct sk_buff *ql_build_rx_skb(struct ql_=
adapter *qdev,
> >  			skb->truesize +=3D size;
> >  			length -=3D size;
> >  			i++;
> > -		} while (length > 0);
> > +		}
>=20
> Looks like length and i modification should be removed from here. But in
> this instance, maybe the original was better anyways.
=20
Thanks for pointing that out. It nearly slipped.

> Agreed with Dan. At least some of those loops can be converted to "count
> up" loops for a more familiar appearance.

I mostly tried to convert the do-while loops, which I think are't that
obvious than while and for loops.

Thanks,

Suraj Upadhyay.


--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8NVAoACgkQ+gRsbIfe
747gZhAAqmjqDCHmzSP1HenEF63cKPYyve1oHdtZQYylYRaN2L9DFakZyAKZOAzG
BuQss5guy5Na3tvPENwNQa/WUcBNkBsmoYdbdiaMfdCIIiCCaS738NCe3zX+iJDn
XYjNutWTL1bPWgGUpODUfMbEB64FwZQO+fF2tXIF2EE+XbFHu9UXg4yvAmVOAuZ4
9TO+NYxOJZ4er23xW2QHw9Q2KN9L72h13BLRObkMqw/c0cVI1Q/Rs54/RpqnYC/H
UYRgNOu5Y+H5B//QoWYdzRPJRyp0z/ITjWwSqcJ20nbN3oBP20QK4iyAjrl2PMaD
ht6z5JjIAsS1hgLaMIKxEtnR23SzHrzWQyH6l6wbMIKLoWTxByZ4eZfivTtZCIqW
1fDv8jzsVfTY+RF18LaLcAAllncRYTwiEMA0wfdYQnDO7UcpoikOfTIyrZuizoDu
AHX5UEza5v4T9yJKa1GnpAQlrXtN3Vle+/otwU3jAchin7OaAPa/J0AbWxRqjBZY
35jZ3nYFEj/uT3EDgOCHtHKuiAKbIDgTGHdMs/fmaeaQ9b7QcayRs7p97a3m/68f
PTFfDce+NHxdpVS++epyhdCUdYY+RluazeTZTwOHHcMj5EgUkYcB9KXl/QBJLvR4
gcwAKr1h+FAzBq23aC+psURXYpznTvTG2u/vuTwjpuQrB8nPBS4=
=St0d
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
