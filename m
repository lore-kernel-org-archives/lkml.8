Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E7BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E7220738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="C/H4h2hA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbgFVSjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:39:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:37227 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730319AbgFVSjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592851115;
        bh=rBxfEZ67KF13JJOQ5naIrxWqmKbXOOuTFfLMGcf4oQ4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=C/H4h2hAu5T+DFzynYhRw7LeaZOUgXd6RZ0e53fe75L0+ia1e21F7QvExrlq/VDrD
         V+fRN78upEy37Go90ECLnUlSloSEeE3fclqbeJdTw3wqXpNy+Y5pMXgdiJDc1Gv4+9
         ep1r6vOGW8W81B4yGg/YUetHLyC/3qc1fw1qejs4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.186]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mirng-1jAn8g3ChI-00eu1N; Mon, 22
 Jun 2020 20:38:34 +0200
Date:   Mon, 22 Jun 2020 20:38:31 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Logan Gunthorpe <logang@deltatee.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Greer <mgreer@animalcreek.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Eric Biggers <ebiggers@google.com>, Jan Kara <jack@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oliver Neukum <oneukum@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Alexander Schremmer <alex@alexanderweb.de>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        David Sterba <dsterba@suse.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones:
 Documentation/admin-guide
Message-ID: <20200622183831.GC2581@latitude>
References: <20200622181944.51083-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <20200622181944.51083-1-grandmaster@al2klimov.de>
X-Provags-ID: V03:K1:Pw4YmJzjjxXasVnBvT+TnaxSEF5MoRvjnalixj0MITaAolFwLpC
 CXcOmef94fKi553CyiFAwmMiG8Cbq5oUwy4kGZVYoN+msroRWbUw2BGCeze0+fsh7dzjggF
 hp+oQomD94xPCNxuaVGpFGIZhEawRN9MsVT0Iyt7Ts3xO5KsY/GFv5YSukGpCJ5p47bIjHs
 /vekM9jd3dwGrpX8OnfXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6jknfIzZmN8=:CeP7HnUmRRrFIRh5r8B8re
 noM3p6Qzkc8gs+NgBkRkHNm1f7SUslHc+M9qnZu4Cyp2HKTf3V0L6oa0XbsE2JTS2TeKLh/+X
 KTZ2d03IUmBKdiwB5dN+hp5v68idtFC2abeCtkkeE6aVOTZkEzrtS9RpJxoAFwk7wr8l2Tdo0
 lRcoaZUPcOvjgUZhx8N9OepcHv3d9BAqaEPN2dovukmCyaIPbLmusREUHqo3imF+sPg+yK7ZB
 kPE0NHKnybf2HTdFYQmbgVsUdYhBx20rV+N3cetdrp1ZwUxDPhyUiWrWA9Z2RUz5QFciBZsuq
 Q6cBNvKL+DQKYSj/f9j3qOVbONQt8BhuI6tjJdvSmEUevzKj1crxgea78kSF/JyzW9nYnOtD1
 nXHyrE1LQlh5G1GC8X9jLPhjJiiP3rB4qBHRgIGH/wEpZ1abz94bS+kbJdPV3PK3ZtE/9J5xi
 HgTUfgv4CaedWQtV7Su3umBESd3Skh1vBnUY+6kfWoR1qaoSqdsqwS/E96ELKmA/dArmE8qss
 e0xFMIovV5t0+8iFNLICvOKX77Xi8Er7pxBrQEuxpX3/sqVVUY16Qa0uONjeLrd4AHV9pq97q
 xvvdUcAtcYxs1GOLyLQhJevDbJYRgNKolRlMA5kGewSI/ELgC5cD6T50dTA1u4EEKNNI7mPQU
 3r8qXs5ADdhI/uYMMit3sjyW4J1XM/8VoX7I+NeIhZeGwpVV0VPD8pOOigg58vQdABHg+IGsc
 vh62lrXeqVW7gmYb5D3/3vBz6sXYirbfX57qwT+VI6ft3QRwdfP4ySQEAa32JBux15LqTYDWX
 lxLd7Ay0udzZY4fz3rkDXEi4u81H7UBNJhsbnccyMMrORuWIJLCp6kamWpARVdDyRnkQ5cdrG
 yIoJ2tAxhZWcmUhqxkBxYmD4t16sW6o61fMkaClskvOvhUksoImr3OrCKojGzRYLOJ8DLFB2g
 lKcWuAfrlKjR0SeZ0LPtRDw4852b4bWqpacPbGTXi24hWdwUG+6/NqTNfOnNNRR2gFsMxyD4D
 Wh6wB5cOzGOOkDBpNrDVhWxM+f2CrvIAOaHPPb458IeIqouywe26ul7Cu5vF5myMWh/N7lsDY
 GuNwK18kfLWEyg5hdHCVwWu8dcH2EC/M8X+EagNRYF03YSiKwgkp/mvzy01613tuak4ohBHMf
 qvCo+c9+4xXJBBapG27Q/lVmJufHYuOD5LB9fiBp9tUGOePSLQWKUpQgUwA0GzhIiYG9+Sygm
 rfYjzMpqAABK3/CQ1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>Subject: [PATCH] Replace HTTP links with HTTPS ones: Documentation/admin-g=
uide

You already sent a patch with the exact same subject line.
Please use an incrementing version number (PATCH v2, PATCH v3, etc.) for
revised versions of a patch, and describe the differences below the ---
line. This is (somewhat lengthily) explained here:

  https://www.kernel.org/doc/html/latest/process/submitting-patches.html#th=
e-canonical-patch-format


Best regards,
Jonathan Neusch=C3=A4fer

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl7w+p8ACgkQCDBEmo7z
X9tWiRAAnuS5matKAOKnBQ++3jS1s4CaYlzM7n36VwGK0eRnd3MeMC3C3yJJYgO1
GvBRp41Hld5Lwu526J+Y7oKdGMn0EY8DljpyhT0uQXeKkDB9rBrYxDDyitJ8I9YE
76TvJtp/UsKHX+lk9FCFfyAADy1/pz4vBsRv1g1R1MQI+5QUtCuOafUCdsoytQK/
7Vtj2CIEklI8eloPgSOTAZLaQoDgJWoIUSzy7Qui2g6UTFboOUROLlXgJR7QGJva
KuA0/4Y4C9Q1s+LH+H5iZyTgEqjETGrOEJNR2oTJlUS0Hf+hmNdi4FU9SvjvkiNh
BzbxMctzeW4b+UFHGHpUsmT5gsNTJtDh7di5eoHfZ1uJ9aHwoJa1XfbXCGp8+8a+
88q+EgyF1DUV8dLG3j8831tPR8yJjk+aZwqoO6pLRU7mEzYOjjP80JrvRtpYj21x
8mpZzc5gAktnPVaQr86gvydCt9SwSZgKuOyFKTKZaibQx4L83XchSzmFKg4NlI8+
JHF1S9C8Cl8GcypYL3w4ZYaUqHm0Zl9bTBApwzZEfd03cPp/k1so8MK69LyXB5tR
TsZrOjCBobS83KoOyMoKNRaw6JYgcLvmCyBygYyBpyUQB5xCCu7XPVd6Tc92DZB+
tGL59Z3gojroAMoLlfRlQIiGhzLG1gp3EjI02/zOBPYViSMb14k=
=Uq1b
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
