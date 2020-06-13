Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92995C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 21:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D1620789
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 21:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="B+QgbMp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgFMVl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 17:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFMVl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 17:41:29 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1108C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 14:41:28 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 205so12381819qkg.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 14:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qw8QtwNGUo+Eum7w2MvIheDYZG+1as/m6hwH6S16ckE=;
        b=B+QgbMp53Pu1FGcIjMGBBgXvJSGIOiiEQ78JXoDNljwVxbac1cxJ83hnJ0ib8DZavC
         dqQ3RJJt77KgagjUSsEOtWLK4ygp2hZY/SLqrnAz/BWTIg7Zts8wNpdx/VbOaDKa3J7m
         K3TtsTKmSVqAy+f2DsIpZCfgtlY5QJY8tvlStbkdCQqmNccbTIVCULK2hXurHhBkaHeP
         KavslPnHUaYe5XtVZ3ogdRlqHmdm79GpQiivb4GTJqVSYnoP3KnyLmbNQsH5C/CLeSjJ
         qFrAYxjZ03DuvF+G51ibkco1Azs8x/EHP6rMOa+gNpbMHTB1MzKPDAQiIjMLI/r7gc+9
         BWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qw8QtwNGUo+Eum7w2MvIheDYZG+1as/m6hwH6S16ckE=;
        b=fzZx72aiD/LshKraBYMo4uJRpdYeuM7RUEac/+6fiX4n53OPdZjSlPq0nzw/ddYMT/
         mGJld/JmI1oBGWJ8BCVVQLlFkFw/1CZsw8AZP9ecFyK8g+coobZn1fpsbKDCePFvf9UZ
         Kj8iUqr9/8NZ9mvG+c+jJlGgjLNbDn6SYLSN5A9BoWY3YCapXDjcYe+SR1a3JlV2ZD4W
         BonxSiey3x1IwOSdOU7b0VxrhmQ/1v+I00hzGHCXKyAUHVmphvorFHnuok+F6UtgrMt9
         /6Rh3MscoRzmBK3iFHq64Hd9cNl+6R32ydWgOQ1EwiPySp6df5Y7/XAipxiP70M4FuYm
         7l9Q==
X-Gm-Message-State: AOAM530u03EAbOHCNGwtmvXPK1KIqYvnOIRIi34yqHbOa6blPVS+dTD+
        /Sn5ZNmlCrGI8NHi7mKo2rkMow==
X-Google-Smtp-Source: ABdhPJzp8jZVoXCa8V3DcsSWREVzD4VLkOGZFOMwEG1ij3Fyk3zoWxRVjEThFvVQO3Zw4Eigo+AjTg==
X-Received: by 2002:a37:a7c5:: with SMTP id q188mr8797992qke.384.1592084487526;
        Sat, 13 Jun 2020 14:41:27 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q32sm8760430qtf.36.2020.06.13.14.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 14:41:26 -0700 (PDT)
Date:   Sat, 13 Jun 2020 17:41:23 -0400
From:   Qian Cai <cai@lca.pw>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [patch V9 10/39] x86/entry: Provide helpers for execute on
 irqstack
Message-ID: <20200613214123.GC992@lca.pw>
References: <87zh9cnfmg.fsf@nanos.tec.linutronix.de>
 <87wo4gnetx.fsf@nanos.tec.linutronix.de>
 <20200610123833.GD954@lca.pw>
 <87h7vig17z.fsf@nanos.tec.linutronix.de>
 <20200613135547.GA992@lca.pw>
 <87a717cbc9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a717cbc9.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 04:03:02PM +0200, Thomas Gleixner wrote:
> Qian,
> 
> Qian Cai <cai@lca.pw> writes:
> > On Wed, Jun 10, 2020 at 09:38:56PM +0200, Thomas Gleixner wrote:
> >
> > Thomas, I get ahold of one of the affected systems now if you want some
> > testing there.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry

Looks good.

<start>
# cat /sys/kernel/debug/stackdepot/info
Unique stacks: 27481
Depot index:   285
Depot offset:  3024

<after oom02>
# cat /sys/kernel/debug/stackdepot/info
Unique stacks: 29242
Depot index:   308
Depot offset:  6608

<after the full testsuite>
# cat /sys/kernel/debug/stackdepot/info
Unique stacks: 49221
Depot index:   530
Depot offset:  5888
