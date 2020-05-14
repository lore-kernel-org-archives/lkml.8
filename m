Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475F7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7AE206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589431844;
	bh=7s71FvC/Ra8fPfWzI1C288e4pFvBrJZ6E6eRlQ3VLbs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cPVSmh3n5Qo+ruVGtOuTXPH6QN5souaAPGOnfjkxdjF64gua85B3sTIyu7TO874OF
	 0Kg1xJwKBWzpJ1xIHsyhsEKKugxD9Sbjl6jvPJwNthbP0htZFilX4/Q9NsLEpiCphH
	 O5aMzDAb4e8iY4oYRLmIwsz7rlvHuXxhlg9O9z14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgENEun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENEum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:50:42 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEEC820728
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589431842;
        bh=7s71FvC/Ra8fPfWzI1C288e4pFvBrJZ6E6eRlQ3VLbs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ihfFJ/20IXoiKRPpLknrCfv6677LqUQCxOQbm7gGE05UEwb30LP3fUuClIwuVj4xI
         1xRq515Y46Sa8r4inr3+oT3+7N7qfWFiLJFpH/UTsqqrfc/vOz3k2Zxzx9GNSha3Ci
         jm0aW1I25n073+VLgWhTm1eS67MB1bN+Yj0ZY/2w=
Received: by mail-wr1-f51.google.com with SMTP id l17so2133779wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:50:41 -0700 (PDT)
X-Gm-Message-State: AOAM5306aR5aCHFWUqPwJLbzjkA+/NDX4WDNqHQfdv/sQlVqMSv9WbWb
        7JMhgfqbXgSUTT8LOOThEQufF86i4EmOLrCe+u4XSg==
X-Google-Smtp-Source: ABdhPJxg5jqNf7alvFhE1Ed7nw8T+ylnhEiiNfcE0OZzlqAm6PU50bgDK4l0aR2BhG2oPRxwSAYP9Hanhzt1/g7cS+k=
X-Received: by 2002:adf:f446:: with SMTP id f6mr3041841wrp.75.1589431840312;
 Wed, 13 May 2020 21:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134905.928967113@linutronix.de>
In-Reply-To: <20200505134905.928967113@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:50:29 -0700
X-Gmail-Original-Message-ID: <CALCETrVS+GZ05_UER-f3-BAanQMLQ24X=He7w-07LKH6HP0rdQ@mail.gmail.com>
Message-ID: <CALCETrVS+GZ05_UER-f3-BAanQMLQ24X=He7w-07LKH6HP0rdQ@mail.gmail.com>
Subject: Re: [patch V4 part 3 27/29] x86/entry: Convert Alignment check
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
> Convert #AC to IDTENTRY_ERRORCODE:
>   - Implement the C entry point with DEFINE_IDTENTRY
>   - Emit the ASM stub with DECLARE_IDTENTRY
>   - Remove the ASM idtentry in 64bit
>   - Remove the open coded ASM entry code in 32bit
>   - Fixup the XEN/PV code
>   - Remove the old prototyoes
>   - Remove the RCU warning as the new entry macro ensures correctness
>
> No functional change.


Acked-by: Andy Lutomirski <luto@kernel.org>
