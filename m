Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE1BC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A4B6218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="F5HxnmxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgIIIvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgIIIvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:51:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E69C061755
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 01:51:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s12so2000921wrw.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FmjsDP04mfdZLFJ3+qkXlrf94+T5cynHI+nHZZTQUrA=;
        b=F5HxnmxZmh/Rkv0qYZTpW/Qud5QjTIfK4ymVAgR9qcydWiqEqt/HTRNU0lmvMH2ZMT
         Wl9nNSsqZoLNibRimE5TzxpM6MhB4TgjKS/Z9JhwnxfUqBXgMfHylbGkssA2AtQCMQsx
         yvZqfVAEg1GG3oZNwCiBM7geET/0rZkSd4/thWucjAHRmL+SFYrqo2UZHXm3tgkh5Exc
         GzEqPfB5FikAQNGFITL3YAuXwyxYk2+W4/U0FYgXdXk5A7wMoNk5y7c7YORrk13S1kTS
         4tSvLHn4bUyPLN8eHOkL1ZZ5VhE7pOOIBpWDC0y9g88ZTZ2kPDLWmDIymgE2RFuNL1LT
         mqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FmjsDP04mfdZLFJ3+qkXlrf94+T5cynHI+nHZZTQUrA=;
        b=XYBJn5eAlkjaLaMQ6YU2o+vM4UlgHyWyHl+LdQk9tIDWT9aovYhFGDv6oFkCojZEF+
         y74+3XzGok2QMJcP8xt1vga1gd8fuKRkok929gRtcDvpjyg+VrQPzCZhqUw4zA8zzdqQ
         wsxKidRSNN0COqtvXJokhIeufeoFdF4v0eYM6s/NB4e/phNK1ij6YlwElyKeygYffJi5
         TNdAN2BSxk9C5BXgttzisQhnU/koGdHNJBb1zRoXDSi6FzI3/fM/1oM2HRIgs6dMrXKh
         bhp4QmNPiEnUlKFGS/nTfYuIV6d/ZBOBbEsDFa1mbXwPeinHfOnsov0IdmzFfdz/FXdx
         ABAA==
X-Gm-Message-State: AOAM531k7XFzXKTMAVPkY1l8elE9IYAWt16q6SXNyaSI1xFB34ezJyS/
        5Fy5wzenQ4mN/q0Ln4dgjKe2Wk+DvWeHew==
X-Google-Smtp-Source: ABdhPJwFSjSHep5K3LKvgNDc2UUUNZuY5swjq7QdRad9kG32ZF8UyIG2HVpfoOhciBbg5VIW4okArA==
X-Received: by 2002:adf:9ed4:: with SMTP id b20mr2914850wrf.206.1599641491830;
        Wed, 09 Sep 2020 01:51:31 -0700 (PDT)
Received: from netronome.com ([2001:982:756:703:d63d:7eff:fe99:ac9d])
        by smtp.gmail.com with ESMTPSA id a74sm3000027wme.11.2020.09.09.01.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 01:51:31 -0700 (PDT)
Date:   Wed, 9 Sep 2020 10:51:30 +0200
From:   Simon Horman <simon.horman@netronome.com>
To:     Paul Davey <paul.davey@alliedtelesis.co.nz>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] ipmr: Use full VIF ID in netlink cache
 reports
Message-ID: <20200909085128.GA14965@netronome.com>
References: <20200907220408.32385-1-paul.davey@alliedtelesis.co.nz>
 <20200907220408.32385-4-paul.davey@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907220408.32385-4-paul.davey@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 10:04:08AM +1200, Paul Davey wrote:
> Insert the full 16 bit VIF ID into ipmr Netlink cache reports.
> 
> The VIF_ID attribute has 32 bits of space so can store the full VIF ID
> extracted from the high and low byte fields in the igmpmsg.
> 
> Signed-off-by: Paul Davey <paul.davey@alliedtelesis.co.nz>
> ---
>  net/ipv4/ipmr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index 4809318f591b..939792a38814 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -2432,7 +2432,7 @@ static void igmpmsg_netlink_event(struct mr_table *mrt, struct sk_buff *pkt)
>  	rtgenm = nlmsg_data(nlh);
>  	rtgenm->rtgen_family = RTNL_FAMILY_IPMR;
>  	if (nla_put_u8(skb, IPMRA_CREPORT_MSGTYPE, msg->im_msgtype) ||
> -	    nla_put_u32(skb, IPMRA_CREPORT_VIF_ID, msg->im_vif) ||
> +	    nla_put_u32(skb, IPMRA_CREPORT_VIF_ID, msg->im_vif | (msg->im_vif_hi << 8)) ||

nit: the inner parentheses seem unnecessary

Otherwise, FWIIW, this series looks good to me.

>  	    nla_put_in_addr(skb, IPMRA_CREPORT_SRC_ADDR,
>  			    msg->im_src.s_addr) ||
>  	    nla_put_in_addr(skb, IPMRA_CREPORT_DST_ADDR,
> -- 
> 2.28.0
> 
