Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2135BC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F050C20CC7
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULYNzhjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgEHOay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:30:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48692 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726873AbgEHOax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588948250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lIRjAGCSvbO1PdVeTIb+ibHQAikoDQgX7hMGEBLwgkE=;
        b=ULYNzhjnLm8tSjHrLNjqg5NCi/l5n+qQjsatWmhfuCGF9AGPqQ9rLaeO4f8kBBH7zp94i5
        C1Z/T4dRQm/QZWee8C4r8CKCwJJxGe5Ym/OyDcbuPcZByZOIbJMdObvwfiMVr60jGcF7u2
        93AqbQQo0IrwoiPkejh2Fz1y+MlIcZw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-ey8eZz3OMjSGpdPbsrGPyA-1; Fri, 08 May 2020 10:30:49 -0400
X-MC-Unique: ey8eZz3OMjSGpdPbsrGPyA-1
Received: by mail-qk1-f197.google.com with SMTP id v6so1116340qkh.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 07:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lIRjAGCSvbO1PdVeTIb+ibHQAikoDQgX7hMGEBLwgkE=;
        b=trPFOcb608548VicCFxJlHFB9dXuP0wv2IZ2HYGq6KgMHcwLbYRsL/csuZ43wkSfPB
         Hdh6PgWPab1u6KCizhJWWWTAzGQxD4kx1vovRMfVbBtpJ/NXNrfEDBvUn9wFY4rMc3c+
         Iai20N0UDFB6wuVNhLxZ3ENiFRU7Df3GAE+YDVhSS7iUQ61XjJPTS5CTzxZTG+YqvXP9
         pxcp69s3Zh5Jr9h2KJrCH9S5AhgtF9m7d1FFCVXSvo+wuKR+lcUa3WmBuJutE+7PpR3V
         O8eA4h5QRYW4FycLV7fXszIlJceemYVSRQYfj3FCkca7KM+WtPysW6cSZY3urm3ubefc
         wPig==
X-Gm-Message-State: AGi0PuYtD19KxZTGjnsE2Cg2Qn0qBzQZTUs1BGGW7cTZeI3P9GLKmB7x
        YlI22cH2r0Gg/fqprz2Fn/EtOdo6wV2Ve3ftnGcaRrygMwg4SXel0H0N7z6Yhcf9dKdsjrmTBLK
        QGtwsgn761AuSHiVWgxIABZY6
X-Received: by 2002:aed:2e24:: with SMTP id j33mr3254490qtd.117.1588948247009;
        Fri, 08 May 2020 07:30:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypLpIgVamTZ1EUCABaqOg/LRWWRWl2ZAJbE/Vu45j1TY2btxCLAF4n4xUil/Okkd6JIjfe6Bqg==
X-Received: by 2002:aed:2e24:: with SMTP id j33mr3254355qtd.117.1588948245283;
        Fri, 08 May 2020 07:30:45 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id k58sm1603302qtf.40.2020.05.08.07.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 07:30:44 -0700 (PDT)
Date:   Fri, 8 May 2020 10:30:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com
Subject: Re: [PATCH v2 1/3] vfio/type1: Support faulting PFNMAP vmas
Message-ID: <20200508143042.GY228260@xz-x1>
References: <158871401328.15589.17598154478222071285.stgit@gimli.home>
 <158871568480.15589.17339878308143043906.stgit@gimli.home>
 <20200507212443.GO228260@xz-x1>
 <20200507235421.GK26002@ziepe.ca>
 <20200508021939.GT228260@xz-x1>
 <20200508121013.GO26002@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200508121013.GO26002@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 09:10:13AM -0300, Jason Gunthorpe wrote:
> On Thu, May 07, 2020 at 10:19:39PM -0400, Peter Xu wrote:
> > On Thu, May 07, 2020 at 08:54:21PM -0300, Jason Gunthorpe wrote:
> > > On Thu, May 07, 2020 at 05:24:43PM -0400, Peter Xu wrote:
> > > > On Tue, May 05, 2020 at 03:54:44PM -0600, Alex Williamson wrote:
> > > > > With conversion to follow_pfn(), DMA mapping a PFNMAP range depends on
> > > > > the range being faulted into the vma.  Add support to manually provide
> > > > > that, in the same way as done on KVM with hva_to_pfn_remapped().
> > > > > 
> > > > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > > >  drivers/vfio/vfio_iommu_type1.c |   36 +++++++++++++++++++++++++++++++++---
> > > > >  1 file changed, 33 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > > > > index cc1d64765ce7..4a4cb7cd86b2 100644
> > > > > +++ b/drivers/vfio/vfio_iommu_type1.c
> > > > > @@ -317,6 +317,32 @@ static int put_pfn(unsigned long pfn, int prot)
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > +static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
> > > > > +			    unsigned long vaddr, unsigned long *pfn,
> > > > > +			    bool write_fault)
> > > > > +{
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = follow_pfn(vma, vaddr, pfn);
> > > > > +	if (ret) {
> > > > > +		bool unlocked = false;
> > > > > +
> > > > > +		ret = fixup_user_fault(NULL, mm, vaddr,
> > > > > +				       FAULT_FLAG_REMOTE |
> > > > > +				       (write_fault ?  FAULT_FLAG_WRITE : 0),
> > > > > +				       &unlocked);
> > > > > +		if (unlocked)
> > > > > +			return -EAGAIN;
> > > > 
> > > > Hi, Alex,
> > > > 
> > > > IIUC this retry is not needed too because fixup_user_fault() will guarantee the
> > > > fault-in is done correctly with the valid PTE as long as ret==0, even if
> > > > unlocked==true.
> > > 
> > > It is true, and today it is fine, but be careful when reworking this
> > > to use notifiers as unlocked also means things like the vma pointer
> > > are invalidated.
> > 
> > Oh right, thanks for noticing that.  Then we should probably still keep the
> > retry logic... because otherwise the latter follow_pfn() could be referencing
> > an invalid vma already...
> 
> I looked briefly and thought this flow used the vma only once?

        ret = follow_pfn(vma, vaddr, pfn);
        if (ret) {
                bool unlocked = false;
 
                ret = fixup_user_fault(NULL, mm, vaddr,
                                       FAULT_FLAG_REMOTE |
                                       (write_fault ?  FAULT_FLAG_WRITE : 0),
                                       &unlocked);
                if (unlocked)
                        return -EAGAIN;
 
                if (ret)
                        return ret;
 
                ret = follow_pfn(vma, vaddr, pfn);      <--------------- [1]
        }

So imo the 2nd follow_pfn() [1] could be racy if without the unlocked check.

Thanks,

-- 
Peter Xu

