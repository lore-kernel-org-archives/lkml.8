Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5945EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223A120674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="b++ZZHJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbgCPPLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:11:02 -0400
Received: from www381.your-server.de ([78.46.137.84]:37514 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731636AbgCPPLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=39LiRtTwaomtR/iSIbjqK3NVuP51oEa0UEvTzpvix7o=; b=b++ZZHJygdwGe30+6G737zQFC0
        63BUd9Ka3v7yI6kkr0xVVXCoK8Y3G1NWgjvefBtQ0/wbiC4x9FuJfA9y5wpNGLzOJdpRtdBBfKGC3
        5Wu6L2F8Wa36xCbgMcItOqdOpaEJJDZ+NZG6Gi83+Ew8Gedgh6z7haPpq4IU8wsbry5YNw/fFBEw7
        OlnAdh9enfZjC0bbjXxm4er1N8yIONcNhXMmpR9q39Vmg1Cpzhntkpx4HqC85v6nJulVri7K638VY
        Ucw2yEnyUu0uED6R5IJB2tnzjWCrq3JIU1fJbrbVe5O6iRxx1ZWmWHM2uGH9vrj0CWFU0adC5xOzc
        72c65vqg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jDrOD-0006uo-Ix; Mon, 16 Mar 2020 16:10:49 +0100
Received: from [93.104.121.61] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jDrOD-000FXy-4l; Mon, 16 Mar 2020 16:10:49 +0100
Subject: Re: [PATCH v2 2/2] ASoC: fsl: Add generic CPU DAI driver
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        kuninori.morimoto.gx@renesas.com, peter.ujfalusi@ti.com,
        broonie@kernel.org, linux-imx@nxp.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     Xiubo.Lee@gmail.com, linux-kernel@vger.kernel.org,
        shengjiu.wang@nxp.com, tiwai@suse.com,
        ranjani.sridharan@linux.intel.com, liam.r.girdwood@linux.intel.com,
        Daniel Baluta <daniel.baluta@nxp.com>,
        sound-open-firmware@alsa-project.org
References: <20200306111353.12906-1-daniel.baluta@oss.nxp.com>
 <20200306111353.12906-3-daniel.baluta@oss.nxp.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e00e3fe1-7e87-e9c5-7c53-50ac6fa991e7@metafoo.de>
Date:   Mon, 16 Mar 2020 16:10:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306111353.12906-3-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25753/Mon Mar 16 14:05:55 2020)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/20 12:13 PM, Daniel Baluta wrote:
> +static int fsl_dai_probe(struct platform_device *pdev)
> +{
> [...]
> +	ret = of_property_read_u32(np, "fsl,dai-index", &dai_index);
> +	if (ret) {
> +		dev_err(&pdev->dev, "dai-index missing or invalid\n");
> +		return ret;
> +	}
Maybe this can follow a more standard approach using DT aliases. Just 
like we assign IDs to things like SPI or I2C masters.
> +
> +	fsl_dai.name = dai_name;
This breaks as soon as there is more than one DAI in the system since 
you are sharing a global struct between them.
[...]
