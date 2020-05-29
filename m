Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C433C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 368532072D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xeh7YBtN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgE2Iq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgE2IqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:46:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E95C08C5C8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:46:23 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t16so851210plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XiIwcIBaCjacNvQQiGLxskNtGMHCMoH6FbpJtFd+1bk=;
        b=xeh7YBtNLEg/HSHajEUKqjg00CUU1WpaXmJGLNkGlhAEyBmFt0sUQ+SEm4iiDCg6Ap
         4hiWdMIri0YvFdptKT236rPnFWAse7EO0mwSgX3dwsi41CIjD5XNM+TpZIXfU0wCkWEa
         F4/S+lzMYxRF4Uvl31ZjzVoEpXMr4ml7Nyh4EKm/gpF2qlJtdNIfcv3d0zdx/eIm3Wyl
         95Bh9PElu3SB0xXOKliink64R6ECiTuBIX4geW1ol4dHZyLEhMz8Bbv2EBwuhD886IHu
         t3+Ovs+G1V6GSYC8sV89Fzj2PGmJ2Uocd19lpFoDNjaHWms+7zgLhy4LtR7JumPEGtTD
         jWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XiIwcIBaCjacNvQQiGLxskNtGMHCMoH6FbpJtFd+1bk=;
        b=n5LtImMTTLf/OQ7wTEZGCKwzbfS49sCeEBIhZ3iC3ndV2ocCLsys0puZtUsF8yJBm1
         EU8BqqfXVHFKr7+iMLKXnycHn1/ioNzC0P9nNMaaKSMe5BRK2ufRfYCLC9syum+goYpN
         t+g82pWDzdcmFQN6j/MUAADGasyRP5Xz/+n+74ROxJqwVtnhUPxKoA8AIlDGhpeDn9V3
         pg2HR2wJb0e6c/GTWgkLNnNIeKW9RO3a3AlFTAfpFwW9dY8kAQydI93cyeAhuvl5GatE
         mMT0HDl8nCkEwRP85BOvbB9NH8myTNWz5q+pqFqvyVZQZ0IlMn/3p7cJ5qBPSWrOcPxA
         knMQ==
X-Gm-Message-State: AOAM530qozTKJh+OKOqhFPj4emtOxnTRZItCRbYE92Fkf1L+Bboe+Wvg
        SrbZ+CIkFOrCghMmWuIVdT/h0pt3pA==
X-Google-Smtp-Source: ABdhPJw2IVsRy1qcylsIEgJDPGvIMlFPrIHQgr9qNQXu3NhWSVtIWrdCs97oISksqqFQyrjbCnIsZw==
X-Received: by 2002:a17:902:8218:: with SMTP id x24mr7894288pln.150.1590741983196;
        Fri, 29 May 2020 01:46:23 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6417:1d6e:1408:1e13:b32e:6edf])
        by smtp.gmail.com with ESMTPSA id i29sm6950738pfk.38.2020.05.29.01.46.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 01:46:22 -0700 (PDT)
Date:   Fri, 29 May 2020 14:16:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Chris Lew <clew@codeaurora.org>
Cc:     davem@davemloft.net, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] net: qrtr: Allocate workqueue before kernel_bind
Message-ID: <20200529084613.GA23769@Mani-XPS-13-9360>
References: <1590707126-16957-1-git-send-email-clew@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590707126-16957-1-git-send-email-clew@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 04:05:26PM -0700, Chris Lew wrote:
> A null pointer dereference in qrtr_ns_data_ready() is seen if a client
> opens a qrtr socket before qrtr_ns_init() can bind to the control port.
> When the control port is bound, the ENETRESET error will be broadcasted
> and clients will close their sockets. This results in DEL_CLIENT
> packets being sent to the ns and qrtr_ns_data_ready() being called
> without the workqueue being allocated.
> 
> Allocate the workqueue before setting sk_data_ready and binding to the
> control port. This ensures that the work and workqueue structs are
> allocated and initialized before qrtr_ns_data_ready can be called.
> 
> Fixes: 0c2204a4ad71 ("net: qrtr: Migrate nameservice to kernel from userspace")
> Signed-off-by: Chris Lew <clew@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  net/qrtr/ns.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
> index e7d0fe3f4330..c5b3202a14ca 100644
> --- a/net/qrtr/ns.c
> +++ b/net/qrtr/ns.c
> @@ -712,6 +712,10 @@ void qrtr_ns_init(void)
>  		goto err_sock;
>  	}
>  
> +	qrtr_ns.workqueue = alloc_workqueue("qrtr_ns_handler", WQ_UNBOUND, 1);
> +	if (!qrtr_ns.workqueue)
> +		goto err_sock;
> +
>  	qrtr_ns.sock->sk->sk_data_ready = qrtr_ns_data_ready;
>  
>  	sq.sq_port = QRTR_PORT_CTRL;
> @@ -720,17 +724,13 @@ void qrtr_ns_init(void)
>  	ret = kernel_bind(qrtr_ns.sock, (struct sockaddr *)&sq, sizeof(sq));
>  	if (ret < 0) {
>  		pr_err("failed to bind to socket\n");
> -		goto err_sock;
> +		goto err_wq;
>  	}
>  
>  	qrtr_ns.bcast_sq.sq_family = AF_QIPCRTR;
>  	qrtr_ns.bcast_sq.sq_node = QRTR_NODE_BCAST;
>  	qrtr_ns.bcast_sq.sq_port = QRTR_PORT_CTRL;
>  
> -	qrtr_ns.workqueue = alloc_workqueue("qrtr_ns_handler", WQ_UNBOUND, 1);
> -	if (!qrtr_ns.workqueue)
> -		goto err_sock;
> -
>  	ret = say_hello(&qrtr_ns.bcast_sq);
>  	if (ret < 0)
>  		goto err_wq;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
