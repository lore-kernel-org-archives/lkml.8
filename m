Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6731DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474CB23D6A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRVCcChd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgFTQIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:08:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53254 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725957AbgFTQIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592669311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uAGWGHZX+NRKxPhaQCrHlyIVKqgbsc6xDoomuBD05Hw=;
        b=HRVCcChduwqCMPn//fe8n8VzggZ0W8IgYjdkVScXl3X1/W5nqiDc2IYGPRsJzUt0dN0GAw
        mE/AGExA5yWkg2xaJ/YH/1ghph1VlWZ8c5qLrUaj9rDAtugTa4BCyaeURbKFpjLnxuE4bj
        x0HgIQiNrfcA7KYozxCtUwkHWpBNK9A=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-3S_bh-Q4OqiklVFXqBv1wA-1; Sat, 20 Jun 2020 12:08:29 -0400
X-MC-Unique: 3S_bh-Q4OqiklVFXqBv1wA-1
Received: by mail-qt1-f200.google.com with SMTP id y5so9557684qto.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uAGWGHZX+NRKxPhaQCrHlyIVKqgbsc6xDoomuBD05Hw=;
        b=soVRsWrV+Lm7KgRZcEjpiLeAEnkHx2xf7Ep/0OiQ+5FBoREvuHbnLJb0WZNCqn1Iut
         MDfPxM+GTaB6Kqkut1l0tFok8kBPiB8hQtCeCOeH4FL1sWjdiTbhpCMDNd4NbnNGhDEA
         YsAgiPvIPJPC/hULwonAGhm0ilArlEG0Sy7owDT6mQ7gWte8oms1G0KeIMQpbqSTzFzQ
         eIgdpSRFcQpMRalU4imYzHJ2MEOoVQsNoHkleM0z8WYzuwTBhC7zRzU7Z4/QhLVZ31wB
         3r6rmG/3BzNTEjo40p1AzL90TFheJtCalwg7wf/H1eS1khOrV3T5FF4r5BGD+o2ijTyI
         9I8g==
X-Gm-Message-State: AOAM530ymePso4Q2FhHlnIK3Rvsnw47yG1Xd8LEVaRM3uBjmxLBg5SVk
        UfVbE+O+RsLFrTH67UjloahKSYAu7Blg6RrsBq4FqpyyIlpiP/zfIwKdJim0uuO/Xo/B0mVv/sK
        ui62S0Ng1rCrXJOkaAhHvBkGW
X-Received: by 2002:ac8:2af4:: with SMTP id c49mr7855097qta.42.1592669308735;
        Sat, 20 Jun 2020 09:08:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhW6m+v5NAydxoWwY4YCydn/fcpsNSqMLAgkBrIBmXw9vSkjNqmzWLGoF9/VukK2HQYENUBg==
X-Received: by 2002:ac8:2af4:: with SMTP id c49mr7855067qta.42.1592669308443;
        Sat, 20 Jun 2020 09:08:28 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 195sm9432761qkg.74.2020.06.20.09.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 09:08:27 -0700 (PDT)
Date:   Sat, 20 Jun 2020 12:08:25 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-csky@vger.kernel.org
Subject: Re: [PATCH 06/26] mm/csky: Use general page fault accounting
Message-ID: <20200620160825.GC6414@xz-x1>
References: <20200619160538.8641-1-peterx@redhat.com>
 <20200619160538.8641-7-peterx@redhat.com>
 <CAJF2gTS+6UwSAbHk9236g2FOhyYniKZ-W3DcKJuSYMF13qHZxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTS+6UwSAbHk9236g2FOhyYniKZ-W3DcKJuSYMF13qHZxQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 09:44:31AM +0800, Guo Ren wrote:
> On Sat, Jun 20, 2020 at 12:05 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > Use the general page fault accounting by passing regs into handle_mm_fault().
> > It naturally solve the issue of multiple page fault accounting when page fault
> > retry happened.
> >
> > CC: Guo Ren <guoren@kernel.org>
> > CC: linux-csky@vger.kernel.org
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  arch/csky/mm/fault.c | 12 +-----------
> >  1 file changed, 1 insertion(+), 11 deletions(-)
> >
> > diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
> > index b14f97d3cb15..a3e0aa3ebb79 100644
> > --- a/arch/csky/mm/fault.c
> > +++ b/arch/csky/mm/fault.c
> > @@ -151,7 +151,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
> >          * the fault.
> >          */
> >         fault = handle_mm_fault(vma, address, write ? FAULT_FLAG_WRITE : 0,
> > -                               NULL);
> > +                               regs);
> what's your kernel version ? （4th arg exsist ?）
>         /*
>          * If for any reason at all we couldn't handle the fault,
>          * make sure we exit gracefully rather than endlessly redo
>          * the fault.
>          */
>         fault = handle_mm_fault(vma, address, write ? FAULT_FLAG_WRITE : 0);
>         if (unlikely(fault & VM_FAULT_ERROR)) {

Hi, Guo,

Sorry to be unclear.  This patch is based on patch 1 in the same series:

https://lore.kernel.org/lkml/20200619160538.8641-2-peterx@redhat.com/

Thanks,

-- 
Peter Xu

