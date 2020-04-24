Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67503C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43CBD20776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="a5yL4+q4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgDXNLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgDXNLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:11:22 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAF4C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:11:22 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y4so9885697ljn.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Gx9hNKg0l/txCpQUT0mCibQINePXOppVz6cuR/nn8AA=;
        b=a5yL4+q452l7JxoNgJo2bhKexP37/cRH1AQbPNfIZSiGptvZXs8q+gLLzv+J8bCwgP
         wUe0NXRCO+V7B6dinuZT8ts9HB26TQv6R+ai4l3w+IiZ9kBnKW9TtG0LY5VjJh+VlJDE
         Pz8EUD4+EsG1qkecWUklJ2Ysmurt3CyRnGygE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gx9hNKg0l/txCpQUT0mCibQINePXOppVz6cuR/nn8AA=;
        b=SImdgfCD4cOxV7mlRY+bpSeiRjRkgo3R+DFEgKak+ijp9JKi27ZsCxzbaghD60SBdF
         4wFzHLoo3LPsOyK7KaP1j1k3hQ1kn/N80j9ElFSDJJ/CbXuH+kViegCMQ+Q9gDN+La6l
         o8lf6ql7ea+j7HNc2bezngQfilDEduxY3aK5KzI/zCLKuXsaKZ0Xz6Oh0R4zrdPGGEHe
         GVLsIfAKI2cdcbItEuxVmgZ7iDylKZ5sdisxTeIatHWhTerKbredZdqD+fxG0pdgxYL7
         qtThjuq9aH72AcSqvsDFQz6u2A9tHJmtpBM3jGVrheoCNUUeBtDNsYuXqN0RMiSeKO3u
         3X3g==
X-Gm-Message-State: AGi0PuYlta1r4PTPFjtVygKt3KLoeukUF54fSAatuUJtBJmbz6mufjM6
        zwejI8n9uraSbuqLTW2HJJ1sWg==
X-Google-Smtp-Source: APiQypITC7oqv5JpXqxP9F+iKDdOC8YPa8L7rOpho6N7WEoFjOLOscnhdTlFof13kpjX94p2752lVg==
X-Received: by 2002:a2e:9118:: with SMTP id m24mr5951942ljg.172.1587733880848;
        Fri, 24 Apr 2020 06:11:20 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id x21sm4180540ljm.74.2020.04.24.06.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 06:11:19 -0700 (PDT)
Subject: Re: [PATCH net-next v3 01/11] bridge: uapi: mrp: Add mrp attributes.
To:     Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net,
        jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org,
        roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20200422161833.1123-1-horatiu.vultur@microchip.com>
 <20200422161833.1123-2-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <2969c2e1-2ed4-87fd-7053-f70a3f923567@cumulusnetworks.com>
Date:   Fri, 24 Apr 2020 16:11:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422161833.1123-2-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2020 19:18, Horatiu Vultur wrote:
> Add new nested netlink attribute to configure the MRP. These attributes are used
> by the userspace to add/delete/configure MRP instances and by the kernel to
> notify the userspace when the MRP ring gets open/closed. MRP nested attribute
> has the following attributes:
> 
> IFLA_BRIDGE_MRP_INSTANCE - the parameter type is br_mrp_instance which contains
>   the instance id, and the ifindex of the two ports. The ports can't be part of
>   multiple instances. This is used to create/delete MRP instances.
> 
> IFLA_BRIDGE_MRP_PORT_STATE - the parameter type is u32. Which can be forwarding,
>   blocking or disabled.
> 
> IFLA_BRIDGE_MRP_PORT_ROLE - the parameter type is br_mrp_port_role which
>   contains the instance id and the role. The role can be primary or secondary.
> 
> IFLA_BRIDGE_MRP_RING_STATE - the parameter type is br_mrp_ring_state which
>   contains the instance id and the state. The state can be open or closed.
> 
> IFLA_BRIDGE_MRP_RING_ROLE - the parameter type is br_mrp_ring_role which
>   contains the instance id and the ring role. The role can be MRM or MRC.
> 
> IFLA_BRIDGE_MRP_START_TEST - the parameter type is br_mrp_start_test which
>   contains the instance id, the interval at which to send the MRP_Test frames,
>   how many test frames can be missed before declaring the ring open and the
>   period which represent for how long to send the test frames.
> 
> Also add the file include/uapi/linux/mrp_bridge.h which defines all the types
> used by MRP that are also needed by the userpace.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/uapi/linux/if_bridge.h  | 42 +++++++++++++++++
>  include/uapi/linux/if_ether.h   |  1 +
>  include/uapi/linux/mrp_bridge.h | 84 +++++++++++++++++++++++++++++++++
>  3 files changed, 127 insertions(+)
>  create mode 100644 include/uapi/linux/mrp_bridge.h
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

