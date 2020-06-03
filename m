Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E3FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 316A22053B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfLRQVaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgFCRqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgFCRqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:46:18 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F96C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 10:46:18 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id k4so1033641oik.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tLGib8QhKZA9YKCvMvFgf4hACvnUS23mYEOPh4jekmw=;
        b=YfLRQVawNCEoOkg4sLOUqrByMY6fMm8V3qqeZu75VC+iV/MWnaMHM1KFxi5BdjMG3n
         wbewxE1y0hv52bn9Ob+e5fhmEl/unMckUBuEtP2Sc7MqAtZVrTKfvfISFz8rsro2AOoz
         0DpqBrMNrBSTXHb9yxiGzF8gaZTfW5n+93HRhryjy8cxCA5I6KyN3AW84gXxbRya5GXV
         1d3XHdjzEDxt4GkNHP0B+VaSWs+UAK/nx2V9k6wUG3D8NUgwGaWrxvKqb95oz01Ouyvc
         /AEgNlU8QMHbZnHkh7tk/bzpCZTHXNam3lLGnigY31AKMuO6mV0RtgerZUrnsuU6Urfd
         6kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tLGib8QhKZA9YKCvMvFgf4hACvnUS23mYEOPh4jekmw=;
        b=C/TOSgxC9NifS9RETGNHsQ7WBbnLWisb1tPSAM6gQCdcVpdTFTLLi8/yZSm7I6Sojt
         w6Og8tYdtinC2JsyHlMq9jiQjcEIlXHkJzlMleGV0Dg3E8R2Ue75JZwGYof/y2DUGNs0
         yjOGn2sQZ5gL2QbZICmiueFwFJXl3d4zDT26zvx/GPPh/BCBe5O4X7ON3XldJG5oDAIG
         FVARqMlpm1biOdLYwcafDrvkMChSLpMpVia4f1agOn3kMJFXr+f5j/p1j6c2S9U7SGPZ
         t+7MJDjFaYBTzzqLxU0JP0tbLSaE0XR79VRXF/mpjBtLXoJc7k7oaFVpfne4nyjuLEvy
         GAow==
X-Gm-Message-State: AOAM533ensfYc4B2XRJFe1X+A/e02x/Ya/6jlIVy6HxWelKsCX1WUmMN
        wVG+W/hwET+qJzNO+ScYKNY=
X-Google-Smtp-Source: ABdhPJxy8Zf2XsCDO1575uUEMLKxENOKfiuERqjT0h4VKr09t1jPb69kq9KkdZnXM6uw+4YtyYZRSQ==
X-Received: by 2002:aca:dfc1:: with SMTP id w184mr580117oig.113.1591206377881;
        Wed, 03 Jun 2020 10:46:17 -0700 (PDT)
Received: from ?IPv6:2606:b400:2001:91:8000::763? ([137.254.7.173])
        by smtp.gmail.com with ESMTPSA id s18sm747255oie.36.2020.06.03.10.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 10:46:16 -0700 (PDT)
Subject: Re: [PATCH] nvme-fc: Only call nvme_cleanup_cmd() for normal
 operations
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
        linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>
References: <20200529113740.31269-1-dwagner@suse.de>
From:   Himanshu Madhani <hmadhani2024@gmail.com>
Message-ID: <d4f5a66a-01d3-191e-231d-0aa7cc03d61c@gmail.com>
Date:   Wed, 3 Jun 2020 12:46:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529113740.31269-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/29/20 6:37 AM, Daniel Wagner wrote:
> Asynchronous event notifications do not have an request
> associated. When fcp_io() fails we unconditionally call
> nvme_cleanup_cmd() which leads to a crash.
>
> Fixes: 16686f3a6c3c ("nvme: move common call to nvme_cleanup_cmd to core layer")
> Cc: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 7dfc4a2ecf1e..287a3e8ea317 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2300,10 +2300,11 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
>   		opstate = atomic_xchg(&op->state, FCPOP_STATE_COMPLETE);
>   		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
>   
> -		if (!(op->flags & FCOP_FLAGS_AEN))
> +		if (!(op->flags & FCOP_FLAGS_AEN)) {
>   			nvme_fc_unmap_data(ctrl, op->rq, op);
> +			nvme_cleanup_cmd(op->rq);
> +		}
>   
> -		nvme_cleanup_cmd(op->rq);
>   		nvme_fc_ctrl_put(ctrl);
>   
>   		if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE &&

Reviewed-by: Himanshu Madhani <hmadhani2024@gmail.com>

