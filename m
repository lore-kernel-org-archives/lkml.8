Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AEEC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967642082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TexuxSH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgBGK1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 05:27:15 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43524 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGK1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L3BlihRpV2iRLC6YY8WIGJCu0AhpCAbYwMvQBNO6mS0=; b=TexuxSH9agtY/5ee2O4MoaKYeN
        583CwsTzpUTyGYS1puz5eeDqsjFT4EoBEFIL9ehVekKcUX/dRvL4hmZY9nB07VxbBPSxaqKePvDqF
        w2YEQJIRq4rfn594HQdCGkZY7IPGTHO/0SsYNLLvzhl+AfOXlCAACcbGt7KN4h4NA8nrqdPnV0afw
        Qv2zUyrcSFfk2UmHFrg5l3caflmW20yszfEWQXGBvDBCcTR9E7sy+uJtXypPQ1SfnrJMPhsWV2dTo
        16Lu4zh9GfhutLTVO7G1ZWw4agBQiV4LMR0wkE76vJSmEbkboXl5S9MEmGPJLhbjQ+BJ+RsxLQ6ti
        2LHaM6Ag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j00qf-0005BO-Ny; Fri, 07 Feb 2020 10:26:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 694D430258F;
        Fri,  7 Feb 2020 11:25:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DC162B834C29; Fri,  7 Feb 2020 11:26:56 +0100 (CET)
Date:   Fri, 7 Feb 2020 11:26:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org, Will Deacon <will@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        ard.biesheuvel@linaro.org, james.morse@arm.com, rabin@rab.in,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [tip: core/kprobes] arm/ftrace: Use __patch_text()
Message-ID: <20200207102656.GS14946@hirez.programming.kicks-ass.net>
References: <20191113092636.GG4131@hirez.programming.kicks-ass.net>
 <157544841563.21853.2859696202562513480.tip-bot2@tip-bot2>
 <10cbfd9e-2f1f-0a0c-0160-afe6c2ccbebd@gmail.com>
 <20200207101747.GE14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207101747.GE14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 11:17:47AM +0100, Peter Zijlstra wrote:
> Is that crash with FTRACE=y or =n ?
> 
> This really isn't making much sense to me, Will, Mark, any clues?

Does the initial patch:

  https://lkml.kernel.org/r/20191111132458.220458362@infradead.org

work, or does it crash the exact same?
