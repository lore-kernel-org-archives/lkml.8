Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4E8C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55547206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ndtMzIgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389945AbgDNOWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389893AbgDNOW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:22:26 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0779C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tla671Fmro8CIHThx1Xf7leHF3ClxMWQwFBU8nfoPaE=; b=ndtMzIgwj7ZmUHHcYr3pyLR8ca
        jcwbT+zKddchRHAGhucg7kexaPD1tGAYmuJJls4zHeW6GwOj1zIFjSMu++Myrydm64IgXjKWqsub/
        fa97XEJpdEjDgcROM2M7O8XpMsd+qe5sdMtTbUd6kP64hYKgfRH15ddB8ACZiF/Sa0uXPrdTxX9dl
        BTBSpj8q6AoEnt5shPPASCMWodPj2KmFI5KncWzPJ1JS6kt4G6g7Fga0UpbXx1HtvyTUA7iyuc6Fc
        QdcNkyVJ1R73Y6Lq3pMOlae+ldVsoTLjQwLDExGpsb6wIYeBl0QcC3GrIBhp8JPIsEE/kcIVrm+As
        pstx3s1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOMRm-0001u5-VR; Tue, 14 Apr 2020 14:21:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 007F63012D8;
        Tue, 14 Apr 2020 16:21:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DCB5F2B22FBE0; Tue, 14 Apr 2020 16:21:52 +0200 (CEST)
Date:   Tue, 14 Apr 2020 16:21:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     vpillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org
Subject: Re: [RFC PATCH 00/13] Core scheduling v5
Message-ID: <20200414142152.GV20730@hirez.programming.kicks-ass.net>
References: <cover.1583332764.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 04:59:50PM +0000, vpillai wrote:
> TODO
> ----
> - Work on merging patches that are ready to be merged
> - Decide on the API for exposing the feature to userland
> - Experiment with adding synchronization points in VMEXIT to mitigate
>   the VM-to-host-kernel leaking

VMEXIT is too late, you need to hook irq_enter(), which is what makes
the whole thing so horrible.

> - Investigate the source of the overhead even when no tasks are tagged:
>   https://lkml.org/lkml/2019/10/29/242

 - explain why we're all still doing this ....

Seriously, what actual problems does it solve? The patch-set still isn't
L1TF complete and afaict it does exactly nothing for MDS.

Like I've written many times now, back when the world was simpler and
all we had to worry about was L1TF, core-scheduling made some sense, but
how does it make sense today?

It's cute that this series sucks less than it did before, but what are
we trading that performance for?
