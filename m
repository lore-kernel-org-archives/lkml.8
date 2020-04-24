Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DA7C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9923F20776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="PWNcKVYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgDXNMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgDXNME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:12:04 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012A5C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:12:04 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id j3so9853261ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9BcUMuWu+VNLqROvvMiYmkUjwNZj8mEI6zOXCjGTZxo=;
        b=PWNcKVYqHTwiMFgcLh7n20tJrrsK/zpNBWaw3Rp0qZdPq2BLfukmh0GIkMVeAuctcY
         Xf9shxjyJXpfiY73Myty+VBxZpg1XpMip0sdhaHc2N+y+1gc7bW53Ua8/P0TFX3RAoAn
         /c6jPNWF57LlMgvDF93pNokpLg5oR44Nsw8eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9BcUMuWu+VNLqROvvMiYmkUjwNZj8mEI6zOXCjGTZxo=;
        b=aR/aPaTSz74qhQWSIe8vw7g3lQ0A8dwpNfWwcc1KbHG+HVNqotolSXSOshX9y8/2yp
         YtPCYcURZW629m5qYnjI2Ff4buDZKdM0B5lR0zQZz89ZC9Gtc6HIOYaUQS/RkUAXQFff
         +1JApNpyifSiT+YKvS3qVuWzVAyL092M6R8knNMV8RT9NBN4XOBQbWWh+XP4s1TyanA9
         q5jj5PZQgaya8tVsPYSVhgkDwHJjf2fAe/dqdQLC/YH35lGHncfEEH2NWe0+XJFX81D4
         ze81QTNxlXoFpNurnqt/gVLxQrjXocrhWreK7nApfePCTjyN4kGKo1PPEfqIuLl7smKA
         uKCQ==
X-Gm-Message-State: AGi0Pubqew+NDM8NR5MQz+BE9dr04hv1w8bUubqEYh9DJQIedqFL0pPT
        kpNgFpOMZ2+/SPpV8MLKBlx3Mw==
X-Google-Smtp-Source: APiQypJfAx+GKKpCQ20WxRaIJTCoQVCKp2g4ouW9mDRPf9ldLGQXwuqlakEeYzLPzXQTTAe3hVNd2g==
X-Received: by 2002:a05:651c:326:: with SMTP id b6mr4651717ljp.259.1587733922298;
        Fri, 24 Apr 2020 06:12:02 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id p13sm4135969ljg.103.2020.04.24.06.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 06:12:01 -0700 (PDT)
Subject: Re: [PATCH net-next v3 03/11] bridge: mrp: Extend bridge interface
To:     Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net,
        jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org,
        roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20200422161833.1123-1-horatiu.vultur@microchip.com>
 <20200422161833.1123-4-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <620390de-6f5a-d3a8-e48c-42089355eefa@cumulusnetworks.com>
Date:   Fri, 24 Apr 2020 16:11:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422161833.1123-4-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2020 19:18, Horatiu Vultur wrote:
> To integrate MRP into the bridge, first the bridge needs to be aware of ports
> that are part of an MRP ring and which rings are on the bridge.
> Therefore extend bridge interface with the following:
> - add new flag(BR_MPP_AWARE) to the net bridge ports, this bit will be
>   set when the port is added to an MRP instance. In this way it knows if
>   the frame was received on MRP ring port
> - add new flag(BR_MRP_LOST_CONT) to the net bridge ports, this bit will be set
>   when the port lost the continuity of MRP Test frames.
> - add a list of MRP instances
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/linux/if_bridge.h | 2 ++
>  net/bridge/br_private.h   | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index 9e57c4411734..b3a8d3054af0 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -47,6 +47,8 @@ struct br_ip_list {
>  #define BR_BCAST_FLOOD		BIT(14)
>  #define BR_NEIGH_SUPPRESS	BIT(15)
>  #define BR_ISOLATED		BIT(16)
> +#define BR_MRP_AWARE		BIT(17)
> +#define BR_MRP_LOST_CONT	BIT(18)
>  
>  #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
>  
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 1f97703a52ff..835a70f8d3ea 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -428,6 +428,10 @@ struct net_bridge {
>  	int offload_fwd_mark;
>  #endif
>  	struct hlist_head		fdb_list;
> +
> +#if IS_ENABLED(CONFIG_BRIDGE_MRP)
> +	struct list_head		__rcu mrp_list;
> +#endif
>  };
>  
>  struct br_input_skb_cb {
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

