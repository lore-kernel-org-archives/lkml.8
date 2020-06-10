Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47079C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2199A20734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2j0TJcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgFJGG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgFJGG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:06:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F19C05BD1E;
        Tue,  9 Jun 2020 23:06:26 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j198so3820480wmj.0;
        Tue, 09 Jun 2020 23:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=34jyuFlOJOGWCs4VyWJzOHASp/gmbYi+UUlU7Aqwhow=;
        b=A2j0TJcPXQMqxfSdZdPmApmeBut68pEJMWH2aTgIaqJR4pniR9FzZfetbwAEbQT1bv
         fAFWusFzTDOQgig36lRbu7PGCQqOwuB+o6uPDm53cOw6VYcXe7acutGeJTSsXtOGas3c
         7+UkPMqLTiW2keS00QxmI1jRFyWnH2HA29MmQ56/ob4LhfVRRQ9ONL33D1kMCskz/Tmo
         fVVQpPaOXTMd6DNiezKW0BWhhNQeLx8T4n66SDtCgv3a8A3tw7cHy+guI6iuCHsjqP9x
         q/G3GRn6dGX5ssBfDrh9kthyAe8MwNRTQw9pR74IfW8DrHYCPr7jjasU5uxFVZNE60q9
         CiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=34jyuFlOJOGWCs4VyWJzOHASp/gmbYi+UUlU7Aqwhow=;
        b=aRRi4vADkzq2uDd4+4+jovC6Hy9Vzi6xMzUMObivQM9MJ7yPpK1LzqIiToqUkiPX38
         4HnP+hvAxItCLs2Dmhe4AeH7x6CsFwc0Rv9ac43056cFln0v5JXPxy6fMqv/us1OsxtD
         U+dWIGR/yVJWnl81kCalsAnilHyp7dIjQGUrHRBJ2hjvTPDbyY1+7wTvIYmZMObFvDD1
         mvle36cgtGCT5gWTMoE8epMJQiad89WpW19Bu4LPh5OUdvMcai6wYlwmVU6VRy50DsbJ
         NBCMDxLd0TGNWeZanJf+UJ2PLbTEwyG0pCsCeEEn5YrDkw+AuiWcjJKqgOsetC4EBTyW
         XKtA==
X-Gm-Message-State: AOAM530Dp6plN9wD0VjhHvVoAD+mLyLRJRyP6XRs6ECs2daGWUW+15xM
        99N4g3n1QeUr5RPQRBoIddNF9otDviU=
X-Google-Smtp-Source: ABdhPJxA9Qe489Bvlee8FiCC11mA12/8iE/udKQQ79QSNSSjTe93KR+aQLSp7+B4K+BNUsSeLQ+mKw==
X-Received: by 2002:a1c:6509:: with SMTP id z9mr1552833wmb.144.1591769185127;
        Tue, 09 Jun 2020 23:06:25 -0700 (PDT)
Received: from macbook-pro-alvaro.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id 50sm6758395wra.1.2020.06.09.23.06.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 23:06:24 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 3/7] drivers: reset: simple: add BCM6345 reset support
From:   =?utf-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
In-Reply-To: <7a86b4df-6c59-244d-c289-ba1612078fe0@gmail.com>
Date:   Wed, 10 Jun 2020 08:06:24 +0200
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, robh+dt@kernel.org,
        tsbogend@alpha.franken.de, jonas.gorski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0175B174-F2F0-4764-941D-7F38791A4160@gmail.com>
References: <20200609134232.4084718-1-noltari@gmail.com>
 <20200609160244.4139366-1-noltari@gmail.com>
 <20200609160244.4139366-4-noltari@gmail.com>
 <7a86b4df-6c59-244d-c289-ba1612078fe0@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

> El 10 jun 2020, a las 3:05, Florian Fainelli <f.fainelli@gmail.com> =
escribi=C3=B3:
>=20
>=20
>=20
> On 6/9/2020 9:02 AM, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
>> Add support for resetting blocks through the Linux reset controller
>> subsystem for BCM63xx SoCs.
>>=20
>> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
>=20
> This looks good to me, however in v1 there was a need for sleeping =
after
> the reset assertion, and this does not appear to be taken care of by
> default by reset-simple.c, did you determine the delay not to be =
necessary?

Let me do some more tests to determine if it=E2=80=99s really needed.

> --=20
> Florian

