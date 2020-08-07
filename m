Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F71C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA402075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="Kg7pTCam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgHGLZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgHGLZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:25:49 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9D7C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 04:25:48 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x5so1423708wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 04:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=O7paGcOXKXd31brfw25UL/WyioLI5ZPkfZ3OZkjGuA4=;
        b=Kg7pTCam7u8BpMn7OoNqeyGI8I/P6oFR0aJ89fN2fug7i+K+zbadsgZQ4+kJy7NHm5
         PAA3S+C+E+VzX0swEy6cgRbbDFJvIMJnxji6BTjw+S5qJse3ZUYR9CK2slrKapauRYRz
         AzIb+e8HBy0Z5dahpoFE9RrUeXbk/tgXjXa8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O7paGcOXKXd31brfw25UL/WyioLI5ZPkfZ3OZkjGuA4=;
        b=RvkSEauGWYZOh2mIvwk6VOyMiCFJdd1DQtQZeYDkQRji5E3A+9yuhNG5kVi3IyNo+e
         DNjXQy8AJB8EF266h9pwe3Miek3vf33bYpYUMHJDnxnrpmfdnwAKpiRj9d7X5ryl3aRr
         p9D/4kCZd4eiTx1kTmiUi6+6a6iNm0CBX38poIYv3DZ9q709ocY8f7PilummX8rARvol
         12PI+uJahVM3LV+EoimA8fAbFfZMLQ8/ng/qYg8w1uam5mBdP1B+ebbxaHfbVY8Qgsel
         ZTmMZU5lEilc+8WkwIgtpJj09TxA/ypcJU37fyFhWfnqT0UugXAr6szBSqZyfwpbYV3o
         +xng==
X-Gm-Message-State: AOAM532dPtTTvkJ4UYBbgarrqhI8C84DfKN8qNwG4FTDfNYzf/9MieDD
        c0LVUhYBkzTKpUzSy4fABgsd+Q==
X-Google-Smtp-Source: ABdhPJx/09gN6DxT56rfqSkxKvr1/HYW6cD5BABn5RY+0d6hyGIYph16+DvbpTYDshIXPECemJdL6A==
X-Received: by 2002:a7b:cbd0:: with SMTP id n16mr12402671wmi.123.1596799547657;
        Fri, 07 Aug 2020 04:25:47 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id b123sm10147077wme.20.2020.08.07.04.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 04:25:46 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] net: dsa: Add protocol support for 802.1AD when
 adding or deleting vlan for dsa switch port
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
        ivecera@redhat.com
References: <20200807111349.20649-1-hongbo.wang@nxp.com>
 <20200807111349.20649-2-hongbo.wang@nxp.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <1ae01bfb-437b-345d-f000-2c4de103f7b1@cumulusnetworks.com>
Date:   Fri, 7 Aug 2020 14:25:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807111349.20649-2-hongbo.wang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2020 14:13, hongbo.wang@nxp.com wrote:
> From: "hongbo.wang" <hongbo.wang@nxp.com>
> 
> the following command will be supported:
> 
> Set bridge's vlan protocol:
>     ip link set br0 type bridge vlan_protocol 802.1ad
> Add VLAN:
>     ip link add link swp1 name swp1.100 type vlan protocol 802.1ad id 100
> Delete VLAN:
>     ip link del link swp1 name swp1.100
> 
> Signed-off-by: hongbo.wang <hongbo.wang@nxp.com>
> ---
>  include/net/switchdev.h   |  1 +
>  net/bridge/br_switchdev.c | 22 ++++++++++++++++
>  net/dsa/dsa_priv.h        |  4 +--
>  net/dsa/port.c            |  6 +++--
>  net/dsa/slave.c           | 53 ++++++++++++++++++++++++++-------------
>  net/dsa/tag_8021q.c       |  4 +--
>  6 files changed, 66 insertions(+), 24 deletions(-)
> 

Hi,
Please put the bridge changes in a separate patch with proper description.
Reviewers would easily miss these bridge changes. Also I believe net-next
is currently closed and that's where these patches should be targeted (i.e.
have net-next after PATCH in the subject). Few more comments below.

Thanks,
 Nik

> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
> index ff2246914301..7594ea82879f 100644
> --- a/include/net/switchdev.h
> +++ b/include/net/switchdev.h
> @@ -97,6 +97,7 @@ struct switchdev_obj_port_vlan {
>  	u16 flags;
>  	u16 vid_begin;
>  	u16 vid_end;
> +	u16 proto;
>  };
>  
>  #define SWITCHDEV_OBJ_PORT_VLAN(OBJ) \
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 015209bf44aa..bcfa00d6d5eb 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -146,6 +146,26 @@ br_switchdev_fdb_notify(const struct net_bridge_fdb_entry *fdb, int type)
>  	}
>  }
>  
> +static u16 br_switchdev_get_bridge_vlan_proto(struct net_device *dev)

const

> +{
> +	u16 vlan_proto = ETH_P_8021Q;
> +	struct net_device *br = NULL;
> +	struct net_bridge_port *p;
> +
> +	if (netif_is_bridge_master(dev)) {
> +		br = dev;
> +	} else if (netif_is_bridge_port(dev)) {

You can use br_port_get_rtnl_rcu() and just check if p is not NULL.
But in general these helpers are used only on bridge devices, I don't think you
can reach them with a device that's not either a bridge or a port. So you can just
check if it's a bridge master else it's a port.

> +		p = br_port_get_rcu(dev);
> +		if (p && p->br)

No need to check for p->br, it always exists.

> +			br = p->br->dev;
> +	}
> +
> +	if (br)
> +		br_vlan_get_proto(br, &vlan_proto);
> +
> +	return vlan_proto;
> +}
> +
>  int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags,
>  			       struct netlink_ext_ack *extack)
>  {
> @@ -157,6 +177,7 @@ int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags,
>  		.vid_end = vid,
>  	};
>  
> +	v.proto = br_switchdev_get_bridge_vlan_proto(dev);
>  	return switchdev_port_obj_add(dev, &v.obj, extack);
>  }
>  
> @@ -169,5 +190,6 @@ int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid)
>  		.vid_end = vid,
>  	};
>  
> +	v.proto = br_switchdev_get_bridge_vlan_proto(dev);
>  	return switchdev_port_obj_del(dev, &v.obj);
>  }
