Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6143C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E8820721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ptml5nxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgDCMkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:40:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37907 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbgDCMkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:40:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id c7so8328236wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 05:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4UoTuchVPcQbessFRne4dgixRRmQ3IULpwTbXSdSKjI=;
        b=ptml5nxSRSHJqKFQi24/vBmgB1JRiVOfz6FKiC4gpmUxkWrdbIyK3uvOqzLg5W8uwh
         yk1CyLp9obg1oU+Hr7N6V0Qazv6OJMEPqjaiFOV+KsBE1iJSqdyMfGbI2Rl+ueZPP0RD
         q7v1i7bZgnoLW05nP9LCgF1a+3JHpfALZxf0xfNQn1SzUNgm31+sKib0d1IHusr6S6GN
         S3M6fCUQu+ra4TFkCP3PW0+YRlA/SrhwExhXWORiYZ0CKq/Y1szY6G0V/0lW1/+ql3PT
         vjcqmIc/VrpfqtHRjppi/1GU3b/+N4+HcwayMIoWnVrI9mhF+z3SZAPdivgHOcuQhmg3
         M9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4UoTuchVPcQbessFRne4dgixRRmQ3IULpwTbXSdSKjI=;
        b=ious6ABn5EHvB+ph9EdeTxF2xGvWC8LisJwE9ah9eTn3f8Vj6FNBz3B8TfRNHK6jrW
         pmN/dMj2CO0eUJpQS3NNQ22bZFZpZN/eZoZ1dstfJ0i8+DeAEVUBCYe981QGQiXtE537
         h6tVCmMedmy7S8gWe8HhMiG2tiPKDZKYlRO5isGcn7iZ3aalso4ehZU/uasuNnp6Dms/
         i/Nh5ka+hz+Pyw2C5lPNujuN/gGmpgTrzBoCP7aQcJz35Q0rZyY+VYhdIgqJbZchj6Ng
         o4YciBj986tiAUMBnpn8mY9Hm9LK5l10FajJWNxrnEs9YJ3v8sCXFwpYk5WiW9mEdlE7
         n4fw==
X-Gm-Message-State: AGi0PuaatSPkafrs4fIFdwM6zgPKNewRw+fNonpWJiAJAuU4+M5VPR7K
        YWs3Uo1Rz/MED2ntxXbPqPIWTw==
X-Google-Smtp-Source: APiQypJxxsi5NWBorLzelVFk5jRcSOCtWuTo4mTy/DlCSSr3s65XnB3k77Ei4DFGaxZmRYKmvHULRg==
X-Received: by 2002:a5d:44c3:: with SMTP id z3mr8800515wrr.284.1585917599670;
        Fri, 03 Apr 2020 05:39:59 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id 91sm5994296wrf.79.2020.04.03.05.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 05:39:59 -0700 (PDT)
Date:   Fri, 3 Apr 2020 14:39:51 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Subject: Re: [PATCH v1 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
Message-ID: <20200403123951.GA1410438@myrica>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-2-git-send-email-yi.l.liu@intel.com>
 <20200402135240.GE1176452@myrica>
 <A2975661238FB949B60364EF0F2C25743A2209E3@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A2209E3@SHSMSX104.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 11:56:09AM +0000, Liu, Yi L wrote:
> > >  /**
> > > + * VFIO_MM objects - create, release, get, put, search
> > > + * Caller of the function should have held vfio.vfio_mm_lock.
> > > + */
> > > +static struct vfio_mm *vfio_create_mm(struct mm_struct *mm)
> > > +{
> > > +	struct vfio_mm *vmm;
> > > +	struct vfio_mm_token *token;
> > > +	int ret = 0;
> > > +
> > > +	vmm = kzalloc(sizeof(*vmm), GFP_KERNEL);
> > > +	if (!vmm)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	/* Per mm IOASID set used for quota control and group operations */
> > > +	ret = ioasid_alloc_set((struct ioasid_set *) mm,
> > 
> > Hmm, either we need to change the token of ioasid_alloc_set() to "void *",
> > or pass an actual ioasid_set struct, but this cast doesn't look good :)
> >
> > As I commented on the IOASID series, I think we could embed a struct
> > ioasid_set into vfio_mm, pass that struct to all other ioasid_* functions,
> > and get rid of ioasid_sid.
> 
> I think change to "void *" is better as we needs the token to ensure all
> threads within a single VM share the same ioasid_set.

Don't they share the same vfio_mm?

Thanks,
Jean
> 
> > > +			       VFIO_DEFAULT_PASID_QUOTA, &vmm->ioasid_sid);
> > > +	if (ret) {
> > > +		kfree(vmm);
> > > +		return ERR_PTR(ret);
> > > +	}
> > > +
> > > +	kref_init(&vmm->kref);
> > > +	token = &vmm->token;
> > > +	token->val = mm;
> > 
> > Why the intermediate token struct?  Could we just store the mm_struct
> > pointer within vfio_mm?
> 
> Hmm, here we only want to use the pointer as a token, instead of using
> the structure behind the pointer. If store the mm_struct directly, may
> leave a space to further use its content, this is not good.
> 
> Regards,
> Yi Liu
> 
