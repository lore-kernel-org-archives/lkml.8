Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C71C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B92A214F1
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598941656;
	bh=vQRDkJyojcuTd04BSfsdD23ZJb7l6n5sNRdUCsmf2cs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HWTdJaBw+CWb50N6LuGsuTmetJQwkhdqYQqfJXLHQPIXyJASab9gNvSh8XyL88dgR
	 6Qb08X74oxsEYlyMvKPce6+IEZCvpgzvAX4HiaXAydonaA+h6KKOlOLbeij8Gxxtgw
	 uBgNpuKWNfoY6hc0sxPLaBYukMHFWR63LHSst1lU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgIAG1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgIAG1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 02:27:33 -0400
Received: from coco.lan (ip5f5ad5cf.dynamic.kabel-deutschland.de [95.90.213.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 824342098B;
        Tue,  1 Sep 2020 06:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598941653;
        bh=vQRDkJyojcuTd04BSfsdD23ZJb7l6n5sNRdUCsmf2cs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yvDgvoVju9G9ODuA094i3jquBkzguo+LxrkgiGFFMFfbzAziJtG6VeEIsaf1m1m1d
         1hF9sY3RAOezm9xb2RnSmLVT5ZiDKOGAUS5Xj5DJKyrRVhuapd2nXYZjgibfMfAhKp
         U3c/RS0SnzJGuP5c9yPZEIWcSRYKHzh5/iBajJq4=
Date:   Tue, 1 Sep 2020 08:27:28 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] staging: spmi: hisi-spmi-controller: Use proper
 format in call to dev_err()
Message-ID: <20200901082728.5ce6eda1@coco.lan>
In-Reply-To: <20200901035722.9324-1-yuehaibing@huawei.com>
References: <20200901035722.9324-1-yuehaibing@huawei.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 1 Sep 2020 11:57:22 +0800
YueHaibing <yuehaibing@huawei.com> escreveu:

> The correct format string for a size_t argument should be %zu.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/staging/hikey9xx/hisi-spmi-controller.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
> index 66a0b296e06f..34c690da09e3 100644
> --- a/drivers/staging/hikey9xx/hisi-spmi-controller.c
> +++ b/drivers/staging/hikey9xx/hisi-spmi-controller.c
> @@ -121,7 +121,7 @@ static int spmi_read_cmd(struct spmi_controller *ctrl,
>  
>  	if (bc > SPMI_CONTROLLER_MAX_TRANS_BYTES) {
>  		dev_err(&ctrl->dev,
> -			"spmi_controller supports 1..%d bytes per trans, but:%ld requested\n",
> +			"spmi_controller supports 1..%d bytes per trans, but:%zu requested\n",
>  			SPMI_CONTROLLER_MAX_TRANS_BYTES, bc);
>  		return  -EINVAL;
>  	}
> @@ -175,7 +175,7 @@ static int spmi_read_cmd(struct spmi_controller *ctrl,
>  	spin_unlock_irqrestore(&spmi_controller->lock, flags);
>  	if (rc)
>  		dev_err(&ctrl->dev,
> -			"spmi read wait timeout op:0x%x slave_id:%d slave_addr:0x%x bc:%ld\n",
> +			"spmi read wait timeout op:0x%x slave_id:%d slave_addr:0x%x bc:%zu\n",
>  			opc, slave_id, slave_addr, bc + 1);
>  	else
>  		dev_dbg(&ctrl->dev, "%s: id:%d slave_addr:0x%x, read value: %*ph\n",
> @@ -197,7 +197,7 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
>  
>  	if (bc > SPMI_CONTROLLER_MAX_TRANS_BYTES) {
>  		dev_err(&ctrl->dev,
> -			"spmi_controller supports 1..%d bytes per trans, but:%ld requested\n",
> +			"spmi_controller supports 1..%d bytes per trans, but:%zu requested\n",
>  			SPMI_CONTROLLER_MAX_TRANS_BYTES, bc);
>  		return  -EINVAL;
>  	}
> @@ -251,7 +251,7 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
>  	spin_unlock_irqrestore(&spmi_controller->lock, flags);
>  
>  	if (rc)
> -		dev_err(&ctrl->dev, "spmi write wait timeout op:0x%x slave_id:%d slave_addr:0x%x bc:%ld\n",
> +		dev_err(&ctrl->dev, "spmi write wait timeout op:0x%x slave_id:%d slave_addr:0x%x bc:%zu\n",
>  			opc, slave_id, slave_addr, bc);
>  	else
>  		dev_dbg(&ctrl->dev, "%s: id:%d slave_addr:0x%x, wrote value: %*ph\n",



Thanks,
Mauro
