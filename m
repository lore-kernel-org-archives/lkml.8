Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B209C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF8C52073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="dL4JFbeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgDVNtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:49:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47302 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDVNtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:49:31 -0400
Received: from zn.tnic (p200300EC2F0DC10060EB155E24FF7BBC.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c100:60eb:155e:24ff:7bbc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3435F1EC0D1F;
        Wed, 22 Apr 2020 15:49:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587563370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pjJUGvvHbF342Ojz5AzX+vMNq90Z6OoibhaVBox2OyY=;
        b=dL4JFbeXI432BdfXAeElNOqb8SVr3IvcKmKNeKwBAsnklTFYgb+4e4dK9wBm4SOJYg3U6r
        Koes5KIq8gn0VI71QsXiNyRvtijVrv2hiLkR7yTinRPXsyfx0WLGm/0770+WhD19NW7MPV
        D/20r5+V1OeJuJYkpUulC7W/mNcv/Sk=
Date:   Wed, 22 Apr 2020 15:49:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Matz <matz@suse.de>, Jakub Jelinek <jakub@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
Message-ID: <20200422134924.GB26846@zn.tnic>
References: <20200417084224.GB7322@zn.tnic>
 <20200417085859.GU2424@tucnak>
 <20200417090909.GC7322@zn.tnic>
 <CAKwvOdnFXPBJsAUD++HtYS5JiR2KmX73M5GAUe-tvX-JYV7DaA@mail.gmail.com>
 <CAKwvOdmNwNwa6rMC27-QZq8VDrYdTQeQqss-bAwF1EMmnAHxdw@mail.gmail.com>
 <20200417190607.GY2424@tucnak>
 <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
 <alpine.LSU.2.21.2004201401120.11688@wotan.suse.de>
 <20200422102309.GA26846@zn.tnic>
 <20200422114007.GC20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422114007.GC20730@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 01:40:07PM +0200, Peter Zijlstra wrote:
> You haz a whitespace issue there.

Fixed.

> Also, can we get this in writing, signed in blood, from the various
> compiler teams ;-)

Yah, I wouldn't want to go fix this again in gcc11 or so. That's why I
wanted the explicit marking but let's try this first - it is too simple
to pass over without having tested it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
