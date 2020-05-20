Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF0EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F1DB2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="B5qxRDCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgETMQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETMQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:16:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5901C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 05:16:29 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bab004cc75e27543cdd50.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ab00:4cc7:5e27:543c:dd50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ABFD81EC0350;
        Wed, 20 May 2020 14:16:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589976986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MLD/1PujuqFss8hz/rJreIyFo+695cA8jplss0woFC0=;
        b=B5qxRDCTQxiyFy4fFKxZK2LdpdIx/LzOzUBuO69SdVrpw7DsLMMikIfLwHcA2gLZsMjPnD
        mK8y8epGTitGCAfn4S5hFNG6bCUs3WdpoPA/ar1PdfiUGOKL+phkljOR2MAjq42s7yHKkI
        1gk2InIuHiuU9tXKjFyi7dISZ8nFSss=
Date:   Wed, 20 May 2020 14:16:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, josh@joshtriplett.org, luto@kernel.org,
        kai.huang@intel.com, rientjes@google.com, cedric.xing@intel.com,
        puiterwijk@redhat.com, Jethro Beekman <jethro@fortanix.com>
Subject: Re: [PATCH v30 01/20] x86/cpufeatures: x86/msr: Add Intel SGX
 hardware bits
Message-ID: <20200520121604.GF1457@zn.tnic>
References: <20200515004410.723949-1-jarkko.sakkinen@linux.intel.com>
 <20200515004410.723949-2-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200515004410.723949-2-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 03:43:51AM +0300, Jarkko Sakkinen wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Add X86_FEATURE_SGX from CPUID.(EAX=7, ECX=1), which informs whether the
> CPU has SGX.
> 
> Add X86_FEATURE_SGX1 and X86_FEATURE_SGX2 from CPUID.(EAX=12H, ECX=0),
> which describe the level of SGX support available [1].
> 
> Remap CPUID.(EAX=12H, ECX=0) bits to the Linux fake CPUID 8 in order to
> conserve some space. Keep the bit positions intact because KVM requires
> this. Reserve bits 0-7 for SGX in order to maintain this invariant also
> when new SGX specific feature bits get added.

That paragraph needs dropping now.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
