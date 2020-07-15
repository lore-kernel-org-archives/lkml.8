Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EE0C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D8B3206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="FdASlJ7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbgGONUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:20:24 -0400
Received: from mail.nic.cz ([217.31.204.67]:41280 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729900AbgGONUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:20:23 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTPSA id AAC84140968;
        Wed, 15 Jul 2020 15:20:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1594819221; bh=EhvEo4m4fKGkK7GF8jSxHSKc1eN7KqOotdvfp78dHIE=;
        h=Date:From:To;
        b=FdASlJ7vdxKjyIY/Xqz49mtaP2/xeCzwUwpM08kQJcfFVYoCs84cOKaLYqUXyfgd+
         NoBgXj2NV1/ZrpmNhamXJ2gffI753w1WiLHY+J2HADCMRvmocCGe3ZbS+nGkYULtdN
         2mWcK1PILV6jjZ5y/37lEKdzJjPWNd1XGGBOZWb4=
Date:   Wed, 15 Jul 2020 15:20:17 +0200
From:   Marek =?ISO-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>, <robh@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v30 02/16] leds: lp5523: Fix various formatting issues
 in the code
Message-ID: <20200715152017.4961ddc7@dellmb.labs.office.nic.cz>
In-Reply-To: <20200713154544.1683-3-dmurphy@ti.com>
References: <20200713154544.1683-1-dmurphy@ti.com>
        <20200713154544.1683-3-dmurphy@ti.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 10:45:30 -0500
Dan Murphy <dmurphy@ti.com> wrote:

> Fix checkpatch errors and warnings for the LP5523.c device
> driver.
>=20
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/leds/leds-lp5523.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)=20

Reviewed-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
