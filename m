Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB78C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 10:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C70A20730
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 10:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cElrmZOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgBFKik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 05:38:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgBFKik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DjXmqETrMux+Kvl54ARTF4j5vGbLSPVcRuU0fti6CUI=; b=cElrmZOkO5QQfNB2K32XFgXSa+
        utFJ6s2akipb7LH6esgagCxAkyYZ+i5/T9dmvqBc+mgEDfb7gu9jQcxR0XIzhgNKru3P6RJocdX5K
        SZNwEUnHqIVsfVfhI1nXdzSzSRWAKBpWFXxYIa0NokFgIyBX2sufPqFq9BSBPbeMQlzZuruhnS7Hp
        3jIbpfGPfFxRIhQkhlAbK0Vodaydr59WGjJHs97FUQSk3VQCg/Pb1Hf6AhPvvjeXB6c8azGu1kU4+
        ecak7avhEjeiExdtb0yoy2UqF/0nzVSbPWu7lEcL/qxN1GlKET5F0Oi+yO3voqz8OF2h4jDDrWvP0
        ThB/X0EA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izeYL-0007Jr-5p; Thu, 06 Feb 2020 10:38:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 673EB3016E5;
        Thu,  6 Feb 2020 11:36:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AAB262B789F43; Thu,  6 Feb 2020 11:38:30 +0100 (CET)
Date:   Thu, 6 Feb 2020 11:38:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, keescook@chromium.org,
        rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 08/11] x86: Add support for finer grained KASLR
Message-ID: <20200206103830.GW14879@hirez.programming.kicks-ass.net>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-9-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205223950.1212394-9-kristen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 02:39:47PM -0800, Kristen Carlson Accardi wrote:
> +static long __start___ex_table_addr;
> +static long __stop___ex_table_addr;
> +static long _stext;
> +static long _etext;
> +static long _sinittext;
> +static long _einittext;

Should you not also adjust __jump_table, __mcount_loc,
__kprobe_blacklist and possibly others that include text addresses?
