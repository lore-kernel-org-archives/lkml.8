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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64198C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35ABD224B2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="KP7mla+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgGNNOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgGNNOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:14:16 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8872C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:14:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f139so5823382wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1AJSCaA9AJiVaVMrb6q0a2YgcuNnUrAPsUutkIoBrlE=;
        b=KP7mla+vPb+XSGtSDhi2klcSbIgpVzmppgsD2StJS+NDiLzJ7E/OGviL7c10+sdQX/
         mU2ycPJQQWWN+P+L4NqKX/qCO1qITVeNHjnrHDlbpXz5bQ4rTj2y92hb+Ri54JhUJd3w
         t77cK4dckcMgES3cSg0+yoKpf81Bo6RQ90/04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1AJSCaA9AJiVaVMrb6q0a2YgcuNnUrAPsUutkIoBrlE=;
        b=kqNCVvl8mKyARaFxMSx6M5oin3P54J0OhGeXC4En5mMe3345Y49lDNiwIMIuTjWXVK
         yrBG1cTzWdLOtGAGjF3EFsapN6Wh4QKJK/RNQDCvgfozHn92dDOLYtvwAqCVHr/gdEIA
         P01Cvi707FYiHkKDTtgK04XvjBpUSDb59P7pr0WTu4MhLhhir6XQiifwTVI6SweVDbAT
         4pSjpNnirBv53OzrnS9VT3b+CXLUJ5pfrpbBpH7p2fuoL96xPfbS1WfQ56O52jKIrVvN
         q1Kh4a1bXAbyv67vLE8csb0hBhY26XUvxWreETR+2/WczPpEc1bVxnH1womyaeDcuckp
         5wsg==
X-Gm-Message-State: AOAM532nNAUgQHRljiJfgI+La3WIzgN2T/gZiUdWjIin3e09Wm6xqYfl
        NGkTBydBaOHN9lq9BzubXnta8A==
X-Google-Smtp-Source: ABdhPJza0n+wds1kcTU4mseaxPhXB71oAq87NXVGqzW81mFJe4YA93/WPoi2yHUVPLIH5nk0QuU9Ow==
X-Received: by 2002:a1c:9650:: with SMTP id y77mr4422291wmd.101.1594732454603;
        Tue, 14 Jul 2020 06:14:14 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id v18sm30475537wrv.49.2020.07.14.06.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 06:14:13 -0700 (PDT)
Subject: Re: [PATCH net-next v4 02/12] bridge: uapi: mrp: Extend MRP
 attributes for MRP interconnect
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org,
        jiri@resnulli.us, ivecera@redhat.com, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
 <20200714073458.1939574-3-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <86fe5d1d-1cda-e832-3ebb-504876ed548a@cumulusnetworks.com>
Date:   Tue, 14 Jul 2020 16:14:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200714073458.1939574-3-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2020 10:34, Horatiu Vultur wrote:
> Extend the existing MRP netlink attributes to allow to configure MRP
> Interconnect:
> 
> IFLA_BRIDGE_MRP_IN_ROLE - the parameter type is br_mrp_in_role which
>   contains the interconnect id, the ring id, the interconnect role(MIM
>   or MIC) and the port ifindex that represents the interconnect port.
> 
> IFLA_BRIDGE_MRP_IN_STATE - the parameter type is br_mrp_in_state which
>   contains the interconnect id and the interconnect state.
> 
> IFLA_BRIDGE_MRP_IN_TEST - the parameter type is br_mrp_start_in_test
>   which contains the interconnect id, the interval at which to send
>   MRP_InTest frames, how many test frames can be missed before declaring
>   the interconnect ring open and the period which represents for how long
>   to send MRP_InTest frames.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/uapi/linux/if_bridge.h  | 53 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/mrp_bridge.h | 38 +++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index c114c1c2bd533..d840a3e37a37c 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -167,6 +167,9 @@ enum {
>  	IFLA_BRIDGE_MRP_RING_ROLE,
>  	IFLA_BRIDGE_MRP_START_TEST,
>  	IFLA_BRIDGE_MRP_INFO,
> +	IFLA_BRIDGE_MRP_IN_ROLE,
> +	IFLA_BRIDGE_MRP_IN_STATE,
> +	IFLA_BRIDGE_MRP_START_IN_TEST,
>  	__IFLA_BRIDGE_MRP_MAX,
>  };
>  
> @@ -245,6 +248,37 @@ enum {
>  
>  #define IFLA_BRIDGE_MRP_INFO_MAX (__IFLA_BRIDGE_MRP_INFO_MAX - 1)
>  
> +enum {
> +	IFLA_BRIDGE_MRP_IN_STATE_UNSPEC,
> +	IFLA_BRIDGE_MRP_IN_STATE_IN_ID,
> +	IFLA_BRIDGE_MRP_IN_STATE_STATE,
> +	__IFLA_BRIDGE_MRP_IN_STATE_MAX,
> +};
> +
> +#define IFLA_BRIDGE_MRP_IN_STATE_MAX (__IFLA_BRIDGE_MRP_IN_STATE_MAX - 1)
> +
> +enum {
> +	IFLA_BRIDGE_MRP_IN_ROLE_UNSPEC,
> +	IFLA_BRIDGE_MRP_IN_ROLE_RING_ID,
> +	IFLA_BRIDGE_MRP_IN_ROLE_IN_ID,
> +	IFLA_BRIDGE_MRP_IN_ROLE_ROLE,
> +	IFLA_BRIDGE_MRP_IN_ROLE_I_IFINDEX,
> +	__IFLA_BRIDGE_MRP_IN_ROLE_MAX,
> +};
> +
> +#define IFLA_BRIDGE_MRP_IN_ROLE_MAX (__IFLA_BRIDGE_MRP_IN_ROLE_MAX - 1)
> +
> +enum {
> +	IFLA_BRIDGE_MRP_START_IN_TEST_UNSPEC,
> +	IFLA_BRIDGE_MRP_START_IN_TEST_IN_ID,
> +	IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL,
> +	IFLA_BRIDGE_MRP_START_IN_TEST_MAX_MISS,
> +	IFLA_BRIDGE_MRP_START_IN_TEST_PERIOD,
> +	__IFLA_BRIDGE_MRP_START_IN_TEST_MAX,
> +};
> +
> +#define IFLA_BRIDGE_MRP_START_IN_TEST_MAX (__IFLA_BRIDGE_MRP_START_IN_TEST_MAX - 1)
> +
>  struct br_mrp_instance {
>  	__u32 ring_id;
>  	__u32 p_ifindex;
> @@ -270,6 +304,25 @@ struct br_mrp_start_test {
>  	__u32 monitor;
>  };
>  
> +struct br_mrp_in_state {
> +	__u32 in_state;
> +	__u16 in_id;
> +};
> +
> +struct br_mrp_in_role {
> +	__u32 ring_id;
> +	__u32 in_role;
> +	__u32 i_ifindex;
> +	__u16 in_id;
> +};
> +
> +struct br_mrp_start_in_test {
> +	__u32 interval;
> +	__u32 max_miss;
> +	__u32 period;
> +	__u16 in_id;
> +};
> +
>  struct bridge_stp_xstats {
>  	__u64 transition_blk;
>  	__u64 transition_fwd;
> diff --git a/include/uapi/linux/mrp_bridge.h b/include/uapi/linux/mrp_bridge.h
> index bee3665402129..6aeb13ef0b1ec 100644
> --- a/include/uapi/linux/mrp_bridge.h
> +++ b/include/uapi/linux/mrp_bridge.h
> @@ -21,11 +21,22 @@ enum br_mrp_ring_role_type {
>  	BR_MRP_RING_ROLE_MRA,
>  };
>  
> +enum br_mrp_in_role_type {
> +	BR_MRP_IN_ROLE_DISABLED,
> +	BR_MRP_IN_ROLE_MIC,
> +	BR_MRP_IN_ROLE_MIM,
> +};
> +
>  enum br_mrp_ring_state_type {
>  	BR_MRP_RING_STATE_OPEN,
>  	BR_MRP_RING_STATE_CLOSED,
>  };
>  
> +enum br_mrp_in_state_type {
> +	BR_MRP_IN_STATE_OPEN,
> +	BR_MRP_IN_STATE_CLOSED,
> +};
> +
>  enum br_mrp_port_state_type {
>  	BR_MRP_PORT_STATE_DISABLED,
>  	BR_MRP_PORT_STATE_BLOCKED,
> @@ -36,6 +47,7 @@ enum br_mrp_port_state_type {
>  enum br_mrp_port_role_type {
>  	BR_MRP_PORT_ROLE_PRIMARY,
>  	BR_MRP_PORT_ROLE_SECONDARY,
> +	BR_MRP_PORT_ROLE_INTER,
>  };
>  
>  enum br_mrp_tlv_header_type {
> @@ -45,6 +57,10 @@ enum br_mrp_tlv_header_type {
>  	BR_MRP_TLV_HEADER_RING_TOPO = 0x3,
>  	BR_MRP_TLV_HEADER_RING_LINK_DOWN = 0x4,
>  	BR_MRP_TLV_HEADER_RING_LINK_UP = 0x5,
> +	BR_MRP_TLV_HEADER_IN_TEST = 0x6,
> +	BR_MRP_TLV_HEADER_IN_TOPO = 0x7,
> +	BR_MRP_TLV_HEADER_IN_LINK_DOWN = 0x8,
> +	BR_MRP_TLV_HEADER_IN_LINK_UP = 0x9,
>  	BR_MRP_TLV_HEADER_OPTION = 0x7f,
>  };
>  
> @@ -118,4 +134,26 @@ struct br_mrp_oui_hdr {
>  	__u8 oui[MRP_OUI_LENGTH];
>  };
>  
> +struct br_mrp_in_test_hdr {
> +	__be16 id;
> +	__u8 sa[ETH_ALEN];
> +	__be16 port_role;
> +	__be16 state;
> +	__be16 transitions;
> +	__be32 timestamp;
> +};
> +
> +struct br_mrp_in_topo_hdr {
> +	__u8 sa[ETH_ALEN];
> +	__be16 id;
> +	__be16 interval;
> +};
> +
> +struct br_mrp_in_link_hdr {
> +	__u8 sa[ETH_ALEN];
> +	__be16 port_role;
> +	__be16 id;
> +	__be16 interval;
> +};
> +
>  #endif
> 

