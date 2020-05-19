Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A4CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D27CF20674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Xhbw9rpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgESXrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 19:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgESXrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 19:47:14 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695E0C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 16:47:14 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id z9so500034qvi.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 16:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hab13sCBMoSFVDNe53Te5/um8u7Dvom/Oq5qeGy6LQM=;
        b=Xhbw9rpuCFAsoXsARVsCZK+5mFgLakvRnkIHpbr4LPiEzmvAFLyiDyxRbU9Mkl9Tfe
         73zROnHsRIGAQKxAXv5vA2bB+Mqm5m394G9/J23BDf/8WQGTOp/6wcKBy2SoClf1hE8n
         CPJmIWUcNVVNK/QO/oUQckvWaQSs6cD3J+zf0ZvwZYNAAWHINHg4rKH8Ts6JpZVdQwET
         dXiDnk2XP5PdM5lfJJldFqF3lgi12EFFkLAnQ4YVU0wRmjSr8MeUAgohtdLObAbCPMtL
         fE28dcJgqERVB0truvko/CaxypXZzlRj+adKyQniVXkcKDWfHG7e52W70g1ZGmN6Ju8l
         Evxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hab13sCBMoSFVDNe53Te5/um8u7Dvom/Oq5qeGy6LQM=;
        b=WDz7OgPzp09w4tILhEsy4YVDjJTYOJH+yqABd31CXa+1+lX/kYex2717q/B7A9IDzk
         E3POG3Isd0k7j9zVbIvPjCIRuCOe5RJTzCaBJRFwXYfvwCXlkBS/cLqosdmfkAVq86Y/
         wTrF+K/CDcXaZomzqIekaYzfxyYUr99kOu82ZI39GoFxcX4yb5KA5c1+RH8ql2DZSWUq
         zKWlwyKjFnOWy+WjP756i2ZO3O8cjybfWfl0e4Om2wlDpw1kSoq7UoLXDvYiC3EPySxf
         q0E9dkm4ZzV9qCPJLpgnjWacLVBCOgYUMMW9mqCYUDmmWSY+toe0evhQv0V2I66m+wzf
         ZLYQ==
X-Gm-Message-State: AOAM530eOMH5lKcPdqDGRA8xtAHDpza/JULIFmLYZI+h4rXpUXemsJ8h
        EU68io+3wOC45MBeNTczvQLe20PcFn4=
X-Google-Smtp-Source: ABdhPJzpAvhAglbfwjvqzAhBMICKgBROUjygpu/1kcwuj3g1+1V47CU1Z7d97GhpLB+Zon5+2NymcQ==
X-Received: by 2002:a0c:a619:: with SMTP id s25mr2273937qva.21.1589932033719;
        Tue, 19 May 2020 16:47:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id q2sm845022qkn.116.2020.05.19.16.47.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 16:47:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbBx2-00081J-VC; Tue, 19 May 2020 20:47:12 -0300
Date:   Tue, 19 May 2020 20:47:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH v2] RDMA/rtrs: client: Fix function return on success
Message-ID: <20200519234712.GE30609@ziepe.ca>
References: <20200519163612.GA6043@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519163612.GA6043@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:36:12AM -0500, Gustavo A. R. Silva wrote:
> Remove the if-statement and return the value contained in _err_,
> unconditionally.
> 
> Addresses-Coverity-ID: 1493753 ("Identical code for different branches")
> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
> Changes in v2:
>  - Return err, unconditionally. As suggested by Bart Van Assche.
>    Thanks, Bart.

Applied to for-next, thanks

Jason
