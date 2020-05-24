Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535BCC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 11:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3897B207FB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 11:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgEXLPK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 07:15:10 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:37371 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgEXLPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 07:15:08 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MowOm-1jFK8C3lGw-00qOwI for <linux-kernel@vger.kernel.org>; Sun, 24 May
 2020 13:15:07 +0200
Received: by mail-qt1-f174.google.com with SMTP id m44so11916097qtm.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 04:15:06 -0700 (PDT)
X-Gm-Message-State: AOAM530+dCrqfy+5KrGLuTjRJH8Gb29jVT86eupn/6NEILofjhNzSRzy
        knNXqiggzE5xPKcqTr7ROh0ymzUjk/q1nJgNiL8=
X-Google-Smtp-Source: ABdhPJzLa7acitFD9xvGhwFgsyhGkTphi6Wcqu/pQU40QEW+DA8DKggWRsmYhNkmqGbzLOwBirNaXJMcJ7YBNL4WB6M=
X-Received: by 2002:ac8:474f:: with SMTP id k15mr15122856qtp.18.1590318905777;
 Sun, 24 May 2020 04:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000861e3305a65e9d74@google.com> <768166145.263589.1590307748272.JavaMail.zimbra@nod.at>
In-Reply-To: <768166145.263589.1590307748272.JavaMail.zimbra@nod.at>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 24 May 2020 13:14:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1VwDCAbzVXomsqOON+xyKC6XNNzpjEh9rgXJ9Dgb4V-Q@mail.gmail.com>
Message-ID: <CAK8P3a1VwDCAbzVXomsqOON+xyKC6XNNzpjEh9rgXJ9Dgb4V-Q@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in uif_close
To:     Richard Weinberger <richard@nod.at>
Cc:     syzbot <syzbot+0ce97ea45b008ba3b8bd@syzkaller.appspotmail.com>,
        daniel baluta <daniel.baluta@nxp.com>,
        festevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel <kernel@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-imx <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        shawnguo <shawnguo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:O9szvi+71zuEMXhDoHRODeJhxBFpfzASVZxCr1AC4q2A7kKRjfO
 Z5TAHMM4C7+mqvrRT8gT7FPIX052UZVNyZxuCXv8n5IFK2vsfO3N6huYfvCaw2/ddrcJSX6
 JZV1Od+acWHDp7MLSTNLO4wggDVkFC53pzhbtPPKNgBegukzAR4oueXIspu5jGA7S9+gpve
 CRLnloPaX8Hm960LY5u1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8YPIMLk+Bh8=:GRI14NeWjKG2VMt2p3i1IC
 7pVeCwT2Vdz9thkCRvL3Tb4v0VKqappRKL5Zeojoz+dR8ZP+EkrfhzrrvLQ4D4A6Sqqx/Ue0C
 H620R9Id1s+ZOoZGxQTAsQYrSin4fcq7Y7LHaogdNdG8iGHmQZPkEud3sCKWAKg/u9ISTJ/uH
 mxzuwBVpZf0VcZDL8WViRfHir7Bb9WaHQ0iwByB+DO0mbk43Ni7vmMRCtlCS3S0FKLkOGyImv
 kFS6QR8T42L5Kqk21fcrOktdDYcdx/s12I5pw8u08MSz/CV/Qizf3dYyb2tq7Nn2FYRQaZE/L
 Jql9fNuWiWLBjDQx3xUizmFg96hG8HiB5AtshPddDQ9CMetlZc5EaE41qRffRsitJPo00ztaG
 7R+yubARlNgud5HOGoFCcRsc6PAx8JJ/op2LX0Ctcy4+DiiMJiJP0cyPkdH3JQx0UQXkhOPjr
 lClmgVcvyVETy1EyZrwavE/3oMhumIyZ1dI5NMbaYh/i+TQj5YRV0JDD3nM2vbNrrWFZK40FE
 b7VDMocMB/YxkxMzA/+9+XSKLfg54jzQoYaafIpMVLj5BJqRNU4StNtBJrNyJNjfmT35dSfSN
 oAjvkD3bm4g79t1/OcHBhyLzDuJwgo3WO5FuSzwLTzGvW7B/kzKolOwN6NQA1/YE1ppRfYnO0
 QTUxDC04R42cerbJN+OWaRuNcF/LxZUSt0bxvS2++NZGgvpx119izPaHHMgL8Bq2N0NVrMdHf
 eEP7uFtg3AcVzY+ytfPGwaVZwm8QWovWBUQOhAW1bpcsNxHISwwobU7AWE1YXhvVzEqtOYUgJ
 GHHhSKzClzK+gCFTxGhiRNFyWBJ6fo8yUz9KfyIdw5PQUutK8k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 10:09 AM Richard Weinberger <richard@nod.at> wrote:
>
> ----- Ursprüngliche Mail -----
> > Von: "syzbot" <syzbot+0ce97ea45b008ba3b8bd@syzkaller.appspotmail.com>
> > An: "Arnd Bergmann" <arnd@arndb.de>, "daniel baluta" <daniel.baluta@nxp.com>, "festevam" <festevam@gmail.com>, "Greg
> > Kroah-Hartman" <gregkh@linuxfoundation.org>, "kernel" <kernel@pengutronix.de>, "linux-arm-kernel"
> > <linux-arm-kernel@lists.infradead.org>, "linux-imx" <linux-imx@nxp.com>, "linux-kernel" <linux-kernel@vger.kernel.org>,
> > "linux-mtd" <linux-mtd@lists.infradead.org>, linux@rempel-privat.de, "Miquel Raynal" <miquel.raynal@bootlin.com>,
> > "richard" <richard@nod.at>, "Sascha Hauer" <s.hauer@pengutronix.de>, "shawnguo" <shawnguo@kernel.org>,
> > syzkaller-bugs@googlegroups.com, "Vignesh Raghavendra" <vigneshr@ti.com>
> > Gesendet: Sonntag, 24. Mai 2020 08:03:03
> > Betreff: Re: KASAN: use-after-free Read in uif_close
>
> > syzbot has bisected this bug to:
> >
> > commit 32ec783ae19d48084b893cc54747fed37b07eb0c
> > Author: Arnd Bergmann <arnd@arndb.de>
> > Date:   Wed Apr 8 19:02:57 2020 +0000
> >
> >    firmware: imx: fix compile-testing
>
> Hmm, from a quick check I don't see how this is related.
> Arnd?

I suppose this was a randconfig build for a configuration that did not build
until I fixed the build stage, and then it failed at runtime, so the bug would
have been in earlier releases as well, it was just not observed.

     Arnd
