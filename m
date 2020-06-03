Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190FBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8FF420679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7itCp34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgFCHZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:25:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27800 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725810AbgFCHZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591169107;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=EC+d+WxemCljULP9SuuqZspKAfF5v0XLd3cIFL/Shds=;
        b=X7itCp34Ge6LXUJNBmHsmqtRwvADycY4lnvLWLtzU26FYpZUWs0FS63kfLCXQqRSUlae8x
        zII4MSEJku2s85dxvqHk/zOPtPcudUDIZe7bk04p99SzCGXZXJDiIXI7pfgC9ng+wDUjRU
        G4s3Z0HGEvaAcrxQUl2KePYBOuUN8Sw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-jHB5BHKTPcKOXlfnsjssxg-1; Wed, 03 Jun 2020 03:25:06 -0400
X-MC-Unique: jHB5BHKTPcKOXlfnsjssxg-1
Received: by mail-qv1-f71.google.com with SMTP id x16so829870qvp.19
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 00:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=EC+d+WxemCljULP9SuuqZspKAfF5v0XLd3cIFL/Shds=;
        b=ErVmIRgh/jujeILUtDkFfPNgapDZKEY4MhvVDa+r9kox5eCVa+Ijkepe6U5Ky08wsj
         +Vr76jjKfGLOX9NtQOyLXUH+H1RsVoL0sh2EJQSPVdvsPjDNszqQuQbaBETs8iWvmPsz
         EOnx3RdylApGdduOA90o/S3UWYJKFpSUjYc3NfOpDz9cuT1GWFpwD+FNR5MEDEbqMO1e
         +OjF7riuV4bZ+xJrT4l+SQyAosQPu8+aZuVsaos0zXotRJolPtTonXg30EpSZ6ttGIzz
         Kdl7UoptBR0WDxVdkw7lsQZQQ6Zbd3t4SQTRsfdfSw3SKMUOy10DdqF+YVsUvLqd2xaa
         lbYQ==
X-Gm-Message-State: AOAM530qVvwGhxwPjwE9RbVNUBs/KmC+moNqv3u06oEjlcQbI52pVy3b
        RTppm5+mbmvdshs3OZPQiSCpTCoXh35X9KoGu8P+1hVT6Pc2+xNJaYJ/yzMgB/DMjydxSGtLQzS
        Jo1yRc6mTgF/l06Jr4Z+vsqhc
X-Received: by 2002:a37:850:: with SMTP id 77mr28134181qki.498.1591169105757;
        Wed, 03 Jun 2020 00:25:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwywfiXv11HyflkYogvBZqV6/H9CCZ3oOPBIMwdCxiPWdRcaBtK8tl9oN/O7TAcINZHy9dowA==
X-Received: by 2002:a37:850:: with SMTP id 77mr28134171qki.498.1591169105494;
        Wed, 03 Jun 2020 00:25:05 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id 80sm910052qkl.116.2020.06.03.00.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 00:25:04 -0700 (PDT)
Date:   Wed, 3 Jun 2020 00:25:03 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Qian Cai <cai@lca.pw>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu: Move Intel and AMD drivers into their own
 subdirectory
Message-ID: <20200603072503.j5iffuoxkdryg7qa@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Qian Cai <cai@lca.pw>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200602092616.24638-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200602092616.24638-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jun 02 20, Joerg Roedel wrote:
>Hi,
>
>two small patches to move the Intel and AMD IOMMU drivers into their own
>subdirectory under drivers/iommu/ to make the file structure a bit less
>cluttered.
>
>Regards,
>
>	Joerg
>
>Joerg Roedel (2):
>  iommu/amd: Move AMD IOMMU driver into subdirectory
>  iommu/vt-d: Move Intel IOMMU driver into subdirectory
>
> drivers/iommu/Makefile                         | 18 +++++++++---------
> drivers/iommu/{ => amd}/amd_iommu.h            |  0
> drivers/iommu/{ => amd}/amd_iommu_types.h      |  0
> .../{amd_iommu_debugfs.c => amd/debugfs.c}     |  0
> drivers/iommu/{amd_iommu_init.c => amd/init.c} |  2 +-
> drivers/iommu/{amd_iommu.c => amd/iommu.c}     |  2 +-
> .../iommu/{amd_iommu_v2.c => amd/iommu_v2.c}   |  0
> .../iommu/{amd_iommu_quirks.c => amd/quirks.c} |  0
> .../{intel-iommu-debugfs.c => intel/debugfs.c} |  0
> drivers/iommu/{ => intel}/dmar.c               |  2 +-
> drivers/iommu/{ => intel}/intel-pasid.h        |  0
> drivers/iommu/{intel-iommu.c => intel/iommu.c} |  2 +-
> .../irq_remapping.c}                           |  2 +-
> drivers/iommu/{intel-pasid.c => intel/pasid.c} |  0
> drivers/iommu/{intel-svm.c => intel/svm.c}     |  0
> drivers/iommu/{intel-trace.c => intel/trace.c} |  0
> 16 files changed, 14 insertions(+), 14 deletions(-)
> rename drivers/iommu/{ => amd}/amd_iommu.h (100%)
> rename drivers/iommu/{ => amd}/amd_iommu_types.h (100%)
> rename drivers/iommu/{amd_iommu_debugfs.c => amd/debugfs.c} (100%)
> rename drivers/iommu/{amd_iommu_init.c => amd/init.c} (99%)
> rename drivers/iommu/{amd_iommu.c => amd/iommu.c} (99%)
> rename drivers/iommu/{amd_iommu_v2.c => amd/iommu_v2.c} (100%)
> rename drivers/iommu/{amd_iommu_quirks.c => amd/quirks.c} (100%)
> rename drivers/iommu/{intel-iommu-debugfs.c => intel/debugfs.c} (100%)
> rename drivers/iommu/{ => intel}/dmar.c (99%)
> rename drivers/iommu/{ => intel}/intel-pasid.h (100%)
> rename drivers/iommu/{intel-iommu.c => intel/iommu.c} (99%)
> rename drivers/iommu/{intel_irq_remapping.c => intel/irq_remapping.c} (99%)
> rename drivers/iommu/{intel-pasid.c => intel/pasid.c} (100%)
> rename drivers/iommu/{intel-svm.c => intel/svm.c} (100%)
> rename drivers/iommu/{intel-trace.c => intel/trace.c} (100%)
>
>-- 
>2.17.1
>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

