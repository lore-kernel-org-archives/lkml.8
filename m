Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68361C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FCC207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pensando.io header.i=@pensando.io header.b="Q/iHPLPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgBRW4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 17:56:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43656 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgBRW4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:56:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id u12so11319120pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 14:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5EPr0BrtYIu4h/VI5T3PQSkN4bFjMVa+ROiHBvZu+BI=;
        b=Q/iHPLPqU8KdXSDOCl9uBuYCdsHCX3GF4coOl8mrfuVReaafn0vLQ569GLDEf95ROp
         1RRq249ryqMkK791jMbWsUYY7Ak2eYcW7PmeDvO7w+F8Jiut3eCYCPpxGR5ekBkbMBjr
         LxqEqtN/u4h1wojWYglY3nSBT7PblCwHynJCaGTHZkABwxg1GRRyrN0se+2ttsxRcOHd
         DYMZ7KOlwY2XXtpca6px953DW+lTYKlgz+F/6QhNYtlh7y064SWeX1Ejg1zzKoXx8kjY
         Dqxou/vrxUtxylYySObfEXXMjHYLTFNdecCmTsrcv+/ZFHp5h/F631YJJOtUQhdTTYXV
         Jzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5EPr0BrtYIu4h/VI5T3PQSkN4bFjMVa+ROiHBvZu+BI=;
        b=XL6IBuxZLonlYF04vFCCI2Ssy4yA3P6/NHBs+VLLO6RRYBeJSE+2TrBi+JRnwpPuDX
         QPsXKCdxwzF6pt5gWKr0u8a7jPvgasuACjWK09jR+QQLYhXLUSlOwIkhwediCfUsffck
         RnwNNPTwhMkSyJaj6a3QiPviki5Qihx2h/kMYj2+teKBpeNEY1RQwRE3JRxXQBHd2wJY
         Tt9OdC8Scny/VVWrmIuybDQMV7nLmhSCJlhIPntkF9k/K7r3KAGgPGJP/oPoiy90HjLg
         2kJ+VmkZlsLlt80mkzqCo21CiYyZi0Ch/EbnUQ9RUhlQl7Am2BceCHxFSHEGeNZcpPzO
         fQjg==
X-Gm-Message-State: APjAAAW0s/F4OPdt5vUTHJdbt4gCxOiOmciam3J/yw0p0T8iTGtRqMe6
        1A8XSqO34JcadirQz6dUC9AFUHkwqXstUQ==
X-Google-Smtp-Source: APXvYqz7nedQ+1/dk7RG2xy+rgK1m7AzU1TycdR/pgv8v/Mql8v6cJP3Fll6GADovWcn9okVAAwWNw==
X-Received: by 2002:a62:4e42:: with SMTP id c63mr23648342pfb.86.1582066602217;
        Tue, 18 Feb 2020 14:56:42 -0800 (PST)
Received: from Shannons-MacBook-Pro.local (static-50-53-47-17.bvtn.or.frontiernet.net. [50.53.47.17])
        by smtp.gmail.com with ESMTPSA id p21sm47270pfn.103.2020.02.18.14.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 14:56:41 -0800 (PST)
Subject: Re: [PATCH net-next v2 08/13] ionic: use new helper
 tcp_v6_gso_csum_prep
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        David Miller <davem@davemloft.net>,
        Pensando Drivers <drivers@pensando.io>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <fffc8b6d-68ed-7501-18f1-94cf548821fb@gmail.com>
 <6960380e-cee3-b65c-010f-551635cb3988@gmail.com>
From:   Shannon Nelson <snelson@pensando.io>
Message-ID: <b542e139-307b-47eb-cdf8-45465e8e7b41@pensando.io>
Date:   Tue, 18 Feb 2020 14:56:40 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <6960380e-cee3-b65c-010f-551635cb3988@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/20 12:07 PM, Heiner Kallweit wrote:
> Use new helper tcp_v6_gso_csum_prep in additional network drivers.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-by: Shannon Nelson <snelson@pensando.io>

> ---
>   drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> index e452f4242..020acc300 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -632,10 +632,7 @@ static int ionic_tx_tcp_pseudo_csum(struct sk_buff *skb)
>   					   ip_hdr(skb)->daddr,
>   					   0, IPPROTO_TCP, 0);
>   	} else if (skb->protocol == cpu_to_be16(ETH_P_IPV6)) {
> -		tcp_hdr(skb)->check =
> -			~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
> -					 &ipv6_hdr(skb)->daddr,
> -					 0, IPPROTO_TCP, 0);
> +		tcp_v6_gso_csum_prep(skb);
>   	}
>   
>   	return 0;

