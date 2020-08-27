Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99900C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E19B2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgH0VGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 17:06:10 -0400
Received: from mg.ssi.bg ([178.16.128.9]:35388 "EHLO mg.ssi.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgH0VGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 17:06:08 -0400
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 340B52E3CE;
        Thu, 27 Aug 2020 23:59:32 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [178.16.128.7])
        by mg.ssi.bg (Proxmox) with ESMTP id A28952E3CC;
        Thu, 27 Aug 2020 23:59:31 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id A90133C09C4;
        Thu, 27 Aug 2020 23:59:27 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id 07RKxO9Y013130;
        Thu, 27 Aug 2020 23:59:26 +0300
Date:   Thu, 27 Aug 2020 23:59:24 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Lach <iam@lach.pw>
cc:     Wensong Zhang <wensong@linux-vs.org>,
        Simon Horman <horms@verge.net.au>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove ipvs v6 dependency on iptables
In-Reply-To: <20200827194802.1164-1-iam@lach.pw>
Message-ID: <alpine.LFD.2.23.451.2008272357240.4567@ja.home.ssi.bg>
References: <20200827194802.1164-1-iam@lach.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Fri, 28 Aug 2020, Lach wrote:

> This dependency was added in 63dca2c0b0e7a92cb39d1b1ecefa32ffda201975, because this commit had dependency on
> ipv6_find_hdr, which was located in iptables-specific code
> 
> But it is no longer required, because f8f626754ebeca613cf1af2e6f890cfde0e74d5b moved them to a more common location

	May be then we should also not include ip6_tables.h from
include/net/ip_vs.h ?

> ---
>  net/netfilter/ipvs/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/netfilter/ipvs/Kconfig b/net/netfilter/ipvs/Kconfig
> index 2c1593089..eb0e329f9 100644
> --- a/net/netfilter/ipvs/Kconfig
> +++ b/net/netfilter/ipvs/Kconfig
> @@ -29,7 +29,6 @@ if IP_VS
>  config	IP_VS_IPV6
>  	bool "IPv6 support for IPVS"
>  	depends on IPV6 = y || IP_VS = IPV6
> -	select IP6_NF_IPTABLES
>  	select NF_DEFRAG_IPV6
>  	help
>  	  Add IPv6 support to IPVS.
> -- 
> 2.28.0

Regards

--
Julian Anastasov <ja@ssi.bg>

