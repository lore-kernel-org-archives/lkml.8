Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7722DC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430242087E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fkM/H3pp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgAVUzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 15:55:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39416 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbgAVUzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 15:55:25 -0500
Received: from zn.tnic (p200300EC2F0CAE00788EF3390FE77771.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:ae00:788e:f339:fe7:7771])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E66B21EC0260;
        Wed, 22 Jan 2020 21:55:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579726523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kuTpIPLP78Xu0y3j5MABprbi+PW0mmI9M3BL9Y2t4zY=;
        b=fkM/H3pplOs6HA7i8aI41G3yzEzjAwybfZjXlYV+yGhIkCRp3LQYABtdHVn1gbT98j9Ji0
        FDXk1nK++hW11dxNrKv3JPwf0MB3SaJH0im/o0mfm1TnYRH53WoOsuezOeWb+NZWQy25V7
        0AfQzSTfXtq4SlUNSpjUxiR2/emp1E4=
Date:   Wed, 22 Jan 2020 21:55:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v12] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200122205516.GB23947@zn.tnic>
References: <20191123003056.GA28761@agluck-desk2.amr.corp.intel.com>
 <20191125161348.GA12178@linux.intel.com>
 <20191212085948.GS2827@hirez.programming.kicks-ass.net>
 <20200110192409.GA23315@agluck-desk2.amr.corp.intel.com>
 <20200114055521.GI14928@linux.intel.com>
 <20200115222754.GA13804@agluck-desk2.amr.corp.intel.com>
 <20200115225724.GA18268@linux.intel.com>
 <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com>
 <20200122190405.GA23947@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F5483E9@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F5483E9@ORSMSX114.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 08:03:28PM +0000, Luck, Tony wrote:
> I could abbreviate CAPABILITIES as "CAP", that would save 9
> characters. Is that enough?

Sure, except...

> I'm not fond of the "remove the vowels": SPLT_LCK_DTCT, but that is
> sort of readable and would save 4 more. What do you think?

... we've been trying to keep the MSR names as spelled in the SDM to
avoid confusion.

Looking at it,

MSR_IA32_CORE_CAPABILITIES -> MSR_IA32_CORE_CAPS

along with a comment above its definition sounds like a good compromise
to me. IMO, of course.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
