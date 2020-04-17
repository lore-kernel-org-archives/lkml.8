Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C65C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 01:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8345E20776
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 01:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="FrdtkA3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgDQBDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 21:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728454AbgDQBDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 21:03:46 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FD7C061A41
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 18:03:44 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g2so326951plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 18:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ZL5DKQEN5tIRYMA9bsAF7qYyxlNKGNuVSjiADQ9SPk=;
        b=FrdtkA3N/A0B10cQBR1BRxqf+/pg1uBkd6DO7lHtdKgOqGpk1/7USrxTk4rdlzJ0Pn
         oQGe7ba6HSEplsOy6ec3K4H8Fpx1j9/0meJ+gk7xvdUqFq7CDtsNxsMJzjX3kGdDbbz8
         GCSySEUU8oXzqHDM2sby4knjcPLSSaIgNvaO9PtWZWWefGILL8HPrNXdIlKHYq2YILWZ
         AMHiZb/IAXXMBCtRYZZ2S6R7t7InyUg113cLru837l9P5It247de3hDzpXYYYkdzsiNW
         l3eKB2Wxab5vn9CTNWz5BkklF52xIUVdN24g+AL8C9OhFHLjLh5Ls1ropaQnpLD31b3o
         DqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ZL5DKQEN5tIRYMA9bsAF7qYyxlNKGNuVSjiADQ9SPk=;
        b=USOjXq/YVeflxnI35LnHPAOjw+/S+1Hgt6Q/FJgKpqbeiSZqsoAHT0YEjb/QmALm2w
         YLsjMndxJwMiLZq2uQdY0Q8TjueyVV+v9q0ZqzNncN1FSuWAJdvSZz3GEs7jMYjCIpJh
         yhuzjS88xy4TvQuUvr5xgVapWzw0XrXDWRFRwkpv2gzUY4EleXW60kG94Jvfp8DOZKud
         3UITuyvxm+CCv/IkF93OJNxdFOaG2aMliQNSqDDvvMAAb4yxWKarcGnScNDA2xJnC6rj
         0byUBkwjGQH1lUFWUy5YGKXCBdRqWNCdIEE14nySQrQ010arwqQHoiQrcTmmFZ7kOt14
         uPHw==
X-Gm-Message-State: AGi0PuZ1oiuHNoPLCi9LZHWKvLtY3XK8uSKuQePZK0Y4AOb+UrfmMAIp
        Yew/OEcGXz7Zoy3kh6I9alnktw==
X-Google-Smtp-Source: APiQypKfJXVVs8nt0ABNaLviRVVB2FF8oWh5BJ43V1JXuqqLWnC3nHs+J6exlmUfG8/Dws2LqNNTtg==
X-Received: by 2002:a17:902:fe09:: with SMTP id g9mr366208plj.171.1587085424144;
        Thu, 16 Apr 2020 18:03:44 -0700 (PDT)
Received: from limbo.local (host-160.218-14-119.dynamic.totalbb.net.tw. [119.14.218.160])
        by smtp.gmail.com with ESMTPSA id u8sm16518026pgl.19.2020.04.16.18.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 18:03:43 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     joro@8bytes.org
Cc:     agross@kernel.org, baolu.lu@linux.intel.com,
        bjorn.andersson@linaro.org, dwmw2@infradead.org,
        gerald.schaefer@de.ibm.com, heiko@sntech.de,
        iommu@lists.linux-foundation.org, jean-philippe@linaro.org,
        jonathanh@nvidia.com, kgene@kernel.org, krzk@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        m.szyprowski@samsung.com, matthias.bgg@gmail.com,
        robdclark@gmail.com, robin.murphy@arm.com,
        thierry.reding@gmail.com,
        virtualization@lists.linux-foundation.org, will@kernel.org,
        jonathan.derrick@intel.com
Subject: Re: [PATCH v2 00/33] iommu: Move iommu_group setup to IOMMU core code
Date:   Fri, 17 Apr 2020 09:03:35 +0800
Message-Id: <20200417010335.31739-1-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414131542.25608-1-joro@8bytes.org>
References: <20200414131542.25608-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

> Hi,
> 
> here is the second version of this patch-set. The first version with
> some more introductory text can be found here:
> 
> 	https://lore.kernel.org/lkml/20200407183742.4344-1-joro@8bytes.org/

Thanks for the continued improvements in this area!

I may have spotted a problem with setups like VMD.

The core PCI bus is set up during early boot.
Then, for the PCI bus, we reach iommu_bus_init() -> bus_iommu_probe().
In there, we call probe_iommu_group() -> dev_iommu_get() for each PCI
device, which allocates dev->iommu in each case. So far so good.

The problem is that this is the last time that we'll call dev_iommu_get().
If any PCI bus devices get added after this point, they do not get passed
to dev_iommu_get().

So when the vmd module gets loaded later, and creates more PCI devices,
we end up in iommu_bus_notifier() -> iommu_probe_device()
-> __iommu_probe_device() which does:

	dev->iommu->iommu_dev = iommu_dev;

dev->iommu-> is a NULL dereference because dev_iommu_get() was never
called for this new device.

Daniel

