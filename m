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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16C4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C12F9224B2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="IKJTtDfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgGNNQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgGNNQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:16:34 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA67C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:16:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so5850421wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=nYoU871Umg8pEf23KuBXa9TezOsCAc9WN1U0Sl9RtIM=;
        b=IKJTtDfzeJQfWdYO3heTD4AUKay2Q9U3WgHKSIs9DMTrGNvvwvNPspmItSSofgH85t
         DeknG4Z2W7z2mUjqPiyM5SdQ4yzp4iuRqD2aT130/Lfl1oBY4MhW/IAltTMHMHlhtD84
         YPNNvDxICENWTM3CaBygQGClu7JAVS22NxZPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nYoU871Umg8pEf23KuBXa9TezOsCAc9WN1U0Sl9RtIM=;
        b=LrJoNT98++myVe+3Q0YPAhI6kUnAZFB0VXbkB5Vj/1/6ICW3mZCpl2KyQHoylODHp/
         oLbaI+1cXBoKdBm928KJsoHzyxH8j8ByF4AGpITgmt0kJy4kCOKh/NU3j/uaDdyuHs1S
         N73ABzOaXbIZr9r9s0AwCtM5ZAdhzW1fyZoI4xtsfHkNLPCjxZhQyd8fbIuDwLGHM/Cb
         bMf8DdW+vXRisVS+hzlyxSsgHFMT4dy5Cj54Wuj0x8eK+h6eXpXjX3ms9Iewj9e9VXE7
         7UYpBjB8CheTUxqe7c4x50DGygKEcqPhKFHCRqYLqGESlYMEF+MNjm6xr4MOheOM24cA
         Nlig==
X-Gm-Message-State: AOAM5320J/zDcHQ+xPV2oAMJm8uyZOsdQ049F52jEcjolHT1CzaYwMI/
        zCFipLMQgl0ZtHDti+TfCh4eFw==
X-Google-Smtp-Source: ABdhPJx2+hIbBipTOTBqyZESIrUYMjNFLrUQaLsYApDK0bO3zAQw1RUetedd+46eFbD8/1i6TrTWQw==
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr4598568wmd.111.1594732592441;
        Tue, 14 Jul 2020 06:16:32 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id f15sm4364597wmj.44.2020.07.14.06.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 06:16:31 -0700 (PDT)
Subject: Re: [PATCH net-next v4 07/12] bridge: switchdev: mrp: Extend MRP API
 for switchdev for MRP Interconnect
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org,
        jiri@resnulli.us, ivecera@redhat.com, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
 <20200714073458.1939574-8-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <f0c67d68-b181-4a79-9d7c-a8810c3bfd70@cumulusnetworks.com>
Date:   Tue, 14 Jul 2020 16:16:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200714073458.1939574-8-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2020 10:34, Horatiu Vultur wrote:
> Implement the MRP API for interconnect switchdev. Similar with the other
> br_mrp_switchdev function, these function will just eventually call the
> switchdev functions: switchdev_port_obj_add/del.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_mrp_switchdev.c | 62 +++++++++++++++++++++++++++++++++++
>  net/bridge/br_private_mrp.h   |  7 ++++
>  2 files changed, 69 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

> diff --git a/net/bridge/br_mrp_switchdev.c b/net/bridge/br_mrp_switchdev.c
> index 0da68a0da4b5a..ed547e03ace17 100644
> --- a/net/bridge/br_mrp_switchdev.c
> +++ b/net/bridge/br_mrp_switchdev.c
> @@ -107,6 +107,68 @@ int br_mrp_switchdev_set_ring_state(struct net_bridge *br,
>  	return 0;
>  }
>  
> +int br_mrp_switchdev_set_in_role(struct net_bridge *br, struct br_mrp *mrp,
> +				 u16 in_id, u32 ring_id,
> +				 enum br_mrp_in_role_type role)
> +{
> +	struct switchdev_obj_in_role_mrp mrp_role = {
> +		.obj.orig_dev = br->dev,
> +		.obj.id = SWITCHDEV_OBJ_ID_IN_ROLE_MRP,
> +		.in_role = role,
> +		.in_id = mrp->in_id,
> +		.ring_id = mrp->ring_id,
> +		.i_port = rtnl_dereference(mrp->i_port)->dev,
> +	};
> +	int err;
> +
> +	if (role == BR_MRP_IN_ROLE_DISABLED)
> +		err = switchdev_port_obj_del(br->dev, &mrp_role.obj);
> +	else
> +		err = switchdev_port_obj_add(br->dev, &mrp_role.obj, NULL);
> +
> +	return err;
> +}
> +
> +int br_mrp_switchdev_set_in_state(struct net_bridge *br, struct br_mrp *mrp,
> +				  enum br_mrp_in_state_type state)
> +{
> +	struct switchdev_obj_in_state_mrp mrp_state = {
> +		.obj.orig_dev = br->dev,
> +		.obj.id = SWITCHDEV_OBJ_ID_IN_STATE_MRP,
> +		.in_state = state,
> +		.in_id = mrp->in_id,
> +	};
> +	int err;
> +
> +	err = switchdev_port_obj_add(br->dev, &mrp_state.obj, NULL);
> +
> +	if (err && err != -EOPNOTSUPP)
> +		return err;
> +
> +	return 0;
> +}
> +
> +int br_mrp_switchdev_send_in_test(struct net_bridge *br, struct br_mrp *mrp,
> +				  u32 interval, u8 max_miss, u32 period)
> +{
> +	struct switchdev_obj_in_test_mrp test = {
> +		.obj.orig_dev = br->dev,
> +		.obj.id = SWITCHDEV_OBJ_ID_IN_TEST_MRP,
> +		.interval = interval,
> +		.max_miss = max_miss,
> +		.in_id = mrp->in_id,
> +		.period = period,
> +	};
> +	int err;
> +
> +	if (interval == 0)
> +		err = switchdev_port_obj_del(br->dev, &test.obj);
> +	else
> +		err = switchdev_port_obj_add(br->dev, &test.obj, NULL);
> +
> +	return err;
> +}
> +
>  int br_mrp_port_switchdev_set_state(struct net_bridge_port *p,
>  				    enum br_mrp_port_state_type state)
>  {
> diff --git a/net/bridge/br_private_mrp.h b/net/bridge/br_private_mrp.h
> index 23da2f956ad0e..0d554ef88db85 100644
> --- a/net/bridge/br_private_mrp.h
> +++ b/net/bridge/br_private_mrp.h
> @@ -72,6 +72,13 @@ int br_mrp_port_switchdev_set_state(struct net_bridge_port *p,
>  				    enum br_mrp_port_state_type state);
>  int br_mrp_port_switchdev_set_role(struct net_bridge_port *p,
>  				   enum br_mrp_port_role_type role);
> +int br_mrp_switchdev_set_in_role(struct net_bridge *br, struct br_mrp *mrp,
> +				 u16 in_id, u32 ring_id,
> +				 enum br_mrp_in_role_type role);
> +int br_mrp_switchdev_set_in_state(struct net_bridge *br, struct br_mrp *mrp,
> +				  enum br_mrp_in_state_type state);
> +int br_mrp_switchdev_send_in_test(struct net_bridge *br, struct br_mrp *mrp,
> +				  u32 interval, u8 max_miss, u32 period);
>  
>  /* br_mrp_netlink.c  */
>  int br_mrp_ring_port_open(struct net_device *dev, u8 loc);
> 

