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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE776C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA65F224B1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="TqSa14w7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgGNNPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgGNNPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:15:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1731DC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:15:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so21519987wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FxJqrHhg0G0ncHUrHEuIRffmrZYQGuHLCnGks1j1bQM=;
        b=TqSa14w7dWnNYezldSLiuWoHhgo2zcjASexkPXEh+2iGpB2nAcR54Vdz6cuj8Oz9B0
         atzp+jjuGO56jmDKvCcRCNrZPIRHALoy+bV3oqGvUCCyB/SO9HPvF1qSUL8iyjwiM2ZN
         r950qHEUsa//TUKVU5SBVVDe1V/hqHRyghU+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FxJqrHhg0G0ncHUrHEuIRffmrZYQGuHLCnGks1j1bQM=;
        b=Squvk3Lzk1mPHeG7NaRTqO7+qOnfo0CYWx8qW6s6gS/fSz/1MYVEt3Kgt1YzEZwnQS
         d0MVgsWlV2FxyuRpOsnmaJxLCT/e8XM1P9Zp4A3S9W+e8M2l/tJ5zjVbXUEccjjiHus/
         xp2wYDPL21IAHLCLx8i1qiFuDn2kr60YlHEOHvwA1WLuQsq46iM1OnxDV5u5eSM42NJO
         fsUcHaUHafQx808s4KaHnTealbw9ITtsGUhj+JZP4mD9dXlnPu6VCbh2Jw9EMDst/qEW
         7q1TmtFKfjKgSi4Ma5YHPlZU1578zfPf4RwKORp5zh5VpQpPPkIPD78SF+CDpj4QvxP6
         VYkQ==
X-Gm-Message-State: AOAM531KCCWNsk72F469zDe6dmnJwRhwBYsjpY1lccXEin4719ucZH+j
        YTmvg6gwC/IGZ9K+w1PzMEdvRQ==
X-Google-Smtp-Source: ABdhPJxAejX7e0cIDmVXbcaejKJR9o77DDTzyzXJOg3PPlA6j89HyUpCZ2ISzb4W6Wh0uyKIKLY8xw==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr5291848wrv.162.1594732548828;
        Tue, 14 Jul 2020 06:15:48 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id e17sm27788229wrr.88.2020.07.14.06.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 06:15:48 -0700 (PDT)
Subject: Re: [PATCH net-next v4 05/12] bridge: mrp: Rename br_mrp_port_open to
 br_mrp_ring_port_open
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org,
        jiri@resnulli.us, ivecera@redhat.com, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
 <20200714073458.1939574-6-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <622d77e3-6ea0-9a5e-2745-4231dd40b1e8@cumulusnetworks.com>
Date:   Tue, 14 Jul 2020 16:15:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200714073458.1939574-6-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2020 10:34, Horatiu Vultur wrote:
> This patch renames the function br_mrp_port_open to
> br_mrp_ring_port_open. In this way is more clear that a ring port lost
> the continuity because there will be also a br_mrp_in_port_open.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_mrp.c         | 6 +++---
>  net/bridge/br_mrp_netlink.c | 2 +-
>  net/bridge/br_private_mrp.h | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

> diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
> index 90592af9db619..fe7cf1446b58a 100644
> --- a/net/bridge/br_mrp.c
> +++ b/net/bridge/br_mrp.c
> @@ -213,7 +213,7 @@ static void br_mrp_test_work_expired(struct work_struct *work)
>  		}
>  
>  		if (notify_open && !mrp->ring_role_offloaded)
> -			br_mrp_port_open(p->dev, true);
> +			br_mrp_ring_port_open(p->dev, true);
>  	}
>  
>  	p = rcu_dereference(mrp->s_port);
> @@ -229,7 +229,7 @@ static void br_mrp_test_work_expired(struct work_struct *work)
>  		}
>  
>  		if (notify_open && !mrp->ring_role_offloaded)
> -			br_mrp_port_open(p->dev, true);
> +			br_mrp_ring_port_open(p->dev, true);
>  	}
>  
>  out:
> @@ -537,7 +537,7 @@ static void br_mrp_mrm_process(struct br_mrp *mrp, struct net_bridge_port *port,
>  	 * not closed
>  	 */
>  	if (mrp->ring_state != BR_MRP_RING_STATE_CLOSED)
> -		br_mrp_port_open(port->dev, false);
> +		br_mrp_ring_port_open(port->dev, false);
>  }
>  
>  /* Determin if the test hdr has a better priority than the node */
> diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
> index c4f5c356811f3..acce300c0cc29 100644
> --- a/net/bridge/br_mrp_netlink.c
> +++ b/net/bridge/br_mrp_netlink.c
> @@ -368,7 +368,7 @@ int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br)
>  	return -EMSGSIZE;
>  }
>  
> -int br_mrp_port_open(struct net_device *dev, u8 loc)
> +int br_mrp_ring_port_open(struct net_device *dev, u8 loc)
>  {
>  	struct net_bridge_port *p;
>  	int err = 0;
> diff --git a/net/bridge/br_private_mrp.h b/net/bridge/br_private_mrp.h
> index 8841ba847fb29..e93c8f9d4df58 100644
> --- a/net/bridge/br_private_mrp.h
> +++ b/net/bridge/br_private_mrp.h
> @@ -74,6 +74,6 @@ int br_mrp_port_switchdev_set_role(struct net_bridge_port *p,
>  				   enum br_mrp_port_role_type role);
>  
>  /* br_mrp_netlink.c  */
> -int br_mrp_port_open(struct net_device *dev, u8 loc);
> +int br_mrp_ring_port_open(struct net_device *dev, u8 loc);
>  
>  #endif /* _BR_PRIVATE_MRP_H */
> 

