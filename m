Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F112DC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B825D217BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Wh4z5l77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgBFWvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 17:51:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44390 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgBFWvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 17:51:49 -0500
Received: from zn.tnic (p200300EC2F0B4B0040E17354A72808B0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:4b00:40e1:7354:a728:8b0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 704821EC0C99;
        Thu,  6 Feb 2020 23:51:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581029508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QtOEEHjg41DUFzH+/V56Ghw3dvejJBhcVDwpJPcS14c=;
        b=Wh4z5l77TCxAa13iYN+M15YfE0SNLPvcDHiimZB47yxRN4C5uoht1dljEnsRnpGJPbQlyS
        QZaf1D6zwCwQmMXgSde20TziBTXNtW5/jVHoLwYrDQnjp0XSxZcHeonrtB1NOPZ2x/WvXI
        SZl/VD2BS1RClx9zYNw9Gpout9t1LqM=
Date:   Thu, 6 Feb 2020 23:51:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config support
Message-ID: <20200206225139.GH9741@zn.tnic>
References: <20200114210316.450821675@goodmis.org>
 <20200114210336.259202220@goodmis.org>
 <20200206115405.GA22608@zn.tnic>
 <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
 <20200206175858.GG9741@zn.tnic>
 <7280e507-cafd-f981-88b5-0e7d375e26d4@infradead.org>
 <20200206173945.0596d32a@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200206173945.0596d32a@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 05:39:45PM -0500, Steven Rostedt wrote:
> Well, to me its as important as the kernel command line itself, and
> printk(). I know printk() can be disabled, should that be default 'n'?

You're arguing for a feature which might potentially become ubiquitous.
I don't think anyone minds it being built-in and even without a config
option when that happens. Just until that happens, it should have
been default n like all the other features we come up with and then
enable everywhere after sufficient amount of time of testing and
reporting/fixing bugs. Then even the config item gets removed. We do it
this way all the time.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
