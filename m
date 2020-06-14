Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29ADC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B318E20747
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgFNUeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 16:34:23 -0400
Received: from gofer.mess.org ([88.97.38.141]:43647 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgFNUeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 16:34:22 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 4D3AAC637E; Sun, 14 Jun 2020 21:34:20 +0100 (BST)
Date:   Sun, 14 Jun 2020 21:34:20 +0100
From:   Sean Young <sean@mess.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: budget-core: Improve exception handling in
 budget_register()
Message-ID: <20200614203420.GA29889@gofer.mess.org>
References: <20200605161728.2513316-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605161728.2513316-1-hslester96@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 06, 2020 at 12:17:28AM +0800, Chuhong Yuan wrote:
> budget_register() has no error handling after its failure.
> Add the missed undo functions for error handling to fix it.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Changes look good, but the Fixes: points to the first import of linux
into git. I'm not sure this is useful information so I've removed it.

Applied, thanks.

> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
> Changes in v2:
>   - Modify the label of error handler.
> 
>  drivers/media/pci/ttpci/budget-core.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/pci/ttpci/budget-core.c b/drivers/media/pci/ttpci/budget-core.c
> index fadbdeeb4495..293867b9e796 100644
> --- a/drivers/media/pci/ttpci/budget-core.c
> +++ b/drivers/media/pci/ttpci/budget-core.c
> @@ -369,20 +369,25 @@ static int budget_register(struct budget *budget)
>  	ret = dvbdemux->dmx.add_frontend(&dvbdemux->dmx, &budget->hw_frontend);
>  
>  	if (ret < 0)
> -		return ret;
> +		goto err_release_dmx;
>  
>  	budget->mem_frontend.source = DMX_MEMORY_FE;
>  	ret = dvbdemux->dmx.add_frontend(&dvbdemux->dmx, &budget->mem_frontend);
>  	if (ret < 0)
> -		return ret;
> +		goto err_release_dmx;
>  
>  	ret = dvbdemux->dmx.connect_frontend(&dvbdemux->dmx, &budget->hw_frontend);
>  	if (ret < 0)
> -		return ret;
> +		goto err_release_dmx;
>  
>  	dvb_net_init(&budget->dvb_adapter, &budget->dvb_net, &dvbdemux->dmx);
>  
>  	return 0;
> +
> +err_release_dmx:
> +	dvb_dmxdev_release(&budget->dmxdev);
> +	dvb_dmx_release(&budget->demux);
> +	return ret;
>  }
>  
>  static void budget_unregister(struct budget *budget)
> -- 
> 2.26.2
