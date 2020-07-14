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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E760BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C271522203
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="CKze1TiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgGNN3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgGNN3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:29:37 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA062C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:29:36 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 17so5984935wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4HmbsAMObqZGkcA7hG2xxjCG9/cCH7z4XX9t73gu4dA=;
        b=CKze1TiGSjQXnD3dI9mZXRtyO4KfBx8rTKNJ8UMhhZQSrGx+pjmc9KjDpI7Cc0kSq/
         Tal5/+YoT/X7tfFnhfBVNm1c4dJgWaW+ELwMYSS9B3sZrVr4mYAZo+MDrc55iDGVlEiV
         Lye0yBzgrwUHplVBuYa9OjhsyborjclEK4lWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4HmbsAMObqZGkcA7hG2xxjCG9/cCH7z4XX9t73gu4dA=;
        b=lrHp9RwNVzXwJEqw2y6/c2qfalXiWZRTXZCdi3AzZ9KSn/j6opqvs5nxtO7A7ztdSR
         HyJQGntxm1UIatjLjCXqp/GEEksaZlEGtFin5cu4hVzZDmLmjEqq3N3yBFFYCslcqFlx
         /HnQDPAe3s5P2exvDzmeZXKOUHn4/8KHZfpiepUa9BBmt7cHT42hxJ6tRNmWETT4SJiN
         0MPdOrZexbEcd3ZYcfaP9rJ/f+3E6uT2n5a9boltRb4U1Id2OP5zgE3hScUNtQQjz8t5
         1EvAz2SCrgyiejxKxZFRgHs1GY1U9QgSC37CB6Up4irtwyogy8n+UWJ3AVITMQZgus39
         iwSQ==
X-Gm-Message-State: AOAM532s9JrEOFPlZ2T2EwOTMwLH89y9ieLKDrAnHc9M7gfaz64PpzjX
        ZpryoxdHDhKyInw4WORe5eI9P6tWNdbzVA==
X-Google-Smtp-Source: ABdhPJyC02bAxpbjIo7tFHGQ0Kf+FQhiG9QsKidBwYlv/AG9V/WaB0iZJUHiYwwOje61BBdFL0+RGA==
X-Received: by 2002:a1c:e143:: with SMTP id y64mr4514377wmg.90.1594733375511;
        Tue, 14 Jul 2020 06:29:35 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id t16sm30280468wru.9.2020.07.14.06.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 06:29:34 -0700 (PDT)
Subject: Re: [PATCH net-next v4 12/12] net: bridge: Add port attribute
 IFLA_BRPORT_MRP_IN_OPEN
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org,
        jiri@resnulli.us, ivecera@redhat.com, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
 <20200714073458.1939574-13-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <9eeb89c5-865f-2b21-c7c6-7f4479bf4175@cumulusnetworks.com>
Date:   Tue, 14 Jul 2020 16:29:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200714073458.1939574-13-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2020 10:34, Horatiu Vultur wrote:
> This patch adds a new port attribute, IFLA_BRPORT_MRP_IN_OPEN, which
> allows to notify the userspace when the node lost the contiuity of
> MRP_InTest frames.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/uapi/linux/if_link.h       | 1 +
>  net/bridge/br_netlink.c            | 3 +++
>  tools/include/uapi/linux/if_link.h | 1 +
>  3 files changed, 5 insertions(+)
> 

It's kind of late by now, but I'd wish these were contained in a nested MRP attribute. :)
Horatiu, do you expect to have many more MRP attributes outside of MRP netlink code?

Perhaps we should at least dump them only for MRP-aware ports, that should be easy.
They make no sense outside of MRP anyway, but increase the size of the dump for all
right now.

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index cc185a007ade8..26842ffd0501d 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -344,6 +344,7 @@ enum {
>  	IFLA_BRPORT_ISOLATED,
>  	IFLA_BRPORT_BACKUP_PORT,
>  	IFLA_BRPORT_MRP_RING_OPEN,
> +	IFLA_BRPORT_MRP_IN_OPEN,
>  	__IFLA_BRPORT_MAX
>  };
>  #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index c532fa65c9834..147d52596e174 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -152,6 +152,7 @@ static inline size_t br_port_info_size(void)
>  #endif
>  		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_GROUP_FWD_MASK */
>  		+ nla_total_size(sizeof(u8))	/* IFLA_BRPORT_MRP_RING_OPEN */
> +		+ nla_total_size(sizeof(u8))	/* IFLA_BRPORT_MRP_IN_OPEN */
>  		+ 0;
>  }
>  
> @@ -216,6 +217,8 @@ static int br_port_fill_attrs(struct sk_buff *skb,
>  		       !!(p->flags & BR_NEIGH_SUPPRESS)) ||
>  	    nla_put_u8(skb, IFLA_BRPORT_MRP_RING_OPEN, !!(p->flags &
>  							  BR_MRP_LOST_CONT)) ||
> +	    nla_put_u8(skb, IFLA_BRPORT_MRP_IN_OPEN,
> +		       !!(p->flags & BR_MRP_LOST_IN_CONT)) ||
>  	    nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(p->flags & BR_ISOLATED)))
>  		return -EMSGSIZE;
>  
> diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
> index cafedbbfefbe9..781e482dc499f 100644
> --- a/tools/include/uapi/linux/if_link.h
> +++ b/tools/include/uapi/linux/if_link.h
> @@ -344,6 +344,7 @@ enum {
>  	IFLA_BRPORT_ISOLATED,
>  	IFLA_BRPORT_BACKUP_PORT,
>  	IFLA_BRPORT_MRP_RING_OPEN,
> +	IFLA_BRPORT_MRP_IN_OPEN,
>  	__IFLA_BRPORT_MAX
>  };
>  #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
> 

