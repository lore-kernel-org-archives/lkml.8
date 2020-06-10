Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3B3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4746620734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGLcspUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgFJGM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgFJGM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:12:57 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06885C05BD1E;
        Tue,  9 Jun 2020 23:12:57 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q11so830255wrp.3;
        Tue, 09 Jun 2020 23:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YFS49LeAdYWsFkZB6toKPPYrtNxxXWg+HB/beR9uOGw=;
        b=cGLcspUr0IuodOqnZAQPSb34Uq+ZHE/hNdoknVPmWWB7jmgqzuNaU7PWQWWYNfhgXk
         CEFkpxamdRuISq5JD4vvNprtJGe83xuHdqOFQOWfQ0YIer42HjR84BsYlf5G5qq25v5a
         kOX9FgoUqJibf9kBYZegnueXdmWmXolWYMbN1LD4VcanomrIIhsBN9b6qOvEeOz9rGFT
         hloQkqMzQ6AqC9M4mJCC1quRpu+NZErUvft6B0s/8Uwe34y2zkErYnd1MioBcPpwOMrI
         +QjbtX6VkOyzTpl6cEBWHzormeWieFoGfd4FL/HvYjqSbeCj6OJhzxkCmae3RxljzDyF
         oexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YFS49LeAdYWsFkZB6toKPPYrtNxxXWg+HB/beR9uOGw=;
        b=kDxZwj+8Ik2/bHoHPbO9FtaetKpnjGulWNDagZsikbJyS7/hsPGTw8rJnOVGX6G+gJ
         RPjHGfeYcumWSI42KzsdnpF1CQw4VBGT5iaKh0d+Irvi8Rbt7hynn2uYqQ5ZIEcg8ER1
         B6hDRifD0EiEYRieeE1COxCU2/2uf8H5yhY5ngMeRrGEXXoYcnc97Lk8tbFGB4Y4SBb7
         nNuk5q8ZLaajO1E1cX9YILuYillYkelY+5S3Y2BQanqEPOXGiIEgMJj686IOMizR+OOT
         8sLp8/CZRXES1ImLUI6PdaChy5TorCQgw+mZQi6FF6DJFuQUYpdDWLv/zAzNENGyMYrI
         jDOA==
X-Gm-Message-State: AOAM531QGcaUoBI6wBVq5HCLvkr80WrAy3lBk8lfgcTm/KDwgnUND4DT
        3BeBJppxeiCljkdhtim4CBk=
X-Google-Smtp-Source: ABdhPJxgn9mt+j/iAy3c3Gf1zgcXhSDyAzwtE33TyE+1dpPQn3yHQl0MPpY1xCBc1tFtNvPNTzVwLQ==
X-Received: by 2002:adf:9795:: with SMTP id s21mr1831925wrb.166.1591769575644;
        Tue, 09 Jun 2020 23:12:55 -0700 (PDT)
Received: from macbook-pro-alvaro.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id l2sm6425028wru.58.2020.06.09.23.12.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 23:12:54 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 2/2] clk: bcm63xx-gate: add BCM6318 support
From:   =?utf-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
In-Reply-To: <1367fcf3-24ed-9106-a329-da5f8e168e17@gmail.com>
Date:   Wed, 10 Jun 2020 08:12:53 +0200
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        bcm-kernel-feedback-list@broadcom.com, julia.lawall@lip6.fr,
        f4bug@amsat.org, jonas.gorski@gmail.com, lkp@intel.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3E897527-55EB-47DB-99ED-C737725F0F9E@gmail.com>
References: <20200609113049.4035426-1-noltari@gmail.com>
 <20200609113049.4035426-3-noltari@gmail.com>
 <1367fcf3-24ed-9106-a329-da5f8e168e17@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

> El 10 jun 2020, a las 4:27, Florian Fainelli <f.fainelli@gmail.com> =
escribi=C3=B3:
>=20
>=20
>=20
> On 6/9/2020 4:30 AM, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
>> +static const struct clk_bcm63xx_table_entry bcm6318_clocks[] =3D {
>> +	{ .name =3D "adsl_asb", .bit =3D 0, },
>> +	{ .name =3D "usb_asb", .bit =3D 1, },
>> +	{ .name =3D "mips_asb", .bit =3D 2, },
>> +	{ .name =3D "pcie_asb", .bit =3D 3, },
>> +	{ .name =3D "phymips_asb", .bit =3D 4, },
>> +	{ .name =3D "robosw_asb", .bit =3D 5, },
>> +	{ .name =3D "sar_asb", .bit =3D 6, },
>> +	{ .name =3D "sdr_asb", .bit =3D 7, },
>> +	{ .name =3D "swreg_asb", .bit =3D 8, },
>> +	{ .name =3D "periph_asb", .bit =3D 9, },
>> +	{ .name =3D "cpubus160", .bit =3D 10, },
>> +	{ .name =3D "adsl", .bit =3D 11, },
>> +	{ .name =3D "sar124", .bit =3D 12, },
>=20
> Nit: this should be sar125

Nice catch, I will fix this in v2.

>=20
>> +	{ .name =3D "mips", .bit =3D 13, .flags =3D CLK_IS_CRITICAL, },
>> +	{ .name =3D "pcie", .bit =3D 14, },
>> +	{ .name =3D "robosw250", .bit =3D 16, },
>> +	{ .name =3D "robosw025", .bit =3D 17, },
>> +	{ .name =3D "sdr", .bit =3D 19, .flags =3D CLK_IS_CRITICAL, },
>> +	{ .name =3D "usb", .bit =3D 20, },
>=20
> This should probably be "usbd" to indicate this is the USB device =
clock
> (not host)

Ok, I will change it. I got confused by the fact that both (usbd and =
usbh) were present on 6318_map_part.h:
#define USBD_CLK_EN         (1 << 20)
#define USBH_CLK_EN         (1 << 20)

>=20
> With that fixed:
>=20
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> --=20
> Florian

