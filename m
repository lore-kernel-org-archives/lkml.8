Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057A8C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08C520674
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="T5A/rbTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgCMSG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:06:58 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47686 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgCMSG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:06:58 -0400
Received: from zn.tnic (p200300EC2F0E1E007CE2C412F47CBB57.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:1e00:7ce2:c412:f47c:bb57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 326C91EC0CFA;
        Fri, 13 Mar 2020 19:06:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584122816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Nj2I7kjJxCSlFJkWrglYuXeSHt8xg948lA+s9DV1Wr8=;
        b=T5A/rbTohnBzc98aKTALtQcB5Eq8v/oYMv2CxpjSbasupv53TSTk0fYoe24ZcRt8+FJfdf
        ooC59ozQFkTrWCwBUR9p6sMYYMXwUayWciHWMe1tU37NI7LCo6qNeKunYsf0YcXjX40VTL
        IIVr2/afPmaGCU8NlMyPvfavkRIdHlo=
Date:   Fri, 13 Mar 2020 19:06:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
Message-ID: <20200313180658.GE8142@zn.tnic>
References: <20200311214601.18141-1-hdegoede@redhat.com>
 <20200311214601.18141-3-hdegoede@redhat.com>
 <20200312001006.GA170175@rani.riverdale.lan>
 <3d58e77d-41e5-7927-fe84-4c058015e469@redhat.com>
 <20200312114225.GB15619@zn.tnic>
 <899f366e-385d-bafa-9051-4e93dc9ba321@redhat.com>
 <20200312125032.GC15619@zn.tnic>
 <20200313044235.GA1159234@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200313044235.GA1159234@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 12:42:36AM -0400, Arvind Sankar wrote:
>  The real problem is that there exist CFLAGS that should be used for
> all source files in the kernel, and there are CFLAGS (eg tracing,
> stack check etc) that should only be used for the kernel proper. For
> special compilations, such as boot stubs, vdso's, purgatory we should
> have the generic CFLAGS but not the kernel-proper CFLAGS. The issue
> currently is that these special compilations need to filter out all
> the flags added for kernel-proper, and this is a moving target as
> more tracing/sanity flags get added. Neither the solution of simply
> re-initializing CFLAGS (which will miss generic CFLAGS) nor trying to
> filter out CFLAGS (which will miss new kernel-proper CFLAGS) works
> very well. I think ideally splitting these into independent variables,
> i.e. BASE_FLAGS that can be used for everything, and KERNEL_FLAGS
> only to be used for the kernel proper is likely eventually the better
> solution, rather than conflating both into KBUILD_CFLAGS.

Hohumm, this has come up a bunch of times in the past in conjunction
with boot/{,compressed/} Makefiles too. I'd be open towards reworking
this properly but I'm afraid it would cause a lot of churn and breakage
and it is hard to say how ugly it would become before someone actually
tries it. ;-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
