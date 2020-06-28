Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26407C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 13:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F2F2065D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 13:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="NFO8nqxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgF1Nvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 09:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgF1Nvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 09:51:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903DDC03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 06:51:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so13940915wrj.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 06:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5mgxW9hsOT95jVSdqt76TrXzIwErXLqCYT4Cq2hSi2M=;
        b=NFO8nqxL0+fVz+1c89X1diLzfnP3FW2Y6K5MMkeSE24rXbkHW+OserBRVE94mmgKbk
         EOUijvy/Tbs9J39/PjQy9jMxzC83AaxW5gepBY90eFM55griMlLeJG6f9m7MDEEfuADR
         0vuA9xtQR55aG9Dx7YJx/cxCY/+yQlanRB2aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5mgxW9hsOT95jVSdqt76TrXzIwErXLqCYT4Cq2hSi2M=;
        b=bq7sDVirxp6OfvH/29XWT7xRheM5gVjdDZ0aOLLKv0oh1OW05sumrsy1HLFhT5v0zs
         rBLxX8tLzcREsoCcLbgtbE28E50ZPVjzI2kVn/9NQSDOWaI82wsfjwXHfJcS9kWPd8+p
         QFRKU1z3kgS0Se7dxL2QpWhi9OcY5VUFoKHVxcVP2a8zEqvQ1P9g6NBq2NZ/5U60Sqz2
         Seka93pZrF/pT+YCmum34rDtmJka5iAjRoaRinJALPGlOuIcEaBokf8LVfQCfWYRxVd9
         4Eue2C0TpoilTeHRUiBe1zR4lhT2x/i/O7xgwZ36lwo6rTfIY5yL9ykM4A2XoEQqpvNi
         TLBQ==
X-Gm-Message-State: AOAM532NxvjwBMSsRj7HdfX+bGXUPYDhkwgDgnS79aU0OQKbwN4kUlmN
        Az7qB9dmvwDf8CFBic6WXsoTPg==
X-Google-Smtp-Source: ABdhPJwL9ReXwP1aRuRXCzuMl/FylxRej/lPdxWKwZRbrGQtRzVjp8f4q95EKHzgOAL03Z3H1xMPLw==
X-Received: by 2002:adf:f20a:: with SMTP id p10mr13696730wro.41.1593352298280;
        Sun, 28 Jun 2020 06:51:38 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id 138sm26714390wma.23.2020.06.28.06.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2020 06:51:37 -0700 (PDT)
Subject: Re: [PATCH net] bridge: mrp: Fix endian conversion and some other
 warnings
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Cc:     kernel test robot <lkp@intel.com>
References: <20200628134516.3767607-1-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <3adf6b93-6cd7-0a9f-9411-736b3d9ca148@cumulusnetworks.com>
Date:   Sun, 28 Jun 2020 16:51:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200628134516.3767607-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2020 16:45, Horatiu Vultur wrote:
> The following sparse warnings are fixed:
> net/bridge/br_mrp.c:106:18: warning: incorrect type in assignment (different base types)
> net/bridge/br_mrp.c:106:18:    expected unsigned short [usertype]
> net/bridge/br_mrp.c:106:18:    got restricted __be16 [usertype]
> net/bridge/br_mrp.c:281:23: warning: incorrect type in argument 1 (different modifiers)
> net/bridge/br_mrp.c:281:23:    expected struct list_head *entry
> net/bridge/br_mrp.c:281:23:    got struct list_head [noderef] *
> net/bridge/br_mrp.c:332:28: warning: incorrect type in argument 1 (different modifiers)
> net/bridge/br_mrp.c:332:28:    expected struct list_head *new
> net/bridge/br_mrp.c:332:28:    got struct list_head [noderef] *
> net/bridge/br_mrp.c:332:40: warning: incorrect type in argument 2 (different modifiers)
> net/bridge/br_mrp.c:332:40:    expected struct list_head *head
> net/bridge/br_mrp.c:332:40:    got struct list_head [noderef] *
> net/bridge/br_mrp.c:682:29: warning: incorrect type in argument 1 (different modifiers)
> net/bridge/br_mrp.c:682:29:    expected struct list_head const *head
> net/bridge/br_mrp.c:682:29:    got struct list_head [noderef] *
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 2f1a11ae11d222 ("bridge: mrp: Add MRP interface.")
> Fixes: 4b8d7d4c599182 ("bridge: mrp: Extend bridge interface")
> Fixes: 9a9f26e8f7ea30 ("bridge: mrp: Connect MRP API with the switchdev API")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_mrp.c         | 2 +-
>  net/bridge/br_private.h     | 2 +-
>  net/bridge/br_private_mrp.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

> diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
> index 779e1eb754430..90592af9db619 100644
> --- a/net/bridge/br_mrp.c
> +++ b/net/bridge/br_mrp.c
> @@ -86,7 +86,7 @@ static struct sk_buff *br_mrp_skb_alloc(struct net_bridge_port *p,
>  {
>  	struct ethhdr *eth_hdr;
>  	struct sk_buff *skb;
> -	u16 *version;
> +	__be16 *version;
>  
>  	skb = dev_alloc_skb(MRP_MAX_FRAME_LENGTH);
>  	if (!skb)
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 2130fe0194e64..e0ea6dbbc97ed 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -430,7 +430,7 @@ struct net_bridge {
>  	struct hlist_head		fdb_list;
>  
>  #if IS_ENABLED(CONFIG_BRIDGE_MRP)
> -	struct list_head		__rcu mrp_list;
> +	struct list_head		mrp_list;
>  #endif
>  };
>  
> diff --git a/net/bridge/br_private_mrp.h b/net/bridge/br_private_mrp.h
> index 33b255e38ffec..315eb37d89f0f 100644
> --- a/net/bridge/br_private_mrp.h
> +++ b/net/bridge/br_private_mrp.h
> @@ -8,7 +8,7 @@
>  
>  struct br_mrp {
>  	/* list of mrp instances */
> -	struct list_head		__rcu list;
> +	struct list_head		list;
>  
>  	struct net_bridge_port __rcu	*p_port;
>  	struct net_bridge_port __rcu	*s_port;
> 

