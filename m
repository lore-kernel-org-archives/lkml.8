Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD418C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FED420747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="YbKS/zWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgGAJnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:43:13 -0400
Received: from mout.web.de ([217.72.192.78]:52925 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgGAJnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593596569;
        bh=jkDmhO7ajhKeRaiefx581Z4ltO0f2V/8AUMhY/HL19w=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YbKS/zWI7kPsj1dKKK/6/QNRtYTw/3nQK1TPZUNTvmBFvsg5BLml+uRGtXBK8Y6nb
         jU7d+7TMZPn0pjiO27RD/tQUUy8Sbvc6OwNwfUmMdcWqw0vDFegAULDwpm0/MpxzIT
         ODZBUDuq+B61L1HburIJVo4e9tseRMEWvDoBuck0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.41.17]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LetQh-1j1qRa1GIh-00qmY1; Wed, 01
 Jul 2020 11:42:49 +0200
Subject: Re: [PATCH v4 14/14] irqchip/xilinx-intc: Fix potential resource leak
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
 <1593569786-11500-15-git-send-email-yangtiezhu@loongson.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e9aaa867-bb11-a469-a4b9-03fb68a18c56@web.de>
Date:   Wed, 1 Jul 2020 11:42:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593569786-11500-15-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uZ0pVDfWtsp/Rq166FjvDL6evahQ5A0UEZXKLu6NzlY/3v7qlZQ
 xyOtluWXXmNeOwXa99IQO7IxFeEnWYH81Av20AAdxBYO3o9K0GBnOPv45dDmC8CqWeS3b3I
 n9vPib7yWP6pXL33N0BhxQR3iM46H1BSJm+EMAXNpjc3v3+r77egNlYfXCKSomT8FXw9p03
 atP3XmcQw37Jsxwf06ARg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ib6gcZ4VFJc=:/3ksnWtr+dH/oJEqwp1XJt
 9+ZBonGoncUK8E67rRjvGWB1NhEJnN3sN2igItYzsYxfKrT8cu9GA8+m0lQwer+2yqgaMRdEN
 /hfuJuLGmc0HShR/hetDexlMOms9+mMTzIgJcsuX/hWEcvIFNXXt9daX5YIs66jA4NGwvwHnq
 pppu0KsafhVbOlOmQSI1WKnJ7VBVwZKzXMyjclL2nw8hTF3sMRpySLJV7NlQv6rHkAWz6QlBB
 zFlAN1SdrAmWMpbddE2g42Pe8esaTVbhs6Fq8JUQv8AegVzPDlb1sub1RgiXmCvX7sKCkiJ33
 9GKSRSGMrAWInvUPJYGifvehY40MmAjHdlU3jyfiDhoJIUfupadyguLSmpZCZykgNWxPCiOj2
 PmGomwfb9lTSUkQgnSwpVAEFIk9kYxSyVlznCO4SyT//56dS9ARsOOFS63/zWTqCMAvlo2jbn
 J6nOtxSzh2/MBGv8vlSWQdHqVySQ4tbh3kxK/iwNHHHrF5v46RHn43uQx3kh94Yh6kjng7XEN
 C5dNPZm3PYA8w0n8cMJFplqSy1wURYuUwXVG2jx9IGgQajwaK6eS4EZAzMIC9jwCJZOHV20jE
 h6FmSSk1mJX3kIrx+XwwkeukY3g9srpPDSOrTGCf4KA0e7EogFFr6EcSihO9vFsH1tYXN4ltx
 n2pIRrJf1dcXmZga4GnlkyTKdMFOxddgn9BPOJmtlhI3pFwm+pZO4kH7KNUtcC+6/8I2rDdPW
 rJaT83/fl/V+Iino0Jj9w4Hnj78md13P+wXXcTEFNdkfPkTd5ehCWREHThQhI4zPswr22OVqM
 oUElEiAG0OVrUkJxbu42QAziuHbLcVzfSx0ccE2eeLzS6YMPBJNDufie6tzxaULYpJ13woDyu
 yXow0IsxHp8cJjlCItFEfEbg3IqpiW/fySRxdrQoIzFA+sCN3Rs7XBG0vBZy5tiiPkYjewiLr
 +gx+HOEZ5TbKdltyYNYcydqq7B3pm8fYxngMdQTXv2yKljuMH1ilBXwb3n6TBi5+Gu3ChvKlo
 aiBEEDu6zEtIdsiOuwG8luIR6ET1ZMEjDRU0ztNJi+lbjFC3e6/+SncQMaPvY/Z1cNj8glZPE
 OPVOJlHuiTuIF+6RGrMTpSrEwSVgCx3Dstz7S4mOMv40Vj7mWSgR1e4cXEsZqDh/0hJ1/cCqU
 JoMVrdQv5hsy4bSdwusyfhvceqeQB0J51rQsUSVTvQ4+2ea2v4APQK6DITlhHw47lBPrVIcOV
 Jq3d+upFfqdGLGACm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In the function xilinx_intc_of_init(), system resource "irqc->root_domai=
n"
> was not released in the error case. Thus add jump target for the complet=
ion
> of the desired exception handling.

Another small wording adjustment:
  =E2=80=A6 Thus add a jump target =E2=80=A6


=E2=80=A6
> +++ b/drivers/irqchip/irq-xilinx-intc.c
=E2=80=A6
> @@ -250,6 +250,8 @@ static int __init xilinx_intc_of_init(struct device_=
node *intc,
>
>  	return 0;
>
> +error_domain_remove:
> +	irq_domain_remove(irqc->root_domain);
>  error:
>  	iounmap(irqc->base);
=E2=80=A6

Can labels like =E2=80=9Cremove_irq_domain=E2=80=9D and =E2=80=9Cunmap_io=
=E2=80=9D be nicer?

Regards,
Markus
