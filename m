Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDBBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5ABC20897
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592424281;
	bh=yCtGv9eVlMKw9D6v7Ig4uZ2wW0Tp8uCLu0Xw3XWC5sE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=URGhpamH3x8rmIu7R3N3SjAADb0t/z+A3SiF4ZcBEyZEtYSGnJ7v+mqtRKyfZjyQf
	 u82O9Ujd4WtOMybAFjwpvleS1clDqV7QfJMoUlrCZU5bCnbngQRqB5ZTEo+zHSHJ3I
	 55FWlRORwGE+GRhDdloGFp/0+qHq/3UuwgEdQnT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgFQUEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:04:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgFQUEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:04:39 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2813217BA
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 20:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592424279;
        bh=yCtGv9eVlMKw9D6v7Ig4uZ2wW0Tp8uCLu0Xw3XWC5sE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U62EIiVFSy9+Y5G0+Z8Ru87mRY7pIfuk/Xt1lZwTH1R4Z1sogOcvMrDrqNLe2yrK7
         2jd3b3fMwAwplYIympzqfs+cgg9rJworSDqTRYxZjGdWiqzDuwnsLQqIWmOVr8J44r
         aR/UgDjBY5umc9i7U44UT5xEFKGcMaR5iAQQ33Ac=
Received: by mail-wm1-f50.google.com with SMTP id y20so3344717wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:04:38 -0700 (PDT)
X-Gm-Message-State: AOAM5329uncqNPEjAfHFU2hZEr104bUgYyflL35DWMB2yCW+Drvi3ERy
        Vl0Mb5wnJwa/+YR/FqB3Rd16cGbTEzhBWR2UAmK2yQ==
X-Google-Smtp-Source: ABdhPJwF+e7fdqSN9IJOEQH25Ju27rVnKNE0KkLy448jhlRMelw5Y5sP+Yps/00ZoQ2rvoEmHyYyOf2BhJS3yDCf8Yw=
X-Received: by 2002:a05:600c:22da:: with SMTP id 26mr394359wmg.176.1592424277291;
 Wed, 17 Jun 2020 13:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <1592418233-17762-1-git-send-email-fenghua.yu@intel.com>
 <1592418233-17762-2-git-send-email-fenghua.yu@intel.com> <CALCETrXFHa_05-sGAy5M9YGJWUfTn9MfM-ZYk+hp12tqHNJA0Q@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7F67216A@ORSMSX115.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F67216A@ORSMSX115.amr.corp.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 17 Jun 2020 13:04:25 -0700
X-Gmail-Original-Message-ID: <CALCETrWe=7CoS8j7w5penF9xWndcrvYDhJpEUdymfLBtjmNUkQ@mail.gmail.com>
Message-ID: <CALCETrWe=7CoS8j7w5penF9xWndcrvYDhJpEUdymfLBtjmNUkQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] iommu: Change type of pasid to unsigned int
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradeed.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 12:39 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> > Is PASID in the uapi at all?
>
>
> $ grep pasid include/uapi/linux/iommu.h
> * @pasid: Process Address Space ID
>         __u32   pasid;
>  * @pasid: Process Address Space ID
>         __u32   pasid;
>  * @pasid: Process Address Space ID
>         __u32   pasid;
>  * - If the PASID bit is set, the @pasid field is populated and the invalidation
>  * @pasid: process address space ID
>         __u64   pasid;
>  * struct iommu_inv_pasid_info - PASID Selective Invalidation Structure
>  * - If the PASID bit is set, the @pasid field is populated and the invalidation
>  * @pasid: process address space ID
> struct iommu_inv_pasid_info {
>         __u64   pasid;
>  * @pasid_info: invalidation data when @granularity is %IOMMU_INV_GRANU_PASID
>                 struct iommu_inv_pasid_info pasid_info;
>  * struct iommu_gpasid_bind_data_vtd - Intel VT-d specific data on device and guest
> struct iommu_gpasid_bind_data_vtd {
>  * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
>  * @hpasid:     Process address space ID used for the guest mm in host IOMMU
>  * @gpasid:     Process address space ID used for the guest mm in guest IOMMU
> struct iommu_gpasid_bind_data {
>         __u64 hpasid;
>         __u64 gpasid;
>                 struct iommu_gpasid_bind_data_vtd vtd;


Aha.  I guess this is considerably older than I thought.
