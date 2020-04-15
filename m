Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F52C2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6022076A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZ4BXox0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393168AbgDOPL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393131AbgDOPLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:11:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BF5C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:11:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id u13so292504wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vzn5Qi0ZG5I2dfN+j2Q0PXBNrTKg5GnbDO72sf5kYmE=;
        b=kZ4BXox0LCjCv71j6mhvSC6hJT0Z/VGQda1i6/OdAyN4W1ETBfMrmBAaUNfak62dI3
         3RgoMqf4NrWAUABEgfHAShe0W9Ugx0uqNG9HBnqOjFxKen/NZrjX0Kb3TvjWgSRd5gs0
         dlJSrbOOrGLjqJ65EYoQ+JQMoKJpmuTUVFeMQiv6GD/OXOuy0ROSiOpexEVW72YZL4ne
         0OEx7p7O1RogVyTytQu6MdFp3uSbs3LBH4q+J6zMCsGLvBXD8XsoV76qaJGgdzoAikzc
         9WM+V67zjUXRTeO4PdviJ4iCQ5dpsQ41nKcBL0kDP0/dwn+24klk82G1y0HwHLzgBR3P
         2+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vzn5Qi0ZG5I2dfN+j2Q0PXBNrTKg5GnbDO72sf5kYmE=;
        b=LU9H8428VIYFlyQlDJr7gEx/U9miVnE56E5BR2e3vStCfHXrKZsa9oRYj8A3JwLtg7
         aCwFOk8AL7nN4Exmc26PWaCZGBP391uOKdxj34gSdqDMhB+x1NgBdxSwsxytR8env8zW
         ILgsnJ7rKclNDWU6iM2wd/N7jF70vu7hiXKoVGEPcm5K0ABdvhY6qiTtJ2a+Al8F5kSw
         zGaWhxMgUePxnLftL1/D5vgTs1lRRilSfCoN4IIVBtpmb7Pv1AaeZK+xGTHMCGM3D/RI
         G3k0IsZ8PhN5El/XIcRooGvS1yK3k1ubaAwWIfHxhiuJFEpmjBU09Q/H/E2FHeI1aq0E
         7OHw==
X-Gm-Message-State: AGi0PuZuFh4cpy1+PKO9krrAVrHMnUa4uKxJBcv9wXTT5iGFLrcqeKc1
        KyMNcsHX0VjYaDhkmro688kNzQ==
X-Google-Smtp-Source: APiQypJ1tKF/+7Bq6w/nAZeilnVQ5/5MxeB23DPP2SO0LzWZkJI3hVp2OiXoJMV4vD1qTUVfbHmQog==
X-Received: by 2002:adf:f844:: with SMTP id d4mr10793811wrq.362.1586963452757;
        Wed, 15 Apr 2020 08:10:52 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id k184sm22809016wmf.9.2020.04.15.08.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 08:10:51 -0700 (PDT)
Date:   Wed, 15 Apr 2020 17:10:43 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 05/10] iommu/ioasid: Create an IOASID set for host SVA use
Message-ID: <20200415151043.GB738821@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200401135316.GF882512@myrica>
 <20200406083353.73efda5b@jacob-builder>
 <20200407110146.GB285264@myrica>
 <20200413150631.60e54d85@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413150631.60e54d85@jacob-builder>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 03:06:31PM -0700, Jacob Pan wrote:
> > > > But quotas are only necessary for VMs, when the host shares the
> > > > PASID space with them (which isn't a use-case for Arm systems as
> > > > far as I know, each VM gets its own PASID space).  
> > > Is there a host-guest PASID translation? or the PASID used by the
> > > VM is physical PASID? When a page request comes in to SMMU, how
> > > does it know the owner of the PASID if PASID range can overlap
> > > between host and guest?  
> > 
> > We assign PCI functions to VMs, so Page Requests are routed with
> > RID:PASID, not PASID alone. The SMMU finds the struct device
> > associated with the RID, and submits the fault with
> > iommu_report_device_fault(). If the VF is assigned to a VM, then the
> > page request gets injected into the VM, otherwise it uses the host
> > IOPF handler
> > 
> Got it, VM private PASID space works then.
> For VM, the IOASID search is within the VM ioasid_set.
> For SVA, the IOASID search is within host default set.
> Should be faster than global search once we have per set xarray.
> I guess the PASID table is per VM instead of per RID (device)? Sorry if
> you already answered it before.

The PASID table is per IOMMU domain, so it's closer to per RID than per
VM, unless userspace puts all devices in the same VFIO container (hence in
the same IOMMU domain).

Thanks,
Jean
