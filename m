Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20ADC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B9F2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XT/uDfKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbgFPQJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:09:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29807 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732628AbgFPQJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592323761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2y8KD7xWbYjXU/cEL7LgtQkBTECAhlAA76XR+Aplj6k=;
        b=XT/uDfKZ+Nz+aKowO4BAdx/H5jwyTOnD34TZbFaDITYa3rC14T/bPWPFfbjAviz+qNEVP3
        /9Ud2KhGIkL69nuh+nUNSnQr461W94Pmov/gsP9vJJWr2UfsgNpBXI/AHKi02EPH75JhTd
        bXS6KQdqzryLGWRMALwusGgaUlBg/dQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-o0V_QEgzMSuTzbl1AfG3Xg-1; Tue, 16 Jun 2020 12:09:19 -0400
X-MC-Unique: o0V_QEgzMSuTzbl1AfG3Xg-1
Received: by mail-qt1-f198.google.com with SMTP id y5so17126531qtd.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2y8KD7xWbYjXU/cEL7LgtQkBTECAhlAA76XR+Aplj6k=;
        b=FS9Hxt+KDw7hhFODPY+dGkFqXIq5AsJ0R3U7vv6oVFopigQCkmczx9TE1cAr/+KGJJ
         mmrmEV28ucDM4m1CKKajRTeZGa5i/jccIrbaaZVN4i4If/FavDv3NIDginETH30gSM8G
         T9CYnhp6zsJ7C06XfGenp05w4OTUTPwqYvlY1jVf8hv+dSXxxCJ/J6RFCZktQwb+eOZW
         1az74paapKlyV1WMrzPLVorlxWWqMi8EvnIvRaXtKMfo0SvHjtQIMbSxJ8zHHNkPAxIp
         XsCgPek6i5LjozXq3dAyS4I6zZYV2SLvaqdEtWvTS636wMxNYkt+iw02nO92HP6Tdm2Q
         nGSA==
X-Gm-Message-State: AOAM531L2mi9inYeZLaaUZGX+aiR9t9T2kGAIdwhhj4b85NMlNce87PE
        wJJN0Ge9z4D+ET9kVm4A4gZ3+K1Fxm42SdCjYxNHry0gjTNB9ycee9f9bgJBITsaEEt5U/KGcyb
        XZpKGpMtDAC56DsO9ICQXO0eL
X-Received: by 2002:ad4:54ea:: with SMTP id k10mr3112698qvx.66.1592323758931;
        Tue, 16 Jun 2020 09:09:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoN5ZsEbH2t5hBW9WW5hOk33D7AAL34ncw5O7fmuB3JLmLE9egHSi0toqNT8A+dCzhofL/5Q==
X-Received: by 2002:ad4:54ea:: with SMTP id k10mr3112676qvx.66.1592323758723;
        Tue, 16 Jun 2020 09:09:18 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id y1sm15552040qta.82.2020.06.16.09.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 09:09:17 -0700 (PDT)
Date:   Tue, 16 Jun 2020 12:09:16 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Tian, Jun J" <jun.j.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "Wu, Hao" <hao.wu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/15] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200616160916.GC11838@xz-x1>
References: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
 <20200615100214.GC1491454@stefanha-x1.localdomain>
 <MWHPR11MB16451F1E4748DF97D6A1DDD48C9D0@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20200616154928.GF1491454@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616154928.GF1491454@stefanha-x1.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 04:49:28PM +0100, Stefan Hajnoczi wrote:
> Isolation between applications is preserved but there is no isolation
> between the device and the application itself. The application needs to
> trust the device.
> 
> Examples:
> 
> 1. The device can snoop secret data from readable pages in the
>    application's virtual memory space.
> 
> 2. The device can gain arbitrary execution on the CPU by overwriting
>    control flow addresses (e.g. function pointers, stack return
>    addresses) in writable pages.

To me, SVA seems to be that "middle layer" of secure where it's not as safe as
VFIO_IOMMU_MAP_DMA which has buffer level granularity of control (but of course
we pay overhead on buffer setups and on-the-fly translations), however it's far
better than DMA with no IOMMU which can ruin the whole host/guest, because
after all we do a lot of isolations as process based.

IMHO it's the same as when we see a VM (or the QEMU process) as a whole along
with the guest code.  In some cases we don't care if the guest did some bad
things to mess up with its own QEMU process.  It is still ideal if we can even
stop the guest from doing so, but when it's not easy to do it the ideal way, we
just lower the requirement to not spread the influence to the host and other
VMs.

Thanks,

-- 
Peter Xu

