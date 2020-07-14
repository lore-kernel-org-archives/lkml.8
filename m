Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE2FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA8A22203
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="XXQ7p8Ky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgGNNQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgGNNQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:16:07 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C36C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:16:07 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so5661371wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=l79f/bqNc9BYIqpkKbR40Mk7GQtal76rQ4QXD+nfL2Y=;
        b=XXQ7p8KyYKTbDMF3l/69Sv27LRV0Ka6JXcMwCu9L4rgoDD1xZOj0g6Sa/pTdCJ6hgg
         q0CobtyfA2V3NqePGjZVUF/K76bRgnbmwqSaS/qVPmy9Ii1Esh3OGkkgd7QKJr3IWX4b
         BU1EUdRloq0XZPEWE7ZjyUym1DIEBgzqp89No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l79f/bqNc9BYIqpkKbR40Mk7GQtal76rQ4QXD+nfL2Y=;
        b=ID0t7sk/yTz4Yvyig+lZhWsgI5PWrZRBVCAlQ76aL1m859wJlcDnJjJ3Q0Nl+gWu6t
         nWAx1f1hTsaI1VSZ203XH+UE8+szsVGdaGNmsvQBph1Hpk3XCbRLLwwvnZVBAQsDA97C
         HfIIg89uSg++wRiAg1/BH+Rg3zCLbB8aIRJNFohsZ98MuLkjeYI3Psus8P0goAIL7qlm
         ae+6CQ4hWptFmh9nJoyIR/I7D8wLgSWN2sVL/goSY0B5RW+k2X9P0Wns69g9p6+adujP
         Fv8sAdBp2nfjFKn+HY4D6st/l0x0VCx52g4mh6ZjiDeZmQNo7CdiEbqY7IExZJI6IRnR
         NYUg==
X-Gm-Message-State: AOAM5307/GHTocxQxh6qry5d4cU+J1Ur2SCo6J+aJRtYv67IE0kDSBJA
        Mf5vvQB2JF815hm41GMKJ+qyuw==
X-Google-Smtp-Source: ABdhPJyo0csAWOJYkjGH9aDpWd86z61HZ736Xs730a9WWVUCWSNiO7+k1NlWjvNJVUecf6+IffGdWQ==
X-Received: by 2002:a1c:e285:: with SMTP id z127mr4490370wmg.162.1594732566214;
        Tue, 14 Jul 2020 06:16:06 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id 59sm30868395wrj.37.2020.07.14.06.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 06:16:05 -0700 (PDT)
Subject: Re: [PATCH net-next v4 06/12] bridge: mrp: Add br_mrp_in_port_open
 function
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org,
        jiri@resnulli.us, ivecera@redhat.com, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
 <20200714073458.1939574-7-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <24df99ce-f81b-03f1-f235-e2c0ce5016f0@cumulusnetworks.com>
Date:   Tue, 14 Jul 2020 16:16:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200714073458.1939574-7-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2020 10:34, Horatiu Vultur wrote:
> This function notifies the userspace when the node lost the continuity
> of MRP_InTest frames.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_mrp_netlink.c | 22 ++++++++++++++++++++++
>  net/bridge/br_private_mrp.h |  1 +
>  2 files changed, 23 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

> diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
> index acce300c0cc29..4bf7aaeb29152 100644
> --- a/net/bridge/br_mrp_netlink.c
> +++ b/net/bridge/br_mrp_netlink.c
> @@ -389,3 +389,25 @@ int br_mrp_ring_port_open(struct net_device *dev, u8 loc)
>  out:
>  	return err;
>  }
> +
> +int br_mrp_in_port_open(struct net_device *dev, u8 loc)
> +{
> +	struct net_bridge_port *p;
> +	int err = 0;
> +
> +	p = br_port_get_rcu(dev);
> +	if (!p) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (loc)
> +		p->flags |= BR_MRP_LOST_IN_CONT;
> +	else
> +		p->flags &= ~BR_MRP_LOST_IN_CONT;
> +
> +	br_ifinfo_notify(RTM_NEWLINK, NULL, p);
> +
> +out:
> +	return err;
> +}
> diff --git a/net/bridge/br_private_mrp.h b/net/bridge/br_private_mrp.h
> index e93c8f9d4df58..23da2f956ad0e 100644
> --- a/net/bridge/br_private_mrp.h
> +++ b/net/bridge/br_private_mrp.h
> @@ -75,5 +75,6 @@ int br_mrp_port_switchdev_set_role(struct net_bridge_port *p,
>  
>  /* br_mrp_netlink.c  */
>  int br_mrp_ring_port_open(struct net_device *dev, u8 loc);
> +int br_mrp_in_port_open(struct net_device *dev, u8 loc);
>  
>  #endif /* _BR_PRIVATE_MRP_H */
> 

