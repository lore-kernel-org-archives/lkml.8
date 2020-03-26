Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64495C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F972077D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="AFi+MNOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgCZWfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:35:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49552 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgCZWfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:35:08 -0400
Received: from zn.tnic (p200300EC2F0A4900088B6946FACBDF73.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:4900:88b:6946:facb:df73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 65AFF1EC0758;
        Thu, 26 Mar 2020 23:35:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585262107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TIKsnilOROD2p3S9sZUXRQKUtQkgU3ET1umN0i8mzFM=;
        b=AFi+MNOMt80RADh3bkG3C616Y5yqZJU8RwFFQDaf992Lie78gtEOyYyngwMzn51zOWCvbb
        AN1lRnP30HmdNGm6vGPbbFE4NNBCcrwn9ykItc84unvyL7UHrvH0Tu3eFAmg00w+PH6zyz
        aQLXyZtC2ryzoEaW9dJorTHu3CXlCPA=
Date:   Thu, 26 Mar 2020 23:35:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sergei Trofimovich <slyfox@gentoo.org>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] x86: fix early boot crash on gcc-10
Message-ID: <20200326223501.GK11398@zn.tnic>
References: <20200316130414.GC12561@hirez.programming.kicks-ass.net>
 <20200316132648.GM2156@tucnak>
 <20200316134234.GE12561@hirez.programming.kicks-ass.net>
 <20200316175450.GO26126@zn.tnic>
 <20200316180303.GR2156@tucnak>
 <20200317143602.GC15609@zn.tnic>
 <20200317143914.GI2156@tucnak>
 <20200317144942.GE15609@zn.tnic>
 <20200325133137.GC27261@zn.tnic>
 <20200326215424.5f1851f3@sf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200326215424.5f1851f3@sf>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 09:54:24PM +0000, Sergei Trofimovich wrote:
> Will attempt to write, test and send out the patch by tomorrow.

No hurry - we'll have merge window opening next Monday so I'll queue
yours after ~2 weeks. So later's fine too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
