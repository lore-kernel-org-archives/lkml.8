Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E8DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF87214F1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AJOyudkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgE2P2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:28:02 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:33843 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725901AbgE2P2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:28:02 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 199F75816ED;
        Fri, 29 May 2020 11:28:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 29 May 2020 11:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=KTlx0B
        PDzCowm6XcDLxS3PzthwM8oHExawfWSnkgOd4=; b=AJOyudkSFe+wwpxmh3g3/a
        6CJGrvVGU8yirj2SgGIuqqbHrI48RRFHDSl+tqzryo3Pyu/pE2CIPs39VyBZyU5R
        bL6kZJN0PL27EBwTStNuaIgY3zmrUHWd/y1UNWNkiuhRBfGHhsEKhgbXYlgHc5c7
        MiZNfdxk7cqEwbMeMl2OV1y9SleQ6npEZDY1Y1re+bTB6IuxdifQ647KTohBzz+B
        4iFeAuvOuKqe+ryN9xr2re2HS9PsL6QjRmcW0Y8ctPV5E0apIFUOZMnyq4cc+MK2
        HVv99taaBPwKh/lMVQ9qqNEbPcse+m2QdTLZ9YqLA4GvTz6Co9p+mSq0jJOvRI3w
        ==
X-ME-Sender: <xms:_ynRXlbBV4gcIYhx2mVz-0365sEKcrJneY_AGHn_JxsCpLKsnPIMMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvkedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesghdtreertdervdenucfhrhhomhephghojhht
    vghkucfrohhrtgiihihkuceofihojhhusehinhhvihhsihgslhgvthhhihhnghhslhgrsg
    drtghomheqnecuggftrfgrthhtvghrnhepueeuuedvvdeukefgheffhfetkeelhfekhfej
    jeeigeejveevueeiueefleetkeelnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    fkphepledurddugeehrdduieelrdeiheenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpeifohhjuhesihhnvhhishhisghlvghthhhinhhgshhlrg
    gsrdgtohhm
X-ME-Proxy: <xmx:_ynRXsaxTvxL-IganTp7rBDATf7gbGaFXR4QM8mYWzI6znL_GyDzew>
    <xmx:_ynRXn_tIa_NqzRqmAYi9eceexFNtZfA87lRNIkfokF9zWZvKeum8Q>
    <xmx:_ynRXjqlyWSb6jX7oBhhJEEEQDH_MpfZCox97BE41vG2VRVhnktVkw>
    <xmx:ASrRXn2I2uUSYQYdDu7v3vP-1jTUzruKwXe0T2NPrl2zEdjKpnmZTg>
Received: from mail-itl.localdomain (91-145-169-65.internetia.net.pl [91.145.169.65])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3366C306215A;
        Fri, 29 May 2020 11:27:59 -0400 (EDT)
Received: by mail-itl.localdomain (Postfix, from userid 1000)
        id 4F9905D351; Fri, 29 May 2020 17:27:56 +0200 (CEST)
Date:   Fri, 29 May 2020 17:27:56 +0200
From:   Wojtek Porczyk <woju@invisiblethingslab.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Don Porter <porter@cs.unc.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Message-ID: <20200529152756.GA7452@invisiblethingslab.com>
Mail-Followup-To: Andy Lutomirski <luto@amacapital.net>,
        Don Porter <porter@cs.unc.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org, bp@alien8.de, luto@kernel.org,
        hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
References: <e9a0a521-104b-5c3a-a689-78f878e73d31@cs.unc.edu>
 <7A3EBAB0-B3B3-4CB7-AA6A-FDF29D03E30D@amacapital.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <7A3EBAB0-B3B3-4CB7-AA6A-FDF29D03E30D@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2020 at 11:38:01AM -0700, Andy Lutomirski wrote:
> One useful test for the actual kernel patches would be to run your SGX
> workload on a loaded core.  That is, do something like taskset -c
> 0 graphene_thing and, simultaneously, write a trivial infinite loop progr=
am
> and run that under taskset -c 0 as well. For good measure, you could have
> perf top or perf record running at the same time.  Look for kernel errors,
> but also look for any evidence of your workload malfunctioning.

We currently run as part of CI several workloads[1], among them LTP tests[2=
],
and sometimes it's not pretty, because we encounter stability problems in
Graphene+SGX even without the patchset. We'll pick some stable subset and
will let know. Right now we'll have to retool CI for custom kernels, which
will take some back and forth with uni's admins.

[1] https://github.com/oscarlab/graphene/tree/master/Examples
[2] https://github.com/oscarlab/graphene/tree/master/LibOS/shim/test/ltp

--=20
pozdrawiam / best regards
Wojtek Porczyk
Graphene / Invisible Things Lab
=20
 I do not fear computers,
 I fear lack of them.
    -- Isaac Asimov

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEaO0VFfpr0tEF6hYkv2vZMhA6I1EFAl7RKfsACgkQv2vZMhA6
I1FwkBAAj6TLkpFQtU7aEJEyWCxLeXiB+5+9Tt/q9/AO25+Za/CPrYmAGLPxGre8
O/MQfe1XfeniHbzPDUKKBxv4/dDfyan+Xmzbm/g9G/S8xeDeGi4p9VpHEj2OOnHg
lpM0MNPO2b5XejdhOXIppq+dvx/Kp8cVscLp8KOxO2/zcqRW0PjMjmTcQS9aaG4o
r6nuAd6oFctztYdEUqExVrg8G3zgYOGyVxtRydlpunGtbahDuZH2+cqS314nB86b
8y3gGyeUhTGiMTpj765yKk8bRMisv8MtUFfzCJHjzPVufuL40xRwGVL32J6Oy22e
xq9PKdcS92wBKH6IMuyqOVg6BU6wyV03douNfGuHQNqs1jVjc/k+33fwbklc/AIW
xDxh9cypR2WagVWnE5+j1cHq7n132sD3D/bV0l3t/FUTP/fKjSuke+Uz7czfIi4L
O6QmVlzotC7tatZUt17INpO3ycv7EjYmh0p/yObVu88ovPNGu6IPzo3p72y2sCTj
dWJWKqn0jFGi6maSrsdZag8Fl1YkaLjO4EH4YpGQNckhYZwhZTqg0+w+LF6lKfQ6
cC3DppUiDM/HwKa560cBWMuKfzZ2leGAcoXIl2SkBd1iyM06Yq45CVvjxyQ9wgUp
cuTLgQ/TsosJT3ToGw5cscMt3oKE5fSnucrJRVRRCfy/kiH49y8=
=fSib
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
