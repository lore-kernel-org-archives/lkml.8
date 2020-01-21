Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C930C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47345207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="nhcjsZOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgAUPpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:45:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38970 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728852AbgAUPpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:45:34 -0500
Received: from zn.tnic (p200300EC2F0B04001968D368394CA6AD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:400:1968:d368:394c:a6ad])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB1D21EC0CAB;
        Tue, 21 Jan 2020 16:45:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579621533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=m40QvzilE3eF+M3My9lK3d81i3eaU7exLqJm718/IaY=;
        b=nhcjsZOo7gv7nuHIu/UG8GW1acu3YBpIJrBFFUneSl19Mdo6fG9ccpb1x3zk6Pv5psYxA+
        ywUIRIsCafF1czHRj+l6pfVUn0ZEpAbr5zU04kJNzXyULe2KDFSASLxuNSiE5KcittNW7x
        /3MCFV7HFTAgLt0PBhoVwtK3qFoc6pA=
Date:   Tue, 21 Jan 2020 16:45:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Marco Elver <elver@google.com>, Qian Cai <cai@lca.pw>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] x86/mm/pat: silence a data race in cpa_4k_install
Message-ID: <20200121154528.GK7808@zn.tnic>
References: <20200121151503.2934-1-cai@lca.pw>
 <CANpmjNPR+mbadR0DDKGUhTkaXJi=vsHmhvq3+Rz0Hrx=E9V_Qg@mail.gmail.com>
 <20200121152853.GI7808@zn.tnic>
 <44A4276D-5530-4DAA-8FC7-753D03ADD2F3@lca.pw>
 <CANpmjNO7mTEMc6pvpVVXdu2r6cMg_N8QkRffEHHG-WNFXE4CjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNO7mTEMc6pvpVVXdu2r6cMg_N8QkRffEHHG-WNFXE4CjA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 04:36:49PM +0100, Marco Elver wrote:
> Isn't the intent "x86/mm/pat: Mark intentional data race" ?  The fact
> that KCSAN no longer shows the warning is a side-effect.  At least
> that's how I see it.

Perhaps because you've been dealing with KCSAN for so long. :-)

The main angle here, IMO, is that this "fix" is being done solely for
KCSAN. Or is there another reason to "fix" intentional data races? At
least I don't see one. And the text says

"This will generate a lot of noise on a debug kernel with
debug_pagealloc with KCSAN enabled which could render the system
unusable."

So yes, I think it should say something about making KCSAN happy.

Oh, and while at it I'd prefer it if it did the __no_kcsan function
annotation instead of the data_race() thing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
