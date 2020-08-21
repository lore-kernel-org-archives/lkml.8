Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805A6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5371B20FC3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="O18nxIBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgHUOHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:07:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:54517 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgHUOHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598018836;
        bh=SURAhCWxL+rs+XOTcdFkDFeBFaamdGl0DhExNOgri7w=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=O18nxIBVNV6XS9CQfovOfLZRIXljMXkhlqgyEDZn+GjiQGuNUo5CEmYlk/MADGjM7
         tJOmSuGgjA2inkI+skkDeHWR0o8rVY+cvW4pm2p6tAUmzLYeqr7DC6do2BAYt+faLM
         LwVIs3MKxmrhtyDPfcmiq6Gr06nIdHGfHWJdH9WI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([185.76.97.101]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwfai-1ksYg54B7S-00y9Jo; Fri, 21
 Aug 2020 16:07:16 +0200
Date:   Fri, 21 Aug 2020 16:07:09 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFqH_53ppxNqhjqpv8z4vz7GPFMxtM8nswx5pgyz5Sx00wGbFA@mail.gmail.com>
References: <20200817145738.986999-1-linux@fw-web.de> <CAFqH_53ppxNqhjqpv8z4vz7GPFMxtM8nswx5pgyz5Sx00wGbFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Revert "irqchip/mtk-sysirq: Convert to a platform driver"
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>
CC:     Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <7571F14D-DEA4-4C85-AB45-3BB32668E6AA@public-files.de>
X-Provags-ID: V03:K1:mPqiuDXJ7hRuccO8KOuiy60/LPRh3L7bw7B4ZBybUBeJsJo3b/3
 MPhg6VUkL9SPXnux3eFz2AymIyii3b0lCEP8MrujU8lqoF6uQAmy2Khs3bkrf8q0glldqjb
 fRh3wsaYqNe0EvQagOo/URNGe4wiARZHWlyxTFFc1SX30OPYN266TWFnwDpmhkpuH7B35gq
 6rDN+XVQPKt8z20lG1qUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v5DuaNRfzL0=:jJTMR9iMcMuSHq9Iym1XYx
 t+uR+GBzIEAgOlU8vxlyIIPeIac1o6Jqoy8Y5I+RpfP3f74QX0gv1MZvdE+wLKPfHSqg9+3Zv
 7UduR69E8UuIjNsBT+eY6QpnVMAz+NcyB7OeXyPhv8epA5Qxwq3qxnr9nD6ik2KSP2UCzXGmu
 zzLXP9vwU7Tq6zY9R4nSB3XHaNdqGiYersUyfCVc3rV8Tu21bnQgv2kqzDT1ZFrMdMspAPf8B
 nFYS/C5gadmF7xdZwRIOuOa0ZD0NJPIyTYewJ5EKGbapf0vgbBSTrLlMcMtlXkHBmZDZMTPWU
 8UoAGvBi+AYFEwgN5VvCtc3+aV1pPt7uWbMxZFkkBBJgJlUWPh/91ui8qReItVzCRIYffuXLQ
 UQQx4cjtPh5zhqbdzRDyhaLdUnqZdMoMu/NPn6YaKgakOXiDzHlC6LE2MegdYZmtuFbmE+sfK
 34r7ziLy/r1g+mRzNcCeYX458oeVu5qOI+9prP5PflJCHyB98VmSgnmv/IF3im3cxvjWpEwzY
 sG8C800kh+lr7JEFhR1ScL98hDjufhbsbsQOTDsy/Ho18exLE0ENGOlV/ssOcxpW8YfzgprNr
 S1UgISMGOajGcT/Oo80Zzk04rm407oSN2HazEu3g1G129XFZ5v+fIbf7b0vaiC3b2sFljy++x
 TmTIVt7CTMiw1UW+OcURc1DJuFKjt1/4YBvcF+wk+DgW2+t7Shy0YkwH8K87dE1syhQjO/sF1
 29mF2vEOONTWdKKO+jAZJHiJoQWiON5nZWe02QuZ2t7UEaGPK0lo4uWF2+t8r4WsY/coAy75h
 ZLNssk69clDa8/PUOmSgQ5L4LMMgtF124ZngBXpA4RxvIUSQVCwF7TYSa/dGEwTHvv8d3l2oO
 Q/2nIpmij0vpP4FAYdwTl9jZxfC0nSg1mkjKSABCcbIZegPMcHd9C6XiWHBolnF1qeyY6LYe3
 /gYrHe8aZUk5Qx2DgMYoEM9tsw7V/5olP2EkPIATag8gCoxunW193UOaErodqjgmPG/JUbMom
 EkopgX+X/kwv6boMeQthI3S6Z4oLf4xKkfYvq783ng+Iy7FIWUIBqv89TCGSZ+3oBInXcn49G
 50zZiMXSvbTskeuu00HxP1EzV+eJHxzbJdgRanzvjA5g5bInwssOT/kEaK+t9+W1MMj6YF2p2
 xKwnjjj56y7EiE0MHHP7AKNpt2SlisWGx/t4jv/h6hkMjt2QbxbPCWOcrmILHZNn1cR7TnZ2u
 Q7XI0s9TEhJABBpiZc68LsRc30vAEw/vCGKONWw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 17=2E August 2020 17:04:32 MESZ schrieb Enric Balletbo Serra <eballetbo=
@gmail=2Ecom>:

>I already answered your BUG report, but, for the record, I think a
>proper fix is following his way [1] and probably will be merged soon=2E
>
>[1]
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/maz/arm-platforms=2Eg=
it/commit/?h=3Dirq/irqchip-next&id=3D7828a3ef8646fb2e69ed45616c8453a037ca78=
67

with Patch "irqchip: Fix probing deferal when using IRQCHIP_PLATFORM_DRIVE=
R helper" i can boot my board, but i get these errors:

[ 0=2E014234] irq: no irq domain found for interrupt-controller@10200100 !
[ 0=2E020981] Failed to map interrupt for /timer@10008000
[ 0=2E026248] Failed to initialize '/timer@10008000': -22
[ 4=2E314126] hw perfevents: /pmu: failed to register PMU devices!

if i revert f97dbf48ca43009e8b8bcdf07f47fc9f06149b36 these are gone
regards Frank
