Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E5CC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91FEA20BED
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="BGX72Bph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgIBUnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:43:03 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:9648 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgIBUnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:43:03 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BhbVX4Ft5z98;
        Wed,  2 Sep 2020 22:43:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1599079380; bh=9NgK8QfqKdwnoJb+ln01fWVLOgxSvgVM5fXq8d1X9m4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BGX72BphZghAaJjS3M5uDgAs7++BJx8xWsTCvGZgYM+4IVtWIt0rRAAwCG1qUMsud
         W53jw7iAD88wqXmbOrYVI88NJLhc1yjWwP1zBCZgH+hfE/p5ii2Ld9JJYuly/6klhy
         +lg+QK4/2HGOntTXzTEmj6vMhpfop3IcVLyePdau0dCq/v9e1lLkUpsuuYHepoxfXD
         ZXFa8/rRqDxFgrXCh0Fq6HskXbuu13qsoPxJWg+KbibkSswyWYuXJVcWBYAXKMMwlr
         2mvQBkFfITVTRsFJYWSCNCCMbZ4xxEEBmVSF7aisxZEP+tEcPz22p8qFCYeUsSyw4L
         91sxQrLUgoboQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Wed, 2 Sep 2020 22:42:55 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/12] i2c: tegra: Clean up messages in the code
Message-ID: <20200902204255.GB1624@qmqm.qmqm.pl>
References: <20200831202303.15391-1-digetx@gmail.com>
 <20200831202303.15391-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200831202303.15391-4-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 11:22:54PM +0300, Dmitry Osipenko wrote:
> Use lowercase and consistent wording for all messages in the code.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/i2c/busses/i2c-tegra.c | 50 ++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index 9bd91b6f32f4..efbb20049cf8 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -427,7 +427,7 @@ static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev)
>  		return 0;
>  
>  	if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA)) {
> -		dev_dbg(i2c_dev->dev, "Support for APB DMA not enabled!\n");
> +		dev_dbg(i2c_dev->dev, "dma support not enabled\n");
>  		return 0;
[...]

DMA is an acronym and so I would usually write it in uppercase for grammatical
correctness unless in a function's name.

Best Regards,
Micha³ Miros³aw
