Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6512AC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44ED22065F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="dqdxmTZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgGTKos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 06:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbgGTKoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 06:44:46 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAF4C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:44:45 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id 88so7060253wrh.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wG7K0uq8mpLNpl6r6yyIK1jp2dXYWitOo/oUfoeSlAo=;
        b=dqdxmTZ6+gN++MK7rDSC7D5QKx04y3ZsSX2bGExyrfDLLkwc3HAre+/5CJjXb8DRCG
         L1b+S+GhVUwfYW/t1Y7dqnLxaAe75m8yZlBo+767cn+ilAhdFEu5ix23YEbE+8xiRUl/
         kbTW8xI6L8oQb24MX72zy2OlV4vKU/QhRL/Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wG7K0uq8mpLNpl6r6yyIK1jp2dXYWitOo/oUfoeSlAo=;
        b=gIeRgwb2jLksHzt4ekyHK5UOARJ04TLlGrgrUg8Kd4Px5xGEDOEKCeAM2OJDXFzkFI
         XedaTIWaoNeTmMaH4HG+U92mfs7pVBbGpiLF2opAIUqtYVB7gN5411XbPne0fROWq92E
         mT10P5eBbq16Ua4WdTN/56kES5xXDhrMov7NHe8k9l6MxPcAverb46jFTbkV3NoN3LzW
         A/GfGdPi5uTLVPg/NqGUujIGoGs+guMdKAD3iE7qb+8+rlEEQ0cnIjz3G1AJGH9tb/Ij
         8jRyEApCXDsSMdGC2HhrJ3f+SJOBCdIiiknQ2+T0uPs+ZZnszaSsNEnmp95QqG9nskRE
         uIpw==
X-Gm-Message-State: AOAM5322QXS/6NFB1cppp2cnrQ2GMOc0h8spzURv+YZvgUmLNfSsCBg8
        fDZUxvebQmGyTdg6/N9hPA6hYw==
X-Google-Smtp-Source: ABdhPJycW9SMvCj+IwJIi5ruNoHI7H4Hqf0HBuMTqROBaRA08TgGoNei9d52jp9Pa0Kxd2bDH0z0qQ==
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr21330200wrs.384.1595241884483;
        Mon, 20 Jul 2020 03:44:44 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id x7sm31909992wrr.72.2020.07.20.03.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 03:44:43 -0700 (PDT)
Subject: Re: [PATCH 1/2] net: dsa: Add flag for 802.1AD when adding VLAN for
 dsa switch and port
To:     hongbo.wang@nxp.com, xiaoliang.yang_1@nxp.com,
        allan.nielsen@microchip.com, po.liu@nxp.com,
        claudiu.manoil@nxp.com, alexandru.marginean@nxp.com,
        vladimir.oltean@nxp.com, leoyang.li@nxp.com, mingkai.hu@nxp.com,
        andrew@lunn.ch, f.fainelli@gmail.com, vivien.didelot@gmail.com,
        davem@davemloft.net, jiri@resnulli.us, idosch@idosch.org,
        kuba@kernel.org, vinicius.gomes@intel.com,
        roopa@cumulusnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, horatiu.vultur@microchip.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        linux-devel@linux.nxdi.nxp.com
References: <20200720104119.19146-1-hongbo.wang@nxp.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <05b06d46-d705-7d06-b4dd-2bee90f75168@cumulusnetworks.com>
Date:   Mon, 20 Jul 2020 13:44:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200720104119.19146-1-hongbo.wang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2020 13:41, hongbo.wang@nxp.com wrote:
> From: "hongbo.wang" <hongbo.wang@nxp.com>
> 
> the following command can be supported:
> ip link add link swp1 name swp1.100 type vlan protocol 802.1ad id 100
> 
> Signed-off-by: hongbo.wang <hongbo.wang@nxp.com>
> ---
>  include/uapi/linux/if_bridge.h | 1 +
>  net/dsa/slave.c                | 9 +++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 

This is not bridge related at all, please leave its flags out of it.

Nacked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>



> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index caa6914a3e53..ecd960aa65c7 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -132,6 +132,7 @@ enum {
>  #define BRIDGE_VLAN_INFO_RANGE_END	(1<<4) /* VLAN is end of vlan range */
>  #define BRIDGE_VLAN_INFO_BRENTRY	(1<<5) /* Global bridge VLAN entry */
>  #define BRIDGE_VLAN_INFO_ONLY_OPTS	(1<<6) /* Skip create/delete/flags */
> +#define BRIDGE_VLAN_INFO_8021AD	(1<<7) /* VLAN is 802.1AD protocol */
>  
>  struct bridge_vlan_info {
>  	__u16 flags;
> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
> index 4c7f086a047b..376d7ac5f1e5 100644
> --- a/net/dsa/slave.c
> +++ b/net/dsa/slave.c
> @@ -1232,6 +1232,7 @@ static int dsa_slave_get_ts_info(struct net_device *dev,
>  static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
>  				     u16 vid)
>  {
> +	u16 flags = 0;
>  	struct dsa_port *dp = dsa_slave_to_port(dev);
>  	struct bridge_vlan_info info;
>  	int ret;
> @@ -1252,7 +1253,10 @@ static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
>  			return -EBUSY;
>  	}
>  
> -	ret = dsa_port_vid_add(dp, vid, 0);
> +	if (ntohs(proto) == ETH_P_8021AD)
> +		flags |= BRIDGE_VLAN_INFO_8021AD;
> +
> +	ret = dsa_port_vid_add(dp, vid, flags);
>  	if (ret)
>  		return ret;
>  
> @@ -1744,7 +1748,8 @@ int dsa_slave_create(struct dsa_port *port)
>  
>  	slave_dev->features = master->vlan_features | NETIF_F_HW_TC;
>  	if (ds->ops->port_vlan_add && ds->ops->port_vlan_del)
> -		slave_dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
> +		slave_dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER |
> +				       NETIF_F_HW_VLAN_STAG_FILTER;
>  	slave_dev->hw_features |= NETIF_F_HW_TC;
>  	slave_dev->features |= NETIF_F_LLTX;
>  	slave_dev->ethtool_ops = &dsa_slave_ethtool_ops;
> 

