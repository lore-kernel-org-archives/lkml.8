Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72B0C2D0EC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFA7206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xN/aZFC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgCZFmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 01:42:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41746 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgCZFmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 01:42:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id z65so2229349pfz.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 22:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lJBGxRctjvtRkYzCqhBiWXNr6fl3LKIu3bPffT4P37Q=;
        b=xN/aZFC3ywkctbct64T9SINp67QHK9DwBCHBXcBs0FP40E5s+s9fCTok4tvNQCqDE+
         L0HFx9UYuKYsHC5iz5cIrIYQCB/b9ETHQmgipbTr9oUNgSA/215Y3WoY6y+Uz92fPbSe
         XrBwg14hsA3gUwlFIJub6Ocyn/qadeRov99TL3mNE3jLPT0wo1gaXP0XskUvd+pCmrvW
         Tv4s9ChbrZ77NxWYJhGUQkbU+8kkUKJ0TleFtzpqxx7sEGDldoLR0V34KZlW2deIaF6k
         01wKAVnPQC0gM161neggvyqFe7HM28zTxM1mwd/YDCy4CsVV1MCJ943ffx9E4NNb1ZUC
         cn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lJBGxRctjvtRkYzCqhBiWXNr6fl3LKIu3bPffT4P37Q=;
        b=HBzMy1FnzqRGwovT72cZYR9v4/tx4JZ++94xHx9xIMueSeVPktfaLIa4GRSkZVOK8Z
         K37NSOEmadcQGMnXJSYkMq+Lyztp7mltUYYUdq1phxobr/vQ81xdNn6jxqVqxPPGyR4i
         vJ3TGqc9gH4IBoLkE62044XJODGQyfGMWlOlEIIm7t9eVPDWrXRoOgUBfSFdtnTn5Hdy
         DtHZVyUwvuvOaFMxFuT+460LWc/PNjOiJz2zqZ5Lxq+k5/ihRUE3GUGdYsaqKqW0eE5v
         TznwG+nbQI0DsyLA9ZaKBgs9wAovlgbAmsCYXSO5z/5eoHq6NArLOoDoIifSGYhGDhIY
         1v7g==
X-Gm-Message-State: ANhLgQ0o2cv9nY+mkK3rY8uvabUUFVXZ2R8CbxY/xLy4X3Lgyopd+TWV
        TedkVPm675Pskn0ZkzwFAMg7Nu9L/yQ=
X-Google-Smtp-Source: ADFU+vv9QFRgclZ54bBY7BJnL7ZL1CHe2/kxdDOsKldUA/e7jUAzRpU6ZAtzDKz3uD4UzX/kxliB3w==
X-Received: by 2002:a63:602:: with SMTP id 2mr6651318pgg.356.1585201357185;
        Wed, 25 Mar 2020 22:42:37 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y9sm751518pfo.135.2020.03.25.22.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 22:42:36 -0700 (PDT)
Date:   Wed, 25 Mar 2020 22:42:34 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] remoteproc: use a local copy for the name field
Message-ID: <20200326054234.GA59436@builder>
References: <20200324201819.23095-1-s-anna@ti.com>
 <20200324201819.23095-3-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324201819.23095-3-s-anna@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24 Mar 13:18 PDT 2020, Suman Anna wrote:

> The current name field used in the remoteproc structure is simply
> a pointer to a name field supplied during the rproc_alloc() call.
> The pointer passed in by remoteproc drivers during registration is
> typically a dev_name pointer, but it is possible that the pointer
> will no longer remain valid if the devices themselves were created
> at runtime like in the case of of_platform_populate(), and were
> deleted upon any failures within the respective remoteproc driver
> probe function.
> 
> So, allocate and maintain a local copy for this name field to
> keep it agnostic of the logic used in the remoteproc drivers.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 9 ++++++++-
>  include/linux/remoteproc.h           | 2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index aca6d022901a..6e0b91fa6f11 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1989,6 +1989,7 @@ static void rproc_type_release(struct device *dev)
>  
>  	kfree(rproc->firmware);
>  	kfree(rproc->ops);
> +	kfree(rproc->name);
>  	kfree(rproc);
>  }
>  
> @@ -2061,7 +2062,13 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  	}
>  
>  	rproc->firmware = p;
> -	rproc->name = name;
> +	rproc->name = kstrdup(name, GFP_KERNEL);

Let's use kstrdup_const() instead here (and kfree_const() instead of
kfree()), so that the cases where we are passed a constant we won't
create a duplicate on the heap.

And the "name" in struct rproc can remain const.

> +	if (!rproc->name) {
> +		kfree(p);
> +		kfree(rproc->ops);
> +		kfree(rproc);
> +		return NULL;

Perhaps we can rearrange the hunks here slightly and get to a point
where we can rely on the release function earlier?

Regards,
Bjorn

> +	}
>  	rproc->priv = &rproc[1];
>  	rproc->auto_boot = true;
>  	rproc->elf_class = ELFCLASS32;
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index ddce7a7775d1..77788a4bb94e 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -490,7 +490,7 @@ struct rproc_dump_segment {
>  struct rproc {
>  	struct list_head node;
>  	struct iommu_domain *domain;
> -	const char *name;
> +	char *name;
>  	char *firmware;
>  	void *priv;
>  	struct rproc_ops *ops;
> -- 
> 2.23.0
> 
