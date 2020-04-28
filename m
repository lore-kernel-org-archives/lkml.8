Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D3CC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52FAD2085B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RYBKC1KO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgD1Ty2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:54:28 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47538 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbgD1Ty2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:54:28 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03SJsIbo049999;
        Tue, 28 Apr 2020 14:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588103658;
        bh=S0IgVG4cUZ8Shy4yN/jVqyWSSYxjQVTE70srLFE5tLQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RYBKC1KOzOdovDNSxor2oIQ43yt22ON0kRSdLY7xgM1wdT+X+w563uXDd5T+/hR9F
         YnaFQ379gdPI9cIA53VbTaHPbkOfD5m8kbUjuHsu5JrYX6NJlASmSAjBVWWItXx8ka
         3ke5DmKzxQkqE98FRhRuRIngXtb4XQdnSPGUyIPc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03SJsI1Y085873;
        Tue, 28 Apr 2020 14:54:18 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 28
 Apr 2020 14:54:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 28 Apr 2020 14:54:17 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03SJsHVa128578;
        Tue, 28 Apr 2020 14:54:17 -0500
Subject: Re: [RESEND PATCH can-next 1/2] can: tcan4x5x: Rename parse_config
 function
To:     <mkl@pengutronix.de>, <wg@grandegger.com>
CC:     <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200227183829.21854-1-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <057bc43f-7db5-de7e-dbf5-8bfe324a973e@ti.com>
Date:   Tue, 28 Apr 2020 14:48:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200227183829.21854-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc

On 2/27/20 12:38 PM, Dan Murphy wrote:
> Rename the tcan4x5x_parse_config function to tcan4x5x_get_gpios since
> the function retrieves the gpio configurations from the firmware.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>   drivers/net/can/m_can/tcan4x5x.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
> index 9821babef55e..37d53ecc560b 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -381,7 +381,7 @@ static int tcan4x5x_disable_state(struct m_can_classdev *cdev)
>   				  TCAN4X5X_DISABLE_INH_MSK, 0x01);
>   }
>   
> -static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
> +static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
>   {
>   	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
>   	int ret;
> @@ -507,7 +507,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
>   	if (ret)
>   		return ret;
>   
> -	ret = tcan4x5x_parse_config(mcan_class);
> +	ret = tcan4x5x_get_gpios(mcan_class);
>   	if (ret)
>   		goto out_power;
>   

I noticed this series never was reviewed and applied.  They are still 
applicable and were requested changes.

Dan

