Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FC7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F02C2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="eS+B+DYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgFSHlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:41:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58866 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbgFSHlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:41:08 -0400
Received: from zn.tnic (p200300ec2f0bac00fd80253c6a150deb.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ac00:fd80:253c:6a15:deb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AFD521EC02AC;
        Fri, 19 Jun 2020 09:41:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592552467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=h4FwYiyWhYR7saNRzcCJ27rw0psvb//Ts/LIFLxn7iU=;
        b=eS+B+DYemdA2HXQwi7Qe4nvX3U3QY63WkSacRFe5wuS37S9Au1EGoiqo+pj4I+vFxC3vUn
        REv9B/uBMcNymPkRZVUH/LrFQ8f4rybPmOs2QCUGUcwfErGLGIilOkq5QAdlk5FTtBoQNu
        PzvDqNsp0lTul1GY3aBN7erN9/cgfM4=
Date:   Fri, 19 Jun 2020 09:41:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Daniel Gutson <daniel@eclypsium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20200619074105.GB32683@zn.tnic>
References: <20200618210215.23602-1-daniel.gutson@eclypsium.com>
 <589c89ae-620e-36f8-2be5-4afc727c2911@intel.com>
 <CAFmMkTHNxSN_uWtm63TdkGxj44NXQQKEOmATXhjA=4DSCS92kQ@mail.gmail.com>
 <23babf62-00cb-cb47-bb19-da9508325934@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23babf62-00cb-cb47-bb19-da9508325934@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 04:52:18PM -0700, Dave Hansen wrote:
> Do we need another driver when running in a SEV guest to tell us about
> SEV's status?

We use /proc/cpuinfo for that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
