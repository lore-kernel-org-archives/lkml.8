Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D799BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63B72078C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P2AND8XD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390823AbgDCMlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:41:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52842 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgDCMlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7SS9MeRqSIElKXBRRy/iM4tRtXsvU9V0Neex/siiw+s=; b=P2AND8XDBYw3d2Id4IRc9mwrxE
        tq2sRN+RoWfEVbGiXT5nCB0U0fSg5yO9uAPb3NWuQsRB6e9hz1hzaMzupRufuDY72KkRMg8Lhlgoj
        9OHHbSzSdRXdjKwqHQcy0byZO3ZJWln8noUjsFrSUqq+jyqF7C6tBb/gtB1vj/jGuLUPRax+inG25
        ITjW5m9mHy56hkGf90PZe2CTFhXQE4m1SArQGl+Yt/BbiRKNlwAZNCahDLx4pAVxVE8qyDNbq+rBH
        4fmLzA2Wepsy8pHPYbKLFewJI45tb3OAjG2NTrd1aX4XXPxxzW0jvAaANaXue+zzWXD4VCcFaHeqC
        qKwUGF1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKLdG-0006eI-LD; Fri, 03 Apr 2020 12:41:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A88A830477A;
        Fri,  3 Apr 2020 14:41:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9161D2B12078B; Fri,  3 Apr 2020 14:41:07 +0200 (CEST)
Date:   Fri, 3 Apr 2020 14:41:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 3/7] objtool: Add support for intra-function calls
Message-ID: <20200403124107.GO20730@hirez.programming.kicks-ass.net>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-4-alexandre.chartre@oracle.com>
 <db508586-258a-0616-d649-e76e95df9611@redhat.com>
 <20200402154919.2c6shw4hfreagchg@treble>
 <3d075cb2-8d99-5ab7-4842-efef1964247d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d075cb2-8d99-5ab7-4842-efef1964247d@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 09:01:38AM +0100, Julien Thierry wrote:
> 
> Last I found is in qcom_link_stack_sanitization() [2], but that's just a
> workaround for a very specific hardware. In my local tree I just put the
> function as STACK_FRAME_NON_STANDARD. But the code just saves the return
> address, has 16 call instructions that just call the instruction after them,
> restores the return address and lets the C-function return normally (and it
> somehow fixes something for that hardware).
> 
That sounds very much like the RSB flushing we do.
