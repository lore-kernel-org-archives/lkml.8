Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0481BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB43720771
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="V6Kamdd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgGBKFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgGBKFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 06:05:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D092C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 03:05:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so26076888wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 03:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=z6rgXj0NTD9PDpQjHsG/IEK9XchmNS0510zhoY6+bRM=;
        b=V6Kamdd1OVWbDdE4nkgJT9LoSC8s7cK+++UHAukTcyCFI+MUhWZ3kQMfEHurLmC3VX
         auY7IxlsQm/sVxo6SSZTvWfeWUs4PnVhl5bVVJFk8GOKjTd8kbPCgrKY9dcrq3UHxwEN
         QxpNaeFbsGDE8QHON37JeMiK5JmBh7K8+j3+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z6rgXj0NTD9PDpQjHsG/IEK9XchmNS0510zhoY6+bRM=;
        b=GERIFBr7HybTia2OvUE0ruKwaIdU+zd4vE4ZcxI5x574MMCTZrGqW7f0BAXCvIcK+P
         Jo1ywR6MNyAZW33+OZj8Pq37thrbjeFgEz/YO3KcfSTaWun75sPJZ1xNxDi38NEjYfQP
         JtuwIZG2BN2pnBrDoKuDw0UYRuKCYsc1hkRDN1yILtJUzGaEsA+MhOTthn6mPt2LyZ6y
         8PD0/Kghaay2nK8zUTmuVzhI+9IZzxTyQYt6+dDsLvPppDgsMckpKRAtPS7J9zoi3X5E
         ZMcie5A+BrgP/SZd/9a7v1H/rJTPGM6qi387aiGmofZ9zzIsS69JNx0XPv2/pqRkG+Q4
         B7Og==
X-Gm-Message-State: AOAM530GYVNbtyM2HLj9lP7alrgAG1IelW+1YG3EA9cp2ClY7d/z412P
        QcIMgnl+St2GZkqiCYPQUOc6iA==
X-Google-Smtp-Source: ABdhPJwSjMqSScQHghRqZI31MUtUpODKi6xYVBUN+0ghQAtB/dtczJkORmCsn4rW41/+AX6Mj89EqA==
X-Received: by 2002:a1c:4303:: with SMTP id q3mr32097134wma.134.1593684303419;
        Thu, 02 Jul 2020 03:05:03 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id x185sm10508303wmg.41.2020.07.02.03.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 03:05:02 -0700 (PDT)
Subject: Re: [PATCH net-next v3 3/3] bridge: Extend br_fill_ifinfo to return
 MPR status
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org,
        jiri@mellanox.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org,
        UNGLinuxDriver@microchip.com
References: <20200702081307.933471-1-horatiu.vultur@microchip.com>
 <20200702081307.933471-4-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <5c94fb61-a85d-e28f-01b4-52e2e4e0892e@cumulusnetworks.com>
Date:   Thu, 2 Jul 2020 13:05:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702081307.933471-4-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2020 11:13, Horatiu Vultur wrote:
> This patch extends the function br_fill_ifinfo to return also the MRP
> status for each instance on a bridge. It also adds a new filter
> RTEXT_FILTER_MRP to return the MRP status only when this is set, not to
> interfer with the vlans. The MRP status is return only on the bridge
> interfaces.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/uapi/linux/rtnetlink.h |  1 +
>  net/bridge/br_netlink.c        | 25 ++++++++++++++++++++++++-
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

> diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
> index 879e64950a0a2..9b814c92de123 100644
> --- a/include/uapi/linux/rtnetlink.h
> +++ b/include/uapi/linux/rtnetlink.h
> @@ -778,6 +778,7 @@ enum {
>  #define RTEXT_FILTER_BRVLAN	(1 << 1)
>  #define RTEXT_FILTER_BRVLAN_COMPRESSED	(1 << 2)
>  #define	RTEXT_FILTER_SKIP_STATS	(1 << 3)
> +#define RTEXT_FILTER_MRP	(1 << 4)
>  
>  /* End of information exported to user level */
>  
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 240e260e3461c..c532fa65c9834 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -453,6 +453,28 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>  		rcu_read_unlock();
>  		if (err)
>  			goto nla_put_failure;
> +
> +		nla_nest_end(skb, af);
> +	}
> +
> +	if (filter_mask & RTEXT_FILTER_MRP) {
> +		struct nlattr *af;
> +		int err;
> +
> +		if (!br_mrp_enabled(br) || port)
> +			goto done;
> +
> +		af = nla_nest_start_noflag(skb, IFLA_AF_SPEC);
> +		if (!af)
> +			goto nla_put_failure;
> +
> +		rcu_read_lock();
> +		err = br_mrp_fill_info(skb, br);
> +		rcu_read_unlock();
> +
> +		if (err)
> +			goto nla_put_failure;
> +
>  		nla_nest_end(skb, af);
>  	}
>  
> @@ -516,7 +538,8 @@ int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>  	struct net_bridge_port *port = br_port_get_rtnl(dev);
>  
>  	if (!port && !(filter_mask & RTEXT_FILTER_BRVLAN) &&
> -	    !(filter_mask & RTEXT_FILTER_BRVLAN_COMPRESSED))
> +	    !(filter_mask & RTEXT_FILTER_BRVLAN_COMPRESSED) &&
> +	    !(filter_mask & RTEXT_FILTER_MRP))
>  		return 0;
>  
>  	return br_fill_ifinfo(skb, port, pid, seq, RTM_NEWLINK, nlflags,
> 

