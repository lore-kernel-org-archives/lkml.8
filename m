Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCF9C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FD820776
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="uUop0dX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgDWJqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 05:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726951AbgDWJqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 05:46:33 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FD0C03C1AF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 02:46:33 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u10so4227197lfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 02:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0bn5MZ3x1AZMueYLHBvYYK4+M4Vkn8wTCGTXb/d2uVE=;
        b=uUop0dX6USv5o0OS0FsApSO+QvBdobyuottPosBAc0udDrdY2SxeBV5a6bdeUQOx5z
         MKAs4zdQdfAKliIGLGt7qagS4L8LMq726kRgyEkwDLhU9B0M3BmDfK40bSEmf/rzTOie
         wV1L912Hhuw3qlbV+F3v2EKuxZfE0KY47fwcFWMR3ONnbF2N5wWRQNlTEr/XDrzT+Wwc
         LQOrdSoPSxQp7PPEkQPKs2MhYDuMizWLdfPkgG33tX2BUGytcxTPeUhZVCCf77Xb0J/Q
         +6o5wVcgQ6gCA9vaA7J3A25ZsnplIoIDyv5qQG6divGjAphr14PyAexwet/CDVpDhyqc
         g7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0bn5MZ3x1AZMueYLHBvYYK4+M4Vkn8wTCGTXb/d2uVE=;
        b=nrYkg6+ZHfJCLD4S4Hje2n1rQ9ti/4CY4HvD2XDHv8waMvXFHfErdyM0bo/ZUulgu3
         9sV+Q8HoUBM1GHPvb8XD/up2qL/wZ9CaObElxscgIMNKSl/0Uigl0ISMNzrwwNSO1WCB
         8QGzLz2jz00molPLooNRkF2Df/qCGMFSpDmUx9hgSVLmQb3I+gYepBmbbEWL7FRvvp2a
         DzhF6Z19TXx/xmresCblSG0ZvJDvoZoEE12wo0VU0jWJi5dauVwbpYvhldKXUZdNFcdI
         Ig6RSyU8/w0nKoRPuoYr7Ztsbt6OZrvzVKZM8AHMWmp/O0hdB5Cpwkc4iEjOy8Hek0Az
         w67A==
X-Gm-Message-State: AGi0PuaMrqZEcLWi+BvopC9jxzB1T3wHZmgPyc3KotaZrbdgWQnxkr8b
        F0K7gHbrhgiZ1ljRjYAyB4X8Rw==
X-Google-Smtp-Source: APiQypLEwhN/y4/l8USQl+mMh50NmWYjOi6/qdBQHkmlNJmc+IJxk5qI719O25WlSoGqZjWR2xG1OA==
X-Received: by 2002:ac2:5930:: with SMTP id v16mr1893719lfi.103.1587635191938;
        Thu, 23 Apr 2020 02:46:31 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:46dc:a81c:1cf:8fa9:cce2:9ac2? ([2a00:1fa0:46dc:a81c:1cf:8fa9:cce2:9ac2])
        by smtp.gmail.com with ESMTPSA id o195sm1322097lfa.50.2020.04.23.02.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 02:46:31 -0700 (PDT)
Subject: Re: [PATCH] ipw2x00: Remove a memory allocation failure log message
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        stas.yakovlev@gmail.com, kvalo@codeaurora.org, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200423075825.18206-1-christophe.jaillet@wanadoo.fr>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <5868418d-88b0-3694-2942-5988ab15bdcb@cogentembedded.com>
Date:   Thu, 23 Apr 2020 12:46:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423075825.18206-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 23.04.2020 10:58, Christophe JAILLET wrote:

> Axe a memory allocation failure log message. This message is useless and
> incorrect (vmalloc is not used here for the memory allocation)
> 
> This has been like that since the very beginning of this driver in
> commit 43f66a6ce8da ("Add ipw2200 wireless driver.")
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/net/wireless/intel/ipw2x00/ipw2200.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
> index 60b5e08dd6df..30c4f041f565 100644
> --- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
> +++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
> @@ -3770,10 +3770,9 @@ static int ipw_queue_tx_init(struct ipw_priv *priv,
>   	struct pci_dev *dev = priv->pci_dev;
>   
>   	q->txb = kmalloc_array(count, sizeof(q->txb[0]), GFP_KERNEL);
> -	if (!q->txb) {
> -		IPW_ERROR("vmalloc for auxiliary BD structures failed\n");
> +	if (!q->txb)
>   		return -ENOMEM;
> -	}
> +

    No need for this extra empty line.

>   
>   	q->bd =
>   	    pci_alloc_consistent(dev, sizeof(q->bd[0]) * count, &q->q.dma_addr);

MBR, Sergei

