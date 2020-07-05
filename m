Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F5DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 01:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF07620747
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 01:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qEec4qRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgGEBjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 21:39:25 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:53992 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgGEBjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 21:39:22 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200705013919epoutp0256a1ac89db18b03e3cbfc08e1cfe241c~et5LRwKw62895628956epoutp02S
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 01:39:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200705013919epoutp0256a1ac89db18b03e3cbfc08e1cfe241c~et5LRwKw62895628956epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593913159;
        bh=inQT8vZIWZCDZwlqNDHC0tfMlJIey0coUpcXgSLWahg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=qEec4qRPyKcF11O3B3FAMkLyizypaMjyJREhlcja0Lb74ob3Fry4sDlxcDmluYcth
         reedNRgWub4VBEl39ljtHWwV5ER+ltahFAmlLmRmYVHJ2MIw3LpIZlBgHKqpg7CP8L
         nOqTTWS7PoL49a7HUSyFXiUnbSPqvgz9nKm5W740=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200705013918epcas5p2ee189c21a7a55066eb0520e396381d6f~et5KiGyRw1758717587epcas5p20;
        Sun,  5 Jul 2020 01:39:18 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.AB.09475.64F210F5; Sun,  5 Jul 2020 10:39:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200705013917epcas5p452d47ac7c3d735a7e7b238947812f68c~et5J7sN_J0041600416epcas5p45;
        Sun,  5 Jul 2020 01:39:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200705013917epsmtrp1a8904e1a46115cc66f81c5734fa31426~et5J7AtbX2579125791epsmtrp1l;
        Sun,  5 Jul 2020 01:39:17 +0000 (GMT)
X-AuditID: b6c32a4b-39fff70000002503-f6-5f012f468071
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.F6.08382.54F210F5; Sun,  5 Jul 2020 10:39:17 +0900 (KST)
Received: from alimakhtar02 (unknown [107.108.234.165]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200705013916epsmtip161efcf4a8c0f66770fccaa943e929215~et5IUQeom2759327593epsmtip1g;
        Sun,  5 Jul 2020 01:39:15 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>
In-Reply-To: <20200704102246.GA5975@kozik-lap>
Subject: RE: [PATCH] arm64: dts: exynos: Add minimal bootargs
Date:   Sun, 5 Jul 2020 07:09:14 +0530
Message-ID: <004c01d6526d$18c365e0$4a4a31a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGPHXmhEFcAzbys4lSarlYwjg0bbAE59K/yA1z+kWMBMBDc06lX2v8w
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZdlhTXddNnzHeYN5+OYv5R86xWpw/v4Hd
        YtPja6wWl3fNYbOYcX4fk0Xr3iPsDmwem1Z1snlsXlLv8XmTXABzFJdNSmpOZllqkb5dAlfG
        zI0pBUcEK3Y9eMnYwPiVt4uRk0NCwERiz7ynrF2MXBxCArsZJWb1HWaHcD4xSjxdPoUZwvnG
        KHFr92w2mJbzV78wQiT2MkpMbnwNVfWGUeLu5lusIFVsAroSOxa3gXWIANmbbywHm8sssBxo
        1O8bLCAJTgE9if0NT9lBbGEBW4nvU7eCNbAIqEjsPtYMVsMrYClx8eQxNghbUOLkzCdgcWYB
        bYllC0E2g5ykIPHz6TJWiGVuEmd2rmSGqBGXOPqzB+w6CYGf7BK/t7xn6mLkAHJcJFYciYPo
        FZZ4dXwLO4QtJfGyv40doiRbomeXMUS4RmLpvGMsELa9xIErc1hASpgFNCXW79KH2MQn0fv7
        CdRwXomONiGIalWJ5ndXoTqlJSZ2d7NC2B4Se+4+Yp/AqDgLyV+zkPw1C8n9sxCWLWBkWcUo
        mVpQnJueWmxaYJyXWq5XnJhbXJqXrpecn7uJEZxktLx3MD568EHvECMTB+MhRgkOZiUR3l5t
        xngh3pTEyqrUovz4otKc1OJDjNIcLErivEo/zsQJCaQnlqRmp6YWpBbBZJk4OKUamLa9nnGw
        NjzK7zeHnrbn2Y6pt9ofMssqb647lW++Yc/V1Q+MZ9yJZ2188PRc7VF2+8N7Lt9fW7v8+UHP
        Y/P/6Z99uo3Vx/Wp91WGXSyep/5kpqXydGf1rH7tmbWiaYs+Q4aldPsFV9bLS9u0pe4LBLrM
        mBig9cfl7x9bydWhV65nVUaIrH84KX//ve3Pfi4Nsv18wvtXONehN8cTg1jr1iz48mjLigK2
        7M/WYbe2BjZymdu2Ra6ZxuQ6heH5lj2VblkvXUXa45wfcyx1P2zg9Hzf16vTLEpeLjt648TK
        oLPiZ3j3mjjGtRq2GNdLmdsc7l54wGHijcSQ1wu9HfSO7vzNfcZtzv31Phyfbxb5/uhWYinO
        SDTUYi4qTgQAf49buKEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSnK6rPmO8wbNX+hbzj5xjtTh/fgO7
        xabH11gtLu+aw2Yx4/w+JovWvUfYHdg8Nq3qZPPYvKTe4/MmuQDmKC6blNSczLLUIn27BK6M
        xhuTmAq+C1RMn7mVuYFxFW8XIyeHhICJxPmrXxi7GLk4hAR2M0rM3HeGGSIhLXF94wR2CFtY
        YuW/5+wQRa8YJS70tLOAJNgEdCV2LG5jA7FFgOzNN5aDFTELrGaU+HtvDzNEx11Gia63R8Cq
        OAX0JPY3PAUbKyxgK/F96lawOIuAisTuY81gU3kFLCUunjzGBmELSpyc+QQsziygLfH05lM4
        e9nC11CnKkj8fLqMFeIKN4kzO1cyQ9SISxz92cM8gVF4FpJRs5CMmoVk1CwkLQsYWVYxSqYW
        FOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgTHjJbmDsbtqz7oHWJk4mA8xCjBwawkwturzRgv
        xJuSWFmVWpQfX1Sak1p8iFGag0VJnPdG4cI4IYH0xJLU7NTUgtQimCwTB6dUA9Pe6Urqdy7/
        TTw5b9ef3aH5mp82/Hl89fX/+T+WZ/ZPP/bALlBT9t7KL2nJRje/yE5aqBBV+e3Yza9zjN0s
        Lt5xDSre/C/SwWG98oHNbB9/3m/zyDE2vuFooHjzzMI5ded19R79n/tbIqfb9jbPvLyAHSE3
        T6xfdv+LXmCgsOksaxevYMuFaxi3CPPYiisdOf4ouKLxZVbBu5hFyxffk14YtXNialVi6KX9
        PGozczg4Upb7rRbcGbBeWUZ65fdit6JOS8tcCTZuNyeOXZ05c2aLyOYvj9lxvKXoLffSVhOW
        dw7J8x9f1U99qbU4qeHlNtnT4iu6zu2QKJ539BB/yL4TDNtUk9cXL/7Jc5af69hPJZbijERD
        Leai4kQAxXKkdwgDAAA=
X-CMS-MailID: 20200705013917epcas5p452d47ac7c3d735a7e7b238947812f68c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200703184543epcas5p4adb3db7693094c72477b8469d9f205ba
References: <CGME20200703184543epcas5p4adb3db7693094c72477b8469d9f205ba@epcas5p4.samsung.com>
        <20200703182536.9190-1-alim.akhtar@samsung.com>
        <000801d6516a$b6efcb40$24cf61c0$@samsung.com>
        <20200704102246.GA5975@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> > > =40=40 -24,6 +24,7 =40=40
> > >
> > >  	chosen =7B
> > >  		stdout-path =3D &serial_2;
> > > +		bootargs =3D =22earlycon=3Dexynos4210,0x14c30000
> > > console=3DttySAC0,115200n8=22;
>=20
> Hi,
>=20
> The console is already chosen by stdout-path and earlycon would use it as=
 well,
> so no need for the address. It should be just =22earlycon=22 if you want =
to enable it
> unconditionally.
>=20
Indeed only =22earlycon=22 will do here. Thanks for point this out.

> Also, why did you use different serial for console?
>=20
Once UART driver gets probed then console changes to ttySAC0. In case I am =
using stdout-path only,
after bootconsole is disabled, kernel logs re-start printing from beginning=
 (which might be expected behaviour?)

=5B    0.012416=5D printk: console =5Btty0=5D enabled
=5B    0.016491=5D printk: bootconsole =5Bexynos4210=5D disabled
=5B    0.000000=5D Booting Linux on physical CPU 0x0000000000 =5B0x410fd032=
=5D
=5B    0.000000=5D Linux version 5.8.0-rc3-next-20200703-00008-g4af626444f4=
a-dirty (alim=40alim) (aarch64-linux-gnu-gcc (Linaro GCC 7.4-2019.02) 7.4.1=
 20181213 =5Bl0
=5B    0.000000=5D Machine model: Samsung Exynos7 Espresso board based on E=
xynos7

> However the question is, are you sure you want earlycon on every, includi=
ng
> successful boot? On most of the boards we do not enable by default. If
> developer needs, he can choose it for example via U-Boot =22setenv opts
> earlycon=22.
>=20
Using U-Boot is not the case always, any bootload can be used to boot the L=
inux, currently I am Coreboot.
And 'earlycon' is not setup by default.
As Espresson board is development board, IMO it is ok to keep it enable all=
 the time, this helps in quickly knowing what going on incase boot fails ea=
rly.
Let me know if it is ok to keep =22 console=3DttySAC0,115200n8=22 or shell =
I just re-spin with only 'earlycon'? or any other suggestion?

Thanks=21

> However it's a development kit so it could be enabled on default...
>=20
> Best regards,
> Krzysztof
>=20
> > >  	=7D;
> > >
> > >  	memory=4040000000 =7B
> > >
> > > base-commit: 9e50b94b3eb0d859a2586b5a40d7fd6e5afd9210
> > > --
> > > 2.17.1
> >
> >

