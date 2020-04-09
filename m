Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2732AC2BB86
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 22:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A0720B1F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 22:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMUYiBy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgDIWS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 18:18:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22275 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726872AbgDIWS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 18:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586470707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wak+4fOkmGwWiUN+MnpwHwLxfkg3pyB2FLjyHTCXGe0=;
        b=cMUYiBy5gbI3t45FJRnkkIzfZtcnxa1+BeqSKPnKsKwhvVXzuZc/V4ePhuLBCZ03zBGQKR
        PAknRmspyRa5UWWzJXoBCyHGQrjTHc4JJE7VgAdiWv6OZFWC+UvesvnLPUZEyauE0ZQtyJ
        Wd7skqmyehUHZNRiplzgw4y+lyfaUJM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-k-EzJbwwMge0ZzZeFaSQhA-1; Thu, 09 Apr 2020 18:18:23 -0400
X-MC-Unique: k-EzJbwwMge0ZzZeFaSQhA-1
Received: by mail-qv1-f72.google.com with SMTP id f9so100308qvt.14
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 15:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wak+4fOkmGwWiUN+MnpwHwLxfkg3pyB2FLjyHTCXGe0=;
        b=nPFh3Hv+v2VCAcW5d8LCBVqqM7n5voWC8LbQlZMIDNmCAfHI1jIOB6B+H/goewEaIq
         kykyANbFbTuKoxKyuyjr3/eRwXsEYPcMGG2HlHQHF0EjPVA/Zeis3fD4go73rXYH/oC6
         2AC0TTRXnlZGlwko6mfjn3q7ckCSrjHkQOOpo+hvojAdBedj/bE3Ej71a6/MGZQBAjdK
         opB0lEVQcn7LU1eqt1fVqsoMN61aRFcUhb7JR2wSPb7BkSTfHbIVXcmrpLgJRTCJqwyQ
         WhyO7WFSugRSXbomfUhlpO7NMmPiBVhrO261YxH9i1CroAfdQDCdEUe0XoJ2L21cKTrk
         6pqg==
X-Gm-Message-State: AGi0Pub/7Ovsa8uJOeTLuwXpYNedvaeUe+W3A2P+U3oI3aN+MzZk2xqF
        JolOgV4XeezJZje9GN3OXJpVB/SZ0I+mpZFMFjkj+SkewRTfpP2c4X3UaHH4vaEoyg4FX38kzla
        kIq8WeX0s243opLHfEDIoHFu8
X-Received: by 2002:a37:4117:: with SMTP id o23mr1141041qka.295.1586470702715;
        Thu, 09 Apr 2020 15:18:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypIJD/iTRAWfSQIyFtDJJdk3323wKWVJn7GNTy0DpExPfZvgf67+NsccoV0ON/i9YnqzueJ/4g==
X-Received: by 2002:a37:4117:: with SMTP id o23mr1141019qka.295.1586470702419;
        Thu, 09 Apr 2020 15:18:22 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id o18sm165603qkk.52.2020.04.09.15.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 15:18:21 -0700 (PDT)
Date:   Thu, 9 Apr 2020 18:18:19 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Documentation: hugetlb: Update hugetlb options
Message-ID: <20200409221819.GA3172@xz-x1>
References: <20200409215800.8967-1-peterx@redhat.com>
 <ba5c87df-9a77-ebd2-e45e-f262a36fbf22@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba5c87df-9a77-ebd2-e45e-f262a36fbf22@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 03:08:07PM -0700, Mike Kravetz wrote:
> On 4/9/20 2:58 PM, Peter Xu wrote:
> > The hugepage options are not documented clearly.
> > 
> > Firstly, default_hugepagesz= should always be specified after the
> > declaration of the same type of huge page using hugepagesz=.  For
> > example, if we boot a x86_64 system with kernel cmdline
> > "default_hugepagesz=2M", we'll get a very funny error message:
> > 
> > "HugeTLB: unsupported default_hugepagesz 2097152. Reverting to 2097152"
> > 
> > It's understandable from code-wise because when hugetlb_init() we
> > didn't have the 2M page hstate registered, so it's unsupported.
> > However 2M is actually the default huge page size on x86_64, so we'll
> > register it right after the error message.  However it's very
> > confusing if without these knowledges.
> > 
> > Secondly, hugepages= option must be used _after_ another hugepagesz=.
> > The word "interleave" is fine but it didn't declare the fact that
> > each of the hugepages= option will be applied to the previous parsed
> > hugepagesz= option.
> > 
> > State all these clear.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Hi Peter,
> 
> Did you happen to see this patch series?
> 
> https://lore.kernel.org/linux-mm/20200401183819.20647-1-mike.kravetz@oracle.com/
> 
> That should address the documentation issue and more.

Great!

I missed that, but I'll definitely read it (probably tomorrow).  Let's
ignore this patch then.

Thanks,

-- 
Peter Xu

