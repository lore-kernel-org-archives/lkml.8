Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B020C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9A620B1F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="mzrdEIiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgDINFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 09:05:25 -0400
Received: from mout.web.de ([212.227.15.14]:44593 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbgDINFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 09:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586437519;
        bh=pdTvAlI3N4fXOnDTP/rTIVU30iaj/Z2obJ7/NGxzl6M=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=mzrdEIiLKsjxXs2TwVnX6X6JIjVYOhlT64xwsNMWsPYOIeXYQwMxs+RoJ354OXBXv
         AFQUTSsKZzZJe7VuhiETP+9GcBY7v6SqCVUEEVXmARmypWQWanq9CBLBURFvrxKhVL
         saUVqRuEos2R/Co+XhKxF3SI/+rx1iT1+Y27l4Kw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.133.77.56]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0ML8Vd-1jMFkl3iQT-000Ixb; Thu, 09
 Apr 2020 15:05:19 +0200
To:     Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: drm/tve200: Checking for a failed platform_get_irq() call in
 tve200_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <0263f4fb-c349-7651-b590-8722cdd30c85@web.de>
Date:   Thu, 9 Apr 2020 15:05:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wjsT6tNGG/h3uDxJEg4/4mXra+qdNJxG1omsKT7lgkRF5XcgI2Q
 uKdtczR1znRwgemW8s3KkD/iBdBbmlAf6fgUk2Fi/wpa7O9arz8oW9KJLQkyhismGunNZ3m
 PRMRDBg5x+CDDRyqqwp0pOps1Sp9pudMfUNEYIH1g9fwnBDBhpWQu21NFDyWWk58sReD3N8
 Jww1Q6u60QxZ769MEVM8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9hS6Z0RwO1A=:xOb6oXpb2KFdWHAUuHreN4
 nMf1ubiIWbiIvQ0GBG1i30WLMR7dOlWOP8we44+VSX00Y7HMBYBC2Beq0kK868qrWETY6jBTm
 qROz/cHDM6Ujjj6ZYtlsChlRs9Zr/DV81VeAN/QpQFXAHjGO1BqojV1qjvo98N7Gd8mhTkadP
 qE1t+0Itg6X/PkgnFnQ5o4hKajRQYjV6y/UVrmqgM++r033ZB3OBrP7cHWzYliIJ3DV1Sifjp
 Ogl9I5gKsqSYrmgFCMMiiAXKYLssl+FGXW5pIDt8PYrns/iXU0AbV3p61h4T7p3jv6It67WZw
 ouejn0Dj1usi1E7gxvlSMhFYzyUbzFET8GUIeF5PVnEeSt/8CV7hJgakQCFo6IJJZXyV6gH8z
 +AFw1A0v4kNmWVc8A2wkxiuptpO3dQwC8KRWzO850dHLwW4sTx/Z5HuBg0Oj7uCtXFzX+4Lum
 J5OKMIMlK3/hloL2TgAi01vttRE58OSaFhROMoJ9ePOB/KvVN5+JPim8Mf0oDdR1QMZq+trPX
 Qvyj0EKnmjLxnN7MS/FJHoVx3m2zquJ8X+pIw6MjCzB7DIjLCxUX58vcd5afPCD1tjg6THMs9
 wY1hEyoqR60G/8OsFIMXrgVx7SNmjBSVHLZ1cTe2rA0F4rzFI74Cor36bz4HVAmQhSnKhVrQV
 gyoD5sIbbCwu0fKlxp2aM12Y1OHnIfscgHv0AJijpCNOH/bn47GbdvS0dpF7nU6EttitY0swQ
 yiafL7MqqKjE6UxvBDbpnwSRC4ZphBLzwCebbAOaUeMZ728IGTZbKTwn92wiinnq1KvMPg2UW
 L8qYoz+PCbN+NkquWN09D+nnvii0EFGftQczfG+PM97ALJ7pRft+ZHnz0uuz0tcBhlnU3zim7
 itBTdk81c9JpwyWnTkvF31ixVX5m37Mt2lJ6GIOlsVU6JAPaIN7grcyJIXiub94JsFkSwILt8
 nojCHU8R3P8Tb2BxOKhDvf9nCdUVBwxzFFAgMTGro6ptEKsU5WJfcv1Fmf6pP3qGqUghQ4c5i
 Cg3/x9v9TcBpPG720Dag6InnQeyDbC0mN9GrnJ6x0pKHQevCs4wUc5j4PGpuQS8Qe3shavMf4
 gEM1mNwOmuf9mUWHIVZIOr2X6mFTilBf0rBL1HaTsgHkg/qJq7/o0lcKlGdqPTVvgdomUic8j
 A3Wx3S0cg+VTGyfPlNPGtcQV0oDeesPQEnOAu2oYkYVWwjPUlh/rThwWTqcp5DmFzV5wkPMs8
 ePbD9S6qcbAwpTFyL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have taken another look at the implementation of the function =E2=80=9Ct=
ve200_probe=E2=80=9D.
A software analysis approach points the following source code out for
further development considerations.
https://elixir.bootlin.com/linux/v5.6.3/source/drivers/gpu/drm/tve200/tve2=
00_drv.c#L212
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/gpu/drm/tve200/tve200_drv.c?id=3D5d30bcacd91af6874481129797af364a53c=
d9b46#n212

	irq =3D platform_get_irq(pdev, 0);
	if (!irq) {
		ret =3D -EINVAL;
		goto clk_disable;
	}


The software documentation is providing the following information
for the used programming interface.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/base/platform.c?id=3D5d30bcacd91af6874481129797af364a53cd9b46#n221
https://elixir.bootlin.com/linux/v5.6.3/source/drivers/base/platform.c#L20=
2

=E2=80=9C=E2=80=A6
 * Return: IRQ number on success, negative error number on failure.
=E2=80=A6=E2=80=9D

Would you like to reconsider the shown condition check?

Regards,
Markus
