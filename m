Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC30DC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9272120735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c33eASpj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgEEOM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:12:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48972 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729219AbgEEOM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588687974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9QocmiR79ciyCV8YIogR/mIbS+d3+LtRW/0KmEr7MtM=;
        b=c33eASpjxykGTTat16XijkHaLXWb58lI0IqcNJJPtPhut7A8LNJZvd9EPsei2q+6r9YhA1
        qPTf4BRKkHr7bLAzhdewDNGW/cKerZ33PLVbqhIGqGdU8CvibQsUIDiKsFd181KWDZ2MSU
        4RoeCKM/KvUBXtmd4AU3cu6b/StZotU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-6OnTRXnfMh6jQtRIW_mcTg-1; Tue, 05 May 2020 10:12:49 -0400
X-MC-Unique: 6OnTRXnfMh6jQtRIW_mcTg-1
Received: by mail-qt1-f197.google.com with SMTP id e44so1799150qta.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9QocmiR79ciyCV8YIogR/mIbS+d3+LtRW/0KmEr7MtM=;
        b=pHnFSoiYt++iv5kMD8tFnDYSscZ7mXGD2AOw8RXaN8HZg2KOWzybaqmsT3pcxbRoE3
         4ItENiKygewLxwa7JOUTPBr0tzlB4UOUG+HBi/gs0OUL0h7q/glKOiZrHhkkdhJfa5Re
         Bw9YY9HzXclDBbun2PABFvkaFm3dEc5CZQbYR9SH7xAsi6H8DFkQAVxGIHB0z2RidRNN
         sznccOYJhN7sb8sjl1MS85dnjVljiQ5jdsJ/16JHsRNKALJjFNjTImXi7fM4VyQdyW/o
         JUfoB1tuvyh/Spm4t2tL5cFxZKZiaYZrk+JwthMzBA2fEd8+Z1Diyhj/2Y/asHgLHREQ
         zaSw==
X-Gm-Message-State: AGi0PuYjzmr/Co8OSMDua3vixPjzksiWhjh62mCtomUSBB4Z0ZGHNf2B
        J6UHInEzRGIJO2v6ikJ5qZXSWsR9KgS/LEGcUU7pltOuGzF+pGIHVAQPM3wUDULF4Cc5Ax3gpKw
        1R26L1GQ3NxhMeHg7K+brg7io
X-Received: by 2002:a05:620a:112c:: with SMTP id p12mr844433qkk.313.1588687967629;
        Tue, 05 May 2020 07:12:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypL2JXMwNHFY++ym7AgRDXitYWpCdW9rKuEVfwZfFB1urpeidfFT0kVgaOLz2D8FZ6rVTNljng==
X-Received: by 2002:a05:620a:112c:: with SMTP id p12mr844411qkk.313.1588687967341;
        Tue, 05 May 2020 07:12:47 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id v5sm1810925qkg.9.2020.05.05.07.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 07:12:46 -0700 (PDT)
Date:   Tue, 5 May 2020 10:12:45 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: Fix a warning in __kvm_gfn_to_hva_cache_init()
Message-ID: <20200505141245.GH6299@xz-x1>
References: <20200504190526.84456-1-peterx@redhat.com>
 <20200505013929.GA17225@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200505013929.GA17225@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 06:39:29PM -0700, Sean Christopherson wrote:
> On Mon, May 04, 2020 at 03:05:26PM -0400, Peter Xu wrote:
> > GCC 10.0.1 gives me this warning when building KVM:
> > 
> >   warning: ‘nr_pages_avail’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> >   2442 |  for ( ; start_gfn <= end_gfn; start_gfn += nr_pages_avail) {
> > 
> > It should not happen, but silent it.
> 
> Heh, third times a charm?  This has been reported and proposed twice
> before[1][2].  Are you using any custom compiler flags?  E.g. -O3 is known
> to cause false positives with -Wmaybe-uninitialized.

No, what I did was only upgrading to Fedora 32 (which will auto-upgrade GCC),
so it should be using the default params of whatever provided.

> 
> If we do end up killing this warning, I'd still prefer to use
> uninitialized_var() over zero-initializing the variable.
> 
> [1] https://lkml.kernel.org/r/20200218184756.242904-1-oupton@google.com
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=207173

OK, I didn't know this is a known problem and discussions going on.  But I
guess it would be good to address this sooner because it could become a common
warning very soon after people upgrades gcc.

Thanks,

-- 
Peter Xu

