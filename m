Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20F1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A88D120575
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589431781;
	bh=HHX7sQCDhE0nKw/Op3KdkQZo+j2F0uCq9k0HzIa2bks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OA7MPqsKEKSK2CthtiJjmfmVz1BYNrIErUf9R1pMvVmsdvLoLfEcJvijlpmSF3yy/
	 UMDUKTaWDZsr/pj2KPmkDeQk8+8yoH2gPpoxABFMAiS4l5SbFnhHKEp8GiRizjLSwH
	 8uF744t+X399ZuhXiLFKnOIiItystLyhT/+FxZzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgENEtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENEtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:49:40 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9790520748
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589431779;
        bh=HHX7sQCDhE0nKw/Op3KdkQZo+j2F0uCq9k0HzIa2bks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E1UmAUSx8Mc46ocTxJFHz8HsH7I22FSEUqRdqdbMpDYgFMMpeeLXjGNg3OVgQSI2V
         p3+w8kTb5kvc69q04BXtnu/UlrC+resV3ZkCmIGcikKGXP0K6vT/w0kqzwAKwK2TeL
         aUc12+q4kI9RlXsrsYqY4ufLmGk4nNqUl1vfVVd0=
Received: by mail-wr1-f45.google.com with SMTP id e16so2106247wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:49:39 -0700 (PDT)
X-Gm-Message-State: AOAM533zsvDi8Gr6pxOUsnr7R8NLT4RKUtLSdCMElc7KI7elRYh+96Pg
        MCj7K3A9ImLxGFoRzDojGv1pZDneYlbvpXPHKrGF/Q==
X-Google-Smtp-Source: ABdhPJynGaeZRZ/zS4PfiCSfQ5qqNn2AIXuPux/vMnFMpSAsDp0daygYi9B8JssowAUC+FKgDDDIDq/s7l+avpft6c0=
X-Received: by 2002:adf:eccf:: with SMTP id s15mr3044153wro.70.1589431778062;
 Wed, 13 May 2020 21:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134905.838823510@linutronix.de>
In-Reply-To: <20200505134905.838823510@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:49:26 -0700
X-Gmail-Original-Message-ID: <CALCETrXnjnk-9b8Aebo7RKGHz1C39K1o8ZWy74YWyQNYdQfzvw@mail.gmail.com>
Message-ID: <CALCETrXnjnk-9b8Aebo7RKGHz1C39K1o8ZWy74YWyQNYdQfzvw@mail.gmail.com>
Subject: Re: [patch V4 part 3 26/29] x86/entry: Convert Coprocessor error
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
> Convert #MF to IDTENTRY_ERRORCODE:
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
