Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF565C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B172074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kmg9S42s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgFANRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:17:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59074 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725847AbgFANRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591017431;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=bTjB8qfrHTSFjfUbutxvl/qwCsz3nerFRx3HPBX7A6Q=;
        b=Kmg9S42sxivFgDCJm9EhN3rZ/XXZIMfREF1ymoRmeL6+qt7n1Ub4WG92paW0Up0kg21+7g
        rRPxV8uPSKyjQlWa+yVuNLLmpK2Ltyr3qeycmzpakBjqEEPZ6RCtBtUzsMH14EHo0LwoxF
        Cfp02DzupsgNQrYg4QlRquOxEWCkyQw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-Hty4AK-7MEuqetaV5Kgx-Q-1; Mon, 01 Jun 2020 09:17:06 -0400
X-MC-Unique: Hty4AK-7MEuqetaV5Kgx-Q-1
Received: by mail-qv1-f69.google.com with SMTP id k35so8513167qva.18
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 06:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=bTjB8qfrHTSFjfUbutxvl/qwCsz3nerFRx3HPBX7A6Q=;
        b=JITp09Syzqktq5WAOYqGpWkbDWLrKKiZaKadQ1DzY36+dIQ/evaNjWPR1vprKrw0Zw
         Nld3KN/St0uIXs+9+h3a9K6DfHtkXGOgGHgXOPo0Pp4YXLERU6k3gnlfp9LcXwWck9ST
         +e/2kYsVAMR7eoHeiRiNdAV/bsFTAw2RRw2AfPKq4P/lCnOs/MARx4Av3IRqP4SvxT4F
         gM5dD/pfPyPEkEIcGRVt9Xw092kFMBrGEq9xG1lsaCV/MoiqCfXOa2WvhurqoOl6FhwB
         3ytPvWW9610+jtC9RQwduJya8HXnU5AmyfyOk4ZvuE0xs6lrKZ+3NrAHb8VPfVE1+Rk5
         UcIQ==
X-Gm-Message-State: AOAM531eNd+05x4+Al4miCOQTVvmGdku5ZWIzJ9W3l+OjbBV5sSyFAz7
        fFGUulrCbjLsKt1zvOQ4Z2T8Kr7VJ/meinx0/1mnlRyWABpTz7Gl71ETSOtUCTCsmSkhYUMkneU
        6kZMWLw8l3sWRpZZowcrHUvg7
X-Received: by 2002:a0c:ee25:: with SMTP id l5mr20058570qvs.5.1591017425792;
        Mon, 01 Jun 2020 06:17:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfI03wn2xa5VbguB4ZgxB0Liv4dY32KsoEfpHfoc+ZEMln7Vo+khXJZaEY6bPHZ9c8b/Aysw==
X-Received: by 2002:a0c:ee25:: with SMTP id l5mr20058438qvs.5.1591017424552;
        Mon, 01 Jun 2020 06:17:04 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id r77sm12075150qke.6.2020.06.01.06.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 06:17:03 -0700 (PDT)
Date:   Mon, 1 Jun 2020 06:17:02 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 00/33] iommu: Move iommu_group setup to IOMMU core code
Message-ID: <20200601131702.4ksimsjvnsmo3mvn@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
References: <20200414131542.25608-1-joro@8bytes.org>
 <20200529221623.qc6twmpzryh7nkvb@cantor>
 <20200601104240.7f5xhz7gooqhaq4n@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200601104240.7f5xhz7gooqhaq4n@cantor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jun 01 20, Jerry Snitselaar wrote:
>On Fri May 29 20, Jerry Snitselaar wrote:
>>On Tue Apr 14 20, Joerg Roedel wrote:
>>>Hi,
>>>
>>>here is the second version of this patch-set. The first version with
>>>some more introductory text can be found here:
>>>
>>>	https://lore.kernel.org/lkml/20200407183742.4344-1-joro@8bytes.org/
>>>
>>>Changes v1->v2:
>>>
>>>	* Rebased to v5.7-rc1
>>>
>>>	* Re-wrote the arm-smmu changes as suggested by Robin Murphy
>>>
>>>	* Re-worked the Exynos patches to hopefully not break the
>>>	  driver anymore
>>>
>>>	* Fixed a missing mutex_unlock() reported by Marek Szyprowski,
>>>	  thanks for that.
>>>
>>>There is also a git-branch available with these patches applied:
>>>
>>>	https://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git/log/?h=iommu-probe-device-v2
>>>
>>>Please review.
>>>
>>>Thanks,
>>>
>>>	Joerg
>>>
>>>Joerg Roedel (32):
>>>iommu: Move default domain allocation to separate function
>>>iommu/amd: Implement iommu_ops->def_domain_type call-back
>>>iommu/vt-d: Wire up iommu_ops->def_domain_type
>>>iommu/amd: Remove dma_mask check from check_device()
>>>iommu/amd: Return -ENODEV in add_device when device is not handled by
>>>  IOMMU
>>>iommu: Add probe_device() and remove_device() call-backs
>>>iommu: Move default domain allocation to iommu_probe_device()
>>>iommu: Keep a list of allocated groups in __iommu_probe_device()
>>>iommu: Move new probe_device path to separate function
>>>iommu: Split off default domain allocation from group assignment
>>>iommu: Move iommu_group_create_direct_mappings() out of
>>>  iommu_group_add_device()
>>>iommu: Export bus_iommu_probe() and make is safe for re-probing
>>>iommu/amd: Remove dev_data->passthrough
>>>iommu/amd: Convert to probe/release_device() call-backs
>>>iommu/vt-d: Convert to probe/release_device() call-backs
>>>iommu/arm-smmu: Convert to probe/release_device() call-backs
>>>iommu/pamu: Convert to probe/release_device() call-backs
>>>iommu/s390: Convert to probe/release_device() call-backs
>>>iommu/virtio: Convert to probe/release_device() call-backs
>>>iommu/msm: Convert to probe/release_device() call-backs
>>>iommu/mediatek: Convert to probe/release_device() call-backs
>>>iommu/mediatek-v1 Convert to probe/release_device() call-backs
>>>iommu/qcom: Convert to probe/release_device() call-backs
>>>iommu/rockchip: Convert to probe/release_device() call-backs
>>>iommu/tegra: Convert to probe/release_device() call-backs
>>>iommu/renesas: Convert to probe/release_device() call-backs
>>>iommu/omap: Remove orphan_dev tracking
>>>iommu/omap: Convert to probe/release_device() call-backs
>>>iommu/exynos: Use first SYSMMU in controllers list for IOMMU core
>>>iommu/exynos: Convert to probe/release_device() call-backs
>>>iommu: Remove add_device()/remove_device() code-paths
>>>iommu: Unexport iommu_group_get_for_dev()
>>>
>>>Sai Praneeth Prakhya (1):
>>>iommu: Add def_domain_type() callback in iommu_ops
>>>
>>>drivers/iommu/amd_iommu.c       |  97 ++++----
>>>drivers/iommu/amd_iommu_types.h |   1 -
>>>drivers/iommu/arm-smmu-v3.c     |  38 +--
>>>drivers/iommu/arm-smmu.c        |  39 ++--
>>>drivers/iommu/exynos-iommu.c    |  24 +-
>>>drivers/iommu/fsl_pamu_domain.c |  22 +-
>>>drivers/iommu/intel-iommu.c     |  68 +-----
>>>drivers/iommu/iommu.c           | 393 +++++++++++++++++++++++++-------
>>>drivers/iommu/ipmmu-vmsa.c      |  60 ++---
>>>drivers/iommu/msm_iommu.c       |  34 +--
>>>drivers/iommu/mtk_iommu.c       |  24 +-
>>>drivers/iommu/mtk_iommu_v1.c    |  50 ++--
>>>drivers/iommu/omap-iommu.c      |  99 ++------
>>>drivers/iommu/qcom_iommu.c      |  24 +-
>>>drivers/iommu/rockchip-iommu.c  |  26 +--
>>>drivers/iommu/s390-iommu.c      |  22 +-
>>>drivers/iommu/tegra-gart.c      |  24 +-
>>>drivers/iommu/tegra-smmu.c      |  31 +--
>>>drivers/iommu/virtio-iommu.c    |  41 +---
>>>include/linux/iommu.h           |  21 +-
>>>20 files changed, 533 insertions(+), 605 deletions(-)
>>>
>>>-- 
>>>2.17.1
>>>
>>>_______________________________________________
>>>iommu mailing list
>>>iommu@lists.linux-foundation.org
>>>https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>>
>>
>>Hi Joerg,
>>
>>With this patchset, I have an epyc system where if I boot with
>>iommu=nopt and force a dump I will see some io page faults for a nic
>>on the system. The vmcore is harvested and the system reboots. I
>>haven't reproduced it on other systems yet, but without the patchset I
>>don't see the io page faults during the kdump.
>>
>>Regards,
>>Jerry
>
>I just hit an issue on a separate intel based system (kdump iommu=nopt),
>where it panics in during intel_iommu_attach_device, in is_aux_domain,
>due to device_domain_info being DEFER_DEVICE_DOMAIN_INFO. That doesn't
>get set to a valid address until the domain_add_dev_info call.
>
>Is it as simple as the following?
>
>diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>index 29d3940847d3..f1bbeed46a4c 100644
>--- a/drivers/iommu/intel-iommu.c
>+++ b/drivers/iommu/intel-iommu.c
>@@ -5053,8 +5053,8 @@ is_aux_domain(struct device *dev, struct iommu_domain *domain)
> {
>        struct device_domain_info *info = dev->archdata.iommu;
>-       return info && info->auxd_enabled &&
>-                       domain->type == IOMMU_DOMAIN_UNMANAGED;
>+       return info && info != DEFER_DEVICE_DOMAIN_INFO &&
>+               info->auxd_enabled && domain->type == IOMMU_DOMAIN_UNMANAGED;
> }
> static void auxiliary_link_device(struct dmar_domain *domain,
>
>
>Regards,
>Jerry
>

With the patch, I avoid the panic, but I'm seeing an issue similar to the epyc system.
I'm getting dmar faults from a couple of nics and the hp ilo. The addresses in question
were in e820 reserved sections, but there aren't rmrr covering those addresses. The system
manages to harvest the vmcore and reboot like the epyc. Without the patches I don't see
the dmar faults. I needed to give this system back, but I'll try to poke at it some more
in the next couple of days.

Regards,
Jerry

