Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B78C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F64520658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="xZ3HXioY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbgGONTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbgGONTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:19:54 -0400
Received: from mail.nic.cz (lists.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A32C061755;
        Wed, 15 Jul 2020 06:19:54 -0700 (PDT)
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTPSA id 599A7140968;
        Wed, 15 Jul 2020 15:19:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1594819192; bh=uAxe5/z8K56pWVvyI4YptHZOZjGfj2fmrRodtWbS1cY=;
        h=Date:From:To;
        b=xZ3HXioYzpKa9LhuSFSGDhqTrFklxBZDUZF42NE8Luy7CCvZdi8J3aRNbZYfJ9AlT
         /v1dAKOuiaHJ4UX0lAxsk2kaMn7FD9cpurWnKW1zVd+KFlJd3yn8hb+filtLIh7llf
         lKzDUqtG9Cux3KsOSmXP/vDskVJBjmuPlSmI4h9o=
Date:   Wed, 15 Jul 2020 15:19:52 +0200
From:   Marek =?ISO-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>, <robh@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v30 01/16] leds: lp55xx: Fix file permissions to use
 DEVICE_ATTR macros
Message-ID: <20200715151952.6d08621b@dellmb.labs.office.nic.cz>
In-Reply-To: <20200713154544.1683-2-dmurphy@ti.com>
References: <20200713154544.1683-1-dmurphy@ti.com>
        <20200713154544.1683-2-dmurphy@ti.com>
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

On Mon, 13 Jul 2020 10:45:29 -0500
Dan Murphy <dmurphy@ti.com> wrote:

> Fix the checkpatch warnings for the use of the file permission macros.
> In converting the file permissions to the DEVICE_ATTR_XX macros the
> call back function names needed to be updated within the code.
>=20
> This means that the lp55xx_ needed to be dropped in the name to keep
> in harmony with the ABI documentation.
>=20
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/leds/leds-lp55xx-common.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>=20

Reviewed-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
