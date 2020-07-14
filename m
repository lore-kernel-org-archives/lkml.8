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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC013C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C05B422461
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="ZCEEJ384"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgGNNZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgGNNY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:24:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3F6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:24:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z2so21583307wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Aj4QKKJojEodXlG0rvLUNxVoPZ5Fr2yPYro2NiVUoeE=;
        b=ZCEEJ384Iu1DGQxnvlhX72M4mccDWl5ldcoVeiCEHr08wVI+D8Q5hSZH2B9pZ6bUcE
         ue6vH3qGR35NPbHd13201SO7tYLiwSm+t3EwJNAmINb0vvzEh2KSOlIlqNoPF6YXfpW+
         /C17pnz3hPkxbrQ96By5VAGCS0+66sxIVXvyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Aj4QKKJojEodXlG0rvLUNxVoPZ5Fr2yPYro2NiVUoeE=;
        b=pJrf7Oz06AcIoWDHMobc9tt1frXRT7xqMtcMz0ICBdy5QSAQubPEUGKid6jGWB8QMh
         aFzwCQdYVIxNl9lWj9IHaXAbVlQsCTB8H+m+W78XRpUS/J2+C07ZxlfgBsnUq7uJNsEp
         GWM/DPctdBw5pg8vWT4si0Qe+nPnJfixMhezQ02jBhQKy5Sm5j0J6GNEy03d+IqvOvAp
         x9IWNXBhdRsapDOgBh/x812JaBjJSDSufB3s7RLwXRToGDrVAbH1+Kj4f4WAU5M27INb
         CnZ6D1EBqZIaIYNkTmEtoAher6zGjzRpv+4Ucm4/QPxQ9bpUwHxO036AbKj/e6G1lQ2a
         HNNQ==
X-Gm-Message-State: AOAM530wzGCJrvWQWhN6N4XTqP3eE/u05UVowjsRcrZINAHPzgxt0HzC
        nBlweyOCUDzXycyraC8RvLGlzA==
X-Google-Smtp-Source: ABdhPJxfYCnUzieYF2XQSYACq4ky+aYgmc2GjwcyD9wVgHGUQeJ272sYluyQFMzuOSGk8Mo5Hxhlvw==
X-Received: by 2002:a5d:55ca:: with SMTP id i10mr2854011wrw.225.1594733098176;
        Tue, 14 Jul 2020 06:24:58 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id t4sm4598552wmf.4.2020.07.14.06.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 06:24:57 -0700 (PDT)
Subject: Re: [PATCH net-next v4 11/12] bridge: mrp: Extend br_mrp_fill_info
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org,
        jiri@resnulli.us, ivecera@redhat.com, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
 <20200714073458.1939574-12-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <dd1e615d-6390-e521-28d3-98f01308df42@cumulusnetworks.com>
Date:   Tue, 14 Jul 2020 16:24:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200714073458.1939574-12-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2020 10:34, Horatiu Vultur wrote:
> This patch extends the function br_mrp_fill_info to return also the
> status for the interconnect ring.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_mrp_netlink.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
> index a006e0771e8d3..2a2fdf3500c5b 100644
> --- a/net/bridge/br_mrp_netlink.c
> +++ b/net/bridge/br_mrp_netlink.c
> @@ -474,6 +474,11 @@ int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br)
>  				     p->dev->ifindex))
>  			goto nla_put_failure;
>  
> +		p = rcu_dereference(mrp->i_port);
> +		if (p && nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_I_IFINDEX,
> +				     p->dev->ifindex))
> +			goto nla_put_failure;
> +
>  		if (nla_put_u16(skb, IFLA_BRIDGE_MRP_INFO_PRIO,
>  				mrp->prio))
>  			goto nla_put_failure;
> @@ -493,6 +498,19 @@ int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br)
>  				mrp->test_monitor))
>  			goto nla_put_failure;
>  
> +		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_IN_STATE,
> +				mrp->in_state))
> +			goto nla_put_failure;
> +		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_IN_ROLE,
> +				mrp->in_role))
> +			goto nla_put_failure;
> +		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_IN_TEST_INTERVAL,
> +				mrp->in_test_interval))
> +			goto nla_put_failure;
> +		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_IN_TEST_MAX_MISS,
> +				mrp->in_test_max_miss))
> +			goto nla_put_failure;
> +
>  		nla_nest_end(skb, tb);
>  	}
>  	nla_nest_end(skb, mrp_tb);
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
