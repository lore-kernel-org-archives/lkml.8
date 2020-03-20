Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D088C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FA620658
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jRZ4w7iR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCTU70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:59:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37872 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbgCTU7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 16:59:25 -0400
Received: from zn.tnic (p200300EC2F0A5A0095ADC0D452E3E28B.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:95ad:c0d4:52e3:e28b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1043D1EC0570;
        Fri, 20 Mar 2020 21:59:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584737962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8iI8IWPehZ1KW+x62OpAlz0HlN2gIEWJg2Hn2mzEzMA=;
        b=jRZ4w7iRJ1EiRXuIFuvaqqn9IbV3+wN+Q1T2vSEeDASwPUcW7/HiNd7GqP/3xfZa37ol+a
        kzD/Mi/5tK1eAWsYKFVeIu5C44Cp8X/ZtfqbmOWUX4chL2kEJHfSR0oq+Fgiw9+ENQ8DJC
        JyFt3DzmdDeh6DuYrhferPDmppBdrwA=
Date:   Fri, 20 Mar 2020 21:59:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alexey Makhalov <amakhalov@vmware.com>
Cc:     linux-x86_64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 0/5] x86/vmware: Steal time accounting support
Message-ID: <20200320205929.GH23532@zn.tnic>
References: <20200320203443.27742-1-amakhalov@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200320203443.27742-1-amakhalov@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 08:34:38PM +0000, Alexey Makhalov wrote:
> Hello,
> 
> This patchset introduces steal time accounting support for
> the VMware guest. The idea and implementation of guest
> steal time support is similar to KVM ones and it is based
> on steal clock. The steal clock is a per CPU structure in
> a shared memory between hypervisor and guest, initialized
> by each CPU through hypercall. Steal clock is got updated
> by the hypervisor and read by the guest. 

...

>  Documentation/admin-guide/kernel-parameters.txt |   2 +-
>  arch/x86/kernel/cpu/vmware.c                    | 227 +++++++++++++++++++++++-
>  2 files changed, 220 insertions(+), 9 deletions(-)

Did you not see my reply to you the last time?

https://marc.info/?l=linux-virtualization&m=158410546921328

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
