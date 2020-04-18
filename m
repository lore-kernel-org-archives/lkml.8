Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9545C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEF121D82
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="XqypijR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgDRIez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 04:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgDRIez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 04:34:55 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A951AC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 01:34:54 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r7so4424120ljg.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 01:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rKlkAwEDDsynKv4RM2bKW1a9OH88bYR0wDlJNA1on3M=;
        b=XqypijR11dFElYci8Imnq9hOK5eVL8pkjyocsAsFD4823+/y5Q+kujZtiIXwF3r+1Q
         uToJmxgH/cIQvXeuLKj38dKdskYq7kiAyCP/fUMZVl0i/O+tA9zM6u3t9gVuPW305Ydh
         QHTQriUUNdSDXKj3F3qtvm+KqUb/eZT2xBoYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rKlkAwEDDsynKv4RM2bKW1a9OH88bYR0wDlJNA1on3M=;
        b=MRW7uBgp11ONbNgEYuyiQp/AXYVfc9OXVAZONrJSvP2fN9tTnyilQ4Eh6XnOnV0mlw
         o97V+gmpmg0nHqWrPRq9zSuyxueGwSxaJjS0cem3pIFA7SBTLr0vMdTTgVVZHxbrvelq
         y+TQ+QvHN9VSK0MQXZfMHhcVl4ZtGtPXH0L2Db9bUKarbuO1RuwAv0IDUaIEXBHiz5Jz
         W31eTbFedzYAY6xQk7MZC6rCNTYpTDXTHFltR65+AaJto5uMIxdOb1XjizQrEnE9K117
         hMCdpuo7Uwe/YXzLFdkJSlSWwivazeF/FNZr1zrWuM+PIo/mXOApvxwdacnd+CML4bqu
         zChQ==
X-Gm-Message-State: AGi0PubmO8shj3ebA8c5yegPM6xi3zWbr9RWxJVjxmdifOt/XbE70IsI
        sS5XoZq7ryCs5hDX5k4PS5RT06+mAfxv2yMo
X-Google-Smtp-Source: APiQypJwNzp0nSRSK9V+z8J2GRFJk/USlO0VNTHF7J1g55asC7kGmrlgb1dstBv5cd7qUljLyuurQQ==
X-Received: by 2002:a2e:992:: with SMTP id 140mr4312957ljj.188.1587198892989;
        Sat, 18 Apr 2020 01:34:52 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id 64sm18009876ljj.41.2020.04.18.01.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 01:34:52 -0700 (PDT)
Subject: Re: [RFC net-next v5 8/9] bridge: mrp: Implement netlink interface to
 configure MRP
To:     Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net,
        jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org,
        roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com
References: <20200414112618.3644-1-horatiu.vultur@microchip.com>
 <20200414112618.3644-9-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <c6666b49-a00f-2edf-8cb6-8d649a2eaedb@cumulusnetworks.com>
Date:   Sat, 18 Apr 2020 11:34:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414112618.3644-9-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2020 14:26, Horatiu Vultur wrote:
> Implement netlink interface to configure MRP. The implementation
> will do sanity checks over the attributes and then eventually call the MRP
> interface.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_mrp_netlink.c | 164 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 net/bridge/br_mrp_netlink.c
> 
> diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
> new file mode 100644
> index 000000000000..0d8253311595
> --- /dev/null
> +++ b/net/bridge/br_mrp_netlink.c
> @@ -0,0 +1,164 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <net/genetlink.h>
> +
> +#include <uapi/linux/mrp_bridge.h>
> +#include "br_private.h"
> +#include "br_private_mrp.h"
> +
> +static const struct nla_policy br_mrp_policy[IFLA_BRIDGE_MRP_MAX + 1] = {
> +	[IFLA_BRIDGE_MRP_UNSPEC]	= { .type = NLA_REJECT },
> +	[IFLA_BRIDGE_MRP_INSTANCE]	= { .type = NLA_EXACT_LEN,
> +					    .len = sizeof(struct br_mrp_instance)},
> +	[IFLA_BRIDGE_MRP_PORT_STATE]	= { .type = NLA_U32 },
> +	[IFLA_BRIDGE_MRP_PORT_ROLE]	= { .type = NLA_EXACT_LEN,
> +					    .len = sizeof(struct br_mrp_port_role)},
> +	[IFLA_BRIDGE_MRP_RING_STATE]	= { .type = NLA_EXACT_LEN,
> +					    .len = sizeof(struct br_mrp_ring_state)},
> +	[IFLA_BRIDGE_MRP_RING_ROLE]	= { .type = NLA_EXACT_LEN,
> +					    .len = sizeof(struct br_mrp_ring_role)},
> +	[IFLA_BRIDGE_MRP_START_TEST]	= { .type = NLA_EXACT_LEN,
> +					    .len = sizeof(struct br_mrp_start_test)},
> +};
> +
> +int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
> +		 struct nlattr *attr, int cmd, struct netlink_ext_ack *extack)
> +{
> +	struct nlattr *tb[IFLA_BRIDGE_MRP_MAX + 1];
> +	int err;
> +
> +	if (br->stp_enabled != BR_NO_STP) {
> +		br_warn(br, "MRP can't be enabled if STP is already enabled\n");
> +		return -EINVAL;
> +	}
> +
> +	err = nla_parse_nested(tb, IFLA_BRIDGE_MRP_MAX, attr,
> +			       NULL, extack);
> +	if (err)
> +		return err;
> +
> +	if (tb[IFLA_BRIDGE_MRP_INSTANCE]) {
> +		struct br_mrp_instance *instance =
> +			nla_data(tb[IFLA_BRIDGE_MRP_INSTANCE]);
> +
> +		if (cmd == RTM_SETLINK)
> +			err = br_mrp_add(br, instance);
> +		else
> +			err = br_mrp_del(br, instance);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (tb[IFLA_BRIDGE_MRP_PORT_STATE]) {
> +		enum br_mrp_port_state_type state =
> +			nla_get_u32(tb[IFLA_BRIDGE_MRP_PORT_STATE]);
> +
> +		err = br_mrp_set_port_state(p, state);

This can be executed for any port, just noting it.

> +		if (err)
> +			return err;
> +	}
> +
> +	if (tb[IFLA_BRIDGE_MRP_PORT_ROLE]) {
> +		struct br_mrp_port_role *role =
> +			nla_data(tb[IFLA_BRIDGE_MRP_PORT_ROLE]);
> +
> +		err = br_mrp_set_port_role(p, role);

This can be executed for any port also, shouldn't it be available only for MRP_AWARE ports?

> +		if (err)
> +			return err;
> +	}
> +
> +	if (tb[IFLA_BRIDGE_MRP_RING_STATE]) {
> +		struct br_mrp_ring_state *state =
> +			nla_data(tb[IFLA_BRIDGE_MRP_RING_STATE]);
> +
> +		err = br_mrp_set_ring_state(br, state);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (tb[IFLA_BRIDGE_MRP_RING_ROLE]) {
> +		struct br_mrp_ring_role *role =
> +			nla_data(tb[IFLA_BRIDGE_MRP_RING_ROLE]);
> +
> +		err = br_mrp_set_ring_role(br, role);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (tb[IFLA_BRIDGE_MRP_START_TEST]) {
> +		struct br_mrp_start_test *test =
> +			nla_data(tb[IFLA_BRIDGE_MRP_START_TEST]);
> +
> +		err = br_mrp_start_test(br, test);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static inline size_t br_mrp_nlmsg_size(void)
> +{
> +	return NLMSG_ALIGN(sizeof(struct ifinfomsg))
> +		+ nla_total_size(4); /* IFLA_BRIDGE_MRP_RING_OPEN */
> +}
> +
> +int br_mrp_port_open(struct net_device *dev, u8 loc)
> +{
> +	struct nlattr *af, *mrp;
> +	struct ifinfomsg *hdr;
> +	struct nlmsghdr *nlh;
> +	struct sk_buff *skb;
> +	int err = -ENOBUFS;
> +	struct net *net;
> +
> +	net = dev_net(dev);
> +
> +	skb = nlmsg_new(br_mrp_nlmsg_size(), GFP_ATOMIC);
> +	if (!skb)
> +		goto errout;
> +
> +	nlh = nlmsg_put(skb, 0, 0, RTM_NEWLINK, sizeof(*hdr), 0);
> +	if (!nlh)
> +		goto errout;
> +
> +	hdr = nlmsg_data(nlh);
> +	hdr->ifi_family = AF_BRIDGE;
> +	hdr->__ifi_pad = 0;
> +	hdr->ifi_type = dev->type;
> +	hdr->ifi_index = dev->ifindex;
> +	hdr->ifi_flags = dev_get_flags(dev);
> +	hdr->ifi_change = 0;
> +
> +	af = nla_nest_start_noflag(skb, IFLA_AF_SPEC);
> +	if (!af) {
> +		err = -EMSGSIZE;
> +		goto nla_put_failure;
> +	}
> +
> +	mrp = nla_nest_start_noflag(skb, IFLA_BRIDGE_MRP);
> +	if (!mrp) {
> +		err = -EMSGSIZE;
> +		goto nla_put_failure;
> +	}
> +
> +	err = nla_put_u32(skb, IFLA_BRIDGE_MRP_RING_OPEN, loc);
> +	if (err)
> +		goto nla_put_failure;
> +
> +	nla_nest_end(skb, mrp);
> +	nla_nest_end(skb, af);
> +	nlmsg_end(skb, nlh);
> +
> +	rtnl_notify(skb, net, 0, RTNLGRP_LINK, NULL, GFP_ATOMIC);
> +	return 0;
> +
> +nla_put_failure:
> +	nlmsg_cancel(skb, nlh);
> +	kfree_skb(skb);
> +
> +errout:
> +	rtnl_set_sk_err(net, RTNLGRP_LINK, err);
> +	return err;
> +}
> +EXPORT_SYMBOL(br_mrp_port_open);
> 

