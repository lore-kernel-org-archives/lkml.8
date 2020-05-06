Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06DCC38A24
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16C72070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="GmeI+UP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgEFJrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 05:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729040AbgEFJrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:47:41 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5892DC061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 02:47:39 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t11so790795lfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 02:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/9ah7zhuR4873GSpvZCqmYYEsJCcLFVCYyRiQ4J6Vdk=;
        b=GmeI+UP24kyAPTiBFvucgZ/V4AdmN9uFhZQV85PUDH3V01byOj0XccFF6diF/xZd4E
         +cSoNUycgb8W8kPHInzeAOkcj+nqZPlNvaGrwlGWqFZpY2eMaUa27ZP5I9tqihtthDnx
         6QQKERCXj5PH5svOqIuTE12LsGdy5dfxSTCXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/9ah7zhuR4873GSpvZCqmYYEsJCcLFVCYyRiQ4J6Vdk=;
        b=AKvwQ+KkhRxpv/R9kVEfo1q8SY/vk9jzXXiiAXTSJBizCr/GSmUw1RAQhJ6TahMvks
         PU2ZAz/emtkDAi/QHnyYEttqxwi0tRX85hXpspo5Ra7gWOjxSTQ/kIQ6DxVxsBRYrT42
         QSfpuHCxa14bOdauULz7cKSFDHAY30Hsu+SXfgnw5X5Kx8fARN/ac1qP9Plfs1gPDPmF
         T/xNVysQI9nb/jRk3yYUEZdKR2Hk3G40ckAkvKasyYYvvzTJClPPZoE+1+csOkwo7ihJ
         86kmUrQ0ng9v0KLIVaGGK9OPStKpopUDGW5qOp6Z609GGdWOawre/PvpPCcN6kiokwTF
         DUbg==
X-Gm-Message-State: AGi0PuYu5pXgPcQa1nQohr2q0mGeRpTZcF0lV2y5Q8wqAlySIxYDrZzm
        /A4EtAkopqYxVk4DrHAD09tM3Nzfa9Np7A==
X-Google-Smtp-Source: APiQypLnD2AvkD2qPRRmjXwr/1RNm41CbdM9Hbn0xbk9jZ1SR3g4pCmCYNoosoZyqZS6x+UMJMpQzA==
X-Received: by 2002:a05:6512:455:: with SMTP id y21mr4691981lfk.202.1588758457377;
        Wed, 06 May 2020 02:47:37 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id 23sm954196lju.106.2020.05.06.02.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 02:47:36 -0700 (PDT)
Subject: Re: [PATCH net-next] net: bridge: return false in br_mrp_enabled()
To:     Jason Yan <yanaijie@huawei.com>, roopa@cumulusnetworks.com,
        davem@davemloft.net, kuba@kernel.org,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200506061616.18929-1-yanaijie@huawei.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <80b3d01a-1bd5-f5c5-abaa-6f3114683617@cumulusnetworks.com>
Date:   Wed, 6 May 2020 12:47:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200506061616.18929-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2020 09:16, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> net/bridge/br_private.h:1334:8-9: WARNING: return of 0/1 in function
> 'br_mrp_enabled' with return type bool
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  net/bridge/br_private.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index c35647cb138a..78d3a951180d 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1331,7 +1331,7 @@ static inline int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb)
>  
>  static inline bool br_mrp_enabled(struct net_bridge *br)
>  {
> -	return 0;
> +	return false;
>  }
>  
>  static inline void br_mrp_port_del(struct net_bridge *br,
> 
Fixes: 6536993371fab ("bridge: mrp: Integrate MRP into the bridge")
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

