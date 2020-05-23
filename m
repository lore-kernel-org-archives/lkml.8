Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76391C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 19:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A4A12070A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 19:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgEWTFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 15:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgEWTFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 15:05:45 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D9DC061A0E;
        Sat, 23 May 2020 12:05:45 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jcZSa-0004FY-Ti; Sat, 23 May 2020 21:05:29 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 39EAF100F1A; Sat, 23 May 2020 21:05:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     paulmck@kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        elver@google.com
Subject: Re: linux-next: build failure after merge of the tip tree
In-Reply-To: <20200523150614.GP2869@paulmck-ThinkPad-P72>
References: <20200522033119.1bbd99c5@canb.auug.org.au> <20200521173520.GL6608@willie-the-truck> <20200522171708.5f392fde@canb.auug.org.au> <20200522174944.1a1732fa@canb.auug.org.au> <20200523001223.GA23921@paulmck-ThinkPad-P72> <20200523064643.GA27431@zn.tnic> <87a71zq8ml.fsf@nanos.tec.linutronix.de> <20200523150614.GP2869@paulmck-ThinkPad-P72>
Date:   Sat, 23 May 2020 21:05:24 +0200
Message-ID: <871rnaqxor.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:
> On Sat, May 23, 2020 at 11:54:26AM +0200, Thomas Gleixner wrote:
>> core/rcu is the one which diverged and caused the merge conflict with
>> PPC to happen twice. So Paul needs to remove the stale core/rcu bits and
>> rebase on the current version (which is not going to change again).
>
> So there will be another noinstr-rcu-* tag, and I will rebase on top
> of that, correct?  If so, fair enough!

Here you go: noinstr-rcu-220-05-23

I wanted this to be 2020 and not 220 but I noticed after pushing it
out. I guess it still does the job :)

Thanks,

        tglx
