Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8835C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A022082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="eEhOVFSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388296AbgFXITu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387606AbgFXITt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:19:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFABDC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:19:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h5so1342527wrc.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Wv1AjMOuj4JRAMUGr5+fFc8v4YLKY5jvII8okZDpzHw=;
        b=eEhOVFSDKpCIqdFMNN+kW8KleYbcUrovSfm7ne7wnV7CvUvqw7kffrtuERcj/5lgzJ
         Sw8ypnbR8gU4OYH3S8MkAlWbIc+sJ8+JOaXYN/0eSPyqOJiCLv0gtsDRjA4m6EM/lZAS
         47GRZPSCZ9kLEj1DRF/uTvXodI7hpYq9b7hF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wv1AjMOuj4JRAMUGr5+fFc8v4YLKY5jvII8okZDpzHw=;
        b=Yc309cnWHqtJVHlAuyjeoLEP3lw5kP3NKpENCaG90wGwiCife4444Vbj05Fs0CO8P5
         RXJEqcMvlnRJXQF0wmLpQAQgVLjUXWy6JD6wr7P/phk01NJ4Cl42Y0Npdcuox7HXGaw/
         oDHZnLuI7BB/PK4LKSAp15bt0FGfmwZ0m3wCRz4EMdhyBRzG9gsRuXkktygoznoZM4bH
         biw6Fh+6kUTfUnWFkLeWQ6+sKmk4OuTx3Zrg4X7F6LzY8SI92ojHdKYJkRROkokhK21P
         lU8KkgaY5Vfd+tbtnqunr/3qTlNA/p4HV0c3blSv9uy+FSr8ojpVnUrTlyTr7hbIqcKU
         DUCw==
X-Gm-Message-State: AOAM531NPyTbZSDDWqbufzA43gMY1FQZp5MvTSWsRceCx9Vy6oxw9K7c
        zsyyOprq9m4z4kO9lw5TkDwzvw==
X-Google-Smtp-Source: ABdhPJyqIqvdIITABaqhCFCT4u+RjtdItZIopohvDn/w+G/Qri7dsna/47US192pjp+Uv8cCJHknPA==
X-Received: by 2002:a05:6000:1006:: with SMTP id a6mr11083820wrx.332.1592986787435;
        Wed, 24 Jun 2020 01:19:47 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id o15sm26156699wrv.48.2020.06.24.01.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 01:19:46 -0700 (PDT)
Subject: Re: [PATCH net-next] bridge: mrp: Extend MRP netlink interface with
 IFLA_BRIDGE_MRP_CLEAR
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bridge@lists.linux-foundation.org
References: <20200624080537.3154332-1-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <84c1e063-f49b-ee5a-c5ed-ab6ba5346991@cumulusnetworks.com>
Date:   Wed, 24 Jun 2020 11:19:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624080537.3154332-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2020 11:05, Horatiu Vultur wrote:
> In case the userspace daemon dies, then when is restarted it doesn't
> know if there are any MRP instances in the kernel. Therefore extend the
> netlink interface to allow the daemon to clear all MRP instances when is
> started.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/uapi/linux/if_bridge.h |  8 ++++++++
>  net/bridge/br_mrp.c            | 15 +++++++++++++++
>  net/bridge/br_mrp_netlink.c    | 26 ++++++++++++++++++++++++++
>  net/bridge/br_private_mrp.h    |  1 +
>  4 files changed, 50 insertions(+)
> 
> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index caa6914a3e53a..2ae7d0c0d46b8 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -166,6 +166,7 @@ enum {
>  	IFLA_BRIDGE_MRP_RING_STATE,
>  	IFLA_BRIDGE_MRP_RING_ROLE,
>  	IFLA_BRIDGE_MRP_START_TEST,
> +	IFLA_BRIDGE_MRP_CLEAR,
>  	__IFLA_BRIDGE_MRP_MAX,
>  };
>  
> @@ -228,6 +229,13 @@ enum {
>  
>  #define IFLA_BRIDGE_MRP_START_TEST_MAX (__IFLA_BRIDGE_MRP_START_TEST_MAX - 1)
>  
> +enum {
> +	IFLA_BRIDGE_MRP_CLEAR_UNSPEC,
> +	__IFLA_BRIDGE_MRP_CLEAR_MAX,
> +};

Out of curiousity - do you plan to have any clean attributes?
In case you don't this can simply be a flag that clears the MRP instances instead
of a nested attribute.

> +
> +#define IFLA_BRIDGE_MRP_CLEAR_MAX (__IFLA_BRIDGE_MRP_CLEAR_MAX - 1)
> +
>  struct br_mrp_instance {
>  	__u32 ring_id;
>  	__u32 p_ifindex;
> diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
> index 24986ec7d38cc..02d102edaaaad 100644
> --- a/net/bridge/br_mrp.c
> +++ b/net/bridge/br_mrp.c
> @@ -372,6 +372,21 @@ int br_mrp_del(struct net_bridge *br, struct br_mrp_instance *instance)
>  	return 0;
>  }
>  
> +/* Deletes all MRP instances on the bridge
> + * note: called under rtnl_lock
> + */
> +int br_mrp_clear(struct net_bridge *br)
> +{
> +	struct br_mrp *mrp;
> +
> +	list_for_each_entry_rcu(mrp, &br->mrp_list, list,
> +				lockdep_rtnl_is_held()) {
> +		br_mrp_del_impl(br, mrp);

I don't think you're in RCU-protected region here, as the lockdep above confirms, which
means br_mrp_del_impl() can free mrp and you can access freed memory while walking the list
(trying to access of the next element).

You should be using list_for_each_entry_safe() to delete elements while walking the list.

Cheers,
 Nik

> +	}
> +
> +	return 0;
> +}
> +
>  /* Set port state, port state can be forwarding, blocked or disabled
>   * note: already called with rtnl_lock
>   */
> diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
> index 34b3a8776991f..5e743538464f6 100644
> --- a/net/bridge/br_mrp_netlink.c
> +++ b/net/bridge/br_mrp_netlink.c
> @@ -14,6 +14,7 @@ static const struct nla_policy br_mrp_policy[IFLA_BRIDGE_MRP_MAX + 1] = {
>  	[IFLA_BRIDGE_MRP_RING_STATE]	= { .type = NLA_NESTED },
>  	[IFLA_BRIDGE_MRP_RING_ROLE]	= { .type = NLA_NESTED },
>  	[IFLA_BRIDGE_MRP_START_TEST]	= { .type = NLA_NESTED },
> +	[IFLA_BRIDGE_MRP_CLEAR]		= { .type = NLA_NESTED },
>  };
>  
>  static const struct nla_policy
> @@ -235,6 +236,25 @@ static int br_mrp_start_test_parse(struct net_bridge *br, struct nlattr *attr,
>  	return br_mrp_start_test(br, &test);
>  }
>  
> +static const struct nla_policy
> +br_mrp_clear_policy[IFLA_BRIDGE_MRP_CLEAR_MAX + 1] = {
> +	[IFLA_BRIDGE_MRP_CLEAR_UNSPEC]		= { .type = NLA_REJECT },
> +};
> +
> +static int br_mrp_clear_parse(struct net_bridge *br, struct nlattr *attr,
> +			      struct netlink_ext_ack *extack)
> +{
> +	struct nlattr *tb[IFLA_BRIDGE_MRP_START_TEST_MAX + 1];
> +	int err;
> +
> +	err = nla_parse_nested(tb, IFLA_BRIDGE_MRP_CLEAR_MAX, attr,
> +			       br_mrp_clear_policy, extack);
> +	if (err)
> +		return err;
> +
> +	return br_mrp_clear(br);
> +}
> +
>  int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
>  		 struct nlattr *attr, int cmd, struct netlink_ext_ack *extack)
>  {
> @@ -301,6 +321,12 @@ int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
>  			return err;
>  	}
>  
> +	if (tb[IFLA_BRIDGE_MRP_CLEAR]) {
> +		err = br_mrp_clear_parse(br, tb[IFLA_BRIDGE_MRP_CLEAR], extack);
> +		if (err)
> +			return err;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/net/bridge/br_private_mrp.h b/net/bridge/br_private_mrp.h
> index 33b255e38ffec..25c3b8596c25b 100644
> --- a/net/bridge/br_private_mrp.h
> +++ b/net/bridge/br_private_mrp.h
> @@ -36,6 +36,7 @@ struct br_mrp {
>  /* br_mrp.c */
>  int br_mrp_add(struct net_bridge *br, struct br_mrp_instance *instance);
>  int br_mrp_del(struct net_bridge *br, struct br_mrp_instance *instance);
> +int br_mrp_clear(struct net_bridge *br);
>  int br_mrp_set_port_state(struct net_bridge_port *p,
>  			  enum br_mrp_port_state_type state);
>  int br_mrp_set_port_role(struct net_bridge_port *p,
> 

