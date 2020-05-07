Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A604C47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7051720720
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QSBVJtiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgEGXy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 19:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726476AbgEGXyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 19:54:25 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B4DC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 16:54:24 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id a15so307566qvt.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 16:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/raYmft6nSaYLNIgpOxoChFcf5nF1Q2ACz6k5lK6B/4=;
        b=QSBVJtiYPNgCyg1Ax8MDmIonk9zKYH0IwrH/+u1j84YGMeisn3e+g5EGfpuObjJv7H
         wXFl0tfpZnxNnL053pF5sRWfIpTmu9eUL4M/zurqAuPqCZexdEgP1pM2dggKDOZjnEyy
         f6umf0+v8hfXZ4AZKWQYtiLz6vbcbQ/SZhptvHMrDLwUmI9k8+UWJ8gEEN+lNSZiuSKN
         rgbjcYlDgqSq19b+5VbYruXqDxWlnvU6ogiMB6YnPypcQltpT5B/nG/bL2YQfDfbt0yM
         FeKyBoa4zJpeEKZGnc4fSHBnCA/++Yf4pPt5kyhoPiECazyfelAm9wkjL4fNtPGd5gQE
         5vUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/raYmft6nSaYLNIgpOxoChFcf5nF1Q2ACz6k5lK6B/4=;
        b=GqTfz5JW+jmFBhdDRX+9cgvuEqHFX7Gj1YCbvHiyhlH39a+pmLdA+5wDy9twhT2BoM
         3B98aWPi1lgalFWDvUiulpom5fr8q8JpxfMCtD8XyRCYoWIOWVRwreY4w1BnzFYFlhIh
         GQo0RXTmiezKeq2UEcoFhK7UkbX+IhSZ+27BowduPu4Br2Ies4cF+hmg1kXonfzJiOJV
         HxteT0tPUBuOIKytMbWU3qmvQrd2xJLeDi+jTYc3H6e9iRc69ucvvsqSOW0xrTxKxaWS
         bcuLz3mmOh/h7GzNyQk2jWvT3JwrqZW+QceRNfaUY2vg4OjA9f5HA1vpS8uS1KEI5hyb
         q2Iw==
X-Gm-Message-State: AGi0PubQ+l5n/Lm3QiTCO4zGdC+6YQis226b5td0plIaXG7Iv982ESSk
        5ABZU98jzaI323N+AOohOo2ubw==
X-Google-Smtp-Source: APiQypJYoWIyvU8RY67V0VqBgsWt6nPorPZktKfWBDwkHhKb5x5+IKwxKG3GMtrHiOuUW542Jyo5Xw==
X-Received: by 2002:ad4:4966:: with SMTP id p6mr61018qvy.161.1588895663160;
        Thu, 07 May 2020 16:54:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id j11sm4877452qkk.33.2020.05.07.16.54.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2020 16:54:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jWqLN-00070n-OS; Thu, 07 May 2020 20:54:21 -0300
Date:   Thu, 7 May 2020 20:54:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com
Subject: Re: [PATCH v2 1/3] vfio/type1: Support faulting PFNMAP vmas
Message-ID: <20200507235421.GK26002@ziepe.ca>
References: <158871401328.15589.17598154478222071285.stgit@gimli.home>
 <158871568480.15589.17339878308143043906.stgit@gimli.home>
 <20200507212443.GO228260@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507212443.GO228260@xz-x1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 05:24:43PM -0400, Peter Xu wrote:
> On Tue, May 05, 2020 at 03:54:44PM -0600, Alex Williamson wrote:
> > With conversion to follow_pfn(), DMA mapping a PFNMAP range depends on
> > the range being faulted into the vma.  Add support to manually provide
> > that, in the same way as done on KVM with hva_to_pfn_remapped().
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> >  drivers/vfio/vfio_iommu_type1.c |   36 +++++++++++++++++++++++++++++++++---
> >  1 file changed, 33 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index cc1d64765ce7..4a4cb7cd86b2 100644
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -317,6 +317,32 @@ static int put_pfn(unsigned long pfn, int prot)
> >  	return 0;
> >  }
> >  
> > +static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
> > +			    unsigned long vaddr, unsigned long *pfn,
> > +			    bool write_fault)
> > +{
> > +	int ret;
> > +
> > +	ret = follow_pfn(vma, vaddr, pfn);
> > +	if (ret) {
> > +		bool unlocked = false;
> > +
> > +		ret = fixup_user_fault(NULL, mm, vaddr,
> > +				       FAULT_FLAG_REMOTE |
> > +				       (write_fault ?  FAULT_FLAG_WRITE : 0),
> > +				       &unlocked);
> > +		if (unlocked)
> > +			return -EAGAIN;
> 
> Hi, Alex,
> 
> IIUC this retry is not needed too because fixup_user_fault() will guarantee the
> fault-in is done correctly with the valid PTE as long as ret==0, even if
> unlocked==true.

It is true, and today it is fine, but be careful when reworking this
to use notifiers as unlocked also means things like the vma pointer
are invalidated.

Jason
