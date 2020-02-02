Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94465C35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 23:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EBA20661
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 23:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lc+bH5oa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgBBX23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 18:28:29 -0500
Received: from mout.gmx.net ([212.227.15.15]:51517 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgBBX23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 18:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580686103;
        bh=azEbm73gSbtBKgWq9/0mmZt4SsTQ9/DE+v30d8fBl5I=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=lc+bH5oaKvniGgaXOQEo2jOBxjCZdjAvCIWmqzgRsBbFPx9sMN+FfbZKdMD9BowxJ
         2irFtqE8g0WBtvbTOf0gQeXIQkN3VlCMzxGgWIQ1neXi1bWcVoTd2UQ2A9FVJGE/Ix
         bIzQYRk46NUnuu8GvZwRmMpCsThXaGjgZdnte+8Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from acme7.acmenet ([186.48.140.18]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbp3-1jCsCz38Hr-00P773; Mon, 03
 Feb 2020 00:28:23 +0100
Date:   Sun, 2 Feb 2020 20:28:16 -0300
From:   edes <edes@gmx.net>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>, Takashi Iwai <tiwai@suse.de>
Subject: Re: kernel 5.4.11: problems with usb sound cards
Message-ID: <20200202202816.5a1d8af1@acme7.acmenet>
In-Reply-To: <20200202134159.GM10381@localhost>
References: <20200201105829.5682c887@acme7.acmenet>
        <20200201141009.GK10381@localhost>
        <20200201132616.09857152@acme7.acmenet>
        <20200202101933.GL10381@localhost>
        <20200202134159.GM10381@localhost>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J4mVlLzOdKmjydmd9g5opaxFwqyhL/Rp1urRb3vKUcgFrda1xwf
 2uBFUlozAMRxgVIq4+Xbk36xvHvH5r9/hPV9ZryxzzCJ1E+IKOGpuc+Nlae883nWfoYe3fz
 iFF32QuBuLazSyzRslVk0BEJzwXLsU5+uNx7vtmYQHoHMC7u2vIg9Sy2yRN11FiV6qbN3Hp
 kJtvWuvZYhsroeruc4otA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/2PxNXBntDc=:oDFqiYG6LbVTruKROL1WB5
 +IaCcnReSRkQ4IdcFlvz4xA5MdHkjwiJP3Azpje/+PBrREuIzdPSYuFyS6/0COnVaYYt28U1q
 sVWtIP9APa1vd3kunh6PJnyLPRSkxk8FL1QfhYP+R7qORBdqvKGt0Z/nbDr72UArAEAhYyrhN
 3pt+kw52LlBE/o64rDb/C+0zE28CtCBsggXRo0dD0x2I6v7ADEOIAq327oWHIA5yySjhM7p46
 APqPn4jQiWcs87FBQSS1g7+HuDkV/K8xXL5NAMW2Yryx1kziHOdaMuRRPs1J9G/79qYiXur2c
 uR2gFiJBOaGbazqXWuWyKn3EAlSXBFXdFUf18RKpzFLzAiBnPjREpiYVhCatpMrrKJH2M979Z
 MWqq7msx3It9Gg8+OW3qK18aqELxUeTR7yIoJsc8DRXnsE1LpG5u8D5vTXGsOzpR699El700g
 /ThBsS59Vk+sqe8CFBv4xYkFEaKA1AR77nH/d6LLf+XvkFBc/xHTks/Z5EPGGT9ZfcTW2MyzM
 EsosXG1o8em3salYLHd7dEhwyr5A1t38yPMEUh+solEIgVDlxGS4gxQi6NjKADYG2e5qvm9kA
 N8cz2H+iqF2ipRA0UMSNLVc035y3PLhcGGY3THFz5AMY3KsjS4f63f7JIo2WGgDWv3a6Xxxe1
 m9E5H8QJEMdq5loqJxHwXxVmXkLf7oJR5q3JHOAVZrdtIDP0g3NJQ5gTci640EyVmeQFbVmPx
 PHqk3V5mgt4HSDqtULk48G28NGlnn4rsVnonwTeElIGw6xE580VZE0LIctpM5PEgPkKX6ptRl
 m8H7ekMfKQqW9INSpLpsLHwLziZ4SiI/6m/SWkLbD3cpLR2uoNtoVz6GdCOkp7bkqJmZe3a4a
 OZ/E9vF4OrlwU2ZostJoDDqEUE3PBHGD5WqOwazZd8FnRULx73N/EBV3qm6HLWnpgVSRiJ4hf
 aC0ubC0b4fF4xZdqEAm73HtvINlq56V3vzU1HrquN7kIwE1mTV8usArNvUX3utvMO5MDWXnOb
 4yyfD6T3E+okxlL3SDywcuiJoTpeoyF53391MQN7V145HebeCxFVsyboFyoZR+FuhRh8D2dDx
 QoGdxNnUDevECnYDCXkjEGGsrHHJlbb67HWGKjIJvvLZiVllPkZxJ9sahFukwmFbtiDQOKad3
 Aw2YjaHTv9BGVrvA79Il7T4Sd7EeTOCmnlkMojEAXztGwcsNRAYLSTvtUdRfCLjY9wvX0lE1Y
 /yV2M/rWqitaX/3mc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


el 2020-02-02 a las 14:41 Johan Hovold escribi=C3=B3:

> I realised I forgot the test to match on the device descriptor when
> applying the blacklist. It doesn't matter currently since I only enable
> the quirk for your device, but if you haven't tested the patch already,
> would you mind testing the below patch instead?

Hi, Johan, thank you for looking into this. I tested your patch, and it
works! (5.4.11 and 5.5.0).

I haven't performed extensive tests, but the card is again recognized as
both playback and capture device. Thank you!

Is this and acceptable solution and will this patch be integrated into the
kernel?

OTOH, you said:

> Ok, so the device has a broken altsetting 3 for interface 1, where
> endpoint 0x85 is declared as an isochronous endpoint, despite being used
> by interface 2 as an audio endpoint:
[...]
> Note that the broken altsetting probably should be using endpoint 0x81
> just like the other altsettings for that interface,=20

I can't say I understand exactly what you're saying, but do you think it
could be worth contacting the company and see if they are willing to fix
this with a new firmware?

Anyway, it's working now, thank you again.



--
