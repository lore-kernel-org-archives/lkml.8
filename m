Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27D2C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 23:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782E72074F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 23:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CMw1rUoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgDIX34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 19:29:56 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42319 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgDIX34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 19:29:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48yy6T0V8cz9sQt;
        Fri, 10 Apr 2020 09:29:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1586474993;
        bh=TKjGe9gKiv6Kej7PZw0+u/oASCxTSPXYbxWhNVENMW0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CMw1rUoM3z/ZfPWNJw5dpEZ+0niu9Oioa18tVeD+7HHNpaUDiGNj0ahQyeA5Bqk25
         f9pUJq32SmsxgBEAytupHNiCZm/5SNtjUicnAB78Qg9al+g05RaG3gqyoXpyDt2rqe
         rI14D43JbOrlYKNz11Ywp/+kvtk03RLVfHf6/6HdOFcpKxZOD8DSLdZkziPKh8vRxg
         WgHuiufz10BZqxGM0sfrNPeX8Vb7lBRpmqUC1GyHIWWbyOgI3OELXdWTPj8eBIbgxc
         D3VEySgc5Nrq6vV7DAQdDMV76uv97n4DWJ0EFTe1JKbHMVbF3+2MOfllX8t1/YOhNF
         Kd+YubpCBX/dQ==
Date:   Fri, 10 Apr 2020 09:29:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
Message-ID: <20200410092951.6db32bfe@canb.auug.org.au>
In-Reply-To: <CAHk-=wgjGgfUfVm_DpTay5TS03pLCgUWqRpQS++90fSE2V-e=g@mail.gmail.com>
References: <20200408014010.80428-1-peterx@redhat.com>
        <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
        <CACT4Y+bhQVcpSkSh_OZ5ZanfFZUqn2iypLhG_Z-nWKTkaYr1jw@mail.gmail.com>
        <CAHk-=wgjGgfUfVm_DpTay5TS03pLCgUWqRpQS++90fSE2V-e=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/n_a=u.Ml/2pJE9BUl5munRl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/n_a=u.Ml/2pJE9BUl5munRl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Thu, 9 Apr 2020 09:32:32 -0700 Linus Torvalds <torvalds@linux-foundation=
.org> wrote:
>
> On Thu, Apr 9, 2020 at 5:55 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > linux-next is boot-broken for more than a month and bugs are piling
> > onto bugs, I've seen at least 3 different ones.
> > syzbot can't get any working linux-next build for testing for a very
> > long time now. =20
>=20
> Ouch.
>=20
> Ok, that's not good. It means that linux-next has basically only done
> build-testing this whole cycle.

Well, there are other CI's beyond syzbot .. Does syzbot only build/test
a single kernel arch/config?

> Stephen, Dmitry - is there some way linux-next could possibly kick out
> trees more aggressively if syzbot can't even boot?

Of course that could be done if I knew that there were problems.  From
memory and my mail archives, I was only cc'd on 3 problems by sysbot
since last November and they were all responded to by the appropriate
maintainers/developers.

Currently, when I am cc'd on reports, if they are also sent to who
seem like the appropriate people, I just file the report assuming it
will be dealt with.

> Kicking trees out of linux-next and making noise if they cause syzbot
> failures might also make some maintainers react more..

That may be true, but in some cases I have carried fixups/reverts/older
versions of trees for quite some time before things get fixed.  But at
least if that happens, I do tend to remind people.

--=20
Cheers,
Stephen Rothwell

--Sig_/n_a=u.Ml/2pJE9BUl5munRl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6Pr+8ACgkQAVBC80lX
0GwCHgf/ZRqpSjhVVe+fYBrYmpnwfFnrL/Oh72lh7tck0j1YEjzwMCFBfN5pijAv
WMI80UlZlDlj3L6ErGNnlkkHuQr+qDmXXPfPFGHXkVYKxf7Wm4653D+xjz5ON1qH
ynkN7384PaKE/o23MokpEvxP8/l7pPMhT0nQeJtY76c/tPDaBVg5vN9cOH+4poZm
KvExSzx242t12kd0m0tqCQSnnNVJKdOdZ5XJ/oCc8oaq8n8t095FfXM+TNffwHkg
N+U17MlvBmmsOetOZ+MhV8BzKyixzKyYgDiNnn8FBgyhCcEae1LEeUaW0qM/um4V
nPrJdvinKjPgPth7YtGGTcHG2iBMsw==
=2xaa
-----END PGP SIGNATURE-----

--Sig_/n_a=u.Ml/2pJE9BUl5munRl--
