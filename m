Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB9DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 02:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F722207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 02:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MoJF1ab9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t0pdfr31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgHUC3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 22:29:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53608 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgHUC3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 22:29:03 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=is756+5g/B+UsuzcfpjCaazryNhoCR7MbohihXk4jig=;
        b=MoJF1ab9p4QXNy7FLEi500VmEOf9izMPbupcEaSGv/Q9omYQ6Md9SIYkEc1y9hRVVq7mdL
        hMWML/701L1JUkg1GIq673xRNbvVykOrq8p5H/37rWRYk3mWzu4/ONqzitxu/nt2QH0lGZ
        X0ajBbOfOsIvVwJgMjMt03/CGhjCGll1NK3nhJApvZsdB/xmj5vxX63cVX/hnAddGx+CnZ
        BCwXqhhuw6diMKoyWMI3JUclasR9EcWfw43eETKJbfVw22WjRvzFyOOPut+mKeSJRnLkYW
        sudQkUEFnRJXXaz+oOrgLriH+MDDk2rrZTJ98MmJErXWs93w8exhJ8e0UmcwNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=is756+5g/B+UsuzcfpjCaazryNhoCR7MbohihXk4jig=;
        b=t0pdfr310fMXxCJx4RvEI+Zne71yneSjyaZCDHsk1vjtRkUh9UIRjTVw3aWSjOq4lsMSdD
        RyqOaMiTUpCrEKDw==
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
Subject: Re: [RFC][PATCH 0/7] x86/debug: Untangle handle_debug()
In-Reply-To: <20200820103832.486877479@infradead.org>
References: <20200820103832.486877479@infradead.org>
Date:   Fri, 21 Aug 2020 04:29:01 +0200
Message-ID: <87tuwwhguq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On Thu, Aug 20 2020 at 12:38, Peter Zijlstra wrote:
> handle_debug() is a mess, and now that we have separate user and kernel paths,
> try and clean it up.
>
> Included amluto's fix for convenience.
>
> The whole set passes x86-selftests and the RR DR0 testcase.

but the utter lack of content in _ALL_ changelogs of this series does
not pass my sanity filter ..
