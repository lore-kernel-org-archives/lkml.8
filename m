Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08466C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C944B2072B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="glb7oCHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgANI1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 03:27:46 -0500
Received: from mout.gmx.net ([212.227.17.20]:58613 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbgANI1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 03:27:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578990457;
        bh=agbXGjEN5RjmocFU6SmJeQFrvw2tb5B4NDSesIjoEBs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=glb7oCHokxGPZIFAUq8hrynTDUjKajOtJslNrF6Phrgx5i4eEMHgQtT4LGRGf9yeY
         wjX2QhOnYLWN1HLcu+5e8hBH0y9hHACi4YbllUVN1Ag13kv2xuS7MdWX8tjPa+QWCt
         +JPL7aWsCDlyRVRqQh8V655KuB1GbbYqg9RAOHlc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.20.70.150] ([193.16.224.6]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvrB-1jIcXl42yj-00hRDA; Tue, 14
 Jan 2020 09:27:37 +0100
Subject: Re: [PATCH] parisc: Use proper printk format for resource_size_t
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200103163925.3967-1-krzk@kernel.org>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <82e79053-00bf-283e-458d-0b2711258585@gmx.de>
Date:   Tue, 14 Jan 2020 09:27:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200103163925.3967-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KP2qJT0YQN40rceb2ADdFAxh1emiX6WqDxZMEliax+tMuPYV+0p
 lA0BbYat/JVtCyihtprbmQ5stXrmikPi9XD8/ZOe/C7hrzBqbalIBTVFHID24ZiKlG8AX/Q
 38ek9dnYifRQgFqNI7D5BE7jP/782/45uw6Kkpk484rKs6QSm5h/5oYTZtzXjdZYelKbH0v
 UbECsn1MqtldL2Yrv2hDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5NEXodbfra4=:BIFmS7vXKAIJyPRUxIj14C
 qYg9vyWMzeXK0ziSM6v3VbqMdxceQ+hv8gkncMHeeGz72bWx4e4Jrybjoj4MC/+r9NrBeCoie
 g1Y7DpW23uQItXpkEfjkJCydansYsImJvvvY/0t4z4PBe5Rkj/MivoSSvUDX+YT9fto1RZbVD
 kpi47QeO2IJCN4wc3cEpteAmu3RZewWMWqDarOUkCJvJrr/+2SHeqp60vFV9QFbfD4qofubRw
 wqYAxGIcvBO+wZIXb668e6ssB0W90pTWRnt1yGB3KCU+xoe96JzdkSKjCguee5odwhIvcHKlM
 zdWptIaXuVVcUr3mfFeOnNjovJMD7SR7w5yEvyGTSBQrVOmiyg2yywByvfMHB63YfqnQoHOSG
 cC+4U9pHJD/RV0sbARtGIdzAxqwXFziHd9dBieSffctqlHnSBgv9TYYIG+UMUD+p1fsT53jgV
 EbK4/j5B9rhq+vUhgT/OOfnkMgtnGllXDY0y6aKPYljG6Ie0alRYQQpxmjRpadn4CL1xdYco3
 kfQMoJcdLw/DdhChxrM6DBohgkQFHCvN6hcTCIL8KLXozR0uOB3R/Xm84lXVgfKn/8AHt54gs
 gzAtChzjUX4/QGvDJsQhUlbPmBYSAGUMtBc0oXUU8u2r6Q53entsZkLq+LSqP/G0Zd88efjpf
 uqiySAFYLoGvMEnfxjRmJ1bkPiAA49Kpq6V3xBsbSx9ngm9PgKUSABHQrLZYjJ8rBMO/4Ua7h
 Tlrpk91NVOy4zi4i/76j08qWy4h7StqkGoodnvvNJM9S0l71MTpoFmgeKsZ+amGPnFjt90aXT
 xPN2I27nT5VvIPsbqeini+FVSaV2/7zu5G9RgDYeIWDxdX0UM5W0naentZajV/M2cB8Emk04E
 uFAHUKLk2JRf3EuJ9MMGpbe9JQXKwwRsnaD4Wuhb8ndvKTMtPxLUYadMn2Ac4BSkFDljvme39
 HrQpOeFcFPbkOA9lQfsHKrkrMwKuK+T/LDrA5pJwFN6d4q5B4eZAX+z4gPfYxt6w0Etr5idkt
 GL8lmvzxnlrPqVVcqvaMNZNhuWWSnYurHxTOgvD0h6AAypYcy2vPkfzqQvE0qwb7Hlw7Pm9ks
 ZdyRWqGijy/+WcIG5ewLiYrXB7zSSDqGfQajot36LJ+PSThUD0DzAWFthxH23QFd1qs7/pKbF
 8LJsNbBwR3ayGXb8y2vOIDDsotY3w2kt6ADPjyXuZbmDHjz8MGUWKRjWiiaDUkOh6FfKL5RXg
 HEMf/PRgkkWr1hZdDOLEPZOXjnqDPCfmJAMqGjg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.01.20 17:39, Krzysztof Kozlowski wrote:
> resource_size_t should be printed with its own size-independent format
> to fix warnings when compiling on 64-bit platform (e.g. with
> COMPILE_TEST):
>
>     arch/parisc/kernel/drivers.c: In function 'print_parisc_device':
>     arch/parisc/kernel/drivers.c:892:9: warning:
>         format '%p' expects argument of type 'void *',
>         but argument 4 has type 'resource_size_t {aka unsigned int}' [-W=
format=3D]
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/parisc/kernel/drivers.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
> index a6c9f49c6612..a154de424421 100644
> --- a/arch/parisc/kernel/drivers.c
> +++ b/arch/parisc/kernel/drivers.c
> @@ -889,8 +889,8 @@ static void print_parisc_device(struct parisc_device=
 *dev)
>  	static int count;
>
>  	print_pa_hwpath(dev, hw_path);
> -	pr_info("%d. %s at 0x%px [%s] { %d, 0x%x, 0x%.3x, 0x%.5x }",
> -		++count, dev->name, (void*) dev->hpa.start, hw_path, dev->id.hw_type,
> +	pr_info("%d. %s at %pa[p] [%s] { %d, 0x%x, 0x%.3x, 0x%.5x }",

It needs to be    %pap   instead of   %pa[p].
The documentation in Documentation/core-api/printk-formats.rst is correct,=
 but misleading.
I corrected & applied it.
Thanks!


Helge


> +		++count, dev->name, &(dev->hpa.start), hw_path, dev->id.hw_type,
>  		dev->id.hversion_rev, dev->id.hversion, dev->id.sversion);
>
>  	if (dev->num_addrs) {
>

