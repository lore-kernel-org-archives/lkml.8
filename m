Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52928C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3968A207D0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589432352;
	bh=34F8eGW7N0jNgiN4aSvNc+ES3vB+phlFfIdTqf7K6F0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hYNVDUBainFftt0w6VhHTi+TNrBLv/dHmPsQr4DDF/5k3Be5MLy/GJ+ce9hAec0wg
	 vdk9OJmgB3bOMBlzl+v9cVahk8WhHZVDdYs5dAtri0FEX2o2rAY0BhT0kr68mxVK4b
	 RNnqrWtaGbAas2JlXd5fqX4YkNA7pdHhXFXJSirg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgENE7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgENE7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:59:10 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1285A20760
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589432350;
        bh=34F8eGW7N0jNgiN4aSvNc+ES3vB+phlFfIdTqf7K6F0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sAuNhWj+W/vblq6c/VQLrv86iMJSKqlo320TejoRm4rYoSVcolQNTzKR4B9VxzgwW
         +Y87T7cz0eZ2e6x2VlqPGSALZpgjy98JWKqKDi+DGcSLI4vS4xVgw4nKz5mlgk9t5y
         +QNZYA/t+sRZxPkCPrs4Z1dziwVB2lKdXVp31i2M=
Received: by mail-wr1-f50.google.com with SMTP id v12so2088397wrp.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:59:09 -0700 (PDT)
X-Gm-Message-State: AOAM532en5kXc+ZCoXbKyFFzU5+9ws+zg816AnJYZhTGPnfDAGCvf042
        Qa17XQLq9pfBdw80G3uUJQlF0s8JDdTwuuZILnCFcw==
X-Google-Smtp-Source: ABdhPJxfXsiygQMHLXwzsecD4MfW3wLYbQ6qE2bPesDvAj5EdcZGqNL61NZ7Vto10GqHNj2DEhKaqwI6vwoAWY3GIdo=
X-Received: by 2002:adf:f446:: with SMTP id f6mr3071623wrp.75.1589432348453;
 Wed, 13 May 2020 21:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135313.731774429@linutronix.de>
In-Reply-To: <20200505135313.731774429@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:58:57 -0700
X-Gmail-Original-Message-ID: <CALCETrUXFme0mMEu9RhnBbwPK2EWXNt7uPFCK5niv_qk2yuyhg@mail.gmail.com>
Message-ID: <CALCETrUXFme0mMEu9RhnBbwPK2EWXNt7uPFCK5niv_qk2yuyhg@mail.gmail.com>
Subject: Re: [patch V4 part 4 04/24] x86/int3: Inline bsearch()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> Avoid calling out to bsearch() by inlining it, for normal kernel configs
> this was the last external call and poke_int3_handler() is now fully self
> sufficient -- no calls to external code.
>


Acked-by: Andy Lutomirski <luto@kernel.org>
