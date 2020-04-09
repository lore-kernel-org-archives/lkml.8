Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C41AC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D6820757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HIYBjOt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgDITf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:35:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43539 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDITfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:35:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id l1so2661083pff.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 12:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZFP+FR08i1s+W9X/XmCSBipjwAMer5IJn5kP7NkKJSQ=;
        b=HIYBjOt621x44z9HbG9j4NfjwMFl6MJKebKLQcx5wGrwENvjwPquktrGcT3wBFq5Ck
         /Xhs+b7DcYyVxNaX9dtaIkK0yDcfUlVdiZ5rgkhovmxc1HdtjgW7kscnsabVieQnMFvy
         jOdVas7tP8po0Lq69NS0gxa+2iZlHe99/KZeM3H0vl2rqS2Fvmm0HaMpgxOQ3k0nZpM+
         N0122VJZeB8i+QUy3FDOjWECfOYLB2cNwQYgO3SaAYVt8CLCDgYDvj+XPpt/aBZeKm29
         iTKmBxvna2NLCgTnsZyvo4wbTy+qFcpKClx5UbXwEnYRvMJzhXikwMT7jVjoBSi2318X
         pdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZFP+FR08i1s+W9X/XmCSBipjwAMer5IJn5kP7NkKJSQ=;
        b=taEFlrfrPxW/XbNPzXqiRmjyCsvnJBIg2npIoiTD1doe9laSiqt7BJF9yiOXuPwZA4
         xgl/BeJ97/Q7y+lZBM2doNiWSWxDHcUrCqU3JzVL3NvH7KDfkiGMd8pTlYZWB7KeouEv
         YJ9Rz7RxABNXKk0IBWIb0G05h1aS2mtEvyMOFUnsHQ8UMWG/AE9BbbuePKLM0kQ4THFf
         XuPyzyrbV9hYAL0+Q7P9OZcFl8HO6FrOG14yxJnWKcZiryl/O59Yh1SskfKjtkGeSNQD
         53POYaB2g1wpsb9GFBFt1mTOt+eL7dwcxVYDGxoXImqPkta20+lmGG61ii6+w+RSKFzi
         m6ww==
X-Gm-Message-State: AGi0PuajqFuABHPLQdiIKxx08uBXUZiJhYsgQpzQbLu68XwFnlZ+xTo5
        IlqID1w+eCShZ+o2ZsRXaCv0Kw==
X-Google-Smtp-Source: APiQypJpng2c9uyJ13km8UqsABXbC96LzH37XJys7RkPANWfPwe1duDDCSXKaU0/QcMa0l+eZylFRw==
X-Received: by 2002:a63:d4f:: with SMTP id 15mr984185pgn.237.1586460952679;
        Thu, 09 Apr 2020 12:35:52 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o12sm2838199pjt.16.2020.04.09.12.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 12:35:51 -0700 (PDT)
Date:   Thu, 9 Apr 2020 12:36:00 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     WANG Wenhu <wenhu.wang@vivo.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Carl Huang <cjhuang@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicholas Mc Guire <hofrat@osadl.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com
Subject: Re: [PATCH v2] net: qrtr: send msgs from local of same id as
 broadcast
Message-ID: <20200409193600.GR20625@builder.lan>
References: <20200407132930.109738-1-wenhu.wang@vivo.com>
 <20200408033249.120608-1-wenhu.wang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408033249.120608-1-wenhu.wang@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07 Apr 20:32 PDT 2020, WANG Wenhu wrote:

> From: Wang Wenhu <wenhu.wang@vivo.com>
> 
> If the local node id(qrtr_local_nid) is not modified after its
> initialization, it equals to the broadcast node id(QRTR_NODE_BCAST).
> So the messages from local node should not be taken as broadcast
> and keep the process going to send them out anyway.
> 
> The definitions are as follow:
> static unsigned int qrtr_local_nid = NUMA_NO_NODE;
> 
> Fixes: commit fdf5fd397566 ("net: qrtr: Broadcast messages only from control port")
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> ---
> Changlog:
>  - For coding style, line up the newline of the if conditional judgement
>    with the one exists before.
> 
>  net/qrtr/qrtr.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
> index 5a8e42ad1504..545a61f8ef75 100644
> --- a/net/qrtr/qrtr.c
> +++ b/net/qrtr/qrtr.c
> @@ -907,20 +907,21 @@ static int qrtr_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
>  
>  	node = NULL;
>  	if (addr->sq_node == QRTR_NODE_BCAST) {
> -		enqueue_fn = qrtr_bcast_enqueue;
> -		if (addr->sq_port != QRTR_PORT_CTRL) {
> +		if (addr->sq_port != QRTR_PORT_CTRL &&
> +			qrtr_local_nid != QRTR_NODE_BCAST) {

So this would mean that if local_nid is configured to be the bcast
address then rather than rejecting messages to non-control ports we will
broadcast them.

What happens when some other node in the network replies? Wouldn't it be
better to explicitly prohibit usage of the bcast address as our node
address?


That said, in torvalds/master qrtr_local_nid is no longer initialized to
QRTR_NODE_BCAST, but 1. So I don't think you need this patch anymore.

Regards,
Bjorn

>  			release_sock(sk);
>  			return -ENOTCONN;
>  		}
> +		enqueue_fn = qrtr_bcast_enqueue;
>  	} else if (addr->sq_node == ipc->us.sq_node) {
>  		enqueue_fn = qrtr_local_enqueue;
>  	} else {
> -		enqueue_fn = qrtr_node_enqueue;
>  		node = qrtr_node_lookup(addr->sq_node);
>  		if (!node) {
>  			release_sock(sk);
>  			return -ECONNRESET;
>  		}
> +		enqueue_fn = qrtr_node_enqueue;
>  	}
>  
>  	plen = (len + 3) & ~3;
> -- 
> 2.17.1
> 
