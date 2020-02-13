Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1D2C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427DF21734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="WMIT38x2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbgBMQDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:03:03 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:53494 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgBMQC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1581609777; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WjFVxWmftnYJudI0P+zBlLjpdpoJuteS1QDW4Yee3k4=;
        b=WMIT38x2f8xFJ9kCXx9mkZx7YdOa8pPD90lqQMWvltPE5KBTgEMyIcH438+OQl6uqORX8K
        jWZASV7U5SthC8Z+JbsQMrboloTDqtxfLZ4MZEMLXBtjgJ7iSbcZh8KxYAYXFql37GwPOu
        nsihHaV8EP8uKRNyyPXfnImsFuudu0o=
Date:   Thu, 13 Feb 2020 13:02:44 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 17/18] irqchip: Replace setup_irq() by request_irq()
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Message-Id: <1581609764.3.2@crapouillou.net>
In-Reply-To: <8e00874d072f32496c2d0da05423bda1cadd6975.1581478324.git.afzal.mohd.ma@gmail.
        com>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
        <8e00874d072f32496c2d0da05423bda1cadd6975.1581478324.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Le mer., f=E9vr. 12, 2020 at 13:35, afzal mohammed=20
<afzal.mohd.ma@gmail.com> a =E9crit :
> request_irq() is preferred over setup_irq(). Existing callers of
> setup_irq() reached mostly via 'init_IRQ()' & 'time_init()', while
> memory allocators are ready by 'mm_init()'.
>=20
> Per tglx[1], setup_irq() existed in olden days when allocators were=20
> not
> ready by the time early interrupts were initialized.
>=20
> Hence replace setup_irq() by request_irq().
>=20
> Seldom remove_irq() usage has been observed coupled with setup_irq(),
> wherever that has been found, it too has been replaced by free_irq().
>=20
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
>=20
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

> ---
>=20
> Since cc'ing cover letter to all maintainers/reviewers would be too
> many, refer for cover letter,
> =20
> https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com
>=20
>  drivers/irqchip/irq-i8259.c   |  9 +++------
>  drivers/irqchip/irq-ingenic.c | 11 +++++------
>  2 files changed, 8 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
> index d000870d9b6b..e9798d02b256 100644
> --- a/drivers/irqchip/irq-i8259.c
> +++ b/drivers/irqchip/irq-i8259.c
> @@ -271,11 +271,6 @@ static void init_8259A(int auto_eoi)
>  /*
>   * IRQ2 is cascade interrupt to second interrupt controller
>   */
> -static struct irqaction irq2 =3D {
> -	.handler =3D no_action,
> -	.name =3D "cascade",
> -	.flags =3D IRQF_NO_THREAD,
> -};
>=20
>  static struct resource pic1_io_resource =3D {
>  	.name =3D "pic1",
> @@ -323,7 +318,9 @@ struct irq_domain * __init=20
> __init_i8259_irqs(struct device_node *node)
>  	if (!domain)
>  		panic("Failed to add i8259 IRQ domain");
>=20
> -	setup_irq(I8259A_IRQ_BASE + PIC_CASCADE_IR, &irq2);
> +	if (request_irq(I8259A_IRQ_BASE + PIC_CASCADE_IR, no_action,
> +			IRQF_NO_THREAD, "cascade", NULL))
> +		pr_err("request_irq() on %s failed\n", "cascade");
>  	register_syscore_ops(&i8259_syscore_ops);
>  	return domain;
>  }
> diff --git a/drivers/irqchip/irq-ingenic.c=20
> b/drivers/irqchip/irq-ingenic.c
> index c5589ee0dfb3..5b20a0f0ece8 100644
> --- a/drivers/irqchip/irq-ingenic.c
> +++ b/drivers/irqchip/irq-ingenic.c
> @@ -58,11 +58,6 @@ static irqreturn_t intc_cascade(int irq, void=20
> *data)
>  	return IRQ_HANDLED;
>  }
>=20
> -static struct irqaction intc_cascade_action =3D {
> -	.handler =3D intc_cascade,
> -	.name =3D "SoC intc cascade interrupt",
> -};
> -
>  static int __init ingenic_intc_of_init(struct device_node *node,
>  				       unsigned num_chips)
>  {
> @@ -130,7 +125,11 @@ static int __init ingenic_intc_of_init(struct=20
> device_node *node,
>  		irq_reg_writel(gc, IRQ_MSK(32), JZ_REG_INTC_SET_MASK);
>  	}
>=20
> -	setup_irq(parent_irq, &intc_cascade_action);
> +	if (request_irq(parent_irq, intc_cascade, 0,
> +			"SoC intc cascade interrupt", NULL)) {
> +		pr_err("request_irq() on %s failed\n",
> +		       "SoC intc cascade interrupt");
> +	}
>  	return 0;
>=20
>  out_domain_remove:
> --
> 2.24.1
>=20

=

