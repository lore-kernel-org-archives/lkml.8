Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00DEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9688A20873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389339AbgE0Ohx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:37:53 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:52715 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389198AbgE0Ohx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:37:53 -0400
Received: from mail-qv1-f43.google.com ([209.85.219.43]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N5UoU-1ixc5l2DSE-016tEC for <linux-kernel@vger.kernel.org>; Wed, 27 May
 2020 16:37:51 +0200
Received: by mail-qv1-f43.google.com with SMTP id r16so2425734qvm.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 07:37:51 -0700 (PDT)
X-Gm-Message-State: AOAM532etWNip7WYtpK4rc2aQAdzFmUpO0dXdAnLlwZG9GRHQKSpQiG/
        yne4/yjMKFzF/JsJtzF5Bc1Ns/dQky8PRWwcXH0=
X-Google-Smtp-Source: ABdhPJyr//A2QIA6/VozIoK3hiWlXU4CoTxPNHDB40HBdX5R7LVfN9VrEtLqLnwnDTFroCXlHhy1X69ousiROtCYm50=
X-Received: by 2002:a05:6214:370:: with SMTP id t16mr25364732qvu.197.1590590270488;
 Wed, 27 May 2020 07:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200527134210.847411-1-arnd@arndb.de> <20200527155304.0cf42848@xps13>
In-Reply-To: <20200527155304.0cf42848@xps13>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 May 2020 16:37:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2DKqO_LUCTpyRrow_9i5OudMdedjczbydrq+hC_CERmg@mail.gmail.com>
Message-ID: <CAK8P3a2DKqO_LUCTpyRrow_9i5OudMdedjczbydrq+hC_CERmg@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: arasan: select CONFIG_BCH
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Piotr Sroka <piotrs@cadence.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Y5zzUsXBCZ5TlQCEaV1lgiqbb1i/m6lCRIoUVKkqCNI9cZQ7X5r
 LXATm/xWTeevNIqXfWST0rqnKiW0vMNEgiPsXu/mx1SH5zqe3L96wv2g6rPyT6Z7fjYnkxV
 hk+51WNyJsAHq+Lf0twjgAvefx8eKPYfJM72jS26GDqnQ7EVl+0xY5Y2+dS1qrjzwGVCJcq
 +O8Pt1nC/9R665i0x5HqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cNIYvZO1Q6k=:pyhDIssDbo/7582d+gNkpm
 zUpZUWbwyE+TITZ6uuWkzdaXyrPQbAryNyna38fCXJ9k9CUmbrsLgTuwCBLXS6lZCar9ly0TY
 bs5jTn+XuVkswLs3j/q3oG1CI565UFCZJdZjqvAfL/DsTH9cS/Rl5cBn0dViz1Nl9pXzDybNL
 +bF0+P6OFk1fLZI9vQiCpADfwmkJWMUeVqgdAtbhB4KMzVj08cL5An+ca8VE66mRi6ySYIXho
 QcrH9uUi3n4bl6xYngMjbIqit/1uXrW+MDUvmTNI7ZfcsJDyNK/pm2bEgVm5I3bZdkGLtmwAb
 r99AKeotXvFpx31Vu4NuyKQJ/0k+zZiqDFkwYKvRySR6K3qK7iRjhZkDAW8rVvH61PG1YTIeY
 I3kaaVrbELq/Oi7vxpjdTqUUp9yXOlTd4YN0xAuXyIIndbGBU9g8QeN3Mxewb946U6xxvUK42
 izkMdEAam3Xohih3i+YK/1bA3Wm7z/UisEuchQCcTG3723i4Jz3GYCBFa19yml/xDQRZMFktn
 yLHrnzpHl8fsB7bFySyDPEnVykzWCZXY6uCakRS9Ay3wVQOwgBssejEgvGVMPy0NiyQHUQYxf
 8dCtzgCwDCq9RVF0y0thn70rmO+ONrmSOq7dBlq2+NJpsflUrn4Tkexb5w4dNLmrkD7HCTMaf
 7KJAbpZY2Fy9BRbAm2k2QuVnbagqgRW2Ycb/vWqSJduPcPVR2VwwVurVB8+k/quvu4b0KTqvz
 tJfru+0KYd2FUkGfHzfYpIkbfAMBXOpHdQ3TrRBsckO5UeamZpeeLCLlC8Jo/ebLtNj9RfAGO
 87guyX8b5s7qg9QJAb0gAzB2OdMcrerp5bJstonDoAnRzzeEes=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 3:53 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Arnd,
>
> Arnd Bergmann <arnd@arndb.de> wrote on Wed, 27 May 2020 15:42:03 +0200:
>
> > Like several other nand flash drivers, this one requires the BCH
> > library to be selected from Kconfig.
>
> Actually most of the time these drivers do not depend on BCH directly.
> Here it is a bit particular: the hardware ECC engine logic being
> broken, I found a workaround by using BCH's library functions directly
> to verify the hardware correctness.
>
> Anyway, thank you very much for the fix but if I didn't make a mistake
> it should have been fixed yesterday night already, so it's probably not
> in linux-next yet.

I'm still on yesterday's linux-next, so I was probably just a little late.
Thanks for fixing it already.

      Arnd
