Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5966C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 03:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96279206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 03:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pensando.io header.i=@pensando.io header.b="vv3C+gcD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgHJDyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 23:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgHJDyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 23:54:22 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F17C061786
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 20:54:22 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mt12so4092119pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 20:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=84bq2eVZP/J9K+NjLEUCnEVIr+p4XUgWluN/PDileB4=;
        b=vv3C+gcDGVxjL/s4FaN5isodWCPVa8ltSCmng0R1vzhJYMgFGPNIc8ZUDDKJEN51GB
         diSghQx1h5aFjxCPXWTdyoZuFkWsdNSjUfubK2eHswpfoJ6Z5DnWLYmfQrPWMCsBRFUZ
         4zVrKAUc05rLzbLxp8b9Aop/f7UHEPebEtqgK5HGQHnvr1kLKAJdFdblVeYnpPKnEr5n
         IKJr8nhLBglgjuVbKNFTDy2Ehe3ES2iWTTpNSPNZp5NqLQdEsx8W6bjLMG4ZX+ndAYxF
         7gCfW+10eQtsSUhWVgzR/Y1iJyvu7/nhibTpBpFIBZO3KCy4ex4ZWStSyMNsOMxfjH4j
         nL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=84bq2eVZP/J9K+NjLEUCnEVIr+p4XUgWluN/PDileB4=;
        b=fa7V2Dt7IxR500hD4Zqs0iZ2VQpzc3BAmnhPygFMWASqPrSi7uW3RY6+8xfAJz6T+e
         OsOlwRS05KkDn7IlR1hmwdYXqSWDNZXbav8m6Yg3LX150OOeq13h00l7VBW2HCR2PoG1
         /vnxRMPrTCpOMEXhNClG93+0uy+mTECRJSGLaqvs4XZ9Cb0gLOUpDlqdd8TmHh+dpr90
         1cyUoyCE4gw5RRJ9VtEA9Z0ikKIocbjdXJ7QUQXHEPFkHJ6cAHwCRKbs9pyw4fAwRMyz
         eyG8ab24y8bpl6rYCqCCzZyuTO23K3RrwNQpyy9w+dOL57sUmFl/cOzf6xfrtsVF00a8
         M2fA==
X-Gm-Message-State: AOAM5321bKuNYCiY0OQ38y/T0r3oCharToZ+N2k00cfEt9n0cyvfokas
        JwS2TvyUz0oePEPnGU9cVosOmnUKbGs=
X-Google-Smtp-Source: ABdhPJwkIR0u5UepQG55u7CmLUqGO482EeNRPSOsTEmnouAeI0ONH5yHYPcwX3LcSsSBiBcbGjk+/w==
X-Received: by 2002:a17:90a:e986:: with SMTP id v6mr26536533pjy.88.1597031661180;
        Sun, 09 Aug 2020 20:54:21 -0700 (PDT)
Received: from Shannons-MacBook-Pro.local (static-50-53-47-17.bvtn.or.frontiernet.net. [50.53.47.17])
        by smtp.gmail.com with ESMTPSA id mp3sm55496383pjb.0.2020.08.09.20.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2020 20:54:20 -0700 (PDT)
Subject: Re: [PATCH] ionic_lif: Use devm_kcalloc() in ionic_qcq_alloc()
To:     Xu Wang <vulab@iscas.ac.cn>, drivers@pensando.io,
        davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200810023807.9260-1-vulab@iscas.ac.cn>
From:   Shannon Nelson <snelson@pensando.io>
Message-ID: <c897238f-c0c9-a2b2-d3ae-c04012e976de@pensando.io>
Date:   Sun, 9 Aug 2020 20:54:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810023807.9260-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/20 7:38 PM, Xu Wang wrote:
> A multiplication for the size determination of a memory allocation
> indicated that an array data structure should be processed.
> Thus use the corresponding function "devm_kcalloc".
>
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Acked-by: Shannon Nelson <snelson@pensando.io>

> ---
>   drivers/net/ethernet/pensando/ionic/ionic_lif.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 1944bf5264db..26988ad7ec97 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -412,7 +412,7 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
>   
>   	new->flags = flags;
>   
> -	new->q.info = devm_kzalloc(dev, sizeof(*new->q.info) * num_descs,
> +	new->q.info = devm_kcalloc(dev, num_descs, sizeof(*new->q.info),
>   				   GFP_KERNEL);
>   	if (!new->q.info) {
>   		netdev_err(lif->netdev, "Cannot allocate queue info\n");
> @@ -462,7 +462,7 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
>   		new->intr.index = IONIC_INTR_INDEX_NOT_ASSIGNED;
>   	}
>   
> -	new->cq.info = devm_kzalloc(dev, sizeof(*new->cq.info) * num_descs,
> +	new->cq.info = devm_kcalloc(dev, num_descs, sizeof(*new->cq.info),
>   				    GFP_KERNEL);
>   	if (!new->cq.info) {
>   		netdev_err(lif->netdev, "Cannot allocate completion queue info\n");

