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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6197FC433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC50224D2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="NQxGY9DH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgGNNYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgGNNYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:24:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3627C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:24:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so21569792wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GLQFPBl5ZkcFo2RqZUybqIh63q95UCf0Z8BJV3RDMtg=;
        b=NQxGY9DH2ko89HRv96PUpvFPQ56CknakRiZggzLyCALPV9ffdGKud1RW/ACIS3sAfQ
         z21YzXvQG6Pu+Hq3ExYQCW2s/xnsbGvt3DeghR5vJIawL84TbRJq1G5sNWpvpsn9FvCz
         LdFKtgabq4Wko8HWsV2p6uYpHABdhM3WwU6hU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GLQFPBl5ZkcFo2RqZUybqIh63q95UCf0Z8BJV3RDMtg=;
        b=VAt5vrtYLvelhR3UeuBEIQyTW9PjwIfRXE18AFTv4th2aWGEQrwwdcBsxvl2OZGeCG
         kfhXgHA4FSTQZIOv78viSB6P40m4DSBvk+4Q8XteR4FdNrYSGgV2jhq47C1DPc0swL1O
         nfSTAEzvR0CAP1ZF9Aaw4X/LhZRXz2Ehs7ywIIxoZhUNs8qJRI6gJMVZXbZm4IwDnp+s
         1NJZdWAijkVVyPnd0H4zkkGKRwu64UMDQJKt+J9zNpfG4qzdsUPbQn09RRUHKP3yc2hK
         5rPtThvKhwGUm2ykGr2QTacR9DdxrzNSOXGPD3cOZ+L7noUd1aL9XDq0Po5/U4HbWmNt
         KC/g==
X-Gm-Message-State: AOAM5318dCu1fNdJEIh5i9qEGFCEriJFrnfTgveKzo1ziC0OzHbPwIpx
        QruAk2o7AO+dzGKQZ2Oyjw792w==
X-Google-Smtp-Source: ABdhPJxCyPl+yApWOj4n537rplVLqxUnmtGApZDEWCERFAe4cqO8pE+Beoe8GGFBqi/ahuXd+98Qqw==
X-Received: by 2002:adf:db86:: with SMTP id u6mr5652247wri.27.1594733051514;
        Tue, 14 Jul 2020 06:24:11 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id d13sm28530933wrn.61.2020.07.14.06.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 06:24:10 -0700 (PDT)
Subject: Re: [PATCH net-next v4 09/12] bridge: mrp: Extend MRP netlink
 interface for configuring MRP interconnect
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org,
        jiri@resnulli.us, ivecera@redhat.com, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
 <20200714073458.1939574-10-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <c78a8a50-3407-d7d2-c72a-897789cd4152@cumulusnetworks.com>
Date:   Tue, 14 Jul 2020 16:24:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200714073458.1939574-10-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2020 10:34, Horatiu Vultur wrote:
> This patch extends the existing MRP netlink interface with the following
> attributes: IFLA_BRIDGE_MRP_IN_ROLE, IFLA_BRIDGE_MRP_IN_STATE and
> IFLA_BRIDGE_MRP_START_IN_TEST. These attributes are similar with their
> ring attributes but they apply to the interconnect port.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_mrp_netlink.c | 140 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 140 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

> diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
> index 4bf7aaeb29152..a006e0771e8d3 100644
> --- a/net/bridge/br_mrp_netlink.c
> +++ b/net/bridge/br_mrp_netlink.c
> @@ -14,6 +14,9 @@ static const struct nla_policy br_mrp_policy[IFLA_BRIDGE_MRP_MAX + 1] = {
>  	[IFLA_BRIDGE_MRP_RING_STATE]	= { .type = NLA_NESTED },
>  	[IFLA_BRIDGE_MRP_RING_ROLE]	= { .type = NLA_NESTED },
>  	[IFLA_BRIDGE_MRP_START_TEST]	= { .type = NLA_NESTED },
> +	[IFLA_BRIDGE_MRP_IN_ROLE]	= { .type = NLA_NESTED },
> +	[IFLA_BRIDGE_MRP_IN_STATE]	= { .type = NLA_NESTED },
> +	[IFLA_BRIDGE_MRP_START_IN_TEST]	= { .type = NLA_NESTED },
>  };
>  
>  static const struct nla_policy
> @@ -235,6 +238,121 @@ static int br_mrp_start_test_parse(struct net_bridge *br, struct nlattr *attr,
>  	return br_mrp_start_test(br, &test);
>  }
>  
> +static const struct nla_policy
> +br_mrp_in_state_policy[IFLA_BRIDGE_MRP_IN_STATE_MAX + 1] = {
> +	[IFLA_BRIDGE_MRP_IN_STATE_UNSPEC]	= { .type = NLA_REJECT },
> +	[IFLA_BRIDGE_MRP_IN_STATE_IN_ID]	= { .type = NLA_U32 },
> +	[IFLA_BRIDGE_MRP_IN_STATE_STATE]	= { .type = NLA_U32 },
> +};
> +
> +static int br_mrp_in_state_parse(struct net_bridge *br, struct nlattr *attr,
> +				 struct netlink_ext_ack *extack)
> +{
> +	struct nlattr *tb[IFLA_BRIDGE_MRP_IN_STATE_MAX + 1];
> +	struct br_mrp_in_state state;
> +	int err;
> +
> +	err = nla_parse_nested(tb, IFLA_BRIDGE_MRP_IN_STATE_MAX, attr,
> +			       br_mrp_in_state_policy, extack);
> +	if (err)
> +		return err;
> +
> +	if (!tb[IFLA_BRIDGE_MRP_IN_STATE_IN_ID] ||
> +	    !tb[IFLA_BRIDGE_MRP_IN_STATE_STATE]) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Missing attribute: IN_ID or STATE");
> +		return -EINVAL;
> +	}
> +
> +	memset(&state, 0x0, sizeof(state));
> +
> +	state.in_id = nla_get_u32(tb[IFLA_BRIDGE_MRP_IN_STATE_IN_ID]);
> +	state.in_state = nla_get_u32(tb[IFLA_BRIDGE_MRP_IN_STATE_STATE]);
> +
> +	return br_mrp_set_in_state(br, &state);
> +}
> +
> +static const struct nla_policy
> +br_mrp_in_role_policy[IFLA_BRIDGE_MRP_IN_ROLE_MAX + 1] = {
> +	[IFLA_BRIDGE_MRP_IN_ROLE_UNSPEC]	= { .type = NLA_REJECT },
> +	[IFLA_BRIDGE_MRP_IN_ROLE_RING_ID]	= { .type = NLA_U32 },
> +	[IFLA_BRIDGE_MRP_IN_ROLE_IN_ID]		= { .type = NLA_U16 },
> +	[IFLA_BRIDGE_MRP_IN_ROLE_ROLE]		= { .type = NLA_U32 },
> +	[IFLA_BRIDGE_MRP_IN_ROLE_I_IFINDEX]	= { .type = NLA_U32 },
> +};
> +
> +static int br_mrp_in_role_parse(struct net_bridge *br, struct nlattr *attr,
> +				struct netlink_ext_ack *extack)
> +{
> +	struct nlattr *tb[IFLA_BRIDGE_MRP_IN_ROLE_MAX + 1];
> +	struct br_mrp_in_role role;
> +	int err;
> +
> +	err = nla_parse_nested(tb, IFLA_BRIDGE_MRP_IN_ROLE_MAX, attr,
> +			       br_mrp_in_role_policy, extack);
> +	if (err)
> +		return err;
> +
> +	if (!tb[IFLA_BRIDGE_MRP_IN_ROLE_RING_ID] ||
> +	    !tb[IFLA_BRIDGE_MRP_IN_ROLE_IN_ID] ||
> +	    !tb[IFLA_BRIDGE_MRP_IN_ROLE_I_IFINDEX] ||
> +	    !tb[IFLA_BRIDGE_MRP_IN_ROLE_ROLE]) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Missing attribute: RING_ID or ROLE or IN_ID or I_IFINDEX");
> +		return -EINVAL;
> +	}
> +
> +	memset(&role, 0x0, sizeof(role));
> +
> +	role.ring_id = nla_get_u32(tb[IFLA_BRIDGE_MRP_IN_ROLE_RING_ID]);
> +	role.in_id = nla_get_u16(tb[IFLA_BRIDGE_MRP_IN_ROLE_IN_ID]);
> +	role.i_ifindex = nla_get_u32(tb[IFLA_BRIDGE_MRP_IN_ROLE_I_IFINDEX]);
> +	role.in_role = nla_get_u32(tb[IFLA_BRIDGE_MRP_IN_ROLE_ROLE]);
> +
> +	return br_mrp_set_in_role(br, &role);
> +}
> +
> +static const struct nla_policy
> +br_mrp_start_in_test_policy[IFLA_BRIDGE_MRP_START_IN_TEST_MAX + 1] = {
> +	[IFLA_BRIDGE_MRP_START_IN_TEST_UNSPEC]	= { .type = NLA_REJECT },
> +	[IFLA_BRIDGE_MRP_START_IN_TEST_IN_ID]	= { .type = NLA_U32 },
> +	[IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL]	= { .type = NLA_U32 },
> +	[IFLA_BRIDGE_MRP_START_IN_TEST_MAX_MISS]	= { .type = NLA_U32 },
> +	[IFLA_BRIDGE_MRP_START_IN_TEST_PERIOD]	= { .type = NLA_U32 },
> +};
> +
> +static int br_mrp_start_in_test_parse(struct net_bridge *br,
> +				      struct nlattr *attr,
> +				      struct netlink_ext_ack *extack)
> +{
> +	struct nlattr *tb[IFLA_BRIDGE_MRP_START_IN_TEST_MAX + 1];
> +	struct br_mrp_start_in_test test;
> +	int err;
> +
> +	err = nla_parse_nested(tb, IFLA_BRIDGE_MRP_START_IN_TEST_MAX, attr,
> +			       br_mrp_start_in_test_policy, extack);
> +	if (err)
> +		return err;
> +
> +	if (!tb[IFLA_BRIDGE_MRP_START_IN_TEST_IN_ID] ||
> +	    !tb[IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL] ||
> +	    !tb[IFLA_BRIDGE_MRP_START_IN_TEST_MAX_MISS] ||
> +	    !tb[IFLA_BRIDGE_MRP_START_IN_TEST_PERIOD]) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Missing attribute: RING_ID or INTERVAL or MAX_MISS or PERIOD");
> +		return -EINVAL;
> +	}
> +
> +	memset(&test, 0x0, sizeof(test));
> +
> +	test.in_id = nla_get_u32(tb[IFLA_BRIDGE_MRP_START_IN_TEST_IN_ID]);
> +	test.interval = nla_get_u32(tb[IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL]);
> +	test.max_miss = nla_get_u32(tb[IFLA_BRIDGE_MRP_START_IN_TEST_MAX_MISS]);
> +	test.period = nla_get_u32(tb[IFLA_BRIDGE_MRP_START_IN_TEST_PERIOD]);
> +
> +	return br_mrp_start_in_test(br, &test);
> +}
> +
>  int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
>  		 struct nlattr *attr, int cmd, struct netlink_ext_ack *extack)
>  {
> @@ -301,6 +419,28 @@ int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
>  			return err;
>  	}
>  
> +	if (tb[IFLA_BRIDGE_MRP_IN_STATE]) {
> +		err = br_mrp_in_state_parse(br, tb[IFLA_BRIDGE_MRP_IN_STATE],
> +					    extack);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (tb[IFLA_BRIDGE_MRP_IN_ROLE]) {
> +		err = br_mrp_in_role_parse(br, tb[IFLA_BRIDGE_MRP_IN_ROLE],
> +					   extack);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (tb[IFLA_BRIDGE_MRP_START_IN_TEST]) {
> +		err = br_mrp_start_in_test_parse(br,
> +						 tb[IFLA_BRIDGE_MRP_START_IN_TEST],
> +						 extack);
> +		if (err)
> +			return err;
> +	}
> +
>  	return 0;
>  }
>  
> 

