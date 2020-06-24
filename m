Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D425C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B43072081A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNU6JS/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgFXUeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:34:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56688 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406668AbgFXUeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593030858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=778N0YMcrWGuAWTtdx98/Vr/9f1rp+JvrngLnU6hHko=;
        b=NNU6JS/xD9X5jbuOXnq+Ld4bDN5seEtLu/xgrvctD20XGP0nGZU81BuVcyAAwZHynlkyia
        zXISI2wVnNoBaB/Rwwfofd35EKg7jnr9qLH8t0ZYjm7ubYTtB6Wg5QuYjqmrOpknbWM5vd
        NLy4MmcisVGI/OZcoEwXLD66l4yWgSM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-jkAxVAZJPs-1VGMDdt9dJg-1; Wed, 24 Jun 2020 16:34:16 -0400
X-MC-Unique: jkAxVAZJPs-1VGMDdt9dJg-1
Received: by mail-qv1-f72.google.com with SMTP id q5so2474334qvp.23
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=778N0YMcrWGuAWTtdx98/Vr/9f1rp+JvrngLnU6hHko=;
        b=HacqS57mw37EnzuEbm0WglzJ/wVWSJYmg+Bo8S208CvVVxwumJDTrlnz3uRnerZgM7
         k7j0fs8bg58KkX2XKQgHBiLN3Uu5G8DmlZ/nrFPu0i0/f8KWP1imNj3jw5932OxH/pip
         RxdIU0IrgfbsxZ/6nbBfONK9SXwZxF6Ha3jRg1mdGWXo5KAhMbmsO5dY/t5DJtOlunEe
         C+2HZfzhrK1fOa91zqF6S/BsuuZgyfiw8tXQ3MZtOpJFukkQYOz+OoNq8lDY0QC6RvSv
         oJzexbo3g2SiuGImcP40AZbo7aYPqxzaFL91NojA4Jwt6OV5moyhefztBZhbQO5cCU2S
         u7nw==
X-Gm-Message-State: AOAM5327FsqQdnDmrSoYeSyRtE+/PltNPaDQ2Do9MGyk0FEz4RnkeWQF
        rlDnMT+POl8yn4vgspHZMh/P4HcIN+qPavxRYpYF7rQ4hsuwOFPQYtXEGMEyicn1H3GKcPfSYxm
        mtl2P/H9MEpxJJSBdLSdj+zIt
X-Received: by 2002:a37:43cb:: with SMTP id q194mr27321566qka.154.1593030856261;
        Wed, 24 Jun 2020 13:34:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNXQ5NY+YbSA74fgnqtSQv3vnfiyEXo0+8mMyoZWuHcrsoUvzY+Sy8ucVTe+W675Myu5adnA==
X-Received: by 2002:a37:43cb:: with SMTP id q194mr27321541qka.154.1593030855957;
        Wed, 24 Jun 2020 13:34:15 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id d78sm4032465qkg.106.2020.06.24.13.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 13:34:14 -0700 (PDT)
Date:   Wed, 24 Jun 2020 16:34:12 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/26] mm: Do page fault accounting in handle_mm_fault
Message-ID: <20200624203412.GB64004@xz-x1>
References: <20200619160538.8641-1-peterx@redhat.com>
 <20200619160538.8641-2-peterx@redhat.com>
 <20200624204903.097a5a58@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200624204903.097a5a58@thinkpad>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 08:49:03PM +0200, Gerald Schaefer wrote:
> On Fri, 19 Jun 2020 12:05:13 -0400
> Peter Xu <peterx@redhat.com> wrote:
> 
> [...]
> 
> > @@ -4393,6 +4425,38 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
> >  			mem_cgroup_oom_synchronize(false);
> >  	}
> > 
> > +	if (ret & VM_FAULT_RETRY)
> > +		return ret;
> 
> I'm wondering if this also needs a check and exit for VM_FAULT_ERROR.
> In arch code (s390 and all others I briefly checked), the accounting
> was skipped for VM_FAULT_ERROR case.

Yes. I didn't explicitly add the check because I thought it's still OK to count
the error cases, especially after we've discussed about
PERF_COUNT_SW_PAGE_FAULTS in v1.  So far, the major reason (iiuc) to have
PERF_COUNT_SW_PAGE_FAULTS still in per-arch handlers is to also cover these
corner cases like VM_FAULT_ERROR.  So to me it makes sense too to also count
them in here.  But I agree it changes the old counting on most archs.

Again, I don't have strong opinion either on this, just like the same to
PERF_COUNT_SW_PAGE_FAULTS...  But if no one disagree, I will change this to:

  if (ret & (VM_FAULT_RETRY | VM_FAULT_ERROR))
      return ret;

So we try our best to follow the past.

Btw, note that there will still be some even more special corner cases. E.g.,
for ARM64 it's also not accounted for some ARM64 specific fault errors
(VM_FAULT_BADMAP, VM_FAULT_BADACCESS).  So even if we don't count
VM_FAULT_ERROR, we might still count these for ARM64.  We can try to redefine
VM_FAULT_ERROR in ARM64 to cover all the arch-specific errors, however that
seems an overkill to me sololy for fault accountings, so hopefully I can ignore
that difference.

> 
> > +
> > +	/*
> > +	 * Do accounting in the common code, to avoid unnecessary
> > +	 * architecture differences or duplicated code.
> > +	 *
> > +	 * We arbitrarily make the rules be:
> > +	 *
> > +	 *  - faults that never even got here (because the address
> > +	 *    wasn't valid). That includes arch_vma_access_permitted()
> 
> Missing "do not count" at the end of the first sentence?
> 
> > +	 *    failing above.
> > +	 *
> > +	 *    So this is expressly not a "this many hardware page
> > +	 *    faults" counter. Use the hw profiling for that.
> > +	 *
> > +	 *  - incomplete faults (ie RETRY) do not count (see above).
> > +	 *    They will only count once completed.
> > +	 *
> > +	 *  - the fault counts as a "major" fault when the final
> > +	 *    successful fault is VM_FAULT_MAJOR, or if it was a
> > +	 *    retry (which implies that we couldn't handle it
> > +	 *    immediately previously).
> > +	 *
> > +	 *  - if the fault is done for GUP, regs wil be NULL and
> 
> wil -> will

Will fix both places.  Thanks,

-- 
Peter Xu

