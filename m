Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AA0C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E23224654
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ieJujH8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBRTul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:50:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52642 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgBRTuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:50:40 -0500
Received: from zn.tnic (p200300EC2F0C1F00DCB96C3517B36067.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1f00:dcb9:6c35:17b3:6067])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 097011EC0CE8;
        Tue, 18 Feb 2020 20:50:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582055439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Sd0idf+pvuS0yKFB+N6Kg8uZlTUf9H7N7/1BmNzZISM=;
        b=ieJujH8xM2RvduR1wQlc6ugEoNbuyqQ6vOPFLxmtAAlCox3aSXr5dHPE+EOwjdrUk4epH7
        +moLXXcNcnCXodI/UhSwhyD38Op7FBaJhJEr4h3+pUe+BLNyM9ZPs/jPC1KRQqOd0g/R5m
        NuUZZvOeAukrBw/w6IqVlR/r0AhWpnw=
Date:   Tue, 18 Feb 2020 20:50:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] #MC mess
Message-ID: <20200218195035.GN14449@zn.tnic>
References: <20200218173150.GK14449@zn.tnic>
 <20200218131158.693eeefc@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200218131158.693eeefc@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 01:11:58PM -0500, Steven Rostedt wrote:
> What's the issue with tracing? Does this affect the tracing done by the
> edac_mc_handle_error code?
> 
> It has a trace event in it, that the rasdaemon uses.

Nah, that code is called from process context.

The problem with tracing the #MC handler is the same as tracing the NMI
handler. And the NMI handler does all kinds of dancing wrt breakpoints
and nested NMIs and the #MC handler doesn't do any of that. Not sure if
it should at all, btw.

> I believe static_key_disable() sleeps, and does all kinds of crazing
> things (like update the code).

True story, thanks for that hint!

static_key_disable()
|-> cpus_read_lock()
|-> percpu_down_read(&cpu_hotplug_lock)
|->might_sleep()

Yuck. Which means, the #MC handler must switch to __rdmsr()/__wrmsr()
now.

I wish I could travel back in time and NAK the hell of that MSR
tracepoint crap.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
