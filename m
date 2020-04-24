Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54365C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3173920728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="boaoa6Qx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgDXNLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgDXNLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:11:25 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742ECC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:11:24 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r17so7650797lff.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=G2uXfV2zQ6YcJDE/jPT/znzd8EhGd4IlBIY8GlaqseU=;
        b=boaoa6QxxZN3lCBv5P/sBvwVlfHCoZjiR0gPpaqf3dyoRwSHGfxFtQStzuk++J/6To
         4n5I0Jvx6fc19Pv+X2xswYOFxMK3keWFmkmu4j8r60wq9yJeXq1wqyMxR2WUlB0Fv38R
         Sk68/ReojCiQxUbN0FG1hf2ZUMLZLX0F3+EAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G2uXfV2zQ6YcJDE/jPT/znzd8EhGd4IlBIY8GlaqseU=;
        b=I09YVixp3qplGcPvE05Vc6tRBl48lUNOPSPNGWJfpXjJbiz6PlMDQxWDNgXJdvVRfN
         rW0U55KBIAUgGOZoNy/EtBLgx+t9x0OTUg0ysd9A8NVkQTr5WKSQ1wlZHa7yax1Z/9md
         VTLICXdWiYtElwzcryr8u4yH6s3+/+7/H6y50BVzlHVtahc91q478ifjRpACPg2l4bxr
         OCc6VqmG2A268GNGqTY8Mov2N04kuzCP3C1N7NlyOg5mfus3j06Juv7kmm06umZKiWUW
         /lOWGGZd1hLm9i2Sz5XBcPdOcvxlcmt/uvidr+T2DSyM+rytEI0fOcyUovGGN4oMPBYA
         LbSA==
X-Gm-Message-State: AGi0PuYhE3pk8SO9o3/25oULR2wVXiaEhVxP+wIjrUOeO1Y7+pX95p7Y
        lk9ouo4lCGiTXmzFind7esf69g==
X-Google-Smtp-Source: APiQypLSz5FyzC47Rafs0O51HZGYwp2jhTj+lYOAvYPKJ5wYmLjjuBz8V0lWiSfO0U29zYw8ZGkO3A==
X-Received: by 2002:a05:6512:3081:: with SMTP id z1mr6229213lfd.102.1587733882939;
        Fri, 24 Apr 2020 06:11:22 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id e186sm4551183lfd.83.2020.04.24.06.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 06:11:21 -0700 (PDT)
Subject: Re: [PATCH net-next v3 02/11] bridge: mrp: Update Kconfig
To:     Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net,
        jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org,
        roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20200422161833.1123-1-horatiu.vultur@microchip.com>
 <20200422161833.1123-3-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <cfbeabee-8df5-3a50-b43f-8833723b8ed9@cumulusnetworks.com>
Date:   Fri, 24 Apr 2020 16:11:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422161833.1123-3-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2020 19:18, Horatiu Vultur wrote:
> Add the option BRIDGE_MRP to allow to build in or not MRP support.
> The default value is N.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/Kconfig | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
> index e4fb050e2078..51a6414145d2 100644
> --- a/net/bridge/Kconfig
> +++ b/net/bridge/Kconfig
> @@ -61,3 +61,15 @@ config BRIDGE_VLAN_FILTERING
>  	  Say N to exclude this support and reduce the binary size.
>  
>  	  If unsure, say Y.
> +
> +config BRIDGE_MRP
> +	bool "MRP protocol"
> +	depends on BRIDGE
> +	default n
> +	help
> +	  If you say Y here, then the Ethernet bridge will be able to run MRP
> +	  protocol to detect loops
> +
> +	  Say N to exclude this support and reduce the binary size.
> +
> +	  If unsure, say N.
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

