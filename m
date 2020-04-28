Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903A8C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49177206F0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="cIkZhSIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgD1OCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:02:48 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:8459 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbgD1OCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:02:46 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49BNdJ16nBz2n;
        Tue, 28 Apr 2020 16:02:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588082564; bh=n//SKULcxb1e0RY+J56W0LUuXIEeG4+PReRi4CmtC28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cIkZhSIRkushRUYLrgwl1KRM4IQrJK85w1nTAg9hB/JvZ/2euvy+SYeO+s/oGPC8o
         YM0+D5FrKHdPUuOOekNqZ4a96FjycmFi0b/IMnf+ZMTCvwE2FfjHNVwifagShFEwSl
         yIu86/7qmMg/Wm8lNuXTUYmigITqsarYJjqFdVpJK4WNyoSLT/j4j6i1aJcGiVs7j1
         qT488HK0Fe/YDvVPAW3BlC42XdCYzLcOzExdvb3f8EqMOCCxvFlh6BnArlyNmKXICT
         WoUiIbxzbhlJ6dJJJmp2PLmI3ybx96g4cqobJ2EFT0GMdZuBr4cbvw20Lyz7ZjAWME
         DitVzT78CPT1A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Tue, 28 Apr 2020 16:02:41 +0200
From:   =?iso-8859-2?B?TWljaGGzoE1pcm9zs2F3?= <mirq-linux@rere.qmqm.pl>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     Peter.Chen@nxp.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: chipidea: usb2: remove unneeded semicolon
Message-ID: <20200428140241.GA2762@qmqm.qmqm.pl>
References: <20200428063359.16433-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200428063359.16433-1-yanaijie@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 02:33:59PM +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> drivers/usb/chipidea/ci_hdrc_usb2.c:75:28-29: Unneeded semicolon
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/usb/chipidea/ci_hdrc_usb2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/ci_hdrc_usb2.c
> index 93c864759135..89e1d82d739b 100644
> --- a/drivers/usb/chipidea/ci_hdrc_usb2.c
> +++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
> @@ -72,7 +72,7 @@ static int ci_hdrc_usb2_probe(struct platform_device *pdev)
>  
>  	priv->clk = devm_clk_get_optional(dev, NULL);
>  	if (IS_ERR(priv->clk))
> -		return PTR_ERR(priv->clk);;
> +		return PTR_ERR(priv->clk);
>  
>  	ret = clk_prepare_enable(priv->clk);
>  	if (ret) {

Fixes: c2de37b31f17 ("usb: chipidea: usb2: make clock optional")
Reviewed-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
