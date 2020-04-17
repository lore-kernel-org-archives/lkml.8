Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E137BC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE86720771
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="MpK588Jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgDQQMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:12:42 -0400
Received: from mout.web.de ([212.227.17.12]:46877 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729282AbgDQQMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587139955;
        bh=r+Ur8bmZ985qnsD/tK30ZIG/FnWrkrnOTjVz+w4V0nI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MpK588JfF4YWBHbIfoUDDKFb/93KSKV0x7pLEo2chPAMCloFGkxiD/BgpUImb/W0o
         1FUG0EWpj8QhOpn5DdnmLIbUWtJHLJv24l4zLuy3adVAbDCsTvqIs2uN1zXWow5jKy
         Wn6khS2dXmIVenY6xlYtw6tSsayi/qoP14qzy7H0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.97.227]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LzbDC-1jCdlo3uPS-014gVx; Fri, 17
 Apr 2020 18:12:35 +0200
Subject: Re: [v2 4/7] remoteproc: Use kstrdup_const() rather than kstrdup()
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alex Elder <elder@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>
References: <20200415204858.2448-1-mathieu.poirier@linaro.org>
 <20200415204858.2448-5-mathieu.poirier@linaro.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7e3f07b1-a45d-0800-e74f-7f042d22eb3c@web.de>
Date:   Fri, 17 Apr 2020 18:12:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415204858.2448-5-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iI/KFctlST+oA3KimBUzQs/7RsQPNDd6ACQGRFsaYdgZ9LDbdie
 e+VFT4KP++IQEt/QbOJI0NjIlm+Gw4T4T3zbjfP8oEqadMJNK/aSO9Y+egew7k3Fi8QyKbp
 7ijE4BIvogprMP9F/8kGsF0AgC5spKzFv9C9cElaJduH64B0ismVKK7IcKv2ySrlkTUf9S3
 KETMyjjmZq1oFE5qWixoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IxsCUy+Etl4=:ryp+yh+i9gK8wFzds9Nivn
 YIYhOUj+JAdx24oT4Zu5iO8pDE0SamnUXQlyYKXsWB1ub10t4Z8aIyhKFq/5b+cKht2d5Ik8S
 +5eY2mI40/j0WoqOxrTxE/gw1RRLdUdMgVGgpRhLchza33lZhGYtvxZoNh/3kexn70fpSXUUI
 zizFloRGvfYNZBLpU26THjlXUtfVkCJMVfUKIvwtNeSYWBDheZwL6Lz0m47BOK6/4R4NlaUFv
 qGkvt5nLnSn6Cnrcltw4w4VNL8PJGhoOCfC0lZPmlyFiX7CAW5yBNoT0kiIw1BYSd8lmkrs6t
 A9p1f5enYfEquTt2tjbj5Ex1BeY6wQW0axYckBOKjJUg6Vx/oEhJ6rKy75xittybZonL7Nze4
 Bt3BfusExmYGl3y+rd7x2Kmqgt9L15J9APekcYWWH9Mc3Yk62MYeR8fOmmJBMDo9XjYB+NoPI
 CSwOGsgPLIior/Wwq7zJBYcXTFk/4kvwOdp+YOD8hGDgnl6AkTPLgVuZBgPc7DeiBgKICTwrS
 JK6wMnrYo/YKKPbtzgMdpMl0EXJrPp/yr+K08Bvra3tRDefzKjRIFxR7wNYFKmgLF/V1cwgU6
 a86wg/axsTZMjEEvM/55jV/nuhKF6t97516hNIGzmtvwvAYLiB0v+YVS1vzWAdMcX+Mn5Ob/S
 /JoOO9zH8iZgzwHizL3upn0B2q+Ybokgn++IVY3LXePFw78JrmrwfVtJQSUO47SdKXZmIqgQI
 k9WsHukDSxJ6hsOxG21vXIgSoxlftHmWlKZAaZ7mxgTuj+1m3aFj5Yjo23dR3lz4cYK9Pf6Vc
 0NrUNlCQqX0bEbv1QZ4X+icglsv191DAPCwpUzNf8gWllAEYU2FF1BI4xEXua1dldIgl76OSp
 t6hvkdCF2scTY3i9paYHg3luvmJ0PgBljjpgX9D/4dxcsXidR/73p4kWPrWOt7/gtqzt79qVW
 It43dP/8jBVhdYZ1s8Yieh9dAHM8JA4sFhojuSpHEaUOmKDYKUCoDxCZGcz8SN5Ktenc0vPWk
 9Zzv5Q6xov+Mu3GRv7ISi2hNC+TkQnMgxzLeFfmJeTeHqLCbKqTXd9neQde/vDItVuOj9o7dz
 gED7Ta/DH/RdOWWeu5DkhmOmIpMbtz8SCjS+vHPitSVjMGWeB/f3XlujHhx3x+qoPU5ZFD5hf
 kyZ+/ZHikjdMlWzXhE4ASq0FqYfX/1gZKFuIlK0BWYzKqH8fof8Kv+6K5tZk38gwxPPPSoDbH
 +swk5dJ7oghjLwsZx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1982,7 +1982,7 @@ static const struct device_type rproc_type =3D {
=E2=80=A6
> -		p =3D kstrdup(firmware, GFP_KERNEL);
> +		p =3D kstrdup_const(firmware, GFP_KERNEL);

How do you think about to avoid a typo for a function name in
the final commit subject?

Regards,
Markus
