Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7FBC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 372C72074D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598382377;
	bh=nFY9Byoa7IafoHZHxTgBMjQ8dyHzdWFqPV0Bq/m9pIQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=1Dt7qI8HEn2h19Hg+egWdpV3OxdGBkFIAFYWXIpIh3G+e/8nTDvlhsscZycnc+oUA
	 i6hE2bAdckv/7gmgSuKI2oSCZk1QvzqZXIMP4p/tmI9F07gluayPgMh6a1jnfkvzKG
	 KgrOsm0LsUwvvkn4wVlVFdgrL2CrhOE7MZWM/WAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgHYTGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:06:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgHYTGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:06:14 -0400
Received: from [192.168.0.50] (89-70-52-201.dynamic.chello.pl [89.70.52.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 363762076C;
        Tue, 25 Aug 2020 19:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598382374;
        bh=nFY9Byoa7IafoHZHxTgBMjQ8dyHzdWFqPV0Bq/m9pIQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=yUgoV8TEt4ukVuYw7absvzUjk2l9zDyAF4VAnUWfsw//qHqZf73dyR7uYYmP61Uyz
         vYJPjzCOZxuEB0C177HjrTdx4TsfOu7aKZKomimGZogPJLauhar4wxmbVRzqET/uoB
         3b1CiqptcnTX5cu3HiFpxpVmtOxKrzU5QXoXY2MA=
Subject: Re: [PATCH v2 6/9] spi: spi-s3c64xx: Check return values
To:     =?UTF-8?Q?=c5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
References: <20200821161401.11307-1-l.stelmach@samsung.com>
 <CGME20200821161407eucas1p116af63a668bdbb75fa974589e5f6139f@eucas1p1.samsung.com>
 <20200821161401.11307-7-l.stelmach@samsung.com>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <e7db038c-b8e6-8ddc-edc7-8b69c2019d04@kernel.org>
Date:   Tue, 25 Aug 2020 21:06:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821161401.11307-7-l.stelmach@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/20 18:13, Łukasz Stelmach wrote:
> Check return values in prepare_dma() and s3c64xx_spi_config() and
> propagate errors upwards.
> 
> Signed-off-by: Łukasz Stelmach<l.stelmach@samsung.com>
> ---
>   drivers/spi/spi-s3c64xx.c | 47 ++++++++++++++++++++++++++++++++-------
>   1 file changed, 39 insertions(+), 8 deletions(-)

> @@ -298,12 +299,24 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
>   
>   	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
>   				       dma->direction, DMA_PREP_INTERRUPT);
> +	if (!desc) {
> +		dev_err(&sdd->pdev->dev, "unable to prepare %s scatterlist",
> +			dma->direction == DMA_DEV_TO_MEM ? "rx" : "tx");
> +		return -ENOMEM;
> +	}
>   
>   	desc->callback = s3c64xx_spi_dmacb;
>   	desc->callback_param = dma;
>   
>   	dma->cookie = dmaengine_submit(desc);
> +	ret = dma_submit_error(dma->cookie);
> +	if (ret) {
> +		dev_err(&sdd->pdev->dev, "DMA submission failed");
> +		return -EIO;

Just return the error value from dma_submit_error() here?


