Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3016C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF1D0206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbgEVS1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 14:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730793AbgEVS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 14:27:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D153C061A0E;
        Fri, 22 May 2020 11:27:01 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jcCNZ-0002gV-UJ; Fri, 22 May 2020 20:26:46 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7F594100F17; Fri, 22 May 2020 20:26:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 10/25] seqlock: Add RST directives to kernel-doc code samples and notes
In-Reply-To: <20200522180336.GD325303@hirez.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de> <20200519214547.352050-11-a.darwish@linutronix.de> <20200522180254.GS325280@hirez.programming.kicks-ass.net> <20200522180336.GD325303@hirez.programming.kicks-ass.net>
Date:   Fri, 22 May 2020 20:26:44 +0200
Message-ID: <871rnbsu57.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Fri, May 22, 2020 at 08:02:54PM +0200, Peter Zijlstra wrote:
>> On Tue, May 19, 2020 at 11:45:32PM +0200, Ahmed S. Darwish wrote:
>> > Mark all C code samples inside seqlock.h kernel-doc text with the RST
>> > 'code-block: c' directive. Sphinx won't properly format the example code
>> > and will produce noisy text indentation warnings otherwise.
>> 
>> I so bloody hate RST.. and now it's infecting perfectly sane comments
>> and turning them into unreadable junk :-(
>
> The correct fix is, as always, to remove the kernel-doc marker.

Get over it already.

