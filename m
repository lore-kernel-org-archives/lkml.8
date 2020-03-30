Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9860BC2D0EE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E259206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="dHFrXjAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgC3QQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:16:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38159 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbgC3QQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:16:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id w1so18703011ljh.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 09:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QpOIR907T/wwW05Dr6k2YR4q9EgvViup03SDjAZ1IS8=;
        b=dHFrXjAmgcscbhtftarqXEKgpHNJjgzLjsFlYUUJhkt7ypj5szHz/C0tGLKYgz1Vi3
         aADxpw2+tymWuQokvjIDaWdUsfDelM6zMTWOmVeNExCybqzT3LP7UcC5Mjn0UMj2IUXb
         nev8nr2pqUrpwP8dKOXZ4YUAjMZ+w6aO7YYIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QpOIR907T/wwW05Dr6k2YR4q9EgvViup03SDjAZ1IS8=;
        b=YPbm5tK1goTTcmsiWRB+HiHAKht+AWUWN/tU2IbltF10lfimxt4RZaB4V5G58pHg7E
         /8D8wAau8VMxiVKj/xeSbRIiM/qNN5dmFUWB9vGLVd0Vp7pjQpPt1gevQLzm2tNwjwcF
         Gt6GE/1dA03JShZoAQX7kc9w1uT86RW3MjJtUC0EFkEwBXpAxp2zeUy94zyTKkUYcFtw
         vogUz3DwjJYMrjOyodJgEds2wiL3FpUN1dh+UWt29PlTjbSnLn80+eQGaSZxf6Ryjy7n
         G3bskl2iDxIw3B91G1cld+tsURgN7y01UfDm/YUcRWwIh48OVoyr0sIF8g48mZFDs3UL
         j2gA==
X-Gm-Message-State: AGi0PuYK+uoKQNf1vpi86/rno+KLzv1xSKPtSUeMqfZ6H5kydCzs3N1s
        E6ZkTtoTNJ8Byf9Jsyo+dFPNXg==
X-Google-Smtp-Source: APiQypKRHK7B+ad3csMViQHoxs0tbVmW7H4M9/KVXhe2awqHXEc4j2Yy5xoqdIKOM2hWBEJ81tG9sA==
X-Received: by 2002:a2e:97cd:: with SMTP id m13mr7795367ljj.20.1585584981318;
        Mon, 30 Mar 2020 09:16:21 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id i20sm476679lja.17.2020.03.30.09.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 09:16:20 -0700 (PDT)
Subject: Re: [RFC net-next v4 8/9] bridge: mrp: Integrate MRP into the bridge
To:     Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net,
        jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org,
        roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20200327092126.15407-1-horatiu.vultur@microchip.com>
 <20200327092126.15407-9-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <17d9fb2a-cb48-7bb6-cb79-3876ca3a74b2@cumulusnetworks.com>
Date:   Mon, 30 Mar 2020 19:16:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200327092126.15407-9-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2020 11:21, Horatiu Vultur wrote:
> To integrate MRP into the bridge, the bridge needs to do the following:
> - add new flag(BR_MPP_AWARE) to the net bridge ports, this bit will be set when
>   the port is added to an MRP instance. In this way it knows if the frame was
>   received on MRP ring port
> - detect if the MRP frame was received on MRP ring port in that case it would be
>   processed otherwise just forward it as usual.
> - enable parsing of MRP
> - before whenever the bridge was set up, it would set all the ports in
>   forwarding state. Add an extra check to not set ports in forwarding state if
>   the port is an MRP ring port. The reason of this change is that if the MRP
>   instance initially sets the port in blocked state by setting the bridge up it
>   would overwrite this setting.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/linux/if_bridge.h |  1 +
>  net/bridge/br_device.c    |  3 +++
>  net/bridge/br_input.c     |  3 +++
>  net/bridge/br_netlink.c   |  5 +++++
>  net/bridge/br_private.h   | 22 ++++++++++++++++++++++
>  net/bridge/br_stp.c       |  6 ++++++
>  6 files changed, 40 insertions(+)
> 
> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index 9e57c4411734..10baa9efdae8 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -47,6 +47,7 @@ struct br_ip_list {
>  #define BR_BCAST_FLOOD		BIT(14)
>  #define BR_NEIGH_SUPPRESS	BIT(15)
>  #define BR_ISOLATED		BIT(16)
> +#define BR_MRP_AWARE		BIT(17)
>  
>  #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
>  
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index 0e3dbc5f3c34..8ec1362588af 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -463,6 +463,9 @@ void br_dev_setup(struct net_device *dev)
>  	spin_lock_init(&br->lock);
>  	INIT_LIST_HEAD(&br->port_list);
>  	INIT_HLIST_HEAD(&br->fdb_list);
> +#if IS_ENABLED(CONFIG_BRIDGE_MRP)
> +	INIT_LIST_HEAD(&br->mrp_list);
> +#endif
>  	spin_lock_init(&br->hash_lock);
>  
>  	br->bridge_id.prio[0] = 0x80;
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index fcc260840028..d5c34f36f0f4 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -342,6 +342,9 @@ rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
>  		}
>  	}
>  
> +	if (unlikely(br_mrp_process(p, skb)))
> +		return RX_HANDLER_PASS;
> +
>  forward:
>  	switch (p->state) {
>  	case BR_STATE_FORWARDING:
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 43dab4066f91..77bc96745be6 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -669,6 +669,11 @@ static int br_afspec(struct net_bridge *br,
>  			if (err)
>  				return err;
>  			break;
> +		case IFLA_BRIDGE_MRP:
> +			err = br_mrp_parse(br, p, attr, cmd);
> +			if (err)
> +				return err;
> +			break;
>  		}
>  	}
>  
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 1f97703a52ff..38894f2cf98f 100644
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
> @@ -1304,6 +1308,24 @@ unsigned long br_timer_value(const struct timer_list *timer);
>  extern int (*br_fdb_test_addr_hook)(struct net_device *dev, unsigned char *addr);
>  #endif
>  
> +/* br_mrp.c */
> +#if IS_ENABLED(CONFIG_BRIDGE_MRP)
> +int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
> +		 struct nlattr *attr, int cmd);
> +int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb);
> +#else
> +static inline int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
> +			       struct nlattr *attr, int cmd)
> +{
> +	return -1;

You should return proper error here.

> +}
> +
> +static inline int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb)
> +{
> +	return -1;

The bridge can't possibly work with MRP disabled with this.

> +}
> +#endif
> +
>  /* br_netlink.c */
>  extern struct rtnl_link_ops br_link_ops;
>  int br_netlink_init(void);
> diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
> index 1f14b8455345..3e88be7aa269 100644
> --- a/net/bridge/br_stp.c
> +++ b/net/bridge/br_stp.c
> @@ -36,6 +36,12 @@ void br_set_state(struct net_bridge_port *p, unsigned int state)
>  	};
>  	int err;
>  
> +	/* Don't change the state of the ports if they are driven by a different
> +	 * protocol.
> +	 */
> +	if (p->flags & BR_MRP_AWARE)
> +		return;
> +

Maybe disallow STP type (kernel/user-space/no-stp) changing as well, force it to no-stp.

>  	p->state = state;
>  	err = switchdev_port_attr_set(p->dev, &attr);
>  	if (err && err != -EOPNOTSUPP)
> 

