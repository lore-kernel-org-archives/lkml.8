Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C090CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98AF32078D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="STu8GWgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgFKJSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:18:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58998 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgFKJS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:18:29 -0400
Received: from zn.tnic (p200300ec2f0bef009c9227b3e94b0042.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ef00:9c92:27b3:e94b:42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 532261EC0286;
        Thu, 11 Jun 2020 11:18:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591867108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=B7J6LazIMYv77qBDC5jmO+QDhxU/h68fVJEh+XvPlm0=;
        b=STu8GWgYHjwZMDroU/A7cu1XftZ1AVlrY27cVfde0WjAQshkoNI3i86mh1fU4rTMoyFzsz
        hNKBzrAr8tMEU8SIbENBcJJLA83RTKc7MFVVuZC3QvQdMs3ejWubRdE2fR8UEfccLd5RoZ
        aFdRrzAN7dQ4TcqAgaUl2q7yq7updZ8=
Date:   Thu, 11 Jun 2020 11:18:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Petteri Aimonen <jpa@git.mail.kapsi.fi>
Cc:     Andy Lutomirski <luto@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch/x86: reset MXCSR to default in kernel_fpu_begin()
Message-ID: <20200611091822.GA30352@zn.tnic>
References: <20200602101119.GA11634@zn.tnic>
 <20200602102951.GE17423@lakka.kapsi.fi>
 <20200602105649.GB11634@zn.tnic>
 <CALCETrURrz=L5f-HHF3kZtUqV0dw5hAEGqSxWTsOjoZvOKaccw@mail.gmail.com>
 <20200611073607.GH17423@lakka.kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200611073607.GH17423@lakka.kapsi.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 10:36:08AM +0300, Petteri Aimonen wrote:
> Hi,
> 
> > How about putting the file you frob in
> > /sys/kernel/debug/selftest_helpers/something_or_other.  The idea would
> > be that /sys/kernel/debug/selftest_helpers would be a general place
> > for kernel helpers needed to make selftests work.
> 
> Seems like this is the consensus for now.
> 
> Any opinions on whether the module should remove "selftest_helpers"
> directory on unloading, or not?
> 
> 1) Removing would break if other test modules will use the same dir.
> 2) Not removing will leave the directory dangling.
> 3) Remove only if empty is one option, though I'm unsure how to
>    cleanly check if debugfs directory is empty.
> 4) E.g. /sys/kernel/debug/x86/ is created centrally and a symbol is
>    exported for its dentry. But I'm not sure if it really makes sense
>    to add another exported symbol just for selftest_helpers.

I'd say you do the simple thing and cleanup after you're done, i.e.,
remove the dir. When something else starts using it, then it would need
to be taught to deal with multiple users.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
