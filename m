Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A0EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE87206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="duiM5LY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgDGLBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 07:01:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54461 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgDGLBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 07:01:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id h2so1281101wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 04:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7e9JekbMjRN4qPP6TudcyC7igTWSIzN2Q0/JhAQisHk=;
        b=duiM5LY4uZHmex4Jt6wly7w4b8nz+kynRNmoYgzVHI2ALnmCS9o3l7eRxd0wjBwdyV
         gbkolDuuheNfRxLCT24aNDLzV/Z2m9v70GkrEG6cWYU0/omnLSKHNfvfTG3gwej2D9H1
         4f+gjsxAGivrRr9lb70weK10C4ni2WemjUf5V1iDy6Xawp2sdtat5DSgNf5panWRyt0h
         rcRw1t4IDFCYct9gfq/Dnia8VNNMyQfOAST2/TqQExF+77UzzScDP5wRwIrk4ShggYV6
         BAymg2P98k6WxZdHTpRYAoZipthquxivlmzUzDPOKHxUvbZk35ywy5kODtjk+5RLjD56
         A1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7e9JekbMjRN4qPP6TudcyC7igTWSIzN2Q0/JhAQisHk=;
        b=WI2tR+7K8bOjcnG6TuVjB/dSxT0VT+DnWXW2K7tyVU3Lsj2hU65kFhN9VOaCE5BNky
         T03Kq7fVjCibXxwYaJ4AqtTcDzB8FnRZG7U0Y5c73eBVcCSdERxWhMB1yQ7BuXShK8A5
         tyk5Z/nFxNRO+wN8SxterjBFCqG402EQwQdmTCzsrAMDtevHtcfWzu2ncOJyF6D90Qe7
         gOwnAQPqdEJuRDhF6tUE7qYsYxOA/1rAaRddgy7Gcz3zwmoznwJwe0xNiFxgno8LtwdG
         z8A+2kwQcbdzzyfvKOYI28K8dsPSH0y0DEXrbqx7s8SyZb9A30ZlLUZBgCalzeNSsJtO
         xKcA==
X-Gm-Message-State: AGi0Pubb7a0dniL2/Kaj5PrwqTrS6stqVDOExU+J4v+azKpFHyWqRDbP
        XViCiPuFSBfLgM/3X1XoFMK/oiRBkms=
X-Google-Smtp-Source: APiQypJpn4ESFTAnvOZvBKGgLWqORpMqhwZ+ndImgbUVp841Jgn4bvs28o6JGa3FczBgoHt12e4o+A==
X-Received: by 2002:a1c:2489:: with SMTP id k131mr1905062wmk.86.1586257275550;
        Tue, 07 Apr 2020 04:01:15 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:6097:1406:6470:33b5])
        by smtp.gmail.com with ESMTPSA id u16sm30205510wro.23.2020.04.07.04.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 04:01:14 -0700 (PDT)
Date:   Tue, 7 Apr 2020 13:01:07 +0200
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
Subject: Re: [PATCH 03/10] iommu/ioasid: Introduce per set allocation APIs
Message-ID: <20200407110107.GA285264@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200401134745.GE882512@myrica>
 <20200406130245.690cfe15@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406130245.690cfe15@jacob-builder>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 01:02:45PM -0700, Jacob Pan wrote:
> > > +	sdata = kzalloc(sizeof(*sdata), GFP_KERNEL);
> > > +	if (!sdata)
> > > +		return -ENOMEM;  
> > 
> > I don't understand why we need this structure at all, nor why we need
> > the SID. Users have already allocated an ioasid_set, so why not just
> > stick the content of ioasid_set_data in there, and pass the
> > ioasid_set pointer to ioasid_alloc()?
> > 
> 
> My thinking was that ioasid_set is an opaque user token, e.g. we use mm
> to identify a common set belong to a VM.
> 
> This sdata is an IOASID internal structure for managing & servicing per
> set data. If we let user fill in the content, some of the entries need
> to be managed by the IOASID code under a lock.

We don't have to let users fill the content. A bit like iommu_domain:
device drivers don't modify it, they pass it to iommu_map() rather than
passing a domain ID.

> IMO, not suitable to let user allocate and manage.
> 
> Perhaps we should rename struct ioasid_set to ioasid_set_token?

Is the token actually used anywhere?  As far as I can tell VFIO does its
own uniqueness check before calling ioasid_alloc_set(), and consumers of
notifications don't read the token.

> 
> /**
>  * struct ioasid_set_data - Meta data about ioasid_set
>  *
>  * @token:	Unique to identify an IOASID set
>  * @xa:		XArray to store ioasid_set private ID to
> system-wide IOASID
>  *		mapping
>  * @max_id:	Max number of IOASIDs can be allocated within the set
>  * @nr_id	Number of IOASIDs allocated in the set
>  * @sid		ID of the set
>  */
> struct ioasid_set_data {
> 	struct ioasid_set *token;
> 	struct xarray xa;
> 	int size;
> 	int nr_ioasids;
> 	int sid;
> 	struct rcu_head rcu;
> };

How about we remove the current ioasid_set, call this structure ioasid_set
instead of ioasid_set_data, and have ioasid_alloc_set() return it, rather
than requiring users to allocate the ioasid_set themselves?

	struct ioasid_set *ioasid_alloc_set(ioasid_t quota):

This way ioasid_set is opaque to users (we could have the definition in
ioasid.c), but it can be passed to ioasid_alloc() and avoids the lookup by
SID. Could also add the unique token as a void * argument to
ioasid_alloc_set(), if needed.

Thanks,
Jean
