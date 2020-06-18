Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C87C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A33B20EDD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMlpmJdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbgFRVYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:24:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30293 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728538AbgFRVYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 17:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592515475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=haaLTYqgVfoC0FVdaFLPcnNGgU33JcWlnnRtWPFZDGE=;
        b=FMlpmJdSuKlMKZjSaCHn9xr4MowuUwnPghGhWo+taOHQxmZevhmy5nW2cA2Y0w8u+9EkPE
        43Ocb7CpBaeUX0jkybhQGTj8baGy2YaUVKxZBAaHFtZb2m11x2mST5gWNqpyT89c/+A4U9
        1YT67h9H+lOGs9diJMTxEHhwKCLykdY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-Ur_JoN0_OtWiGtCtreQynQ-1; Thu, 18 Jun 2020 17:24:33 -0400
X-MC-Unique: Ur_JoN0_OtWiGtCtreQynQ-1
Received: by mail-qt1-f198.google.com with SMTP id h30so3845758qtb.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 14:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=haaLTYqgVfoC0FVdaFLPcnNGgU33JcWlnnRtWPFZDGE=;
        b=q1G9t0pjQuCkCJqOhq6Uxss0C4AQbzbKhANzsgHPJ/7gO/VcVHfcvVRZbOjNh4PwBg
         1cd4BChsDhi6mMdHiwjqIb7IfSfXy/5wDpn1RXoC6o2p5kyD6MKFnooVUzkXtvXvlZNT
         PJNDUxQQiwaLLd4iXFeeyvGAzqk0JS7T7mJz9/3Zl8qVNJmXTyiYmb8pm9bMeeDA+k9I
         o60fsvzE0+2BUp7QE04Vxek6Ff6nDYcD0lSSjkbiwjfMMLQ4jof+RTUNAx4e3kT+DlyT
         oBy4xdO63nsf0saWjvuOtornaVdlizu1Nrp2SX81z0b8mQgImrcFvgeUm3yo2ydk3uRS
         4LQA==
X-Gm-Message-State: AOAM530D4NejHH26DWVNzwJx3t3Mmz+PSsXRbRYA2dxGyAQrAHFm8VGE
        TneAwd75o1SV51mW9JcXb83sklkvoNRJY7nLEb2pwllUOfi44OCofoGS9jNwX72L1djLr15Lhqm
        XZ+ByHjAHY5xWtz06ucp6n41t
X-Received: by 2002:a37:a89:: with SMTP id 131mr449508qkk.92.1592515473213;
        Thu, 18 Jun 2020 14:24:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOI3BDf105zZFrrtKLefw+JPntFffyT9jzVBn+gtJGfiQ/ZPPE81O97Qn5Qh7QuKxUQSj2Mg==
X-Received: by 2002:a37:a89:: with SMTP id 131mr449488qkk.92.1592515472972;
        Thu, 18 Jun 2020 14:24:32 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id y16sm4723019qty.1.2020.06.18.14.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 14:24:32 -0700 (PDT)
Date:   Thu, 18 Jun 2020 17:24:30 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guo Ren <guoren@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-csky@vger.kernel.org
Subject: Re: [PATCH 07/25] mm/csky: Use mm_fault_accounting()
Message-ID: <20200618212430.GO76766@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615221607.7764-8-peterx@redhat.com>
 <CAJF2gTSVSXO=phc1eeb-ZmDMrSDjSSLd3tN6ng_8n-pCSZh5zw@mail.gmail.com>
 <20200617154925.GC76766@xz-x1>
 <CAHk-=wi=58J7d5iyFyYyHrU+pzjWB55cit_LQCkSkavpH-trsg@mail.gmail.com>
 <20200617195807.GH76766@xz-x1>
 <CAHk-=wj_V2Tps2QrMn20_W0OJF9xqNh52XSGA42s-ZJ8Y+GyKw@mail.gmail.com>
 <20200618143801.GK76766@xz-x1>
 <CAHk-=whFEZbTJZaNwEkyevUV2aqRwbeVmtp6hhk1sK2mW4vaGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whFEZbTJZaNwEkyevUV2aqRwbeVmtp6hhk1sK2mW4vaGA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 10:15:50AM -0700, Linus Torvalds wrote:
> On Thu, Jun 18, 2020 at 7:38 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > GUP needs the per-task accounting, but not the perf events.  We can do that by
> > slightly changing the new approach into:
> >
> >         bool major = (ret & VM_FAULT_MAJOR) || (flags & FAULT_FLAG_TRIED);
> >
> >         if (major)
> >                 current->maj_flt++;
> >         else
> >                 current->min_flt++;
> >
> >         if (!regs)
> >                 return ret;
> >
> >         if (major)
> >                 perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, address);
> >         else
> >                 perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
> 
> Ack, I think this is the right thing to do.
> 
> No normal situation will ever notice the difference, with remote
> accesses being as rare and specialized as they are. But being able to
> remote the otherwise unused 'tsk' parameter sounds like the right
> thing to do too.
> 
> It might be worth adding a comment about why.
> 
> Also, honestly, how about we remove the 'major' variable entirely, and
> instead make the code be something like
> 
>         unsigned long *flt;
>         int event_type;
>         ...
> 
>         /* Major fault */
>         if ((ret & VM_FAULT_MAJOR) || (flags & FAULT_FLAG_TRIED)) {
>                 flt = &current->maj_flt;
>                 event_type = PERF_COUNT_SW_PAGE_FAULTS_MAJ;
>         } else {
>                 flt = &current->min_flt;
>                 event_type = PERF_COUNT_SW_PAGE_FAULTS_MIN;
>         }
>         *flt++;
>         if (regs)
>                 perf_sw_event(event_type, 1, regs, address);
> 
> instead. Less source code duplication, and I bet it improves code
> generation too.

Will do.  Thanks!

-- 
Peter Xu

