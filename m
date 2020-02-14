Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED21C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 09:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21CA20873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 09:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kyzHVH+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgBNJCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 04:02:48 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35444 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729007AbgBNJCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 04:02:47 -0500
Received: from zn.tnic (p200300EC2F0D5A00F0C2F03C7F1C4548.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:5a00:f0c2:f03c:7f1c:4548])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 810731EC0570;
        Fri, 14 Feb 2020 10:02:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581670966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QPOMuZeWr4lwxGvUXgwxF0YbMIdB9uFfBPhvPASgf/8=;
        b=kyzHVH+BIlq2uFanQrM1Qc9tyvpIJxji6mQX0TFAFNA8jug8DQSyjvtSFWplmckijMEWL4
        v4i0B1shlRbVsgtoHRdLn71V4hMfCFzzTxi4o7GbcRbZGom7GXSGZmI7NiWXwJrSPJcnLB
        MIOa6ctp+4tK16UzwjlJuusMWKI7y4k=
Date:   Fri, 14 Feb 2020 10:02:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] x86/mce: Fix all mce notifiers to update the
 mce->handled bitmask
Message-ID: <20200214090241.GE13395@zn.tnic>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200212204652.1489-5-tony.luck@intel.com>
 <20200213170308.GM31799@zn.tnic>
 <20200213221913.GB21107@agluck-desk2.amr.corp.intel.com>
 <CALCETrVrL1Ps9ubAcKQykxTofn4hbkESBYE9H22Ws5Pis_vG+g@mail.gmail.com>
 <20200213230807.GA22454@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213230807.GA22454@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 03:08:07PM -0800, Luck, Tony wrote:
> Ok. We don't have code that does this yet. If we need some, I'll
> make sure to do the weed out before it gets to the notifier.

... which would make running the CEC hook *before* running the notifiers
the easiest thing. Hacking in "did-CEC-handle-it" logic in the rest of
the chain is just going to be painful so the best would be IMO: if the
CEC decided to consume it, it won't even go down the notifiers.

Just like the added crap^W value firmware-first thing does and we should
learn from it. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
