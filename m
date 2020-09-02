Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36A0C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B776D204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ir0yIXio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgIBPqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgIBNj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:39:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63B4C061260
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xzcFqBW66P6Gi8gRIAZhe8QJBU9uv82X621N7CBk6yY=; b=Ir0yIXioOglUfalbvX2p6P0Sw7
        M0j34LvZNu5hnXnxeC/wk8TSosMJMFVm6DUYqwXC6oczYY18Ny2HSP+OQZiP6GfCDyDTGrbPkfSZA
        RiFWKGuQ5hQwE4noSGIGnS0vSXuG3e9E6lOwYNT/qvezzsmPWbdPpQziOSIIyfUk0kStZVbEbBVv0
        anpKUGvKM2S9Iyz6GaUx36acSFeh7g0w5eu6DXJGQTUX/dLYON2ygpxgCQrjPnTrispYFKks0GKzL
        3YuYuTNWQXNp8ULQ6lcNrH0POISqmhORL43KWEoHLZFzfufFT3MyPIbAHY65aiVcg7qry8U6XkgfK
        ByF5b/sA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDSxq-0003ZX-Kx; Wed, 02 Sep 2020 13:38:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CBBC53056DE;
        Wed,  2 Sep 2020 15:38:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A873329A82C1D; Wed,  2 Sep 2020 15:38:11 +0200 (CEST)
Message-ID: <20200902132549.496605622@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Sep 2020 15:25:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 00/13] x86/debug: Untangle handle_debug()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The first two patches probably ought to go in x86/urgent, the rest (!RFC) can
go into x86/core and wait a bit.

handle_debug() is a mess, and now that we have separate user and kernel paths,
try and clean it up a bit.

There's two RFC patches at the end that impact the ptrace_{get,set}_debugreg(6)
ABI, I've no idea what, if anything, is expected of that or if anybody actually
cares about that. If I read the code correctly nothing actually consumes the
value from ptrace_set_debugreg(6).

Kyle, you seem to be pushing all this to the edge with RR, any clues?

Since v2:

 - fixed (user) INT1 / icebp detection
 - some further cleanups
 - two additional RFC patches

