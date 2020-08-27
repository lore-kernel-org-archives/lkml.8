Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC90C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B27D204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgH0Ju2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:50:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:53030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgH0Ju1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:50:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C031CAD78;
        Thu, 27 Aug 2020 09:50:57 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 5A269603FB; Thu, 27 Aug 2020 11:50:25 +0200 (CEST)
Date:   Thu, 27 Aug 2020 11:50:25 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Fabian Frederick <fabf@skynet.be>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7 net-next] vxlan: add VXLAN_NL2FLAG macro
Message-ID: <20200827095025.p4mxmuh2jwmzs5kt@lion.mk-sys.cz>
References: <20200827065019.5787-1-fabf@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827065019.5787-1-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 08:50:19AM +0200, Fabian Frederick wrote:
> Replace common flag assignment with a macro.
> This could yet be simplified with changelink/supported but it would
> remove clarity
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
[...]
> diff --git a/include/net/vxlan.h b/include/net/vxlan.h
> index 3a41627cbdfe5..8a56b7a0f75f9 100644
> --- a/include/net/vxlan.h
> +++ b/include/net/vxlan.h
> @@ -290,6 +290,16 @@ struct vxlan_dev {
>  					 VXLAN_F_UDP_ZERO_CSUM6_RX |	\
>  					 VXLAN_F_COLLECT_METADATA)
>  
> +
> +#define VXLAN_NL2FLAG(iflag, flag, changelink, changelink_supported) {   \
> +	if (data[iflag]) {						 \
> +		err = vxlan_nl2flag(conf, data, iflag, flag, changelink, \
> +				    changelink_supported, extack);       \
> +		if (err)						 \
> +			return err;					 \
> +	}								 \
> +}
> +

Hiding a goto or return in a macro is generally discouraged as it may
confuse people reading or updating the code. See e.g. commit
94f826b8076e ("net: fix a potential rcu_read_lock() imbalance in
rt6_fill_node()") for an example of such problem - which was likely the
trigger for removal of NLA_PUT() and related macros shortly after.

Michal

>  struct net_device *vxlan_dev_create(struct net *net, const char *name,
>  				    u8 name_assign_type, struct vxlan_config *conf);
>  
> -- 
> 2.27.0
> 
