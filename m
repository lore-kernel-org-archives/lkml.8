Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994A6C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F43B21569
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="Sr+iKy2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgDXNUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgDXNUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:20:40 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A6CC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:20:40 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l11so7659287lfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=E4cbnT6iD9NKF/pSlrfjp2r6UpANFg0iv/kYrzOZLes=;
        b=Sr+iKy2By/lSo0Y94e7vCAmXPlw3o+frOpginSSqvNVDZKz+8JKWDI9IEMVKNbDKin
         sURo8CzDQuMEUkRmGLUfCdMh3p8Feax72WCiViNKCpYXaXN6nP/Q8a/3i5Z03Dn5R5kO
         JQyEN1R+eU3eC5UtW4Hy4qrr2u7VxIL7zpjkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E4cbnT6iD9NKF/pSlrfjp2r6UpANFg0iv/kYrzOZLes=;
        b=JjJBsQ4EnS7ajJC7gENALvO+HybQ/3lFIeNCXvuAlE0BxmajTijpCQRzDA9iJ9MkoD
         NIwVrXWGZVJ/RblsKOI/U2Cg6NZaZgCmRryMTBHeq+Lqg8zj7PUy7xaN2VDbQDvUlqs9
         srbrW+pBePEHrfH6O3fKen3U3W1PKIFEDMEfJKju2kC7yU6dR99sVX1cpEXrZI9N47Jb
         hk3uybU12IQVKz3GnSMAhouh9stSr1kdnu4F8vojTmWr1G0QOHE93xO76Z0AcEed5osl
         sqmuX7vlU9w82oUWX1U8DObMswXM1NGgJrAk+wuYRgK383JqXchu4ZOJvTFeSoD4TBQb
         4npA==
X-Gm-Message-State: AGi0PuY/BSfPJGtaghDwn9LCHdkl7jIp2T2pm+VsEYqk0N/KWTMOYhzT
        0ureu+Ag1Do3HTMOxJT7KQbONw==
X-Google-Smtp-Source: APiQypLyLg/ZbS3zAM8LTd2glrbQ22nI6vwPlWMi53bTGZhDnFMOfArtlnmfUo3xGPQOc4KgZzVnGQ==
X-Received: by 2002:a19:230c:: with SMTP id j12mr6327801lfj.109.1587734438545;
        Fri, 24 Apr 2020 06:20:38 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id j22sm4120697ljh.107.2020.04.24.06.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 06:20:37 -0700 (PDT)
Subject: Re: [PATCH net-next v3 11/11] net: bridge: Add checks for enabling
 the STP.
To:     Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net,
        jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org,
        roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20200422161833.1123-1-horatiu.vultur@microchip.com>
 <20200422161833.1123-12-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <2d97fea6-8f24-89ba-a97b-99a12cf41b09@cumulusnetworks.com>
Date:   Fri, 24 Apr 2020 16:20:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422161833.1123-12-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2020 19:18, Horatiu Vultur wrote:
> It is not possible to have the MRP and STP running at the same time on the
> bridge, therefore add check when enabling the STP to check if MRP is already
> enabled. In that case return error.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_ioctl.c    |  3 +--
>  net/bridge/br_netlink.c  |  4 +++-
>  net/bridge/br_private.h  |  3 ++-
>  net/bridge/br_stp.c      |  6 ++++++
>  net/bridge/br_stp_if.c   | 11 ++++++++++-
>  net/bridge/br_sysfs_br.c |  4 +---
>  6 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
> index ae22d784b88a..5e71fc8b826f 100644
> --- a/net/bridge/br_ioctl.c
> +++ b/net/bridge/br_ioctl.c
> @@ -242,8 +242,7 @@ static int old_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
>  		if (!ns_capable(dev_net(dev)->user_ns, CAP_NET_ADMIN))
>  			return -EPERM;
>  
> -		br_stp_set_enabled(br, args[1]);
> -		ret = 0;
> +		ret = br_stp_set_enabled(br, args[1], NULL);
>  		break;
>  
>  	case BRCTL_SET_BRIDGE_PRIORITY:
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 1a5e681a626a..a774e19c41bb 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -1109,7 +1109,9 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
>  	if (data[IFLA_BR_STP_STATE]) {
>  		u32 stp_enabled = nla_get_u32(data[IFLA_BR_STP_STATE]);
>  
> -		br_stp_set_enabled(br, stp_enabled);
> +		err = br_stp_set_enabled(br, stp_enabled, extack);
> +		if (err)
> +			return err;
>  	}
>  
>  	if (data[IFLA_BR_PRIORITY]) {
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 5835828320b6..c35647cb138a 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1283,7 +1283,8 @@ int br_set_ageing_time(struct net_bridge *br, clock_t ageing_time);
>  /* br_stp_if.c */
>  void br_stp_enable_bridge(struct net_bridge *br);
>  void br_stp_disable_bridge(struct net_bridge *br);
> -void br_stp_set_enabled(struct net_bridge *br, unsigned long val);
> +int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
> +		       struct netlink_ext_ack *extack);
>  void br_stp_enable_port(struct net_bridge_port *p);
>  void br_stp_disable_port(struct net_bridge_port *p);
>  bool br_stp_recalculate_bridge_id(struct net_bridge *br);
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
>  	p->state = state;
>  	err = switchdev_port_attr_set(p->dev, &attr);
>  	if (err && err != -EOPNOTSUPP)
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index d174d3a566aa..a42850b7eb9a 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -196,10 +196,17 @@ static void br_stp_stop(struct net_bridge *br)
>  	br->stp_enabled = BR_NO_STP;
>  }
>  
> -void br_stp_set_enabled(struct net_bridge *br, unsigned long val)
> +int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
> +		       struct netlink_ext_ack *extack)
>  {
>  	ASSERT_RTNL();
>  
> +	if (br_mrp_enabled(br)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "STP can't be enabled if MRP is already enabled\n");

The operation could be disable (noop in case it's already disabled) and this will still
return an error.

> +		return -EINVAL;
> +	}
> +
>  	if (val) {
>  		if (br->stp_enabled == BR_NO_STP)
>  			br_stp_start(br);
> @@ -207,6 +214,8 @@ void br_stp_set_enabled(struct net_bridge *br, unsigned long val)
>  		if (br->stp_enabled != BR_NO_STP)
>  			br_stp_stop(br);
>  	}
> +
> +	return 0;
>  }
>  
>  /* called under bridge lock */
> diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
> index 9ab0f00b1081..7db06e3f642a 100644
> --- a/net/bridge/br_sysfs_br.c
> +++ b/net/bridge/br_sysfs_br.c
> @@ -126,9 +126,7 @@ static ssize_t stp_state_show(struct device *d,
>  
>  static int set_stp_state(struct net_bridge *br, unsigned long val)
>  {
> -	br_stp_set_enabled(br, val);
> -
> -	return 0;
> +	return br_stp_set_enabled(br, val, NULL);
>  }
>  
>  static ssize_t stp_state_store(struct device *d,
> 

