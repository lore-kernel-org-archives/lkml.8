Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2CEC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BD224672
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgB2XRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:17:51 -0500
Received: from baldur.buserror.net ([165.227.176.147]:54336 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgB2XRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 18:17:51 -0500
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1j8BMa-0002MK-90; Sat, 29 Feb 2020 17:17:40 -0600
Message-ID: <4b8581f5fd497b3fb1e5232510cd57c1e7ccb92d.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        galak@kernel.crashing.org, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Sat, 29 Feb 2020 17:17:39 -0600
In-Reply-To: <20200208140920.7652-1-christophe.jaillet@wanadoo.fr>
References: <20200208140920.7652-1-christophe.jaillet@wanadoo.fr>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: christophe.jaillet@wanadoo.fr, galak@kernel.crashing.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH 2/2] powerpc/83xx: Add some error handling in
 'quirk_mpc8360e_qe_enet10()'
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-02-08 at 15:09 +0100, Christophe JAILLET wrote:
> In some error handling path, we should call "of_node_put(np_par)" or
> some resource may be leaking in case of error.
> 
> Fixes: 8159df72d43e ("83xx: add support for the kmeter1 board.")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  arch/powerpc/platforms/83xx/km83xx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Both patches:
Acked-by: Scott Wood <oss@buserror.net>


> diff --git a/arch/powerpc/platforms/83xx/km83xx.c
> b/arch/powerpc/platforms/83xx/km83xx.c
> index 306be75faec7..bcdc2c203ec9 100644
> --- a/arch/powerpc/platforms/83xx/km83xx.c
> +++ b/arch/powerpc/platforms/83xx/km83xx.c
> @@ -60,10 +60,12 @@ static void quirk_mpc8360e_qe_enet10(void)
>  	ret = of_address_to_resource(np_par, 0, &res);
>  	if (ret) {
>  		pr_warn("%s couldn't map par_io registers\n", __func__);
> -		return;
> +		goto out;
>  	}
>  
>  	base = ioremap(res.start, resource_size(&res));
> +	if (!base)
> +		goto out;
>  
>  	/*
>  	 * set output delay adjustments to default values according
> @@ -111,6 +113,7 @@ static void quirk_mpc8360e_qe_enet10(void)
>  		setbits32((base + 0xac), 0x0000c000);
>  	}
>  	iounmap(base);
> +out:
>  	of_node_put(np_par);
>  }
>  

