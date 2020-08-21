Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914D5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 02:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6221B20732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 02:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dXl5rr/Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dlAHNmwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgHUCZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 22:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbgHUCZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 22:25:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0422BC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 19:25:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pep2opEDdTAbVK1vQIZNLYAMKewMUZ+8IiDQVHdbRgw=;
        b=dXl5rr/YcgVIFDsu7luyXfMfLxXIA2ZqsBri/WnmA3L6b2UrAQnRTz5Xb9SPp936GO4U32
        7hMt5K9/tKxR3EByFgMMcbbVrA4V8NcwdVo6TeOiEk3ZqWcZnlyBthDk4kIpyeQKHYhAAn
        4lMcgOAdWgI5QLdYikpiciYj8HbhzY3BjCmuv/A9GP+IVdROwx6Z5Arw4wtfFWa4ctv1xa
        XXIfSvMd1IN2l0TVeOTJGFwqVMQrmbDkarQ/2HKzXDMOtlRXIyJkcGNQOTWiUEjHQodLd5
        s6iDcxPeBClOuaBInkMua05CVCzKM4z6W9lPb9ycFUg5vKXhsZ3ropeNpj1onA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pep2opEDdTAbVK1vQIZNLYAMKewMUZ+8IiDQVHdbRgw=;
        b=dlAHNmwE1h4LRLoLiya6hEa/prxEn+mubTXoxIK4uvcRyv47rhldw/tjfJeQ4JPGrb1CrI
        ZyHc8kYPIkd/rZDQ==
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
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
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 2/7] x86/debug: Sync BTF earlier
In-Reply-To: <20200820104905.178074795@infradead.org>
References: <20200820103832.486877479@infradead.org> <20200820104905.178074795@infradead.org>
Date:   Fri, 21 Aug 2020 04:25:55 +0200
Message-ID: <87wo1shgzw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20 2020 at 12:38, Peter Zijlstra wrote:

The WHAT is clearly spelled out, just the WHY is a big void ....
