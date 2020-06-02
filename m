Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C91C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B76720738
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h0KmI4cA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgFBQaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBQaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:30:30 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BA6C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 09:30:29 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d128so3803309wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 09:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Sanqk8e2p1ErNKdaUjhTIbGYw6FSAhJELz2qKyaSoVQ=;
        b=h0KmI4cAXFJrBHFEVbvzqxeIfq6MnHMYRrAGlIgNVeUqH1PO2UBdYlyNdyjKp3gDGU
         C4sGrNvcI6Ur/GprXem6tyiU0ZaFelQ8A2X2/b3P7JId4ENq99SAZTS2riyf2Jq0IzAL
         1AMwFDEK0KHZWqhAAEa26ly2YJBidfpouQMWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Sanqk8e2p1ErNKdaUjhTIbGYw6FSAhJELz2qKyaSoVQ=;
        b=Zv51ejISqklTPtLOGEM8ntKzPpbuqJ8Xv3m1v6LgJnxVmZWlFgoN9BgJe/XAGeRaoG
         m0ZL9BA49V8NT1RO9tR16IxVflqC7SkIhEkJRrjjW6x4foDreY+Q19lXhLmHRnUzClxn
         CC94q0u7EaTUD8+Hi9mf2YCdGzAx5WqX8JPiWcvJmCUl5faLyvxePsA3gXl6+8fbe/UX
         p2xQ81vZFfCcwe3H03gx5JPfXoKyGf1ZEXYyx4H16DGhIPMznDb8hQC+MsEnftE2e31U
         M3bFR5RHqaFQEK7nyRFg8T38Q0Y4tkgSvAVnxZbqw8q4Ah/ET1UJygE/pSFTX75irLam
         871Q==
X-Gm-Message-State: AOAM531r7Fhh/n0O7hehp4JbXjbqK5qS3DjfZF8xz1alaqSlEAvC3PdV
        P+y4JWiyrvTI52Z7ogN7qODooA==
X-Google-Smtp-Source: ABdhPJzpbdXn9V9FFlq6T0pPI8ZbQRoBqMYB6C87dCYT1Ejucy9FSmK3+swUNUpWBdtOmMCOpA7/ew==
X-Received: by 2002:a1c:a905:: with SMTP id s5mr4734280wme.120.1591115428316;
        Tue, 02 Jun 2020 09:30:28 -0700 (PDT)
Received: from [192.168.1.237] (ip68-5-85-189.oc.oc.cox.net. [68.5.85.189])
        by smtp.gmail.com with ESMTPSA id a16sm4689495wrx.8.2020.06.02.09.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 09:30:27 -0700 (PDT)
Subject: Re: [PATCH] nvme-fc: Only call nvme_cleanup_cmd() for normal
 operations
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>
References: <20200529113740.31269-1-dwagner@suse.de>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <673ed6fc-e0fd-db71-67e5-b0d5e6007397@broadcom.com>
Date:   Tue, 2 Jun 2020 09:30:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200529113740.31269-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/29/2020 4:37 AM, Daniel Wagner wrote:
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

Reviewed-by:  James Smart  <james.smart@broadcom.com>

-- james

