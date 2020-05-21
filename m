Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24CCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE5920738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="LdVexuje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgEUIQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 04:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbgEUIQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 04:16:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4307CC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 01:16:48 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w64so5437073wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 01:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jBkf6P6nSXkyKzMFNo3bLUqW/4eqoq0c19s0e7M06zY=;
        b=LdVexujeEgbDGsiI0uzhi86AsBADHpO7fcAZkjSHwVByEZ1BzgfoNWK1h/S25Nn5uV
         q8MiB1Pkj2NFuHc53bE/hg3iJ8K1W5X16BokluyyxhBHZbx6aU5XuT4KkCgLzoANwp2z
         0IkrwffwDe1Q0bNIT7SNygMo1YJX/3KNKpJak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jBkf6P6nSXkyKzMFNo3bLUqW/4eqoq0c19s0e7M06zY=;
        b=aTDwpHqJ6OjXQWo4Uouv3yeHL3ijcTKI6W7ldD3JEpgfhoXW78zBkzTUjRQmAWZ0H4
         uhi3B5jh8SUh8JKTRi1mMmQw38pJ5YimX50EFig9dTFG8rXv7e/W10L8oU1XNIo3Wscf
         6ZOPAXgEiqkmZMs1lKOiyyGu3RLAxKDtTXcjxPVOXeX1E4s3H1QZzhHvqtdxlbxbQML4
         7NHnnVDepD4dcApUCAmWk2qyo4PZCY4DmV14lkvhfM/c07+S1ag5TYpW/Lk/DFuX4Ii1
         8bjEaEgXxbsrJw1j/Ekpq899kn6f3Y87NWZHGIMhs+tbKca9Yk3vzYv/5ZGqVEWeQbE6
         0MrA==
X-Gm-Message-State: AOAM532WPx13u/mKVz3VXvybgkEz4e8vfLcwNizoUhncrSlqBTwj2nyt
        t/QBt0VW6a5NnbizWoNtZ0xFHg==
X-Google-Smtp-Source: ABdhPJy5zO/XnY8I5DXGdgeP4O6u+idOSeEQM2pULeJGWQoKIWpcgAPJbz/cElBzBm674NjeF6fIrg==
X-Received: by 2002:a1c:7d43:: with SMTP id y64mr8224264wmc.46.1590049006940;
        Thu, 21 May 2020 01:16:46 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id n13sm5466384wrs.2.2020.05.21.01.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 01:16:46 -0700 (PDT)
Subject: Re: [PATCH 1/3] bridge: mrp: Add br_mrp_unique_ifindex function
To:     Horatiu Vultur <horatiu.vultur@microchip.com>, jiri@resnulli.us,
        ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org,
        roopa@cumulusnetworks.com, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20200520130923.3196432-1-horatiu.vultur@microchip.com>
 <20200520130923.3196432-2-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <cecbdbf0-bb49-1e3c-c163-8e7412c6fcec@cumulusnetworks.com>
Date:   Thu, 21 May 2020 11:16:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200520130923.3196432-2-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2020 16:09, Horatiu Vultur wrote:
> It is not allow to have the same net bridge port part of multiple MRP
> rings. Therefore add a check if the port is used already in a different
> MRP. In that case return failure.
> 
> Fixes: 9a9f26e8f7ea ("bridge: mrp: Connect MRP API with the switchdev API")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_mrp.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
> index d7bc09de4c139..a5a3fa59c078a 100644
> --- a/net/bridge/br_mrp.c
> +++ b/net/bridge/br_mrp.c
> @@ -37,6 +37,32 @@ static struct br_mrp *br_mrp_find_id(struct net_bridge *br, u32 ring_id)
>  	return res;
>  }
>  
> +static bool br_mrp_unique_ifindex(struct net_bridge *br, u32 ifindex)
> +{
> +	struct br_mrp *mrp;
> +	bool res = true;
> +
> +	rcu_read_lock();

Why do you need the rcu_read_lock() here when lockdep_rtnl_is_held() is used?
You should be able to just do rtnl_dereference() below as this is used only
under rtnl.

> +	list_for_each_entry_rcu(mrp, &br->mrp_list, list,
> +				lockdep_rtnl_is_held()) {
> +		struct net_bridge_port *p;
> +
> +		p = rcu_dereference(mrp->p_port);
> +		if (p && p->dev->ifindex == ifindex) {
> +			res = false;
> +			break;
> +		}
> +
> +		p = rcu_dereference(mrp->s_port);
> +		if (p && p->dev->ifindex == ifindex) {
> +			res = false;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +	return res;
> +}
> +
>  static struct br_mrp *br_mrp_find_port(struct net_bridge *br,
>  				       struct net_bridge_port *p)
>  {
> @@ -255,6 +281,11 @@ int br_mrp_add(struct net_bridge *br, struct br_mrp_instance *instance)
>  	    !br_mrp_get_port(br, instance->s_ifindex))
>  		return -EINVAL;
>  
> +	/* It is not possible to have the same port part of multiple rings */
> +	if (!br_mrp_unique_ifindex(br, instance->p_ifindex) ||
> +	    !br_mrp_unique_ifindex(br, instance->s_ifindex))
> +		return -EINVAL;
> +
>  	mrp = kzalloc(sizeof(*mrp), GFP_KERNEL);
>  	if (!mrp)
>  		return -ENOMEM;
> 

