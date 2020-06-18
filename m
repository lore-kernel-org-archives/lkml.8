Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224B4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F262070A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="d76yf0ZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbgFRWBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:01:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40948 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729038AbgFRWBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 18:01:51 -0400
Received: from zn.tnic (p200300ec2f0dcf00e5fab16b0229ac41.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:cf00:e5fa:b16b:229:ac41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF2401EC0351;
        Fri, 19 Jun 2020 00:01:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592517709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=z7tzUJcmxZPJQVGPWE/8k6uh061P0+HKZAnoMljoEl4=;
        b=d76yf0ZZ4aZtt8vWdCSWyVz+IWZuZcmCdHkH/OkjESUkKWtYHMGkyO8NXzCjj0V7DbhrVt
        mJb9ytD7Mw+jztZSKvZgJEPiNGKn98UiZXurmEA5p5KwpwkRcOyIUawVlVmwO/URlK+Q3j
        aN4wtg4lpEgukvlZUhotPheszn4Mgrk=
Date:   Fri, 19 Jun 2020 00:01:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Gutson <daniel@eclypsium.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
Message-ID: <20200618220139.GH27951@zn.tnic>
References: <20200618210215.23602-1-daniel.gutson@eclypsium.com>
 <589c89ae-620e-36f8-2be5-4afc727c2911@intel.com>
 <CAFmMkTHNxSN_uWtm63TdkGxj44NXQQKEOmATXhjA=4DSCS92kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFmMkTHNxSN_uWtm63TdkGxj44NXQQKEOmATXhjA=4DSCS92kQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 06:26:25PM -0300, Daniel Gutson wrote:
> Red Hat and Eclypsium are working on a specification to assess
> firmware platform security. One of the inputs that the specification
> takes into consideration is whether MKTME is enabled or disabled.
> Exposing this value is necessary for tools checking the conformance of
> the specification.

Would it be enough to grep /proc/cpuinfo whether it has "tme" or not,
instead of adding a bunch of code just to read a status value?

@Dave: this is where those flags in /proc/cpuinfo come real handy. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
