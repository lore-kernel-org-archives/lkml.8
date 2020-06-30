Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B8BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AFE42053B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QUdibEW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgF3VF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgF3VF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:05:27 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAB9C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:05:27 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o22so4981752pjw.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7IVzLJAup4VkDuAt/OunGpXP5pyiE7ynN3kodoEoQWE=;
        b=QUdibEW+tmy14fhQZz/MEX47zW5zuODLO2iw5hCK+fuz6atzNqZS7wfwq88aa5gGNZ
         tcoL4SeyvbY2vZmuDYF3SJACAtGQNg2IUJvfpnMncjKaqSpG+Ag8Up58cx+CC5r0x0by
         oWkkAUayol9EAh71nHOO/Cyzkwxn0qRfwv8rIwAUjTLk55vymD83jgXIJjUjDplKPxzQ
         twNxTc0A2bK/TrTAepZMJ8yD2igZBAP5033cejEg5xi9B5nra3awyGB6anyEkxBLnPth
         xMLNrjI0kueaOX2OFYgDwPamPjl7Tj5L+9O1YReWNl93rCB3emRFthqAk9voQHii1UyL
         1iLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7IVzLJAup4VkDuAt/OunGpXP5pyiE7ynN3kodoEoQWE=;
        b=THvUTBumXe2ohCp4cURbFgKM0XJ13evyjPJ6HfMsUsjwN3uBjsCFpzK9mHw4e9XhB9
         bHTdV2TYuYZXt2W+cYPc81XI7qu/jG2SPVyHH+cEnIApf3z30a6+hSFsARA4PyQawn6r
         Pg8SwkGAqDhum5hUgN4te3yuC7QpEHHoeD97EN1VPj+6B6dg51duViuXkHpaReawl7ku
         HNSnGl8T0cIXEHm13+ogofJXWZOA+Jkkr93jtf8XdC3GTjMwDdfEJuHloZtDxX8qmpPa
         Hu7aInlOk/aThuz2aTqMp6n5qzmKRnjS11kK3iZzre745i2hWafTV9KbkKUyU9qFsaVH
         8AKg==
X-Gm-Message-State: AOAM530R7oVsshqSce2uH10HQjS20ouOGYR1qKEszQnq4+lg7E93I3rQ
        OpktdEzkeMM0R/WRj/ehT1l17KgGbJk=
X-Google-Smtp-Source: ABdhPJyq5YmJisNfnjQfOl9rdHWGw5ke+qYQHvoo0zgIGiWy+mH4xpMMFhE4xTloPrHRDSCSwy44xw==
X-Received: by 2002:a17:90a:db0f:: with SMTP id g15mr23799623pjv.5.1593551125958;
        Tue, 30 Jun 2020 14:05:25 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id h100sm3168311pjb.46.2020.06.30.14.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 14:05:24 -0700 (PDT)
Date:   Tue, 30 Jun 2020 14:05:24 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Peter Xu <peterx@redhat.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 01/26] mm: Do page fault accounting in
 handle_mm_fault
In-Reply-To: <20200630204504.38516-1-peterx@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2006301401560.1512657@chino.kir.corp.google.com>
References: <20200630204504.38516-1-peterx@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020, Peter Xu wrote:

> @@ -4408,6 +4440,34 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  			mem_cgroup_oom_synchronize(false);
>  	}
>  
> +	if (ret & (VM_FAULT_RETRY | VM_FAULT_ERROR))
> +		return ret;
> +
> +	/*
> +	 * Do accounting in the common code, to avoid unnecessary
> +	 * architecture differences or duplicated code.
> +	 *
> +	 * We arbitrarily make the rules be:
> +	 *
> +	 *  - Unsuccessful faults do not count (e.g. when the address wasn't
> +	 *    valid). That includes arch_vma_access_permitted() failing above.
> +	 *
> +	 *    So this is expressly not a "this many hardware page faults"
> +	 *    counter. Use the hw profiling for that.
> +	 *
> +	 *  - Incomplete faults do not count (e.g. RETRY).  They will only
> +	 *    count once completed.
> +	 *
> +	 *  - The fault counts as a "major" fault when the final successful
> +	 *    fault is VM_FAULT_MAJOR, or if it was a retry (which implies that
> +	 *    we couldn't handle it immediately previously).
> +	 *
> +	 *  - If the fault is done for GUP, regs will be NULL and no accounting
> +	 *    will be done.
> +	 */
> +	mm_account_fault(regs, address, (ret & VM_FAULT_MAJOR) ||
> +			 (flags & FAULT_FLAG_TRIED));
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(handle_mm_fault);

Just a nit, likely not important: I wonder if it would be cleaner to pass 
the vm_fault_t into mm_account_fault() and then do the VM_FAULT_RETRY and
VM_FAULT_ERROR checks there as well as putting the comment about how 
accounting is handled in that function.  Your comment is great.
