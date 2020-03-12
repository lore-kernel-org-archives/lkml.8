Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16C4C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769622067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BrOntzbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCLMui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:50:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46858 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgCLMui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 08:50:38 -0400
Received: from zn.tnic (p200300EC2F0DBF00E89CA278D0B3F041.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:bf00:e89c:a278:d0b3:f041])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2AB401EC0CF0;
        Thu, 12 Mar 2020 13:50:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584017435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FtDeqB+NSzCP3QZ3Tfb9afis08hMGM0ymTR2hgPs35o=;
        b=BrOntzbKG7fzuGT4CmaUsmAjV357S9nAX1L1ZaLJvcFIVDK0VQM2YZx+Ele+k+PwQGrDmI
        XG9nsxCqOndpYArzqpeY6aHbPVtE9HxyxJbVXMSN4vP+1wCuA2PKpdUvz9bIWxLprwo/1y
        5Vx3cmWs3kbA4qB/2yomekpci4jFuHw=
Date:   Thu, 12 Mar 2020 13:50:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
Message-ID: <20200312125032.GC15619@zn.tnic>
References: <20200311214601.18141-1-hdegoede@redhat.com>
 <20200311214601.18141-3-hdegoede@redhat.com>
 <20200312001006.GA170175@rani.riverdale.lan>
 <3d58e77d-41e5-7927-fe84-4c058015e469@redhat.com>
 <20200312114225.GB15619@zn.tnic>
 <899f366e-385d-bafa-9051-4e93dc9ba321@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <899f366e-385d-bafa-9051-4e93dc9ba321@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 12:58:24PM +0100, Hans de Goede wrote:
> My version of this patch has already been tested this way. It is

Tested with kexec maybe but if the 0day bot keeps finding breakage, that
ain't good enough.

> 1. Things are already broken, my patch just exposes the brokenness
> of some configs, it is not actually breaking things (well it breaks
> the build, changing a silent brokenness into an obvious one).

As I already explained, that is not good enough.

> 2. I send out the first version of this patch on 7 October 2019, it
> has not seen any reaction until now. So I'm sending out new versions
> quickly now that this issue is finally getting some attention...

And that is never the right approach.

Maintainers are busy as hell so !urgent stuff gets to wait. Spamming
them with more patchsets does not help - fixing stuff properly does.

So, to sum up: if Arvind's approach is the better one, then we should do
that and s390 should be fixed this way too. And all tested. And we will
remove the hurry element from it all since it has not been noticed so
far so it is not urgent and we can take our time and fix it properly.

Ok?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
