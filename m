Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4419C34022
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDE1214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ao33AH+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgBRC1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 21:27:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35438 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726212AbgBRC1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 21:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581992822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s+rxSpvQ1vwDbeuy8s6SOqVEIqbGp9AfMoz3S66N13U=;
        b=Ao33AH+3k/3xXjH1GzjqfNC+107fPX7FWuTqwitvgwnT0Hox+sHQigxANc8jh4jFqaK0qn
        bLnQ6YwMwWQ24Bg6wGnt1PUsFSXp7hVWpr7Wf8MlkTJGSjMZGjuDy65gPGAIem0QGNopXJ
        hOC+dzoHRGFNTxNCxGMzvgKEeS0irLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-_n4gutFuPVm5i0c0jyjSWg-1; Mon, 17 Feb 2020 21:27:01 -0500
X-MC-Unique: _n4gutFuPVm5i0c0jyjSWg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9E9118A5500;
        Tue, 18 Feb 2020 02:26:59 +0000 (UTC)
Received: from mail (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EF9B360BE1;
        Tue, 18 Feb 2020 02:26:56 +0000 (UTC)
Date:   Mon, 17 Feb 2020 21:26:55 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Sonny Rao <sonnyrao@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [RFC PATCH] userfaultfd: Address race after fault.
Message-ID: <20200218022655.GE29216@redhat.com>
References: <20200214225849.108108-1-bgeffon@google.com>
 <20200214231954.GA29849@redhat.com>
 <CADyq12w3tBO5NfZ33R__B3jvF=ed7ys+o4horGwyUO3bNevObg@mail.gmail.com>
 <20200217160739.GB1309280@xz-x1>
 <CADyq12zU25+w2nX9bFGm=O2svgMM_ReC73qfE7JDeVfJz0Y0UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12zU25+w2nX9bFGm=O2svgMM_ReC73qfE7JDeVfJz0Y0UQ@mail.gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 07:50:19PM -0600, Brian Geffon wrote:
> But in the meantime, if the plan of record will be to always allow
> retrying then shouldn't the block I mailed a patch on be removed
> regardless because do_user_addr_fault always starts with
> FAULT_FLAG_ALLOW_RETRY and we shouldn't ever land there without it in
> the future and allows userfaultfd to retry?

It might hide the limitation but only if the page fault originated in
userland (Android's case), but that's not something userfault users
should depend on. Userfaults (unlike sigsegv trapping) are meant to be
reliable and transparent to all user and kernel accesses alike.

It is also is unclear how long Android will be forced to keep doing
bounce buffers copies in RAM before considering passing any memory to
kernel syscalls.

For all other users where the kernel access may be the one triggering
the fault the patch will remove a debug aid and the kernel fault would
then fail by hitting on the below:

		/* Not returning to user mode? Handle exceptions or die: */
		no_context(regs, hw_error_code, address, SIGBUS, BUS_ADRERR);

There may be more side effects in other archs I didn't evaluate
because there's no other place where the common code can return
VM_FAULT_RETRY despite the arch code explicitly told the common code
it can't do that (by not setting FAULT_FLAG_ALLOW_RETRY) so it doesn't
look very safe and it doesn't seem a generic enough solution to the
problem.

That dump_stack() helped a lot to identify those kernel outliers that
erroneously use get_user_pages instead of the gup_locked/unlocked
variant that are uffd-capable.

Thanks,
Andrea

