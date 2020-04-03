Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AB3C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9355820787
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t1GnrrkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390462AbgDCIfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:35:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44869 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbgDCIfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:35:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id m17so7421607wrw.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 01:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gSDnBtalBGHCeLhjHixwG2yB0Zm9Uo7yHmAg2UgLWeU=;
        b=t1GnrrkQzojg5Ujx4Cx6gRfTF9IbKcMgckidZWrVxH8SZ3YPcQuVNqwXz9IWys1ocf
         nP0Sz58PeL/xyaexdo3oj5Xq17DXktK9Mr6F1pi2PG4PpETrWOhxupj3XMNEohVCevRI
         Zp0apcsoNnq2F3VYkJ318tjg0SZZN6xWy1Uj5Wh9Wqo5v/PQJhxiejM7ZwalDMNJtuAm
         0yyXZPNqtRkAWhfOqoLIbeHsBGeSsvljtVT72J9o3BpItjmn9JDroP/om91tC2QEj5JB
         ow+FeIgaKGa5ajlJIWJtSD/y31uh8MQVhb961019Lf/9or27Z/oHAP0ZDm0A2bynuxMC
         QeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gSDnBtalBGHCeLhjHixwG2yB0Zm9Uo7yHmAg2UgLWeU=;
        b=hby9brpr7n/K7JrSC2Gf+4SGaalXmnYmIjd9+G4tgUHLyIVMcHtOaz8QKyuC2JpS3Y
         CR1fsr3fZ9AQA4Us4F/aYVR8RlacZcYrmExnMTUIczeOTIGWXV/p35lxGyTXfFNrRhkT
         qIVOnJOpagYp3RP4XZKD1YgU/Pz6WENB2TfCWiSJyd1ANYPD/hVBa0mVCek0nAr4cHJg
         1Z3uL9uZE6jQfztiyLDIQYG5UIiTi+2XX2by90dA1eHSrnZXnFz8ZBl99BWydjrvFkdg
         JjFNFcxsf0Ugm4Rbhp9RFbi7Y8z0smyokcqOYOshU9KUOeSxMtowQA+qvtfSwbBKo/2T
         csNA==
X-Gm-Message-State: AGi0PuYA4sZgeYtmGzLkA7Z2ZjFrHjZ98LXDAgDW+Cv+7dqA9Km+UW2x
        8Q3EMUSsyt3rO5K+7HQpnna50w==
X-Google-Smtp-Source: APiQypLBXNwvFu6keSYM+miYTrHXIWwYEuTvwr0d2qKOYlQDhXSjNTC9FSVDKnLTWiEvjqmBKIE58A==
X-Received: by 2002:adf:b6a9:: with SMTP id j41mr5268509wre.70.1585902900172;
        Fri, 03 Apr 2020 01:35:00 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m11sm10720712wmf.9.2020.04.03.01.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 01:34:59 -0700 (PDT)
Date:   Fri, 3 Apr 2020 10:34:52 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Yi L Liu <yi.l.liu@intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Subject: Re: [PATCH v1 6/8] vfio/type1: Bind guest page tables to host
Message-ID: <20200403083407.GB1269501@myrica>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-7-git-send-email-yi.l.liu@intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FF98F@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A21D8C6@SHSMSX104.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D805F75@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A21ED01@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A21ED01@SHSMSX104.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 08:05:29AM +0000, Liu, Yi L wrote:
> > > > > static long vfio_iommu_type1_ioctl(void *iommu_data,
> > > > >  		default:
> > > > >  			return -EINVAL;
> > > > >  		}
> > > > > +
> > > > > +	} else if (cmd == VFIO_IOMMU_BIND) {
> > > >
> > > > BIND what? VFIO_IOMMU_BIND_PASID sounds clearer to me.
> > >
> > > Emm, it's up to the flags to indicate bind what. It was proposed to
> > > cover the three cases below:
> > > a) BIND/UNBIND_GPASID
> > > b) BIND/UNBIND_GPASID_TABLE
> > > c) BIND/UNBIND_PROCESS
> > > <only a) is covered in this patch>
> > > So it's called VFIO_IOMMU_BIND.
> > 
> > but aren't they all about PASID related binding?
> 
> yeah, I can rename it. :-)

I don't know if anyone intends to implement it, but SMMUv2 supports
nesting translation without any PASID support. For that case the name
VFIO_IOMMU_BIND_GUEST_PGTBL without "PASID" anywhere makes more sense.
Ideally we'd also use a neutral name for the IOMMU API instead of
bind_gpasid(), but that's easier to change later.

Thanks,
Jean

