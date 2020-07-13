Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC97C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8BB20771
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="d/oZ3wu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgGMPg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:36:59 -0400
Received: from crapouillou.net ([89.234.176.41]:48090 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729840AbgGMPg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1594654615; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LdQqHm6kiUKALUnP/0MNOMd3kQYrs4cg4UjvzyzDtFg=;
        b=d/oZ3wu0ru+qzQPHhvrBWinlsFSiLxgNwcFwHFGHVAKryXjjM5TadVyotwAoAjWtKXtVmz
        p9NUhGnNvISXm15jx4CkhkKPzcShmWsGzP+vbHcLR8aV+qbElRS2wwXOZ8kTz9JNj1ZdSP
        ZB98OmKsVN0TF1gukfK3FZhpCJ1mxNE=
Date:   Mon, 13 Jul 2020 17:36:46 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH RESEND v2] dt-bindings: pinctrl: Convert
 ingenic,pinctrl.txt to YAML
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, od@zcrc.me,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <ADZEDQ.ZXJ99TAYD15S2@crapouillou.net>
In-Reply-To: <20200713153252.GA234029@bogus>
References: <20200622113740.46450-1-paul@crapouillou.net>
        <20200713153252.GA234029@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Le lun. 13 juil. 2020 =E0 9:32, Rob Herring <robh@kernel.org> a =E9crit :
> On Mon, Jun 22, 2020 at 01:37:40PM +0200, Paul Cercueil wrote:
>>  Convert the ingenic,pinctrl.txt doc file to ingenic,pinctrl.yaml.
>>=20
>>  In the process, some compatible strings now require a fallback, as=20
>> the
>>  corresponding SoCs are pin-compatible with their fallback variant.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Notes:
>>      v2: - Use 'pinctrl' instead of 'pin-controller' as the node name
>>          - remove 'additionalProperties: false' since we will have=20
>> pin conf nodes
>=20
> What do those look like? They need to be described, but that can be a
> follow-up.

These are generic conf nodes that are handled by the pinctrl core.=20
Nothing specific to the hardware described here. The subnodes don't=20
have any specific pattern so it is not possible to represent them in=20
devicetree (we'd need a 'catch them all' wildcard pattern property).

Cheers,
-Paul


