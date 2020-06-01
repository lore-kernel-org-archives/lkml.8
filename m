Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6F9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E2A20776
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RcNlFUKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgFAQrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:47:07 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52401 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgFAQrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:47:02 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200601164701euoutp01d62d9e1df7e355ab8dd8f7892b605897~UeV-twXfZ1133411334euoutp01T;
        Mon,  1 Jun 2020 16:47:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200601164701euoutp01d62d9e1df7e355ab8dd8f7892b605897~UeV-twXfZ1133411334euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591030021;
        bh=41DTQKjG5AU+zWznqYpehAyQ+BBqsyhrsE8G6fKCSA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RcNlFUKEl+e2VPikgTe/8gAa/27IAY2hPG97mw9HgMpUJvnOtgMo0hysgkC5rmw9F
         qyVsGlD7qy8VbISxp7SJMQ9GtvfiA6eBhRm2cyXFU6DWpzFNrH+cGxJUkts1uvtbYs
         ze5uSbeji5+IqWhZA4l9Xyq46yzevZUEq1vA5JIU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200601164701eucas1p18c058525bd3891aa14bbafebd56bd076~UeV-hR2_M0213502135eucas1p1G;
        Mon,  1 Jun 2020 16:47:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0E.93.60679.40135DE5; Mon,  1
        Jun 2020 17:47:01 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200601164700eucas1p2e30af458bae7e820ca55f7936ac3579a~UeV-P70tK0934609346eucas1p2v;
        Mon,  1 Jun 2020 16:47:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200601164700eusmtrp2d2ca4a69ceaafed1fe510266b0f28dc8~UeV-PO8nv3192131921eusmtrp2_;
        Mon,  1 Jun 2020 16:47:00 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-79-5ed5310463c4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BF.E4.07950.40135DE5; Mon,  1
        Jun 2020 17:47:00 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200601164700eusmtip1e6df1f0c03cd0a2491173112999503a5~UeV-DOeIX0036200362eusmtip1f;
        Mon,  1 Jun 2020 16:47:00 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 5/5] arm: kexec_file: load zImage or uImage, initrd and
 dtb
Date:   Mon, 01 Jun 2020 18:46:46 +0200
In-Reply-To: <20200601151431.GN1551@shell.armlinux.org.uk> (Russell King's
        message of "Mon, 1 Jun 2020 16:14:31 +0100")
Message-ID: <dleftjmu5msphl.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa1BMYRj27rnsqWzztYVXue4wQ0Ylt+N+GTPOTH8yxgxmxOK0drSb2dNG
        frDGIEusda2MZEwoLW1NqExmBw2xYhNmilxGuZTc5VI6fZnx73mf5/me732++QRG38lFCmZr
        mmyzGlMMfDBbfrPTP56b8DAp7sRTEEuOXeBEt+eaRnyyrVIj3tljEb0vGzgxUHGcF32Hr4JY
        fL1JKz5vfsyJRV23QexwdWvE39WdrFjqPczM1UmBhvuMlOu4z0p/ClsZ6aTXLnkLd/NSY0MV
        L7X7/Vqp9PRWydXRxkv7ygpB+uwdlhiyPHjmWjnFnC7bYmevCl6349sNfsPO0E3N+5vAAT9C
        nCAISCah2xfjhGBBT84C1hVlMk4I6hm+AO75GE2Fz4Bt1W9YVVAPHPj4jqPCGcDv7QENHVoA
        m9vbNWosT2KwuHipCiPIdKzbO0a1MOQDg0cr23iVDyeL8HX+YjWTJaPR4WzuzQ8iGfjV5e1d
        QkemYkHtN1DxADINy1qfaSkfhreyX/X6GWLB7HvvQc1Hki9gy/vbPF10AdYHshiKw/FtTZmW
        4iHYfSVPQ9tvxYPuKfTsXsDy4z/6Ss7ARv/Pvpx5WHlsN0f9ofi4LYzeG4ru8qMMpXWYuVNP
        3aPQs7+qLyUSs96eBYolLG3xAX2pLMCn5y7xLhiR81+dnP/q5PTEMmQsXqiIpfQ4LMh/x1A8
        Cz2eD+xJ4AphkGxXLCZZibfKG2MUo0WxW00xa1ItXuj5hLVdNV8uQ8Xv1T4gAhj664QX9Ul6
        zpiuZFh8MKon6cXFojqIZK2pVtkQoZt/tzZJr1trzNgs21JX2uwpsuKDKIE1DNJNPPVmhZ6Y
        jGnyelneINv+qRohKNIBpgeBoeYOwb4pDLLj8pP7zS7YcqTkipAZzTpScw8mDvsUnj4wKmRX
        wug5/lWNI81l9vrMZM+z2p93E7YUxLe6m+7UL7n2Wl7WWTrrV9y2wVnOQ8PzxlkulhhI6/BH
        lYmTz8UPZmITZiYJimtG9/k8s2lBMonK1rZ0KWlpIxduB5uBVdYZJ0QzNsX4F9L2MH+MAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xu7oshlfjDC4c0bbYOGM9q8WkdQeY
        LG427mayONOda7Hp8TVWi8u75rBZHJq6l9Fi7ZG77BYPH9xgtVj97xSjxYcJ/5ks/uz/yWKx
        edNUZgdej8vXLjJ7zG64yOLxd9ULZo8Fm0o9Nq3qZPO4c20Pm8e7c+fYPTYvqfeY8OEtm0ff
        llWMHp83yQVwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJal
        FunbJehltH47ylbQxlfxoP8uYwPjD+4uRk4OCQETiYkfX7N2MXJxCAksZZSY+mk2YxcjB1BC
        SmLl3HSIGmGJP9e62CBqnjJKfJndwQRSwyagJ7F2bQSIKSJgJXGhRwOkhFngIbPEw10v2EB6
        hQX8JWbOX8IKYgsJWEps+noALM4ioCrR0PWABcTmFKiU+DphEzOIzStgLrHs9DdGEFsUqH7L
        i/vsEHFBiZMzn4DVMwtkS3xd/Zx5AqPALCSpWUhSs4BOYhbQlFi/Sx8irC2xbOFrZgjbVmLd
        uvcsCxhZVzGKpJYW56bnFhvpFSfmFpfmpesl5+duYgRG8rZjP7fsYOx6F3yIUYCDUYmHd8P9
        K3FCrIllxZW5hxhVgMY82rD6AqMUS15+XqqSCK/T2dNxQrwpiZVVqUX58UWlOanFhxhNgf6c
        yCwlmpwPTD55JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoY107d
        /elK5O6qQ/umuEi3TJ26pT9d+PuJyvQTvyMfRWUXpng4MNfOF6nU3p/8pyhsQeTezOaop6vL
        VprKtZ8T5eI4dUTzYFj70fR3szKVHoRbLH659/Hs6ClLXoU8XrOn+plZQkg1v/DLa5P+m0bU
        XH3m7qAXf0v1ccXWF5u1axz7z25RCWK9o8RSnJFoqMVcVJwIAMUahn0GAwAA
X-CMS-MailID: 20200601164700eucas1p2e30af458bae7e820ca55f7936ac3579a
X-Msg-Generator: CA
X-RootMTR: 20200601164700eucas1p2e30af458bae7e820ca55f7936ac3579a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200601164700eucas1p2e30af458bae7e820ca55f7936ac3579a
References: <20200601151431.GN1551@shell.armlinux.org.uk>
        <CGME20200601164700eucas1p2e30af458bae7e820ca55f7936ac3579a@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-06-01 pon 16:14>, when Russell King - ARM Linux admin wrote:
> On Mon, Jun 01, 2020 at 04:07:45PM +0100, Russell King - ARM Linux admin =
wrote:
>> On Mon, Jun 01, 2020 at 04:27:54PM +0200, =C5=81ukasz Stelmach wrote:
>> > diff --git a/arch/arm/kernel/kexec_zimage.c b/arch/arm/kernel/kexec_zi=
mage.c
>> > new file mode 100644
>> > index 000000000000..d09795fc9072
>> > --- /dev/null
>> > +++ b/arch/arm/kernel/kexec_zimage.c
>> > @@ -0,0 +1,199 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +/*
>> > + * Kexec zImage loader
>> > + *
>> > + * Copyright (C) 2020 Samsung Electronics
>> > + * Author: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
>>=20
>> Please credit me as part author of this - you have taken some of my
>> code from the userspace kexec tool (such as the contents of
>> find_extension_tag()) and copied it in here, so this is not all your
>> own work.
>
> It would also be a very good idea to indicate _where_ you copied some
> of this code from.

Sure thing. Done.

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl7VMPYACgkQsK4enJil
gBDbnQgAk+zRuAmQ25CmOx1g3Lghd/oIx+I9Yfpdw3UUkw8iDM0P2nt5fSsL+VBT
hzL6Mn+02xyReGWNluD0njyIP3x/FbwM9aktNIRxC18QYBAnISKXaZw/HIr8TRKT
LxbMiuj6EqtTPTaKrJuekMl8C059GOHBSNjR9xw4Dx9HXpPFB9xdJg3R24+pg7nC
3+RXJuqId6pOKbsQD2VsCuF60mb1Q7FoG3mqqdzMs4J2TrjwsGznqyCkMcJ0ctPz
GCh/WpsCUMS0oIclQKx4EzwTyqLJemWIF94TFy/W0H8aarhZ9kYPDHlAgoePFgO2
E+b2qf2egZ1bKbVy/SiQmsydb+op9w==
=qyp7
-----END PGP SIGNATURE-----
--=-=-=--
