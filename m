Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D8FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 255572072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="U39ctksz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgFJNVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:21:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35524 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgFJNVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:21:45 -0400
Received: from zn.tnic (p200300ec2f0c1900a8dd7bf9cd2897c1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1900:a8dd:7bf9:cd28:97c1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A9B441EC02C3;
        Wed, 10 Jun 2020 15:21:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591795298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+y6sTff02uxOaGiZSreDjcUCBtuqUc5REGpMVDTOxa4=;
        b=U39ctkszTzmyTRiCk6asv/5/E2r2S58eQhqvOJ9ZAt45kMPFcaSwYx9UPOMyZMleL8fRap
        /B00XBOm7ZMjE3D4O67wpW9192HJ7jcvUWc916PxHXE+uJfTyLbkoNmu0/cbD40/z+HrEf
        xyVhKQJxgKMehEnuWfE8a5WZyIUrLeY=
Date:   Wed, 10 Jun 2020 15:21:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Morton <Eric.Morton@amd.com>
Subject: Re: [PATCH 3/3] x86/msr: Add an MSR write callback
Message-ID: <20200610132131.GG14118@zn.tnic>
References: <20200610110037.11853-1-bp@alien8.de>
 <20200610110037.11853-4-bp@alien8.de>
 <20200610123226.GC2497@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200610123226.GC2497@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 02:32:26PM +0200, Peter Zijlstra wrote:
> We cache a whole bunch of MSRs in kernel. Why is this one special?

If the others need the post-write handling, they should be added there
too. I did it with this one only as a start.

> If you write using the stupid msr device, you get to keep all pieces.

Yes, the tainting-on-write is the next thing that goes ontop of this.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
