Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFC9C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C362077B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="R8BaOrWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgAORzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:55:15 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:57178 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgAORzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1579110912; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ZZVRQqrxHD4LUg9xqCDh6soEht3MVKnL/1H1VjFviE=;
        b=R8BaOrWr5ieD+8tf2/e4HRFjQaDGtKkhh9ZbgQzmEO0EYTKs2kZtigFjvnsSgdw4NGuZDQ
        4RFPP9GALVyl9WHJRg4yLBdG36BjhbGEboUBRQEskOlYLHfEpJqk/1vDBqf0lJfd+7dWVp
        cmACTG3bwe4tlbo1ZSYHjaRA9bCnQlY=
Date:   Wed, 15 Jan 2020 14:54:57 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3] clocksource: Add driver for the Ingenic JZ47xx OST
To:     Maarten ter Huurne <maarten@treewalker.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, od@zcrc.me,
        linux-kernel@vger.kernel.org, Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Message-Id: <1579110897.3.0@crapouillou.net>
In-Reply-To: <2994787.aV6nBDHxoP@hyperion>
References: <20200114150619.14611-1-paul@crapouillou.net>
        <8026844b-75d2-edfb-c3ed-fdabd34a9aa0@linaro.org>
        <1579096621.3.0@crapouillou.net> <2994787.aV6nBDHxoP@hyperion>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mer., janv. 15, 2020 at 18:48, Maarten ter Huurne=20
<maarten@treewalker.org> a =E9crit :
> On Wednesday, 15 January 2020 14:57:01 CET Paul Cercueil wrote:
>>  Le mer., janv. 15, 2020 at 14:44, Daniel Lezcano
>>  <daniel.lezcano@linaro.org> a =E9crit :
>>  > Is the JZ47xx OST really a mfd needing a regmap? (Note regmap_read
>>  > will take a lock).
>>=20
>>  Yes, the TCU_REG_OST_TCSR register is shared with the clocks driver.
>=20
> The TCU_REG_OST_TCSR register is only used in the probe though.
>=20
> To get the counter value from TCU_REG_OST_CNTL/TCU_REG_OST_CNTH you
> could technically do it by reading the register directly, if=20
> performance
> concerns make it necessary to bypass the usual kernel infrastructure=20
> for
> dealing with shared registers.

In theory yes, in practice there's no easy way to do that (the=20
underlying mmio pointer is not obtainable from the regmap), and=20
besides, the lock is just a spinlock and not a mutex.

-Paul

=

