Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A5FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FBE7207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407123AbgE1UTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406991AbgE1UTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:19:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2138C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:19:09 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jeOzY-0008GM-KY; Thu, 28 May 2020 22:19:04 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A2E86100D01; Thu, 28 May 2020 22:19:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     paulmck@kernel.org
Cc:     syzbot <syzbot+3ae5eaae0809ee311e75@syzkaller.appspotmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>, bp@alien8.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com, x86@kernel.org
Subject: Re: WARNING: suspicious RCU usage in idtentry_exit
In-Reply-To: <20200528161143.GF2869@paulmck-ThinkPad-P72>
References: <000000000000840d4d05a6850c73@google.com> <87wo4wnpzb.fsf@nanos.tec.linutronix.de> <20200528161143.GF2869@paulmck-ThinkPad-P72>
Date:   Thu, 28 May 2020 22:19:02 +0200
Message-ID: <878shbols9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

"Paul E. McKenney" <paulmck@kernel.org> writes:
> On Thu, May 28, 2020 at 03:33:44PM +0200, Thomas Gleixner wrote:
>> syzbot <syzbot+3ae5eaae0809ee311e75@syzkaller.appspotmail.com> writes:
>> Weird. I have no idea how that thing is an EQS here.
>
> No argument on the "Weird" part!  ;-)
>
> Is this a NO_HZ_FULL=y kernel?

No, it has only NO_HZ_IDLE.

  https://syzkaller.appspot.com/x/.config?x=47b0740d89299c10

> If so, one possibility is that the call
> to rcu_user_exit() went missing somehow.  If not, then RCU should have
> been watching userspace execution.
>
> Again, the only thing I can think of (should this prove to be
> reproducible) is the rcu_dyntick trace event.

:)

Thanks,

        tglx
