Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEF1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 14:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6214206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 14:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="fb2LMxB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgHXOxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 10:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgHXOxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 10:53:24 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43891C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 07:53:24 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id x69so7609621qkb.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3l1KJ9xV7Ihgw4DySoyFjywNiCcO94+hClVbk8PhJDY=;
        b=fb2LMxB4wNEiqGB/WKAEEee6AInA688gDAPnxIwA0puPxBbgFEpAhmWrqLIOLxwUqO
         piA7NwBR9xAQhwkmVzCPJ9G+Z2ImOQXCy2uTdCIV2UiN7cqDSLSqGHSaY3r+o7QHbFzb
         6UwKIJG8yIaKmIe8fDrLVsagZN8ztozhoVOOyiX9GRK7MeLb5iJ7cdsSoAhw10eJs3FA
         Zs/APyRP4Dxq4B7GHYEeHMbhsApSLIxTDULvAZGwzOIulbJQDZYZtEtonAEhN3GrQ+t+
         g3jJc1H5ehqin+cLHGaNku5jUhEwLMjHwICNqqVMkEQ+/iSiWNw/lImbU9DeQgGU/9OM
         MmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3l1KJ9xV7Ihgw4DySoyFjywNiCcO94+hClVbk8PhJDY=;
        b=PGF0gA06k57lWAZj3cSJf7mwA2jYkNmpd0I2wnqerx3w2XM75qjMQvy7RsEWTU+PdJ
         Q8OQDOSYHqG6ilNLFrW29/s5mqywjZSiOUKgJ5TObWI8KMze9dU/1GL9gsMdWRmMpZKI
         fTlzVK2U67i0twnzJBm1ymB4khCDkoBbS3vPMd8KwbliMeaHBtbqsYjQXUarBOHIaSD+
         nDVb0vNwoiaYYH+dhplUW43iBj9BPD6mTa6nWq/VrV2VS9FtgTnPOLeO/+yTGOnolaKu
         OSNMS3dYws7J5kbMrScoCt6AMdybDih2GAookXtE/mVI+F53huMGOTIdSrOXsv9ZADbL
         nF3w==
X-Gm-Message-State: AOAM530Z2Kd/qXyQXZW/99hFKRRyM+EL6EmGG+zlf+k4Ky1UVz+dwrcP
        InfE/EYRq23m+jBv55Y3jYet9w==
X-Google-Smtp-Source: ABdhPJygUsE4ZNlaDvJkGQu300bpD2xQkMX8JafenyVd3k4nAZAwUqU3DUvpGlvkZmw72SMxoOy2AA==
X-Received: by 2002:a37:8cc3:: with SMTP id o186mr5193554qkd.390.1598280800264;
        Mon, 24 Aug 2020 07:53:20 -0700 (PDT)
Received: from kudzu.us ([136.56.1.171])
        by smtp.gmail.com with ESMTPSA id f3sm2668691qth.56.2020.08.24.07.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 07:53:19 -0700 (PDT)
Date:   Mon, 24 Aug 2020 10:52:47 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Kaige Li <likaige@loongson.cn>
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND] NTB: hw: amd: fix an issue about leak system resources
Message-ID: <20200824145246.GB27238@kudzu.us>
References: <1597111197-28563-1-git-send-email-likaige@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597111197-28563-1-git-send-email-likaige@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 09:59:57AM +0800, Kaige Li wrote:
> The related system resources were not released when pci_set_dma_mask(),
> pci_set_consistent_dma_mask(), or pci_iomap() return error in the
> amd_ntb_init_pci() function. Add pci_release_regions() to fix it.
> 
> Signed-off-by: Kaige Li <likaige@loongson.cn>

Pulled into my ntb branch.  I added:
    Fixes: a1b3695820aa ("NTB: Add support for AMD PCI-Express Non-Transparent Bridge")

Thanks,
Jon

> ---
> 
> changed commit massage.
> 
>  drivers/ntb/hw/amd/ntb_hw_amd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index 88e1db6..71428d8 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -1203,6 +1203,7 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
>  
>  err_dma_mask:
>  	pci_clear_master(pdev);
> +	pci_release_regions(pdev);
>  err_pci_regions:
>  	pci_disable_device(pdev);
>  err_pci_enable:
> -- 
> 2.1.0
> 
