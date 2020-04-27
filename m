Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20639C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F110A206CD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="P/lpHRdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgD0Jq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726948AbgD0Jqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:46:55 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8362C0610D6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 02:46:53 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e25so16869954ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 02:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UiB8Sz4YfAvbHdDR7SWAyV+bAGQjoJnQnsYXO+tF1Jw=;
        b=P/lpHRdZrhWFk5hitl3BMEiBmG5w4opF0Oalc7Vj/JoILMg5y36ElUeI+8OqWPcNzr
         YghOBqFT5ur+fYkEaQP1DXOdxTjngMaA6419pL6Wo8lYNLTZ/Q1+lF20AKOJHiG6E5r6
         zs44vu2HOocwuzkTfmPJMGGoYFkG5TIGY8zGtoOoboq0uxJnQ5ivErKgaCD+EBfQ8hck
         ep5kHSOtNdPFTS8mI1crRmYKZ8zFxpL+hk51g4gnMMNrmYjI9TtYVcSodtRa2/bJlUtL
         wAkkoDHecXlBGiqiOuiHjlOXNxx/FvMzbAirJDyJhkyH6h5Ay0rzua9icwCF7VuqFAPE
         ioOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UiB8Sz4YfAvbHdDR7SWAyV+bAGQjoJnQnsYXO+tF1Jw=;
        b=kBwDneig+zP/sSgIzzp+EuI/8w69bZrTxcXmHHK10EB6hXEBtVx0GFftsVwnpXfJgD
         I2yorF8o1sbb0p1T8j33A3bu/Ez2GXU3Wn8b48eYV3S5A/CZ1+bzIyzPBblf9oH06NV/
         fQdE7oPgx9tpglboqggXmcFxegRwyiFGvIeNbNM35OMcEq1wy4EluFHxxDfX9bb7qmZR
         1ejsJ49GuMc/DY2DFyRQzw2z8H9YytFw5NFyLinfEib6kX3OflCFfW1vFR9RSjur9aZ5
         yf4luZUR18q/8DQhGvIcAOUzOdGmuj3oqiR7R5U6jWFy97kvkiGbnba0WFnmqCfTWmUi
         wB3Q==
X-Gm-Message-State: AGi0Pub4oO2c76WW+J1gE9h5qrpziGut+H8jN6581pJNwKHq0fZpT1Jl
        qQ/ueW2NcVki7r19aU8aHeXxtg==
X-Google-Smtp-Source: APiQypKroMeYJY/wQUfBYPTmpEXq29J4Z1z4LHIzXUP4q2GwmDpeJ5RcHUo8V2suYyqKrVSqw83gSA==
X-Received: by 2002:a2e:9c09:: with SMTP id s9mr14002613lji.169.1587980812467;
        Mon, 27 Apr 2020 02:46:52 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:468e:1152:9c79:cdeb:725:5fa4? ([2a00:1fa0:468e:1152:9c79:cdeb:725:5fa4])
        by smtp.gmail.com with ESMTPSA id r9sm8794099ljh.36.2020.04.27.02.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 02:46:51 -0700 (PDT)
Subject: Re: [PATCH net-next v4 02/11] bridge: mrp: Update Kconfig
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        nikolay@cumulusnetworks.com, davem@davemloft.net, jiri@resnulli.us,
        ivecera@redhat.com, kuba@kernel.org, roopa@cumulusnetworks.com,
        olteanv@gmail.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org
References: <20200426132208.3232-1-horatiu.vultur@microchip.com>
 <20200426132208.3232-3-horatiu.vultur@microchip.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <ea7b30af-57b7-4cad-b73a-a13cf762c742@cogentembedded.com>
Date:   Mon, 27 Apr 2020 12:46:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200426132208.3232-3-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 26.04.2020 16:21, Horatiu Vultur wrote:

> Add the option BRIDGE_MRP to allow to build in or not MRP support.
> The default value is N.
> 
> Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>   net/bridge/Kconfig | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
> index e4fb050e2078..51a6414145d2 100644
> --- a/net/bridge/Kconfig
> +++ b/net/bridge/Kconfig
> @@ -61,3 +61,15 @@ config BRIDGE_VLAN_FILTERING
>   	  Say N to exclude this support and reduce the binary size.
>   
>   	  If unsure, say Y.
> +
> +config BRIDGE_MRP
> +	bool "MRP protocol"
> +	depends on BRIDGE
> +	default n

    Not needed, N is the default default. :-)

[...]

MBR, Sergei
