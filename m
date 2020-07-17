Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1741CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB7812070A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e99KnuVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgGQOZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgGQOZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:25:29 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F8AC0619D2;
        Fri, 17 Jul 2020 07:25:29 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o18so11040743eje.7;
        Fri, 17 Jul 2020 07:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mUVdR+ZDJVxSmd7ZbQVSsi764XMpQahMmDvfOF22gQY=;
        b=e99KnuVGCS6dPPckmUblnQ/Eq5Pt0qMRRfY1ARV29XHavDg6gElhKrIaEDpBLGpuds
         P5FHLwnwgL07Jn0MnjcLpQ9PvpecGEu96QTkn24/clTC27J7zVna4p0PTDdn1Mx8DXhP
         t0TXqYHl0sfJBoJibUYV3CdQFO+K2xZuud8PpDxPXaY4lLsgUh+oAkCt8nZ++lqC5qps
         2zNBx4zcV0160Grno+DH4jd12dqPucjjjo2mZzy3TAsCmc0crUPAuT5mzRaDaGdR/ll+
         2AunOn2TjQGBbiGS8LS4T2yBBEyswfI6F2qVP3yDg1f5QDVWQDLFKLERr+d8NUhqcsTZ
         El7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mUVdR+ZDJVxSmd7ZbQVSsi764XMpQahMmDvfOF22gQY=;
        b=GSgf+iX46pD0y4iEiG3zH9KYe4TM/AUF1LdZNrLB4zoK8Tu7NiITr9Ad0iE29N7slF
         NfXrlIX6CgWJst3fQGvQTkap8wrmcIC3GhEf3im8rNj5esMtT2MAGMkbsumm8hlcjmxr
         qJQv4NnSHH/593qKrv0mRNIzbyw1oWTNeee0M3JZjkZZCJoGSnUbLLjfWXk5WzlK/Z3P
         oz6yZ0pDeuvib2/xdYyjeo90b99LB8MhhzGeuizAqyqV0U4NKxbmXXjQs3u6hqYfd0H2
         ZLexej7Q+mlwoS1nPw+Xp84FeQsEI3z90CE+1e23aTOzyHvRLvLhIQlsmdVcSv6uSLMX
         vpZA==
X-Gm-Message-State: AOAM533ldoEFw7RfENjxrz+Eqhb1uXyuidNAVFt8rsYJ3CPuL1GMSt6g
        wKR5GOE82MNj18XwhpJBWdc=
X-Google-Smtp-Source: ABdhPJyu7NsACW41OKjti0Dmecq5SwVTGW26QQC4foUalOjXrZcuCwKG78N9LWqnKSZwGFISKNM07A==
X-Received: by 2002:a17:906:d286:: with SMTP id ay6mr8804419ejb.400.1594995927698;
        Fri, 17 Jul 2020 07:25:27 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id p14sm8475984edr.23.2020.07.17.07.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:25:26 -0700 (PDT)
Date:   Fri, 17 Jul 2020 16:25:24 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     miaoqinglang <miaoqinglang@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] gpu: host1x: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20200717142524.GA1218823@ulmo>
References: <20200716090323.13274-1-miaoqinglang@huawei.com>
 <20200716133450.GJ535268@ulmo>
 <5684dcb3-c5a4-96c1-dd96-c44f5a94938f@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <5684dcb3-c5a4-96c1-dd96-c44f5a94938f@huawei.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 09:32:21AM +0800, miaoqinglang wrote:
>=20
> =E5=9C=A8 2020/7/16 21:34, Thierry Reding =E5=86=99=E9=81=93:
> > On Thu, Jul 16, 2020 at 05:03:23PM +0800, Qinglang Miao wrote:
> > > From: Yongqiang Liu <liuyongqiang13@huawei.com>
> > >=20
> > > Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> > >=20
> > > Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> > > ---
> > >   drivers/gpu/host1x/debug.c | 28 ++++------------------------
> > >   1 file changed, 4 insertions(+), 24 deletions(-)
> > This doesn't apply. Can you please resend, based on something like
> > linux-next?
> >=20
> > Thanks,
> > Thierry
> Hi, Thierry
>=20
> =C2=A0 Sorry I didn't mention it in commit log, but this patch is based on
> linux-next where commit <4d4901c6d7> has switched over direct=C2=A0 seq_r=
ead
> method calls to seq_read_iter, this is why there's conflict in=C2=A0 your=
 apply.
>=20
> =C2=A0 Do you think I should send a new patch based on 5.8rc?

No need to. I'm about to send out the pull request for v5.9-rc1, so I'll
just defer this to v5.10 since it doesn't look like it's anything
urgent.

Thierry

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8RtM8ACgkQ3SOs138+
s6Hj6g/+MgjmNXDQakxoDHLk0m84f7i97cY0lrI0Z0XFp0ZsuZp4VHLS0Rzd2wt8
3tb6OLbwu6Q456lBZIw/FKa7i4zJ3bRzV1+dnvZaXPWgVUzSRMEgo6AugBNGQqhy
eQJH+5NfpN75sWFtXjhA/PscNW1v6oR/QkTKa2kcYFtP5xbSWHxVkdRUK/Xl5s15
TGaYsskrZehPE8k+6xNH6c0RIpt6ERO1NxnjrapApW3w98IYen1X8ONjILhJhjny
ZjUJN3WbTaZVo7WtxZWG9G5AMR+5LK8qByRzjf1VoWWpFbiuZaPae/ewRFm8CZeg
jNS3PYpAuSW9Bv0j5o2EEXUK4LV9gAC8ET140dTMmupSLH73Eu1ML7+Lm0TAGkK0
MPmJ8jLc0TMTERdA2Jt5s5sNZttMjaABxgPvl2igT+2zVA3yzyE1E3EO5qpyVQSF
R2AWrcyc9gVdyCElBq5Z39td7OkL4ylG/sboo6xxudgW5gcYo2K2w541CEES9TKm
JWeo5cf8YiBWcoF6ppg+OkTw61NILMjiMopyrd5ZDSOnwAi/oprOyGT7TfQJqazJ
y78QPzi3GrAzlZzMovNWNw+7MIIuig0tYtxVMz1i5/uBAE89ngZjN+09a4G14q4z
0giSD+1Iya4q2w/DBhCIwiyhT53pHp76KrCj/+Xy1+8FUVHUprU=
=J7AY
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
