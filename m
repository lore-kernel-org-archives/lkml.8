Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4549C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A62DD208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C58ODwXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgFPQfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:35:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32389 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729912AbgFPQfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592325315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ORHnGJFA6Z19L1N7yd7kPFx1/z/PnVDRBNvmZJMNqEQ=;
        b=C58ODwXuEakej8S2vZBMO9sREEvmAah9xtwU9piCSyGunyo6hn6njjwk4YeuiuC0ZzlTDT
        rW3IFulau/nfbkH3YlGN0cvpyMF4mxRIQk9PS6buVNrhGaZTGImISkdkjyvqKDRofESlzm
        Mm9Ul/0NBmlrfJ+UlJQp/+6jZgs/T54=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-gH-oggDdPRa8ev6uGsQkRg-1; Tue, 16 Jun 2020 12:35:13 -0400
X-MC-Unique: gH-oggDdPRa8ev6uGsQkRg-1
Received: by mail-qk1-f197.google.com with SMTP id a6so17244240qka.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ORHnGJFA6Z19L1N7yd7kPFx1/z/PnVDRBNvmZJMNqEQ=;
        b=Ppf43pY8FhNXVoFFy29EQPp/XX9m9VFXgWjpougSDfdDmqB+hljxOFovGBdCDvA4fC
         kQtXGenfKFSzyscrtJthGFDbmZA/HlpRfne/NmIXnmT+OHjfqhrwmCV717+Cmr6Slqa4
         R0yvHU5ZcIAcTQixSOSJx4mdIhcisYXkvlGpPIyUVxGXTIb1o2mygFiJIfE+L7KmA45C
         IKywUgM6oUOzD7vi9tmhCUv/PZdUpF2ckET2UsNMbhgNn6V/T6A35JY9mEQ3OKfR/tzb
         XtScDv//TOZQaJLh/4mPjcv/eMEf2k5fvUgjCS5zU45crVPer4aXfNlvBloTZO6rRv1J
         zfjg==
X-Gm-Message-State: AOAM532aHbo0HSmAh/XvimKrbQzjeUu2RTsfKjXAcL4HyJuiTGaLdHmz
        +1zBxcLpSAznsnWp0Z8ENWSvfE2CzhLpqhJbaELN0LNK7/+aPtRo/xYrymMZVmJQNwcgGGQeSY3
        qRH9kLMEcJdyKyTNhWAmlshAP
X-Received: by 2002:a37:9587:: with SMTP id x129mr21560261qkd.184.1592325312798;
        Tue, 16 Jun 2020 09:35:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFtYGitcStKhm9rXFtngsYzszPm1k1N+2h9Oc/swRH+scEB+KPGSxp8+t3TKRkUXSpqa15Pg==
X-Received: by 2002:a37:9587:: with SMTP id x129mr21560236qkd.184.1592325312498;
        Tue, 16 Jun 2020 09:35:12 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id b24sm14336505qkj.0.2020.06.16.09.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 09:35:11 -0700 (PDT)
Date:   Tue, 16 Jun 2020 12:35:10 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 19/25] mm/s390: Use mm_fault_accounting()
Message-ID: <20200616163510.GD11838@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615222302.8452-1-peterx@redhat.com>
 <20200616155933.GA12897@oc3871087118.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616155933.GA12897@oc3871087118.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alexander,

On Tue, Jun 16, 2020 at 05:59:33PM +0200, Alexander Gordeev wrote:
> > @@ -489,21 +489,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> >  	if (unlikely(fault & VM_FAULT_ERROR))
> >  		goto out_up;
> > 
> > -	/*
> > -	 * Major/minor page fault accounting is only done on the
> > -	 * initial attempt. If we go through a retry, it is extremely
> > -	 * likely that the page will be found in page cache at that point.
> > -	 */
> >  	if (flags & FAULT_FLAG_ALLOW_RETRY) {
> > -		if (fault & VM_FAULT_MAJOR) {
> > -			tsk->maj_flt++;
> > -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
> > -				      regs, address);
> > -		} else {
> > -			tsk->min_flt++;
> > -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
> > -				      regs, address);
> > -		}
> >  		if (fault & VM_FAULT_RETRY) {
> >  			if (IS_ENABLED(CONFIG_PGSTE) && gmap &&
> >  			    (flags & FAULT_FLAG_RETRY_NOWAIT)) {
> 
> Seems like the call to mm_fault_accounting() will be missed if
> we entered here with FAULT_FLAG_RETRY_NOWAIT flag set, since it
> jumps to "out_up"...

This is true as a functional change.  However that also means that we've got a
VM_FAULT_RETRY, which hints that this fault has been requested to retry rather
than handled correctly (for instance, due to some try_lock failed during the
fault process).

To me, that case should not be counted as a page fault at all?  Or we might get
the same duplicated accounting when the page fault retried from a higher stack.

Thanks,

-- 
Peter Xu

