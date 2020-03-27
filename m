Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7CDC2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD8F20714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LA9Fq6az"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgC0Ip6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:45:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50797 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgC0Ip5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:45:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id d198so10589148wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 01:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TNtHMrBw1/kFRLyWRQzpEzTGkiODbvLoqCcIATUetSQ=;
        b=LA9Fq6azF2+zSralszTxVY7JqxhxxsiaZb2AoDbfkRN0R3N0rkQgFTS6aGvtGchHSq
         rGvKFw+0Zf8fHrmkahk4/6T3g1thDq3mnNR/aO4WyAvZYh3EhZOwiAs8p3je9NR8FqeH
         eugcdMHplFlkKr3XiGbHLTK0T3hIfOEt+M/NTlQcdTGw8Rk0VoMHKlmiiWpqbHbPcwXo
         /ZOo3it+BOseqw84us4p+ubVuYX1XIJtpj38y1kZV/AK6AlqlYX+UUjX4wUuMn0B1uTO
         jAxY7u+cIYL8ahbK3hSj8z04XrUqEAxtSPl8sMDrkuj2AVpubAi9PzGk62rHm7z/KdgE
         QErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TNtHMrBw1/kFRLyWRQzpEzTGkiODbvLoqCcIATUetSQ=;
        b=uVUL7ixFteWHnx43Gd1U/OQGing8CS4yvefRtXp23/snB1bBAYNrxRHmOP+a1tT5av
         EnDO5YydXftqZ0s1VG131rOh88N3eWczz1Ppcn1KeWBCKVSj1GXH66Xns67PGUS9IZ7+
         UbFATKiWk/C8gv8G/xOMnXmLm7sB0iuV05beFcys7/i7yImSPjfiLQ0R1bZKOg7E5uNi
         3e3Bio0I8kodw0yN8F/Zh2OHWH+ZLX1cRduAVCPP8Bg9q59cJ8K+O3uO9UOyel7uRNvr
         PBVpHHzVJ2Gk1u+cFGaaPJ6QI0w01D9upIqOtrv2sat7Wq3Na7uzRHh7olX71royaKPY
         E7ew==
X-Gm-Message-State: ANhLgQ3bZLalznk+K6h1dDKWAIzEdkQnTPAtXgtRvaAY9pRkfLDHQJY/
        tPfMrQQA3EG7+ZOp9V1YcB+xwA==
X-Google-Smtp-Source: ADFU+vsEaMqgmcJTryYU53r8BbWXb0EA3wBlWHalOBre6t/JUxmyfZ0AnP1+VitjwwucuGEimHxOZQ==
X-Received: by 2002:a1c:4987:: with SMTP id w129mr4498312wma.168.1585298755090;
        Fri, 27 Mar 2020 01:45:55 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y187sm7437237wmd.0.2020.03.27.01.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 01:45:54 -0700 (PDT)
Date:   Fri, 27 Mar 2020 09:45:46 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v4 02/16] ACPI/IORT: Remove direct access of
 dev->iommu_fwspec
Message-ID: <20200327084546.GA4083132@myrica>
References: <20200326150841.10083-1-joro@8bytes.org>
 <20200326150841.10083-3-joro@8bytes.org>
 <82dea1be-4a2e-e914-c607-8aeb924eb36f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82dea1be-4a2e-e914-c607-8aeb924eb36f@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 11:30:53AM +0800, Hanjun Guo wrote:
> On 2020/3/26 23:08, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> > 
> > Use the accessor functions instead of directly dereferencing
> > dev->iommu_fwspec.
> > 
> > Tested-by: Hanjun Guo <guohanjun@huawei.com>
> > Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Joerg Roedel <jroedel@suse.de>
> > ---
> >  drivers/acpi/arm64/iort.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index ed3d2d1a7ae9..7d04424189df 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -1015,6 +1015,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
> >  		return ops;
> >  
> >  	if (dev_is_pci(dev)) {
> > +		struct iommu_fwspec *fwspec;
> >  		struct pci_bus *bus = to_pci_dev(dev)->bus;
> >  		struct iort_pci_alias_info info = { .dev = dev };
> >  
> > @@ -1027,8 +1028,9 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
> >  		err = pci_for_each_dma_alias(to_pci_dev(dev),
> >  					     iort_pci_iommu_init, &info);
> 
> ...
> 
> >  
> > -		if (!err && iort_pci_rc_supports_ats(node))
> > -			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
> > +		fwspec = dev_iommu_fwspec_get(dev);
> > +		if (fwspec && iort_pci_rc_supports_ats(node))
> 
> Should we check !err as well?

No need, the check should have been on fwspec from the beginning. Checking
err was just a lazy shortcut on my part, as we're really just making sure
that we can dereference fwspec->flags here.

Thanks,
Jean

> 
> Thanks
> Hanjun
> 
> > +			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
> >  	} else {
> >  		int i = 0;
> >  
> > 
> 
