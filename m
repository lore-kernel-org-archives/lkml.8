Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F31C352A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D7424671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBNAKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 19:10:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53522 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgBNAKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 19:10:35 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j2OYt-0005cO-DU; Fri, 14 Feb 2020 01:10:27 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E60DA101115; Fri, 14 Feb 2020 01:10:26 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>
Cc:     linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Julien Thierry <jthierry@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [tip: core/objtool] objtool: Fail the kernel build on fatal errors
In-Reply-To: <20200213221100.odwg5gan3dwcpk6g@treble>
References: <f18c3743de0fef673d49dd35760f26bdef7f6fc3.1581359535.git.jpoimboe@redhat.com> <158142525822.411.5401976987070210798.tip-bot2@tip-bot2> <20200213221100.odwg5gan3dwcpk6g@treble>
Date:   Fri, 14 Feb 2020 01:10:26 +0100
Message-ID: <87sgjeghal.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Poimboeuf <jpoimboe@redhat.com> writes:
> On Tue, Feb 11, 2020 at 12:47:38PM -0000, tip-bot2 for Josh Poimboeuf wrote:
>> The following commit has been merged into the core/objtool branch of tip:
>> 
>> Commit-ID:     644592d328370af4b3e027b7b1ae9f81613782d8
>> Gitweb:        https://git.kernel.org/tip/644592d328370af4b3e027b7b1ae9f81613782d8
>> Author:        Josh Poimboeuf <jpoimboe@redhat.com>
>> AuthorDate:    Mon, 10 Feb 2020 12:32:38 -06:00
>> Committer:     Borislav Petkov <bp@suse.de>
>> CommitterDate: Tue, 11 Feb 2020 13:27:03 +01:00
>> 
>> objtool: Fail the kernel build on fatal errors
>> 
>> When objtool encounters a fatal error, it usually means the binary is
>> corrupt or otherwise broken in some way.  Up until now, such errors were
>> just treated as warnings which didn't fail the kernel build.
>> 
>> However, objtool is now stable enough that if a fatal error is
>> discovered, it most likely means something is seriously wrong and it
>> should fail the kernel build.
>> 
>> Note that this doesn't apply to "normal" objtool warnings; only fatal
>> ones.
>
> Clang still has some toolchain issues which need to be sorted out, so
> upgrading the fatal errors is causing their CI to fail.

Good. Last time we made it fail they just fixed their stuff.

> So I think we need to drop this one for now.

Why? It's our decision to define which level of toolchain brokeness is
tolerable.

> Boris, are you able to just drop it or should I send a revert?

I really want to see a revert which has a proper justification why the
issues of clang are tolerable along with a clear statement when this
fatal error will come back. And 'when' means a date, not 'when clang is
fixed'.

Thanks,

        tglx


