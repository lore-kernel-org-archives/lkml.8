Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FB0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC59620659
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgENAtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 20:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728481AbgENAtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 20:49:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE26C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:49:31 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZ23b-0007pQ-0P; Thu, 14 May 2020 02:49:03 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 648391004CE; Thu, 14 May 2020 02:49:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, paulmck <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "Joel Fernandes\, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V4 part 1 05/36] x86/entry: Flip _TIF_SIGPENDING and _TIF_NOTIFY_RESUME handling
In-Reply-To: <20200513203735.7e181bc2@oasis.local.home>
References: <20200505131602.633487962@linutronix.de> <20200505134058.560059744@linutronix.de> <1970736614.19996.1589403401588.JavaMail.zimbra@efficios.com> <20200513171047.04c2c10e@gandalf.local.home> <87v9kzz862.fsf@nanos.tec.linutronix.de> <20200513203735.7e181bc2@oasis.local.home>
Date:   Thu, 14 May 2020 02:49:02 +0200
Message-ID: <87sgg3z6gx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Thu, 14 May 2020 02:12:21 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> I should have thought about this before, so thanks to both of you for
>> making me look at it again for the very wrong reasons.
>> 
>> Consider the patch dropped.
>
> I'm glad our incompetence could be of service to you :-/

Asking incompetent questions is perfectly fine depending on who is
asking them.

Thanks,

        tglx
