Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB3DC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BD4320578
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="buUx2qTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbgGONU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:20:59 -0400
Received: from lists.nic.cz ([217.31.204.67]:41476 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731457AbgGONU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:20:59 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTPSA id 23DFE140968;
        Wed, 15 Jul 2020 15:20:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1594819257; bh=MKsvJ3WgdNJPCd+vYDcqNV2g9WbIM7ygtB7ybQlAeGg=;
        h=Date:From:To;
        b=buUx2qThhjCdZvYwBpaAxEmBrBDfZ0JHSadLQM+bbzyKduMOAIOCzMwVNzyTsGBiA
         V2+/pF35hTi03NUCdMfplsTCIy8R+1YwIJVZYpDK1ena10vEtRvHDPCJ5fJ0ktMQIz
         IfhIggfK92O0z1o9+9y9x6Fq1RKANd9EYrfGErqY=
Date:   Wed, 15 Jul 2020 15:20:56 +0200
From:   Marek =?ISO-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>, <robh@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v30 04/16] leds: Add multicolor ID to the color ID list
Message-ID: <20200715152056.3505e181@dellmb.labs.office.nic.cz>
In-Reply-To: <20200713154544.1683-5-dmurphy@ti.com>
References: <20200713154544.1683-1-dmurphy@ti.com>
        <20200713154544.1683-5-dmurphy@ti.com>
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

On Mon, 13 Jul 2020 10:45:32 -0500
Dan Murphy <dmurphy@ti.com> wrote:

> Add a new color ID that is declared as MULTICOLOR as with the
> multicolor framework declaring a definitive color is not accurate
> as the node can contain multiple colors.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/leds/led-core.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
