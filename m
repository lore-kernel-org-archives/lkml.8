Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764F0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 524792088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZ7Yr9sD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgGCAqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 20:46:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49641 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725937AbgGCAqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 20:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593737183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9rqwmq1BXfatZyLmM0JFLeV+p7atwrIAzGXvJ0Y4ZPM=;
        b=HZ7Yr9sD3dyZ4XewrQz2BviK+WqzUeBm8Vm64qUj1FnjiU3aeA2CF/g+F12k1K6rViKY66
        h0qUfS9rLODzGqUrc5KwMSr5zRFy63LP7ZfVygUSuIugMHnzp+94dIZrC6xTMAb5KIg0mw
        FebPKwGi6TQ2SlhIcPXaq1W6AlvKDZI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-oJFzVXfkOjK0m6g-aZHR_w-1; Thu, 02 Jul 2020 20:46:22 -0400
X-MC-Unique: oJFzVXfkOjK0m6g-aZHR_w-1
Received: by mail-qv1-f69.google.com with SMTP id j6so19569958qvl.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 17:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9rqwmq1BXfatZyLmM0JFLeV+p7atwrIAzGXvJ0Y4ZPM=;
        b=Y1AUJ3SwIKDlt7YcDGSO5YouqnaojpT1io4kj7K4aHE9pUcftwRF3uJakapxgKwbHn
         svduJCq6eWlqAfhYcsuTpk0UqLyn5cIQ2JziJJKDReRKbZ8Uk1w6zi2G5p4L5XHJPt2t
         kyafTYCHHPBhAAph5X48rUcBBhXOwQfDEY0wy8IB7haOSUtIYDZhoOqyhBidVNR9HRqv
         yDfRkPfR7SD81EM1pWYgbJh5wfl8aSDkc1K6VOZz3np7OmH4zjrwGf5QltZ8vgQ+y0wY
         N1CD+stmhDeLmni8eYe7noTX3YLsHEaXdDiZbjmzj5UPfVu/gYb7A+IuFJ4Dgj6cfDFy
         AknA==
X-Gm-Message-State: AOAM5337B8is10cJXdlqeXUVKe3SFmVzdjtwJ9MOMWkiHrI5XWPCwyFJ
        57RvGzqgdaT/kJFlV9ZV2vUP61EezssAl6OlDJOHNTlPt0XuzXejqudajA636v/unUbAZ3uVxpm
        AytOXjEIbQinjJ0ePt4vPdG0a
X-Received: by 2002:a37:9fc2:: with SMTP id i185mr31515432qke.481.1593737181621;
        Thu, 02 Jul 2020 17:46:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOZVt1rNwhhw6r5JjnkASIBSV0ZVmK0m+nybu6BuerB0f3qAECba+gztBqlgJIH0uHbePjfQ==
X-Received: by 2002:a37:9fc2:: with SMTP id i185mr31515420qke.481.1593737181371;
        Thu, 02 Jul 2020 17:46:21 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id p7sm9336307qki.61.2020.07.02.17.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 17:46:20 -0700 (PDT)
Date:   Thu, 2 Jul 2020 20:46:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 23/26] mm/x86: Use general page fault accounting
Message-ID: <20200703004618.GA6677@xz-x1>
References: <20200630204601.39591-1-peterx@redhat.com>
 <f75ffbf6-5e88-74b8-ffb0-59a316dc6ff3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f75ffbf6-5e88-74b8-ffb0-59a316dc6ff3@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dave,

On Wed, Jul 01, 2020 at 08:35:40AM -0700, Dave Hansen wrote:
> On 6/30/20 1:46 PM, Peter Xu wrote:
> > Use the general page fault accounting by passing regs into handle_mm_fault().
> ...
> > -	/*
> > -	 * Major/minor page fault accounting. If any of the events
> > -	 * returned VM_FAULT_MAJOR, we account it as a major fault.
> > -	 */
> > -	if (major) {
> > -		tsk->maj_flt++;
> > -		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, address);
> > -	} else {
> > -		tsk->min_flt++;
> > -		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
> > -	}
> > -
> >  	check_v8086_mode(regs, address, tsk);
> >  }
> 
> I did a quick grep and it wasn't obvious to me how
> PERF_COUNT_SW_PAGE_FAULTS_MIN/MAJ get bumped in the handle_mm_fault() path.
> 
> Are you sure they get set?

Sorry for missing the context.  This patch is based on the 1st patch of the
same series:

https://lore.kernel.org/lkml/20200630204504.38516-1-peterx@redhat.com/

Both of them are set there.

Thanks,

-- 
Peter Xu

