Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81371C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D514207D0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bP8zHXM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgFDAdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 20:33:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23575 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725936AbgFDAdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 20:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591230812;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=z0GcSxT2WNBSxlfmkg95uPwf3ZGL3Q7ykUANj5zGO7w=;
        b=bP8zHXM6BebnlMYBLbVjv6tYBEKzZiDbNmsFoYEDjLRfofs/7fagZmjTJuo0ZWhSb/cFgN
        T9u+g6E8fR/5gk3lvtMQ2xdiw05o+nrJcC8WiVV5suBPzC7redpSwBynPHSij2sjLGW4OT
        bSx4t3bEVvbjXp7K4JEVF6IAsKCI1fM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-YSwW9XWBP9KntNcc60P_jQ-1; Wed, 03 Jun 2020 20:33:31 -0400
X-MC-Unique: YSwW9XWBP9KntNcc60P_jQ-1
Received: by mail-qv1-f71.google.com with SMTP id j4so3043544qvt.20
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 17:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=z0GcSxT2WNBSxlfmkg95uPwf3ZGL3Q7ykUANj5zGO7w=;
        b=S4PSBuH5vvikOtip9oj75n+VICtRCzAAaujaBod2Mblh9C2UBlfe/hcSqUsI/NxTO0
         pJQhYr5eyLTkEsHKCGq38vwpGH4l9oaMZlQ9bXugCR6OAFRSflyg8ACQUgf5pkYMFksi
         je4WDLbhYHYpxS9ehkNGcp62c6gSc3ulU2nmDOw7jP0OQYYgSeKvlQx+caineITXzrPj
         PlHveMCALmxNCYEJq4zHVCiXtwsRMv4Nynab4r+dTHeD5pY9AceSwXpK1pcgRzB+O4pS
         +6V8T0oO9vFsp9V0eePIL1fHH71CCz/2Ke2nuhGcUMiI1XQudwdzKkjYgcKJmM3ayzul
         Mxyg==
X-Gm-Message-State: AOAM532PJDtJzMxkTkzB6pfbmogaJbn0WrRqncIGsnI3TBORX2vtzV5c
        oQQJSo9Crx91Zp8yeeKldnhAtRb8Lb13t5d1QH9h5U5xEuEBqADq0TUZrpY04vwt84VCjraHX06
        /FrRNgdSBOloEjFkIZEQEOKc6
X-Received: by 2002:ac8:339b:: with SMTP id c27mr2001846qtb.210.1591230810244;
        Wed, 03 Jun 2020 17:33:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLAqtZLyXW1qmZCBVVBSMCAd/hiQhcdwBWw2XvC2mofMUKO2j+DxwewPxvUEt5AscwPHRMyQ==
X-Received: by 2002:ac8:339b:: with SMTP id c27mr2001822qtb.210.1591230809949;
        Wed, 03 Jun 2020 17:33:29 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id 5sm2725501qko.14.2020.06.03.17.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 17:33:28 -0700 (PDT)
Date:   Wed, 3 Jun 2020 17:33:27 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Qian Cai <cai@lca.pw>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu: Move Intel and AMD drivers into their own
 subdirectory
Message-ID: <20200604003327.hk7w7i5qs7z3z2w3@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Qian Cai <cai@lca.pw>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200602092616.24638-1-joro@8bytes.org>
 <148834f4-849e-acf1-c347-e25093aac518@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <148834f4-849e-acf1-c347-e25093aac518@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jun 04 20, Lu Baolu wrote:
>Hi Joerg,
>
>On 6/2/20 5:26 PM, Joerg Roedel wrote:
>>Hi,
>>
>>two small patches to move the Intel and AMD IOMMU drivers into their own
>>subdirectory under drivers/iommu/ to make the file structure a bit less
>>cluttered.
>>
>
>Does the MAINTAINERS file need to update?
>
>Best regards,
>baolu
>

Yes, that should be updated to point at the new directories. Good catch.


>>Regards,
>>
>>	Joerg
>>
>>Joerg Roedel (2):
>>   iommu/amd: Move AMD IOMMU driver into subdirectory
>>   iommu/vt-d: Move Intel IOMMU driver into subdirectory
>>
>>  drivers/iommu/Makefile                         | 18 +++++++++---------
>>  drivers/iommu/{ => amd}/amd_iommu.h            |  0
>>  drivers/iommu/{ => amd}/amd_iommu_types.h      |  0
>>  .../{amd_iommu_debugfs.c => amd/debugfs.c}     |  0
>>  drivers/iommu/{amd_iommu_init.c => amd/init.c} |  2 +-
>>  drivers/iommu/{amd_iommu.c => amd/iommu.c}     |  2 +-
>>  .../iommu/{amd_iommu_v2.c => amd/iommu_v2.c}   |  0
>>  .../iommu/{amd_iommu_quirks.c => amd/quirks.c} |  0
>>  .../{intel-iommu-debugfs.c => intel/debugfs.c} |  0
>>  drivers/iommu/{ => intel}/dmar.c               |  2 +-
>>  drivers/iommu/{ => intel}/intel-pasid.h        |  0
>>  drivers/iommu/{intel-iommu.c => intel/iommu.c} |  2 +-
>>  .../irq_remapping.c}                           |  2 +-
>>  drivers/iommu/{intel-pasid.c => intel/pasid.c} |  0
>>  drivers/iommu/{intel-svm.c => intel/svm.c}     |  0
>>  drivers/iommu/{intel-trace.c => intel/trace.c} |  0
>>  16 files changed, 14 insertions(+), 14 deletions(-)
>>  rename drivers/iommu/{ => amd}/amd_iommu.h (100%)
>>  rename drivers/iommu/{ => amd}/amd_iommu_types.h (100%)
>>  rename drivers/iommu/{amd_iommu_debugfs.c => amd/debugfs.c} (100%)
>>  rename drivers/iommu/{amd_iommu_init.c => amd/init.c} (99%)
>>  rename drivers/iommu/{amd_iommu.c => amd/iommu.c} (99%)
>>  rename drivers/iommu/{amd_iommu_v2.c => amd/iommu_v2.c} (100%)
>>  rename drivers/iommu/{amd_iommu_quirks.c => amd/quirks.c} (100%)
>>  rename drivers/iommu/{intel-iommu-debugfs.c => intel/debugfs.c} (100%)
>>  rename drivers/iommu/{ => intel}/dmar.c (99%)
>>  rename drivers/iommu/{ => intel}/intel-pasid.h (100%)
>>  rename drivers/iommu/{intel-iommu.c => intel/iommu.c} (99%)
>>  rename drivers/iommu/{intel_irq_remapping.c => intel/irq_remapping.c} (99%)
>>  rename drivers/iommu/{intel-pasid.c => intel/pasid.c} (100%)
>>  rename drivers/iommu/{intel-svm.c => intel/svm.c} (100%)
>>  rename drivers/iommu/{intel-trace.c => intel/trace.c} (100%)
>>
>

