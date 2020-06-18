Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58CEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEE1E207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbgFRSZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgFRSZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 14:25:44 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C732C06174E;
        Thu, 18 Jun 2020 11:25:44 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jlzEB-0000M3-As; Thu, 18 Jun 2020 20:25:31 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C790B101482; Thu, 18 Jun 2020 20:25:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>,
        "Bae\, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH v13 00/16] Enable FSGSBASE instructions
In-Reply-To: <CALCETrUeRPVq2n0UVuZZ9WTugH8Aetdw5rY+cccCT_=YgnJ_og@mail.gmail.com>
References: <20200528201402.1708239-1-sashal@kernel.org> <874kr8cv9i.fsf@nanos.tec.linutronix.de> <CALCETrUeRPVq2n0UVuZZ9WTugH8Aetdw5rY+cccCT_=YgnJ_og@mail.gmail.com>
Date:   Thu, 18 Jun 2020 20:25:30 +0200
Message-ID: <87wo44b59h.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:
> Is there a plan to deal with:
>
>         /*
>          * This function has some ABI oddities.
>          *
>          * A 32-bit ptracer probably expects that writing FS or GS will change
>          * FSBASE or GSBASE respectively.  In the absence of FSGSBASE support,
>          * this code indeed has that effect.  When FSGSBASE is added, this
>          * will require a special case.
>          *
>          * For existing 64-bit ptracers, writing FS or GS *also* currently
>          * changes the base if the selector is nonzero the next time the task
>          * is run.  This behavior may? not be needed, and trying to preserve it
>          * when FSGSBASE is added would be complicated at best.
>          */
>
> in arch/x86/kernel/ptrace.c?

Not that I'm aware of.
