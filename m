Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D80C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0A82063A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732002AbgDCElt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 00:41:49 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:54562 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgDCEls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 00:41:48 -0400
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 9CA6E2001B8;
        Fri,  3 Apr 2020 04:41:47 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 8C84020735; Fri,  3 Apr 2020 06:41:08 +0200 (CEST)
Date:   Fri, 3 Apr 2020 06:41:08 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Hu Haowen <xianfengting221@163.com>
Cc:     jeyu@kernel.org, maennich@google.com, axboe@kernel.dk,
        nborisov@suse.com, josef@toxicpanda.com, stfrench@microsoft.com,
        chris@chris-wilson.co.uk, wqu@suse.com, xiubli@redhat.com,
        airlied@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: remove some unused space characters
Message-ID: <20200403044108.GA306056@light.dominikbrodowski.net>
References: <20200330020024.8174-1-xianfengting221@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330020024.8174-1-xianfengting221@163.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 10:00:24AM +0800, Hu Haowen wrote:
> There are a few space characters I found by chance. I think they are
> redundant, so I removed them.
> 
> Signed-off-by: Hu Haowen <xianfengting221@163.com>

Applied to pcmcia-next.

Thanks,
	Dominik

> ---
>  drivers/pcmcia/sa1100_simpad.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pcmcia/sa1100_simpad.c b/drivers/pcmcia/sa1100_simpad.c
> index e2e8729afd9d..784ada5b8c4f 100644
> --- a/drivers/pcmcia/sa1100_simpad.c
> +++ b/drivers/pcmcia/sa1100_simpad.c
> @@ -14,7 +14,7 @@
>  #include <asm/mach-types.h>
>  #include <mach/simpad.h>
>  #include "sa1100_generic.h"
> - 
> +
>  static int simpad_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
>  {
>  
> @@ -66,7 +66,7 @@ simpad_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
>  		simpad_clear_cs3_bit(VCC_3V_EN|VCC_5V_EN|EN0|EN1);
>  		break;
>  
> -	case 33:  
> +	case 33:
>  		simpad_clear_cs3_bit(VCC_3V_EN|EN1);
>  		simpad_set_cs3_bit(VCC_5V_EN|EN0);
>  		break;
> @@ -95,7 +95,7 @@ static void simpad_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
>  	simpad_set_cs3_bit(PCMCIA_RESET);
>  }
>  
> -static struct pcmcia_low_level simpad_pcmcia_ops = { 
> +static struct pcmcia_low_level simpad_pcmcia_ops = {
>  	.owner			= THIS_MODULE,
>  	.hw_init		= simpad_pcmcia_hw_init,
>  	.hw_shutdown		= simpad_pcmcia_hw_shutdown,
> -- 
> 2.20.1
> 
> 
