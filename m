Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA23C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B797824656
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="nUOfHjOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgAUJvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:51:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36452 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgAUJvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:51:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so2419344wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 01:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZI0atwJ3s6X/StOieAcUPING7QLdESS+gVuKdESoeM8=;
        b=nUOfHjOz93uo00Ul9JjHIYcdpXRpD91FGhXKiI3DbvxV2BO2aWgkLtnZjTUxfmDW2I
         5wIjUPAD3CzImoTZMmLQ0tdqq7owN/2wAWIgtyc1Slp/tQJa7ONrJG/tX1IOk2iNx3ps
         zKOatbgNJTJ9Wm869mOIX92Ypbuo/2KCMP+cN2yU1ZftTtlMXsr31wiBQDonV/Y81i/C
         JlegtyqVzaVGNXZ5PRRX9N0NLM/lLz0bw9imTqJpvFskBb6jf4N7D4CntVRBplsZ8sof
         T4Zz0YfiHYja9NZzcrxHfnDGnqq+jK+w7KXA9sMdIN2/gSWsULahN+ko5SxdZQZBxuKP
         ouug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZI0atwJ3s6X/StOieAcUPING7QLdESS+gVuKdESoeM8=;
        b=BbXiOe6/yzyDK8QoD7LqV07NOUnizdJUOgH7Sjdzlq4BzvP4BgG5OgpQ+lnN3kHs2N
         /xAofITSUKDmyBamgf+OQn4gjFSjMv282aM9k7h3oNadtYJQoUg0d2SnPQ1jofUnSHcA
         jvT2vUsdGd/R2l6M/Licx9nbQiQQQFubJtsyrVkEfpipfrkQKGK7Y6Axsf+pCOyZ0Ml/
         9VbofSvm2zF+QN8ofhb0scBE+AJcyzNDr7m+SGM3p3Xvkkn4lQYx1JcTCv2JWA/2rYHH
         t8XBEl710o5/Rc6lwBhVzVqjnfSedOHIJuDDIeX59XnhyoJNCMLXZ6iv+ZCEmY9rTxea
         eyGQ==
X-Gm-Message-State: APjAAAXDe8zxYz7LnGD00bGbmEsXTD9QYtia7hsDnxDz2pc1hzKzO8Mp
        dpiMuyhRVCFJp4tH5Lpr6fa7S85k9uIs8DZPT4wSzQ==
X-Google-Smtp-Source: APXvYqxAKCqSHMRYwdAc4+G8YAFujr0n0Lp3fm9R3/wAR6Pi012ThbAAQo6Ca5vAsTFhTl5nyeRAizZaA/Jf2zrnUbU=
X-Received: by 2002:a5d:530e:: with SMTP id e14mr4242678wrv.250.1579600262652;
 Tue, 21 Jan 2020 01:51:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578578535.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1578578535.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Tue, 21 Jan 2020 10:50:50 +0100
Message-ID: <CAHTX3dJZ+fsHKpen=wtw2g2fPWq1FZwKmvn5mWJpE7m3ZJSM7Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] arm64: zynqmp: Enable iio-hwmon based on iio ina226
 driver with labels
To:     linux-arm <linux-arm-kernel@lists.infradead.org>,
        git <git@xilinx.com>
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C4=8Dt 9. 1. 2020 v 15:02 odes=C3=ADlatel Michal Simek <michal.simek@xilin=
x.com> napsal:
>
> Hi,
>
> the patch 2c3d0c9ffd24 ("iio: core: Add optional symbolic label to device=
 attributes")
> added support for labelling IIO devices that's why I can enable iio based
> ina226 driver with label property.
>
> Thanks,
> Michal
>
>
> Michal Simek (7):
>   arm64: zynqmp: Enable iio-hwmon for ina226 on zcu100
>   arm64: zynqmp: Enable iio-hwmon for ina226 on zcu111
>   arm64: zynqmp: Add label property to all ina226 on zcu111
>   arm64: zynqmp: Enable iio-hwmon for ina226 on zcu102
>   arm64: zynqmp: Add label property to all ina226 on zcu102
>   arm64: zynqmp: Enable iio-hwmon for ina226 on zcu106
>   arm64: zynqmp: Add label property to all ina226 on zcu106
>
>  .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    |   8 +-
>  .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 145 +++++++++++++++---
>  .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 145 +++++++++++++++---
>  .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 113 ++++++++++++--
>  4 files changed, 360 insertions(+), 51 deletions(-)
>
> --
> 2.24.0
>

Applied.
M


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
