Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1606C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7645320721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JIZhKVw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgEUIvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 04:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbgEUIvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 04:51:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467EDC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 01:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2wizm4Rngjr7Gy1sl663+W2PlI9xBLkts/AnIHHMOCs=; b=JIZhKVw80kcxxEDG3gSuOqCdwV
        vszpf9ep3YcI+viVbXEQRQZw6xR9YjWfCxXF/htnV1n8GN8blhxRt5H/rV2mX34OYPShNwXogxQsI
        xCXIzDAUGMK8RoG0zS8gAY4m6b2Ctf3NCXx0b/lzpQdcvWrZxStENbVG+ncRXmFkuX1y73T2w9Xu5
        rw3ttzhHzzBebYBLw8WT1XYpGrIFyQkrEOrNFZCGhjpw0OH22k1JyxSZ5p4fAn2dvtHMAw44Ri2Vh
        ISDK3VHx3G/rccMIfE4+zjtKKBdoE8TNt/IyqbyxyS0oPd3OwXF8nfpca42oFodlF8EeytXo+cIL+
        J/XzyFFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbgvF-0000Ng-K2; Thu, 21 May 2020 08:51:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9D0853011C6;
        Thu, 21 May 2020 10:51:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 891FE212820FE; Thu, 21 May 2020 10:51:22 +0200 (CEST)
Date:   Thu, 21 May 2020 10:51:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        vpillai <vpillai@digitalocean.com>, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH RFC] sched: Add a per-thread core scheduling interface
Message-ID: <20200521085122.GF325280@hirez.programming.kicks-ass.net>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200520222642.70679-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520222642.70679-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 06:26:42PM -0400, Joel Fernandes (Google) wrote:
> Add a per-thread core scheduling interface which allows a thread to tag
> itself and enable core scheduling. Based on discussion at OSPM with
> maintainers, we propose a prctl(2) interface accepting values of 0 or 1.
>  1 - enable core scheduling for the task.
>  0 - disable core scheduling for the task.

Yeah, so this is a terrible interface :-)

It doens't allow tasks for form their own groups (by for example setting
the key to that of another task).

It is also horribly ill defined what it means to 'enable', with whoem
is it allows to share a core.

> Special cases:

> (1)
> The core-scheduling patchset contains a CGroup interface as well. In
> order for us to respect users of that interface, we avoid overriding the
> tag if a task was CGroup-tagged because the task becomes inconsistent
> with the CGroup tag. Instead return -EBUSY.
> 
> (2)
> If a task is prctl-tagged, allow the CGroup interface to override
> the task's tag.

OK, so cgroup always wins; is why is that a good thing?

> ChromeOS will use core-scheduling to securely enable hyperthreading.
> This cuts down the keypress latency in Google docs from 150ms to 50ms
> while improving the camera streaming frame rate by ~3%.

It doesn't consider permissions.

Basically, with the way you guys use it, it should be a CAP_SYS_ADMIN
only to enable core-sched.

That also means we should very much default to disable.
