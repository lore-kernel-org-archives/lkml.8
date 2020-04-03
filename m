Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C855C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4342720721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sS+v7CNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390546AbgDCIXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:23:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38658 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390535AbgDCIXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:23:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id f6so6703893wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 01:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U598O76U1plvyjaapeO4Tf0HbIirnZODFv/NpOBhzfU=;
        b=sS+v7CNSHWE4356b1WV3iEELGpmmrK+V8Z9u/2DN2ksjjpwVQ0i70e/y9PrqolZTvR
         YgWGO5Z9s9oRyQ2O0oVNsV/IyvUKbUJxrvv6V/ITs0YV9P/0pLpm2PRplRyP2Bqt5z3B
         D8Y4bDSIXNqWHJHKtTtvteUgo5s3BhtamspGDsGtxlS0wKdGT15tCOZ1F6kpCZshKX34
         iuNHKvFVBXCnURhwDeh/Vv4p8xgOveUyiJJURsvP1oWALPnLGusrqaDt0Zs11FAyUrHm
         f/msg2cCxBvecHpZxSQUibB5xrMts67F1WVonZhQUcmlQkKR12fTa/KWY+WwA1Iug4Md
         IrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U598O76U1plvyjaapeO4Tf0HbIirnZODFv/NpOBhzfU=;
        b=Lp0DPk1xs1+ZuDZ+XgW0BbNH/XLG684DVXemEK717rYrNYeVLroK4QfGSFxI/dHsWw
         zkxYy8CO9e/wnZSVaFkzPY6Lod5b2hZTgVOE5UeyStqeSjO7bSiL3yhyTSw5kBzUTDIn
         lXL/sB2bDPr3tgftlsWlF1+g2bJKN3sWp2PgCbZxLLtx3dtYoaAQYkXT0oiI+4Tl5d7X
         7RklU5G0yZEld6VRZfLP+IgF6o45S8AtODu3gblCH5m9Ozt49ElUe6jesOsfb1awHwGS
         Gfg/slWiPXw/Lzf14+oZgVqN9QO3DghBxbxSSlipZwSN/q4aWKAQBdMgs9rbqKJwlTGi
         y0/g==
X-Gm-Message-State: AGi0PuYNHy7utzQkCdiYjf3vZYV4rmUKgrMr2golpsiuya52tGOHw2Hi
        urv6V3k9YUNNKim5FPWLlkJa7Q==
X-Google-Smtp-Source: APiQypJFlMG5cTB5/W9HLf5ZU0jVXEpq09c6jxtlvF0HcbDaR76403IdBh5WlxRSt57X9GXZ1B+fIw==
X-Received: by 2002:a1c:4486:: with SMTP id r128mr7726787wma.32.1585902192918;
        Fri, 03 Apr 2020 01:23:12 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id e8sm3163413wrw.40.2020.04.03.01.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 01:23:12 -0700 (PDT)
Date:   Fri, 3 Apr 2020 10:23:05 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Tian, Jun J" <jun.j.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wu, Hao" <hao.wu@intel.com>
Subject: Re: [PATCH v1 5/8] vfio/type1: Report 1st-level/stage-1 format to
 userspace
Message-ID: <20200403082305.GA1269501@myrica>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-6-git-send-email-yi.l.liu@intel.com>
 <cb68e9ab-77b0-7e97-a661-4836962041d9@redhat.com>
 <A2975661238FB949B60364EF0F2C25743A21DB4E@SHSMSX104.ccr.corp.intel.com>
 <b47891b1-ece6-c263-9c07-07c09c7d3752@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b47891b1-ece6-c263-9c07-07c09c7d3752@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 03:01:12PM +0200, Auger Eric wrote:
> >>>  	header = vfio_info_cap_add(caps, sizeof(*nesting_cap),
> >>>  				   VFIO_IOMMU_TYPE1_INFO_CAP_NESTING, 1);
> >>> @@ -2254,6 +2309,7 @@ static int vfio_iommu_info_add_nesting_cap(struct
> >> vfio_iommu *iommu,
> >>>  		/* nesting iommu type supports PASID requests (alloc/free) */
> >>>  		nesting_cap->nesting_capabilities |= VFIO_IOMMU_PASID_REQS;
> >> What is the meaning for ARM?
> > 
> > I think it's just a software capability exposed to userspace, on
> > userspace side, it has a choice to use it or not. :-) The reason
> > define it and report it in cap nesting is that I'd like to make
> > the pasid alloc/free be available just for IOMMU with type
> > VFIO_IOMMU_TYPE1_NESTING. Please feel free tell me if it is not
> > good for ARM. We can find a proper way to report the availability.
> 
> Well it is more a question for jean-Philippe. Do we have a system wide
> PASID allocation on ARM?

We don't, the PASID spaces are per-VM on Arm, so this function should
consult the IOMMU driver before setting flags. As you said on patch 3,
nested doesn't necessarily imply PASID support. The SMMUv2 does not
support PASID but does support nesting stages 1 and 2 for the IOVA space.
SMMUv3 support of PASID depends on HW capabilities. So I think this needs
to be finer grained:

Does the container support:
* VFIO_IOMMU_PASID_REQUEST?
  -> Yes for VT-d 3
  -> No for Arm SMMU
* VFIO_IOMMU_{,UN}BIND_GUEST_PGTBL?
  -> Yes for VT-d 3
  -> Sometimes for SMMUv2
  -> No for SMMUv3 (if we go with BIND_PASID_TABLE, which is simpler due to
     PASID tables being in GPA space.)
* VFIO_IOMMU_BIND_PASID_TABLE?
  -> No for VT-d
  -> Sometimes for SMMUv3

Any bind support implies VFIO_IOMMU_CACHE_INVALIDATE support.


> >>> +	nesting_cap->stage1_formats = formats;
> >> as spotted by Kevin, since a single format is supported, rename
> > 
> > ok, I was believing it may be possible on ARM or so. :-) will
> > rename it.

Yes I don't think an u32 is going to cut it for Arm :( We need to describe
all sorts of capabilities for page and PASID tables (granules, GPA size,
ASID/PASID size, HW access/dirty, etc etc.) Just saying "Arm stage-1
format" wouldn't mean much. I guess we could have a secondary vendor
capability for these?

Thanks,
Jean
