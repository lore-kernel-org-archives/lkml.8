Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843ACC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BFD206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="A8LNTl0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgCLLm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:42:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58624 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLLmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 07:42:25 -0400
Received: from zn.tnic (p200300EC2F0DBF00894A3A768C8141DF.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:bf00:894a:3a76:8c81:41df])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 97BE21EC0CDE;
        Thu, 12 Mar 2020 12:42:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584013342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5ts1wYr8Y6kl8TGrx8KZOvBk5CMgeDGfnjJ2CSF20RY=;
        b=A8LNTl0uzrmQPlD2mKVW8cuoJntEIQ52wkVyeW2rZOfrHyypnST6L1SA78ibuv852HaOgq
        AdbJvjTA74V7+32n09P3X6MH0rxiacuOIUqvMYm2+2Xtb0vTkgSkqF9aPwmQatvqJ932bh
        y7jSRFWg3DV+efIau9/J878wva+Ps9g=
Date:   Thu, 12 Mar 2020 12:42:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
Message-ID: <20200312114225.GB15619@zn.tnic>
References: <20200311214601.18141-1-hdegoede@redhat.com>
 <20200311214601.18141-3-hdegoede@redhat.com>
 <20200312001006.GA170175@rani.riverdale.lan>
 <3d58e77d-41e5-7927-fe84-4c058015e469@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d58e77d-41e5-7927-fe84-4c058015e469@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 12:31:39PM +0100, Hans de Goede wrote:
> I will send out a v5 of my patch-set changing the first patch to
> also fix the new issue the kbuild test robot has found. I'm going
> to leave this patch as is. If you prefer replacing the second patch
> in the set (this patch) with your solution then that is fine with me.

Can we please slow down here, select the best solution, test it properly
- yes, kexec file-based syscall whatever which uses the purgatory - and be
done with it once and for all instead of quickly shooting out patchsets
which keep breaking some randconfigs?

In order to check for the latter, you can script around "make
randconfig" and let it run for a while on a big machine. This is how I do it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
