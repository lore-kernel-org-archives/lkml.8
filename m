Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91806C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54FEC20732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ST2YWj2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgHUJsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:48:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46518 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgHUJsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:48:08 -0400
Received: from zn.tnic (p200300ec2f0eda003935e3317bb76801.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:da00:3935:e331:7bb7:6801])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 14D811EC0426;
        Fri, 21 Aug 2020 11:48:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598003287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+0ENpjcxM2Qzt/z2kna3FCQDeW7bODLheZkT+Orfjyg=;
        b=ST2YWj2ug/4JGtnMQFlZSPIpI32BMCI53zPMNw8B+fFl5SPgUiQjHqCgvVbLnzKWN6QBCx
        Onh0koE2gmQbHnb5Uh336pkz0rYlTKoHiqwCXurxSdhqM3FL23XjHTYpTA8fq7eYQ3fyZV
        32bs+y2NX4gliBfKZQwKMcf3n5fGX08=
Date:   Fri, 21 Aug 2020 11:48:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Chang Seok Bae <chang.seok.bae@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] x86/entry/64: Disallow RDPID in paranoid entry if KVM is
 enabled
Message-ID: <20200821094802.GG12181@zn.tnic>
References: <20200821025050.32573-1-sean.j.christopherson@intel.com>
 <20200821074743.GB12181@zn.tnic>
 <3eb94913-662d-5423-21b1-eaf75635142a@redhat.com>
 <20200821081633.GD12181@zn.tnic>
 <3b4ba9e9-dbf6-a094-0684-e68248050758@redhat.com>
 <20200821092237.GF12181@zn.tnic>
 <1442e559-dde4-70f6-85ac-58109cf81c16@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1442e559-dde4-70f6-85ac-58109cf81c16@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:44:33AM +0200, Paolo Bonzini wrote:
> It's not like we grab MSRs every day.  The user-return notifier restores
> 6 MSRs (7 on very old processors).  The last two that were added were
> MSR_TSC_AUX itself in 2009 (!) and MSR_IA32_TSX_CTRL last year.

What about "If it is a shared resource, there better be an agreement
about sharing it." is not clear?

It doesn't matter how many or which resources - there needs to be a
contract for shared use so that shared use is possible. It is that
simple.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
