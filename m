Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DBAC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B47D206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="l44Uxqre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgBUP5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:57:13 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58128 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728643AbgBUP5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:57:12 -0500
Received: from zn.tnic (p200300EC2F090A0078F81E233D8BB03D.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:a00:78f8:1e23:3d8b:b03d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B9F91EC045C;
        Fri, 21 Feb 2020 16:57:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582300631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PwabF4GOlu60fd6dS0Oyqq9zi1lSTotH33nDQFsA1aI=;
        b=l44UxqreqVuG3/28DbVDIxlmN3cK9XZgPgu1+6gGUu30e9Q3y03u946G+vmKkTjCJyzksv
        qFYmvX1xOIS/MqORAIXLlYDUh+JwM+npDli2HxSxPYiVLaHnD04s1Pf2+fC7VbqP4O8LFp
        8y+kYaqVAhLmfNRTDbX1d1ec/GWqnq4=
Date:   Fri, 21 Feb 2020 16:57:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, it+linux-x86@molgen.mpg.de
Subject: Re: kernel BUG at arch/x86/kernel/apic/apic.c with Dell server with
 x2APIC enabled and unset X2APIC
Message-ID: <20200221155706.GJ25747@zn.tnic>
References: <d573ba1c-0dc4-3016-712a-cc23a8a33d42@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d573ba1c-0dc4-3016-712a-cc23a8a33d42@molgen.mpg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 03:37:23PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On the Dell PowerEdge T640/04WYPY, BIOS 2.4.8 11/27/2019, Linux 5.4.14 (and 4.19.57) with
> unset `IRQ_REMAP` and `X86_X2APIC` crashes on start-up, when x2APIC is enabled in the
> firmware.

Does it happen with latest 5.5-stable too? I see 5.5.5 is the last one...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
