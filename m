Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9097C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC13D206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="DkggYZAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgFBK45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 06:56:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60148 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgFBK44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 06:56:56 -0400
Received: from zn.tnic (p200300ec2f0bbb00c19a54a9b37b354f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:bb00:c19a:54a9:b37b:354f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7EEF41EC0350;
        Tue,  2 Jun 2020 12:56:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591095415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=B26BaFsTDMz7FwhYbd3k5w48C6XsF0pJGiHJygBA8VU=;
        b=DkggYZAr0nx9UkOGjZkE2dkpesE6t8WFOljYCaZ7E4OoyNVbwnq+3ehNVzFXggneQuH/4i
        iQrlStFg+okQoE4Fs9ovXGNLq8YXUiZg3E1xVDURXMv1pxd37eC5eK2nWfjnsp12H64Q0C
        EN1reJNYiPzFhA+hYDO5yIxIA/R38bQ=
Date:   Tue, 2 Jun 2020 12:56:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Petteri Aimonen <jpa@git.mail.kapsi.fi>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch/x86: reset MXCSR to default in kernel_fpu_begin()
Message-ID: <20200602105649.GB11634@zn.tnic>
References: <20200602101119.GA11634@zn.tnic>
 <20200602102951.GE17423@lakka.kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200602102951.GE17423@lakka.kapsi.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 02, 2020 at 01:29:51PM +0300, Petteri Aimonen wrote:
> The kernel module is not actually x86-specific, even though it is 
> currently only enabled for x86. amdgpu driver already does kernel mode 
> floating point operations on PPC64 also, and the same module could be 
> used to test the same thing there.

Then make it generic please and put the user portion in, say,
tools/testing/selftests/fpu/ and we can ask ppc people to test it too.
People might wanna add more stuff to it in the future, which would be
good.

> To deterministically trigger the bug, the syscall has to come from the 
> same thread that has modified MXCSR. Going through /usr/sbin/modprobe 
> won't work, and manually doing the necessary syscalls for module loading 
> seems too complicated.

Ok, fair enough. But put that file in debugfs pls.

> The fesetround() and feenableexcept() are the portable ways to modify 
> MXCSR. The test module does cause Precision Exception and Denormal 
> Exception if those exceptions are unmasked.

Ok.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
