Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E6BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 845B2206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589431764;
	bh=V/oBOYtKp6M9rPVY/uwibfRmC4k4sU8suKlC0+cFFz4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y8YwXHIyBfHxtMVtFFyLey4ZWrQfZNkbse+Bz998NVpi+Y7+cKlh9RHkO3bOcSnf8
	 oeEvdI8VxhkXssBjK/h/3DtdVeMspdABH65Sdq7QxA6PByDcOPQOIDP1J7/DDYpWy+
	 AFsvo6UZQBu9cDOyWCUHoe6DZAHpvAlGeq2vL5tw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgENEtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:49:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENEtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:49:23 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6203220758
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589431762;
        bh=V/oBOYtKp6M9rPVY/uwibfRmC4k4sU8suKlC0+cFFz4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZBMgjwe7TjczZXnPrBrukDP6+NucmGH+g8uDw3PZfMTVH/vY1KevCsB8An92YhsUQ
         hXh7zEbqrtBqMRNNOzgViDW+uXs+kEP6A00Eu1sRDqCxyelBCSHDf3JG7OOjl9wl++
         6jTPcV0Oadq6R8uyXW9/H7MFieA4W04r2XrN6Kk0=
Received: by mail-wr1-f50.google.com with SMTP id i15so2075263wrx.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:49:22 -0700 (PDT)
X-Gm-Message-State: AOAM5324oY/hMBRqwvRodUtI1ERxyfqkZL4q720Td07T+H3LwPfiKNU4
        0podg23CmhjUx+D7yutZ2eHDB8ZXQsk6ZK8dgxc7dw==
X-Google-Smtp-Source: ABdhPJyDvFRxlNed4RKDzx70fmEv2+c/lffoH0aQ1m0xUx0Qyjm+pIh4/8d1WHNqII6A7RTqPhG54kyDdNLThm33kSM=
X-Received: by 2002:adf:a298:: with SMTP id s24mr3057145wra.184.1589431760838;
 Wed, 13 May 2020 21:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134905.539867572@linutronix.de>
In-Reply-To: <20200505134905.539867572@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:49:09 -0700
X-Gmail-Original-Message-ID: <CALCETrUHFQ+TAq1xBpzUbXiA=HmpdndTRiUyWWJfcmL-EeGMKg@mail.gmail.com>
Message-ID: <CALCETrUHFQ+TAq1xBpzUbXiA=HmpdndTRiUyWWJfcmL-EeGMKg@mail.gmail.com>
Subject: Re: [patch V4 part 3 23/29] x86/entry: Convert Stack segment
 exception to IDTENTRY
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
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Convert #SS to IDTENTRY_ERRORCODE:
>   - Implement the C entry point with DEFINE_IDTENTRY
>   - Emit the ASM stub with DECLARE_IDTENTRY
>   - Remove the ASM idtentry in 64bit
>   - Remove the open coded ASM entry code in 32bit
>   - Fixup the XEN/PV code
>   - Remove the old prototyoes
>
> No functional change.


Acked-by: Andy Lutomirski <luto@kernel.org>
