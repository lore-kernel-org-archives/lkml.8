Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581F3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3582C2074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="LKtqTSVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgGAHty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:49:54 -0400
Received: from mout.web.de ([217.72.192.78]:41715 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbgGAHtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593589771;
        bh=AUSAQHdZ185AAIFEsveQlxvM8o94B7vxd0p7U0M505g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LKtqTSVdcvio03D+QGvlFPp/E3FoXOd7dEgeeVAoI2FQ6IMZ4mdim6B8+qunKA1e+
         SAiEyxd6m0q6q/I2vh7aaaAgJhHtSpuZ7KcUEG2S0IROGCT8k6/EOuwJzHZIr2DACP
         P4npAd4kYnTFiQre1NJh7TuzbXe2o8bZzNIvy7u8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.41.17]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhFhg-1jDeJN20m2-00eK7j; Wed, 01
 Jul 2020 09:49:31 +0200
Subject: Re: [PATCH v4 03/14] irqchip/csky-mpintc: Fix potential resource
 leaks
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
 <1593569786-11500-4-git-send-email-yangtiezhu@loongson.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <35eae701-e6b1-96af-9be4-0993330a17dc@web.de>
Date:   Wed, 1 Jul 2020 09:49:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593569786-11500-4-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VK0SXfyvpzWFdJ0AaSP9rc2ghNhPd5/O3GG2Z8MUfriTZ56VE/t
 Ed1/i+KNfFFuIBAlA5a81ablBx7x1pMOWZodjdOxyH3b5FeV8wMBvNYX24cQI/6T2UlBvfP
 +vWKpyouZfyt6eFl9Q5u6IMtPoFM/C7LuThfTZLzt1jR3CjT0Tf3MRIXUOvEMQFh7rBd5rD
 F6GBUR9nZWMwTminvvCeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gl2/AEw5Jps=:7OhERpI8F6QKhPQ9B0kPwT
 HNCCSdiaS4x01s39GuQgJagg9a9pR5fe4SiGHB3I7Y8Pt0SND2dil5M0MGbGqlLqJAjOJMtsg
 2mgJti2aXVEjAywRXK+WCXwm++Y2Q6mvuUdyt0a4gXahV10ND1wDqF8PSE17k5AIrmUw96LRz
 VsqCgFd8l1QrSl+oYsUXeujfFUdCJnXO9XPUkWBTw6QaMZialYRhTFduoPrdbXv8O/LfhrMzx
 Qvbjba8s+fOxISMH4Yz60kEF27SzkB7jyk7DbrVneSe1ipJvFjYBRd8Z2Qd595TImqOFWUXQl
 kVkCa1RmvZ3slfpiIp5mA7UQsLao5xrJHAeiqlf/Z4Sdoi6/alVf60iFLwzDix/TUbQIrFMtH
 SBsGO9X8urbTdCw01PVjM3s9XHdt3EPPBfpdbUSn9ESRTivrRzIEpLjtTmTtJ0asVNEZIBf5C
 TvUymg8CHUBN4XtDxODCqfABiFn2eQyzDK7aJUZ2qGrBjz4fxmpC8wzfbmifwOqaurY2x5bsz
 BN/4ZxK2FurWOAH35+c/wTh+BNJOh/FxAMHTjy/fkrbpTcVwHXmwJmBmApwej+ddFNd/GZ4zK
 kIm/aiQhcpI3uTC4oQiWLG4Oc6XfiAl4YsezelsHfsXOmOZpr0Rd7aSzOmX+zogAE9xipweEE
 ziB4OBPa/zerNEXdWW9JUm4VzidPBp6MmcXy9rk24ogSSFNWo+TORoCl3KoWU7WpAINy8NAk7
 5auqdCWOK6PvM4fK2TS/m43nhn3CQ8ToZ/lykhUCw9l3+kZ0Mk2cnBGKVuq/xmlPV1/uhap7e
 k8uKyLu8sR6EzwpayKlNXFrV9GOWw4se1YsAJtEQo1czJ830PQLJC0cFPCyUaZtNyXjXKZds8
 zycftJKLlH+JsQF2NEE2yl+1ub55D+DeYHAZuzWWBSW9oQSMVpSplQ01ztfiWD92XRXDH1M+W
 Z56C9n1xtNzAOwvaOlt2JpaRGd4VlkjFZsYiC+WbexlD33x0tjvxgpXI6HdDnMMVq2hYwGvsS
 4jtr6tK4l3fMp/1sn716zABSEOi6jsD5TSSPZiw7XLy7aSJTNy7sXZt20vEDzFJbzH/mvfq5U
 m6HL0CudFGnjr4eSN0u/bztFFEhu7A79CiA/d7t2Ah4nI54AsRahFhYZbsl97JsYbOKP3lDlk
 N2sG60DKipDrb20WKtvoW2ND/3t4ilaXPZreB+th4plDD+7huQz8dsGaDGQA4idzU1l+ETdKz
 qPH+mM+TwbwgDb4Xj
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> exception handling. By the way, do some coding-style cleanups

I propose to consider another bit of fine-tuning.


=E2=80=A6
> +++ b/drivers/irqchip/irq-csky-mpintc.c
=E2=80=A6
> @@ -270,12 +274,24 @@ csky_mpintc_init(struct device_node *node, struct =
device_node *parent)
>
>  #ifdef CONFIG_SMP
>  	ipi_irq =3D irq_create_mapping(root_domain, IPI_IRQ);
> -	if (!ipi_irq)
> -		return -EIO;
> +	if (!ipi_irq) {
> +		ret =3D -EIO;
> +		goto err_domain_remove;

How do you think about to use the following source code variant
at this place?

+		irq_domain_remove(root_domain);
+		ret =3D -EIO;
+		goto err_iounmap;


Would you like to avoid the repetition of the check =E2=80=9C#ifdef CONFIG=
_SMP=E2=80=9D?

Regards,
Markus
