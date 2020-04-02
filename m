Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B7FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957BE2078B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbgDBKoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:44:08 -0400
Received: from kernel.crashing.org ([76.164.61.194]:37732 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbgDBKoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 06:44:07 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 032Ah8n8028563
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Apr 2020 05:43:12 -0500
Message-ID: <1947a3705a220ce14a2fda482c833b38a4d9fe9a.camel@kernel.crashing.org>
Subject: Re: [PATCH] net/faraday: fix grammar in function
 ftgmac100_setup_clk() in ftgmac100.c
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Hu Haowen <xianfengting221@163.com>, davem@davemloft.net,
        andrew@lunn.ch, mchehab+samsung@kernel.org, andrew@aj.id.au,
        corbet@lwn.net
Cc:     stfrench@microsoft.com, chris@chris-wilson.co.uk,
        xiubli@redhat.com, airlied@redhat.com, tglx@linutronix.de,
        hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 02 Apr 2020 21:43:06 +1100
In-Reply-To: <20200401105624.17423-1-xianfengting221@163.com>
References: <20200401105624.17423-1-xianfengting221@163.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-01 at 18:56 +0800, Hu Haowen wrote:
> "its not" is wrong. The words should be "it's not".
> 
> Signed-off-by: Hu Haowen <xianfengting221@163.com>

Typo more than grammer :-)

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 (the offender) 

> ---
>  drivers/net/ethernet/faraday/ftgmac100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 835b7816e372..87236206366f 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -1731,7 +1731,7 @@ static int ftgmac100_setup_clk(struct ftgmac100 *priv)
>  	if (rc)
>  		goto cleanup_clk;
>  
> -	/* RCLK is for RMII, typically used for NCSI. Optional because its not
> +	/* RCLK is for RMII, typically used for NCSI. Optional because it's not
>  	 * necessary if it's the AST2400 MAC, or the MAC is configured for
>  	 * RGMII, or the controller is not an ASPEED-based controller.
>  	 */

