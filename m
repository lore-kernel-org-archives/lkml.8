Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5627DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35CB320801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgFLKeh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 06:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFLKeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:34:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1C3C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 03:34:36 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jjh0t-0001u4-Ig; Fri, 12 Jun 2020 12:34:19 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id AD1CA100F5A; Fri, 12 Jun 2020 12:34:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, cj.chengjian@huawei.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        lkft-triage@lists.linaro.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: Perf: WARNING: arch/x86/entry/common.c:624 idtentry_exit_cond_rcu+0x92/0xc0
In-Reply-To: <8DD3180E-0E69-4FD6-92C3-311AAB3F688F@amacapital.net>
References: <87imfwd5f6.fsf@nanos.tec.linutronix.de> <8DD3180E-0E69-4FD6-92C3-311AAB3F688F@amacapital.net>
Date:   Fri, 12 Jun 2020 12:34:18 +0200
Message-ID: <87d064d13p.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@amacapital.net> writes:
>> On Jun 12, 2020, at 2:01 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> There is no IST on 32bit, never was. We do software stack switching for
>> device interrupts, but that's a different story.
>> 
>
> DEFINE_IDTENTRY does the idtentry_enter_cond_rcu() dance, which isn’t
> intended to be safe from NMI context.  It should probably map to
> DEFINE_IDTENTRY_RAW() instead.  The specific issue is that NMI ends up
> there, and at least DEFINE_IDTENTRY_NMI should be raw.

Yes, you are right. That's clearly broken. 

> I haven’t tried this at all, nor have I dug through all the users of
> these macros to check what they expect.  Perhaps we should not have
> the _IST one defined at all on 32 bit and rename it to
> DEFINE_IDTENTRY_IST_RAW on 64 bit to make it more clear what’s going
> on when reading the C code.

Let me go over it with a fine comb.

> Or maybe I’m too sleepy and I’m nuts. But I don’t think I am.

/me politely refrains from commenting
