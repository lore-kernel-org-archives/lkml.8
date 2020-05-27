Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E766C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E92832065F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tp59n4X8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgE0WKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0WKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:10:39 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DA5C05BD1E;
        Wed, 27 May 2020 15:10:39 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h9so10434146qtj.7;
        Wed, 27 May 2020 15:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G1XVpETlJJP2/jiBYqi8DO5iH3KbcawIwgPnsLm6SC8=;
        b=Tp59n4X8czCiReNvvETssPFFJvGvIGmo5rc4qluvNzypT/Tkr2LkJFYlrlbkYvGBSz
         SMKmCostg8pAueCS5/Bey4mSxgdfZcVcg37ZcuvQ+F/yvaQ1Yk7qsRNQpz2c9RHn85bx
         0MygTRpTy6xgU4z7fifDIit8ixqEiYh1bUfDfIZTPp4/MOZ7Lmkm4NMbh5Np6AeZlOk2
         ftXWKIFgDL4ibrSK28kKyruj+2F6hBBpntD6FMbx1JwEb6fdA2r5x/HhpD2sQBVTcGUm
         urc73dd/+t0N6gBrMvWpf5fjRaJhgHlda4Q5OX1WqJN9cHDvznyuTUL47hrgNkCgG1us
         IBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G1XVpETlJJP2/jiBYqi8DO5iH3KbcawIwgPnsLm6SC8=;
        b=VqiaLePLy+N1sXi7As+9KK9gWg7CXXmtl9WQK7oOclUjdP7km527vCpw2/44dSQyDU
         J7WhVMBi81jAmzYyTxKGFhe4iX6cYE6O5DqI0XxfZ2NHjK0WdIw51EYLczKxdBiJgkoL
         B25GDv4n8oOdzRa2E96pFAqNOWuq/TVUTWQ9ePlZ/VnUV8Wsr4J+QnzwXsJcvfrS8I7L
         quS2XtZS3s/vDTBpR5DuMUZWVv5qbvYnF5mhxaU/f+L8w0n/TjWX1FTl2iXHh514eQ50
         rCmjm1KMcy2RZGGjKyUWMRAKrNml2pH3+PbZ2QMHew6Prb939MCTYOk64g1D24SMOoAh
         zCTg==
X-Gm-Message-State: AOAM532Yfu21Ke9u3LK7vMVwHYaGDlahTi0k3M2BZ6v2IWcsbdtp1MLy
        RYSFsgNMB/uBU90TKMgz7d4=
X-Google-Smtp-Source: ABdhPJyvPQqfUeH5p1gAxZJINHZv485sQezDQXZjkMcuPkV3lWTZYCE9XvqscSdhtwB0fetxjN3oBA==
X-Received: by 2002:ac8:226d:: with SMTP id p42mr73463qtp.1.1590617438572;
        Wed, 27 May 2020 15:10:38 -0700 (PDT)
Received: from localhost.localdomain ([2001:1284:f013:8992:a39b:b6ab:3df8:5b60])
        by smtp.gmail.com with ESMTPSA id i3sm3530811qkf.39.2020.05.27.15.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 15:10:37 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 6A1E0C1B84; Wed, 27 May 2020 19:10:35 -0300 (-03)
Date:   Wed, 27 May 2020 19:10:35 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Jonas Falkevik <jonas.falkevik@gmail.com>
Cc:     lucien.xin@gmail.com, nhorman@tuxdriver.com, vyasevich@gmail.com,
        davem@davemloft.net, kuba@kernel.org, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sctp: check assoc before SCTP_ADDR_{MADE_PRIM,ADDED}
 event
Message-ID: <20200527221035.GB47547@localhost.localdomain>
References: <20200527095640.270986-1-jonas.falkevik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527095640.270986-1-jonas.falkevik@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 11:56:40AM +0200, Jonas Falkevik wrote:
> Make sure SCTP_ADDR_{MADE_PRIM,ADDED} are sent only for associations
> that have been established.
> 
> These events are described in rfc6458#section-6.1
> SCTP_PEER_ADDR_CHANGE:
> This tag indicates that an address that is
> part of an existing association has experienced a change of
> state (e.g., a failure or return to service of the reachability
> of an endpoint via a specific transport address).
> 
> Signed-off-by: Jonas Falkevik <jonas.falkevik@gmail.com>

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Thanks!

> ---
> Changes in v2:
>  - Check asoc state to be at least established.
>    Instead of associd being SCTP_FUTURE_ASSOC.
>  - Common check for all peer addr change event
> 
>  net/sctp/ulpevent.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/sctp/ulpevent.c b/net/sctp/ulpevent.c
> index c82dbdcf13f2..77d5c36a8991 100644
> --- a/net/sctp/ulpevent.c
> +++ b/net/sctp/ulpevent.c
> @@ -343,6 +343,9 @@ void sctp_ulpevent_nofity_peer_addr_change(struct sctp_transport *transport,
>  	struct sockaddr_storage addr;
>  	struct sctp_ulpevent *event;
>  
> +	if (asoc->state < SCTP_STATE_ESTABLISHED)
> +		return;
> +
>  	memset(&addr, 0, sizeof(struct sockaddr_storage));
>  	memcpy(&addr, &transport->ipaddr, transport->af_specific->sockaddr_len);
>  
> -- 
> 2.25.4
> 
