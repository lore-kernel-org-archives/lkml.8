Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9910BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7861620578
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bX9RUGDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbgGONji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730872AbgGONjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:39:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF1AC061755;
        Wed, 15 Jul 2020 06:39:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k6so2781382wrn.3;
        Wed, 15 Jul 2020 06:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=331LipqvmuxHa4q2emBmbZbjHucC9tfrGiX56G/rfzs=;
        b=bX9RUGDT9pMH8X2npSgVxbz7GEC3FGIRiJ0GsV8D6nxZjfgn5e5uzvuJILCqUYuTdN
         PX/vg54Do0TfRLNy5H4DS0G1Nc+qBWiHtf26IVPQ3OLvQfm0B1U9Iw4lwo/k8adClDnz
         T7SlQVo3GF1fpUDQNqSQ0JN+4+W8UTXL6zHS8wDSjYltuQx8ECo0EIGPNr+o2YVvz7wB
         zDWrwr8fiJIkuxYMQHXJ/G/Dcrpiyd7cd/TTmoAx5HDIrt8IYoJjIw1mvKZpc60tIYeY
         DwJQdS1pFJZIkl54cgVLxZrPd7hxdRa0ANcngNPGdq/aAnkHc5Mnh26JzAkrJ2YMIoJJ
         3s4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=331LipqvmuxHa4q2emBmbZbjHucC9tfrGiX56G/rfzs=;
        b=rOjeeR1VXrd0qgCTIZhPR0NLLhGCekaUMVNr4D6BzPVWbt7SrpvaXKk1QYFy2pqZIu
         H1I2D6zO4K1h/ecHFAtOuKo6gz5BN6GBEzoWKyBpCSAIRO6BaH6z6j05aF0zbZpCHn2i
         Q41Tm5bOq6hU5DTaKW5Tsp2VE10gNwpGq4rBfOcSohNC6we8cTLtD5ds68RbIxcWkPOB
         HuioK3HXu+BWzUluer3nPqGiAAtUPypyT/0g5gS1Zy5vdHcjF6OwWSPJHqDjtHoHJIJs
         f/W1+FmvjtlGx8EBl66UUkC5fr7AaV1Pp1Q3vwmTPGO3Of1iShX2eDWvUsHDEpyeNlIl
         JkXA==
X-Gm-Message-State: AOAM531ccH7MevNQ8Ujuu31IOMXL8oVDdMmf8yIjhjL8kUnml5yHofOz
        VVMbCNLVwy7ZGeHcOPkgLDl8L++9Zss=
X-Google-Smtp-Source: ABdhPJxcQeOWoxTkgUlKb3T3E6eZIODiRewNPO6gvvmjUi2d7LRx5ZhyKnrtebkx2V4+r8gTesI7Ig==
X-Received: by 2002:adf:dc90:: with SMTP id r16mr11474177wrj.264.1594820376227;
        Wed, 15 Jul 2020 06:39:36 -0700 (PDT)
Received: from macbook-pro-alvaro-eth.lan (67.red-88-15-120.dynamicip.rima-tde.net. [88.15.120.67])
        by smtp.gmail.com with ESMTPSA id j14sm3555568wrs.75.2020.07.15.06.39.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 06:39:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v6 2/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
From:   =?utf-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
In-Reply-To: <2e28eed25955385ab2513f8b617829f3@arlott.org>
Date:   Wed, 15 Jul 2020 15:39:34 +0200
Cc:     Jonas Gorski <jonas.gorski@gmail.com>, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Philipp Zabel <p.zabel@pengutronix.de>, krzk@kernel.org,
        gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C342CF5-7417-4C6D-B1D2-75C71B9688C1@gmail.com>
References: <20200715131803.1762064-1-noltari@gmail.com>
 <20200715131803.1762064-3-noltari@gmail.com>
 <2e28eed25955385ab2513f8b617829f3@arlott.org>
To:     Simon Arlott <simon@octiron.net>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Simon,

This is based on your work:
=
https://github.com/nomis/linux/commit/c4c55b603a78e2732044a833e248c1a1087e=
7053
=
https://github.com/nomis/linux/commit/f153a58b9e6f88e72c3ef34dc076118f8b3a=
de5b

You never sent it, but I took it from your Github.
Nevertheless, I can remove you from these patches.

Best regards,
=C3=81lvaro.

> El 15 jul 2020, a las 15:32, Simon Arlott <simon@octiron.net> =
escribi=C3=B3:
>=20
> On 2020-07-15 14:18, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
>> Add BCM63xx USBH PHY driver for BMIPS.
>> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
>> ---
>> ...
>> +MODULE_DESCRIPTION("BCM63xx USBH PHY driver");
>> +MODULE_AUTHOR("=C3=81lvaro Fern=C3=A1ndez Rojas =
<noltari@gmail.com>");
>> +MODULE_AUTHOR("Simon Arlott <simon@fire.lp0.eu>");
>> +MODULE_LICENSE("GPL");
>=20
> I'm not the author of this.
>=20
> Nacked-by: Simon Arlott <simon@octiron.net>
>=20
> --=20
> Simon Arlott

