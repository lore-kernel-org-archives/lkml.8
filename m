Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231E0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA539207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589908009;
	bh=5uyJonE29aj4ak5TUOBdNcZHvtIQ6YkbcxtKmWnxMaE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yrOEbiwFFbkFh9g7ZMdrFVIvIw69qhqzuiVhY+d3o2+Kof/dtvhdBgQdZxIBsA4NH
	 i0y2TlHDCVNInKxGr/a5QONgStZu0Jbt8gixDf1OWJ7qMTIQ7YzMb9OJlxoCMaBfSG
	 LVi5PLcAzJhwaxN9n2VVLdUoRAaP2r8jDqnjx8KU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgESRGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 13:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbgESRGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 13:06:47 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AF83207FB
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589908007;
        bh=5uyJonE29aj4ak5TUOBdNcZHvtIQ6YkbcxtKmWnxMaE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MsB1LAiKZbGqSdt+soafuZbmOZWcT66sES6FRS8M3S3TN1vIegT/XK89QEea77TrF
         EwG/s9ioO4W0euXFRcDxooADoknK8yAF9hbJZjk6h9oN6ZYSdDlFqx+hOEjJ5tG8ZR
         JjepjE190R6ojuFkEz83KPoFK9jhKwEDdBVJGzKs=
Received: by mail-wr1-f45.google.com with SMTP id w7so169437wre.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 10:06:47 -0700 (PDT)
X-Gm-Message-State: AOAM533F8uamLS+lvHxa9oFpLNDcySj5QfoPwikIy+umRkPlVTdz2LqK
        Z2PWfDq8yMZM4giZVogejZ3/2s6Ijc0a+uMjm/qf8w==
X-Google-Smtp-Source: ABdhPJz3JhIvhZ6BzmepWImpKytvzD+eViMps8zFTCQbF441FYQ2piB8plXbggqL/06BTC41Bk0ZnZ43u1doYvHPr6w=
X-Received: by 2002:adf:f446:: with SMTP id f6mr26166972wrp.75.1589908005923;
 Tue, 19 May 2020 10:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.519511140@linutronix.de>
In-Reply-To: <20200515235125.519511140@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 10:06:33 -0700
X-Gmail-Original-Message-ID: <CALCETrVzjC+EoX9jCbaLdYirFTbKpK+44RB8OeGWUZT3w04Q8w@mail.gmail.com>
Message-ID: <CALCETrVzjC+EoX9jCbaLdYirFTbKpK+44RB8OeGWUZT3w04Q8w@mail.gmail.com>
Subject: Re: [patch V6 11/37] x86/entry/64: Simplify idtentry_body
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>
> All C functions which do not have an error code have been converted to the
> new IDTENTRY interface which does not expect an error code in the
> arguments. Spare the XORL.

Acked-by: Andy Lutomirski <luto@kernel.org>
