Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640DCC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44CBA2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOUWFlT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgEHCTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 22:19:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20827 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbgEHCTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 22:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588904384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JLgSaSiv4yYvs1EPOLMzvQOEIO76IkdBvqeIXiY7JGM=;
        b=KOUWFlT9xjBwouWRnTx01ihtTMyn43q5Yyb6WeFfFQFgswZdM2510KQuTBmQJzxrfZApHw
        NrJLeaqCm5vbxcX7GuKHE20dLhECt5rqP+h/TFZZD1CSYBm0WuyCHtEcfTHiBn2YrCVA43
        kjYMNq78aS3T485ZTc2I6Y4VaEa9i5U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-iYG7U1iIMxian9LI29XpNQ-1; Thu, 07 May 2020 22:19:42 -0400
X-MC-Unique: iYG7U1iIMxian9LI29XpNQ-1
Received: by mail-qk1-f198.google.com with SMTP id h1so403182qkl.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 19:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JLgSaSiv4yYvs1EPOLMzvQOEIO76IkdBvqeIXiY7JGM=;
        b=MS6k/6K31VfeY2VXSk2ESI0dGMGNp0qL2XdKIZDVLzYYWmcsm+fVapoI4a371MOFKK
         +WsIIXg2U1H5gyGJuQRS1h70P/MAGk1SRN03jbuFZQJm28gad68JQ4HTPZt+DJl5Wigp
         f9Ghl+YLh3jaVEQxmVAfpKzLDEFMKH2dXSTZTUqC3hhVL2l33EWdxJvPucUbAOg+chM4
         cpOihJ1ysQvkWpUXKhi3WYWf8AtOx4LfIRylNbGjI/F0CsRYYE7eiBVnbijeD1CPQDsy
         25L2ucE09Tc8CtX1fFaJqfbdo9mXgx+gu/6/ij+cKL7w7rHGU0wcyScTStHu2RV05ja/
         qvGA==
X-Gm-Message-State: AGi0Pua/dkzqJZpkf4KdZc7JDGMfP3nNgspcpRbNm04+b/VMCap5KXH8
        pDDJZqBbrXy3JttTcNGeA93PjXCnbVIYeypu1S/mgAbXet//9AD4TAw4bbY2drDrttTC6AyObDc
        s6Ogp+USbrhzCYPi7oA56QFEC
X-Received: by 2002:a37:b244:: with SMTP id b65mr495695qkf.329.1588904381905;
        Thu, 07 May 2020 19:19:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypK5WVcJu8AxnvxH75BqYI7fquWzH90Irnz0KNnKxL7u7e3h154rbjbL3aetQuw1D3Oexo6GEQ==
X-Received: by 2002:a37:b244:: with SMTP id b65mr495685qkf.329.1588904381668;
        Thu, 07 May 2020 19:19:41 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id i59sm333207qtb.58.2020.05.07.19.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 19:19:41 -0700 (PDT)
Date:   Thu, 7 May 2020 22:19:39 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com
Subject: Re: [PATCH v2 1/3] vfio/type1: Support faulting PFNMAP vmas
Message-ID: <20200508021939.GT228260@xz-x1>
References: <158871401328.15589.17598154478222071285.stgit@gimli.home>
 <158871568480.15589.17339878308143043906.stgit@gimli.home>
 <20200507212443.GO228260@xz-x1>
 <20200507235421.GK26002@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200507235421.GK26002@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 08:54:21PM -0300, Jason Gunthorpe wrote:
> On Thu, May 07, 2020 at 05:24:43PM -0400, Peter Xu wrote:
> > On Tue, May 05, 2020 at 03:54:44PM -0600, Alex Williamson wrote:
> > > With conversion to follow_pfn(), DMA mapping a PFNMAP range depends on
> > > the range being faulted into the vma.  Add support to manually provide
> > > that, in the same way as done on KVM with hva_to_pfn_remapped().
> > > 
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > >  drivers/vfio/vfio_iommu_type1.c |   36 +++++++++++++++++++++++++++++++++---
> > >  1 file changed, 33 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > > index cc1d64765ce7..4a4cb7cd86b2 100644
> > > +++ b/drivers/vfio/vfio_iommu_type1.c
> > > @@ -317,6 +317,32 @@ static int put_pfn(unsigned long pfn, int prot)
> > >  	return 0;
> > >  }
> > >  
> > > +static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
> > > +			    unsigned long vaddr, unsigned long *pfn,
> > > +			    bool write_fault)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = follow_pfn(vma, vaddr, pfn);
> > > +	if (ret) {
> > > +		bool unlocked = false;
> > > +
> > > +		ret = fixup_user_fault(NULL, mm, vaddr,
> > > +				       FAULT_FLAG_REMOTE |
> > > +				       (write_fault ?  FAULT_FLAG_WRITE : 0),
> > > +				       &unlocked);
> > > +		if (unlocked)
> > > +			return -EAGAIN;
> > 
> > Hi, Alex,
> > 
> > IIUC this retry is not needed too because fixup_user_fault() will guarantee the
> > fault-in is done correctly with the valid PTE as long as ret==0, even if
> > unlocked==true.
> 
> It is true, and today it is fine, but be careful when reworking this
> to use notifiers as unlocked also means things like the vma pointer
> are invalidated.

Oh right, thanks for noticing that.  Then we should probably still keep the
retry logic... because otherwise the latter follow_pfn() could be referencing
an invalid vma already...

Thanks,

-- 
Peter Xu

