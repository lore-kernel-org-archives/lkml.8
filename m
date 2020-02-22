Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D117C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 07:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2145420707
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 07:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Oe6C3Dxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgBVHnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 02:43:05 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44412 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgBVHnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 02:43:05 -0500
Received: from zn.tnic (p200300EC2F1C5400284D3F3FD3B9EA68.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:5400:284d:3f3f:d3b9:ea68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 615F51EC05FD;
        Sat, 22 Feb 2020 08:43:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582357384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kzfaNNUY7sL+bzzMyCJL/b6vBfV9JuThvluB5Z9akUc=;
        b=Oe6C3Dxu0fmk1vx2aaKdm//r7aVn5uPPOPDurvHAf9sS5C3jgiLbUGpEzKhxHlFRr5YEm2
        xglRW+pAKyyWAyHsHw5g8lIuABc1rGfFfjue+qgo00uwVmaSqyDaaapiI0+nDtq0IxwPMc
        BWgOi8Vy0Or5XYRysem82ZWRKyeS418=
Date:   Sat, 22 Feb 2020 08:42:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Fangrui Song <maskray@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH 2/2] x86/boot/compressed: Remove unnecessary sections
 from bzImage
Message-ID: <20200222074254.GB11284@zn.tnic>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200109150218.16544-2-nivedita@alum.mit.edu>
 <20200222050845.GA19912@ubuntu-m2-xlarge-x86>
 <20200222065521.GA11284@zn.tnic>
 <20200222070218.GA27571@ubuntu-m2-xlarge-x86>
 <20200222072144.asqaxlv364s6ezbv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200222072144.asqaxlv364s6ezbv@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 11:21:44PM -0800, Fangrui Song wrote:
> In GNU ld, it seems that .shstrtab .symtab and .strtab are special
> cased. Neither the input section description *(.shstrtab) nor *(*)
> discards .shstrtab . I feel that this is a weird case (probably even a bug)
> that lld should not implement.

Ok, forget what the tools do for a second: why is .shstrtab special and
why would one want to keep it?

Because one still wants to know what the section names of an object are
or other tools need it or why?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
