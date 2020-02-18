Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2597C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF7721D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="K0lsGjlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgBRTvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:51:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52812 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgBRTvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:51:31 -0500
Received: from zn.tnic (p200300EC2F0C1F00DCB96C3517B36067.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1f00:dcb9:6c35:17b3:6067])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BE3431EC0CE8;
        Tue, 18 Feb 2020 20:51:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582055489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0X4BxMmr/5PkYvo37a52u/SJVzspvMpEnBA2FEz2mig=;
        b=K0lsGjlPw9pMCn0iJy/omwGK7TysstVjycoXMHjrsZDFCYtJtvBbifZmPU7GwRy4um0pLH
        vrC9IiWkn+xtL4MG23P6VqEr0tZ1cdL2uPBzVunSH+bkBO1jmNEpakFJ7J1+GS3SfqulL+
        JqghHMdo2OFtOxd0tLQ0o/6XC5DOcLU=
Date:   Tue, 18 Feb 2020 20:51:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] #MC mess
Message-ID: <20200218195130.GO14449@zn.tnic>
References: <20200218173150.GK14449@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F57B937@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F57B937@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 06:20:38PM +0000, Luck, Tony wrote:
> > Anything else I'm missing? It is likely...
> 
> +	hw_breakpoint_disable();
> +	static_key_disable(&__tracepoint_read_msr.key);
> +	tracing_off();
> +
>  	ist_enter(regs);
> 
> How about some code to turn all those back on for a recoverable (where
> we actually recovered) #MC?

The use case being?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
