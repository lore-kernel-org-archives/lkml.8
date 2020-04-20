Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1E0C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D3620672
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="P83+///7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgDTRSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726751AbgDTRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:18:35 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03956C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:18:35 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id w145so8644969lff.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Sd8E77foj1OUgsaWFd9h8ikuxOeJShnx246PjzjsMdU=;
        b=P83+///79KUkjs8GzdyrNR6bxDjqliRkmJtvTNgYl6VXFoxCRH1sOMGQhR9jq5i1FN
         8XWAkZh/7UWBbTWMn5Jf+IIONxmCljSviNanlUDzeefOeE5OaIYtiVsBaNwo6b7uLja6
         FFXjFuy2hvquUy58sW0rcV1kiTa0dhP8R/fdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sd8E77foj1OUgsaWFd9h8ikuxOeJShnx246PjzjsMdU=;
        b=Ts1Ye69f4lB6pXWYnv/QZG60sZwH4xINm4IqZsErwa6NcGkU1MyC/jvf8riy5cEsdP
         AE8JcgEtdd9n2i4khxd9h4oPKnY6qEYpKLZ53og1VelixmUy1mGfKw2jhUfo8yuyws5K
         ACN+L8Lfxjp+gRDi6lyKezsz6QAmabv/CC533oYtajXRGa3wFdcjog9D4jc3m7qDM6Cq
         28T0YMAZBTaV2XBHjhsHtx9D4r+149qATEiqKcfn8G2vhtygQDnZmOs896FCWWvCobGx
         vFoKulmtfl94DCu1FSnnJfelCvkoOIDmagP68oZ4bcGp3bBbv4pmjHMVu6FeNAP5ZMuz
         CLgg==
X-Gm-Message-State: AGi0PuYGiCEKev3ys4J+9GlSwRPQFa9ZMBxAp12B9JrGPSAtG7Zga82w
        fsevw/Dc6EbSzUncp7Xsuy4Zig==
X-Google-Smtp-Source: APiQypIxaP0fafVwzJZ054hJLnt465e+HmYeWYVyY2US5ptrI3RN8PVSMLCFEi3UiV9HecxpjLPEpg==
X-Received: by 2002:a19:700b:: with SMTP id h11mr11256321lfc.89.1587403113517;
        Mon, 20 Apr 2020 10:18:33 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id v15sm57421ljd.33.2020.04.20.10.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 10:18:32 -0700 (PDT)
Subject: Re: [PATCH net-next 10/13] bridge: mrp: Implement netlink interface
 to configure MRP
To:     Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net,
        jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org,
        roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20200420150947.30974-1-horatiu.vultur@microchip.com>
 <20200420150947.30974-11-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <066720c4-ddc4-ce71-734f-932b6a342e01@cumulusnetworks.com>
Date:   Mon, 20 Apr 2020 20:18:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420150947.30974-11-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2020 18:09, Horatiu Vultur wrote:
> Implement netlink interface to configure MRP. The implementation
> will do sanity checks over the attributes and then eventually call the MRP
> interface.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_mrp_netlink.c | 117 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 net/bridge/br_mrp_netlink.c
> 
> diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
> new file mode 100644
> index 000000000000..0ff42e7c7f57
> --- /dev/null
> +++ b/net/bridge/br_mrp_netlink.c
> @@ -0,0 +1,117 @@
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
> +		NL_SET_ERR_MSG_MOD(extack, "MRP can't be enabled if STP is already enabled\n");
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
> +		if (err)
> +			return err;
> +	}
> +
> +	if (tb[IFLA_BRIDGE_MRP_PORT_ROLE]) {
> +		struct br_mrp_port_role *role =
> +			nla_data(tb[IFLA_BRIDGE_MRP_PORT_ROLE]);
> +
> +		err = br_mrp_set_port_role(p, role);
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
> +int br_mrp_port_open(struct net_device *dev, u8 loc)
> +{
> +	struct net_bridge_port *p;
> +	int err = 0;
> +
> +	p = br_port_get_rcu(dev);
> +	if (!p) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	p->loc = loc;
> +	br_ifinfo_notify(RTM_NEWLINK, NULL, p);
> +
> +out:
> +	return err;
> +}
> +EXPORT_SYMBOL(br_mrp_port_open);
> 

I just noticed the EXPORT_SYMBOL() here, why do you need it?

