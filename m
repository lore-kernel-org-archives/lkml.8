Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CD4C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BC520663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w84O1QQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbgCPPkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:40:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38532 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbgCPPkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:40:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id s1so91756wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 08:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vJQ7s9x85ia8HxlMYprwaZJGn4L6RP+BR7+jWVKPLTo=;
        b=w84O1QQJwU6wMTGEhyd3tdZmzyokkNQNgtvlgCbk7JrgRg0w2R3EtdUzes5TKo/XyE
         0GN9BzerCd+PBe2gdX+VVWalWV0GvUaZ1Hvpn02xC7Z6cQbZ9zUYoVR8SlrMkeTHa5pO
         ZNV7G4zwVtMQAtwNFVsP7G9rAugODJUvegfg+Joz2/pLSwTVFLeBdLC69Mm9fmsFaT0H
         4lQ985eQTWmn73BDP/WhhWDXVBZBfC45ZHQLQxe35G5uOfpUGYH7dFLUTw7I6qKsVqm6
         VCf79+8VBzgdX46YQ4mkH13lYwMdQrGC6Ai/EhOinV88dF/tVd63mOiTbTus//PTo1AD
         eHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vJQ7s9x85ia8HxlMYprwaZJGn4L6RP+BR7+jWVKPLTo=;
        b=mU1KArjaLdF/I0V4dFaLCWv3hUhi9KAbqXifL86HKoYUwBfmKF38qsn226MGkq/FMG
         00VW7igsYthEVJM+NCVqEk6wEY6nwfz7ZwOxAcaYGlzZxvgW5iq7sigLEIj19akPYesF
         yF6LLsOeSf0XenLa3v7aZnDddYbKmS7Pj+Lh0WufyBCNMZKJ/CZ/QwMp52DCbOR6KBcF
         evOYSYf4d1oKdPrqhSGvi/WaHPNuBM9HN4o0Pmlkmm5Pi+Iagv2MMKi9/i8nEy5uWr+i
         QRHnRviuhN9ZCFD4K7UUcK4JT9nE7HdNnnb1/eZXCknCZ9QhPcIvOCpM0AJHBfOudyCz
         XIiw==
X-Gm-Message-State: ANhLgQ2bzUv7eKOa5dbO755jAhG4yZHeTm1YFTYtlfnUj0Vub4kf3PFK
        wfVitVF1+im5Y0j6bHNJUQDaJg==
X-Google-Smtp-Source: ADFU+vu5RlEmmjxd74oFX3RvJEdQFPOMmKqi/N4OkXyJVDSx1NxqeLTrLEHwet7QRQD2B1qytUrz8w==
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr29213545wrs.119.1584373212032;
        Mon, 16 Mar 2020 08:40:12 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id u17sm393519wrm.43.2020.03.16.08.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:40:11 -0700 (PDT)
Date:   Mon, 16 Mar 2020 16:40:03 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 02/15] ACPI/IORT: Remove direct access of
 dev->iommu_fwspec
Message-ID: <20200316154003.GC304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-3-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-3-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 10:12:16AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Use the accessor functions instead of directly dereferencing
> dev->iommu_fwspec.
> 
> Tested-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/acpi/arm64/iort.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index ed3d2d1a7ae9..7d04424189df 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1015,6 +1015,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>  		return ops;
>  
>  	if (dev_is_pci(dev)) {
> +		struct iommu_fwspec *fwspec;
>  		struct pci_bus *bus = to_pci_dev(dev)->bus;
>  		struct iort_pci_alias_info info = { .dev = dev };
>  
> @@ -1027,8 +1028,9 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>  		err = pci_for_each_dma_alias(to_pci_dev(dev),
>  					     iort_pci_iommu_init, &info);
>  
> -		if (!err && iort_pci_rc_supports_ats(node))
> -			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
> +		fwspec = dev_iommu_fwspec_get(dev);
> +		if (fwspec && iort_pci_rc_supports_ats(node))
> +			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
>  	} else {
>  		int i = 0;
>  
> -- 
> 2.17.1
> 
