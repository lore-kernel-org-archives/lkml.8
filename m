Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4FBC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78DD20780
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ugEMl3nw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgDHLFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 07:05:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgDHLFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 07:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oqUjbefYS3Yk7lY8aXBkaPJgSKoP23s64kxD/fHCpR8=; b=ugEMl3nwCKlvAWACI3gmebiipt
        8/1xS63dnZ7clRpRx+bkMlxjyy8k+YsGj2MI+19jCGbSbjP9/Mh5p/Sq4Ns9IBZ0gRBma6VKHMr/o
        XEW41GFTJDDlVx/mihtetBghKO/Pe9haIl5N9JxwKET5XHndOUhNK/ybyUXpJEQJAjk2gFBFkRJZB
        +02sNenIRFkYFGQEGXc6iwLxT+UnA4UTLIsWcXvI4Ai5zcYW6wgFbgT0qxY+3I8cqsnpMr251t/ZG
        vDz6HI4/lhpMzkmvbNWol4H34lr5aKfXny5PMY1OzXL/BXXZbLP430nCgbEc5TvjOztIXWIfYYJ1u
        pLlISIDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM8W0-0007ea-8z; Wed, 08 Apr 2020 11:05:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9ACC7300130;
        Wed,  8 Apr 2020 13:05:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BE212BA90A60; Wed,  8 Apr 2020 13:05:01 +0200 (CEST)
Date:   Wed, 8 Apr 2020 13:05:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        jpoimboe@redhat.com, namit@vmware.com, mhiramat@kernel.org,
        jgross@suse.com, bp@alien8.de, vkuznets@redhat.com,
        pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        mihai.carabas@oracle.com, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [RFC PATCH 09/26] x86/paravirt: Add runtime_patch()
Message-ID: <20200408110501.GS20713@hirez.programming.kicks-ass.net>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
 <20200408050323.4237-10-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408050323.4237-10-ankur.a.arora@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 10:03:06PM -0700, Ankur Arora wrote:
> +/*
> + * preempt_enable_no_resched() so we don't add any preemption points until
> + * after the caller has returned.
> + */
> +#define preempt_enable_runtime_patch()	preempt_enable_no_resched()
> +#define preempt_disable_runtime_patch()	preempt_disable()

NAK, this is probably a stright preemption bug, also, afaict, there
aren't actually any users of this in the patch-set.
