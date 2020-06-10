Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3980AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071722064C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BptUjTfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgFJHqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgFJHqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:46:45 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE93C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:46:45 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x6so1050561wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Awbgv42OMXGb6ctOD7E4FBtvK9ls7UGron4i9/J0u1w=;
        b=BptUjTfvTvB5LiiymmCDDSbS8OMNpZTb6zRCZtjzKJEyulu4PyOPyHpvfNYbD0fJBa
         SKgfne31eOEXdfN1GV/veMWiYl+cHbGK8Hy8oNUN54Br2HERl4B9nZMtawM3IBLcyWWy
         BuLB2yDdUkPCWL4zHD5C9x8YJjIQid97OrN/bIUPE6TUFaDCeYRc1RdQr3H+W3FW3St8
         SUGpW0OxDcSSLIdiBmUW6Nx4DZzrKTs4VDbxzBCEk59zUIFLD+Pv+PLA4g+8HuCFs21/
         QsauO9rl/YnIBk1eqhThpNCidjlBQVC7rV0oB614eZ+QEtCdI3JIbQCauFQIm4mfXoQV
         WcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Awbgv42OMXGb6ctOD7E4FBtvK9ls7UGron4i9/J0u1w=;
        b=EpELcFSC2AFb/dm40vkvVUM32mC8ZUWT8Tk0Bv3uRM15H4eT1fjX6W9XgxIpQmbHez
         K/On2z1OybWZChHxE8YgOILqLjTXl5efSmaM+zizCMqa/3D8vbicF6yDCDvi62Ffcy1i
         GG85O6l8dC4DDgxVIM+7t/6D2xSQHnaIc7VuE+nbiD2EMtZtedAZrE09bf/7DF7JJ8dB
         OqlZugrUeHenwEkmpV4Rmpg4XgaeDttoJfuxSHw8audgvE3u/DxTuZdHXKLuxKPRmhwM
         Km8vZPcx8BXRgG7ZHlyaguN+0i52oUoe1s1UaZJ3J5sv4i2K1NsSdAMekyScRrzezfhx
         E6nA==
X-Gm-Message-State: AOAM531KlWjxW00V0MNeez6pUrWoGVy2KHdFxATfd4mWaAJNDaA/DI8z
        ZU8EdMaAcbJYxgTCqX07yFUDfA==
X-Google-Smtp-Source: ABdhPJzkV9QPPpMLfpxD7CIlFFiHZCG/SnoIDk6DQokkgAFu5bO6biRCrF7dhJ/EXug3tzFjbGxgqg==
X-Received: by 2002:adf:f4d2:: with SMTP id h18mr2129295wrp.370.1591775204095;
        Wed, 10 Jun 2020 00:46:44 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d5sm6908771wrb.14.2020.06.10.00.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 00:46:43 -0700 (PDT)
Date:   Wed, 10 Jun 2020 09:46:33 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, kenneth-lee-2012@foxmail.com,
        Wangzhou <wangzhou1@hisilicon.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PCI: Remove End-End TLP as PASID dependency
Message-ID: <20200610074633.GA6844@myrica>
References: <1591762694-9131-1-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591762694-9131-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 12:18:14PM +0800, Zhangfei Gao wrote:
> Some platform devices appear as PCI and have PCI cfg space,
> but are actually on the AMBA bus.
> They can support PASID via smmu stall feature, but does not
> support tlp since they are not real pci devices.
> So remove tlp as a PASID dependency.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/pci/ats.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 390e92f..8e31278 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -344,9 +344,6 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>  	if (WARN_ON(pdev->pasid_enabled))
>  		return -EBUSY;
>  
> -	if (!pdev->eetlp_prefix_path)
> -		return -EINVAL;
> -

This check is useful, and follows the PCI specification (4.0r1.0
2.2.10.2 End-End TLP Prefix Processing: "Software should ensure that TLPs
containing End-End TLP Prefixes are not sent to components that do not
support them.")

Why not set the eetlp_prefix_path bit from a PCI quirk?  Unlike the stall
problem from the other thread, this one looks like a simple design mistake
that can be fixed easily in future iterations of the platform: just set
the "End-End TLP Prefix Supported" bit in the Device Capability 2 Register
of all bridges.

Thanks,
Jean
