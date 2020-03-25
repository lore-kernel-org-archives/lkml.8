Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA56C2D0E6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563F020740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585160823;
	bh=8eot++bwcSHkvtf7ImsGmY9q1r5X5Yt6dA3yoI7A5dM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PHGlWV8yUodXXLiOYeJDwuF0Ck+dpMGpjShV58bziJZTx/ls9o6l0tQ0rtVQetku1
	 zgIOuWnIMraXwja93cOvnyLv4JqrC4v/r2oxbeAjiU9dp6FS99mhAwgPwcdJLU5Yw+
	 TWtK5I0ey+VRkVaHM5Hwup0wo/ySzGlqrZxooETQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgCYS1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:27:02 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45211 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgCYS1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 14:27:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id t17so3561845ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 11:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5X6cqBMAIN38Vpa0k6I9LJbV/IM/WQtUqFEnNCnTPNY=;
        b=TlWPo6jnLSxn8p8IHTlkVwEwL3/bAuCByG1NNq6gwkhFHy+98AmzLxQujgt6EH9gbF
         VcqyVwF6ZKpy9+4bUUmP4yT6mL6eVT3nwrrQriNR3oKU9S/kvgiCbtQV77gvaeTWDbpA
         CTniS/587iNKbgs/L/iiHAANJVJIvMl/L1U5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5X6cqBMAIN38Vpa0k6I9LJbV/IM/WQtUqFEnNCnTPNY=;
        b=N4F4i1lPWJdqK9jWWswLLbCj/H8Pl6hr1FG3TtJQZCiidvqGth/IZSThWnO2Q/+VS+
         uWFcW9/HEQTAnOWtOFR1Ut1Q/yIAiwsOfPgNySpNYySLxHfAc1ZRLvv6cg7oYTFMifv0
         VDNJBhKKGnsYmJWf423Owl6gKcYI0V+Ri0KDA3U/wTQjcXDYoPu6wNzK7VeMQ14TEsrh
         MF2VSWds+EUPV9BlyULDM2NOghbs5Eulgg/smVp7vTVMkQL5FB1V/8HCIVdBIDFZmiYR
         PSGYmJ3qLmWo/s/jG4eVGG0nQwRr5bi8/XRNYh0+2nJRIbn1ZIeAsu02oQ91ceNIMHYg
         WXiA==
X-Gm-Message-State: AGi0Puap0s+2mlVET1D7rQfG1L3JwKygSNIChmVpP8Qm5PNbmA2iWPP1
        CV1CKYHqz1ulBHqZ65WY+Bq5uA7o7BQ=
X-Google-Smtp-Source: ADFU+vseBkaIJIVhSK+ZTnZutvzpSsafoA1rkWdaVT6RBlUrq/P29S5nACS2/F0EoN5pFX/fcyY5EQ==
X-Received: by 2002:a2e:7401:: with SMTP id p1mr2778448ljc.279.1585160816316;
        Wed, 25 Mar 2020 11:26:56 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id i2sm846999lfg.23.2020.03.25.11.26.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 11:26:55 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id q19so3564071ljp.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 11:26:54 -0700 (PDT)
X-Received: by 2002:a2e:b4cb:: with SMTP id r11mr2853613ljm.201.1585160814464;
 Wed, 25 Mar 2020 11:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiumU4QxAkT+GqhBt5f-iUsoLNC0sqVfRKp0xypA6aNYg@mail.gmail.com>
 <86D80EA7-9087-4042-8119-12DD5FCEAA87@amacapital.net> <CAHk-=wim-2aaFi_GNs5KmX4ykkgQjnRo5D4B9ZK+1Oz=kpp_2A@mail.gmail.com>
 <20200324170306.GU20696@hirez.programming.kicks-ass.net> <20200325181339.GK20713@hirez.programming.kicks-ass.net>
In-Reply-To: <20200325181339.GK20713@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Mar 2020 11:26:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPrOd_yM5NGHQDE3AFtNWqV=MDFno2xgZOYV3jwGQU4w@mail.gmail.com>
Message-ID: <CAHk-=wiPrOd_yM5NGHQDE3AFtNWqV=MDFno2xgZOYV3jwGQU4w@mail.gmail.com>
Subject: Re: [RESEND][PATCH v3 14/17] static_call: Add static_cond_call()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 11:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> To clarify; the problem is a task getting preempted with its RIP at the
> RET. Then when we rewrite the text to be a CALL/JMP.d32 it will read
> garbage (1 byte into the displacement of the instruction) instead of a
> RET when it resumes.

Yeah, I realized it when you mentioned it. I was trying to come up
with some clever way to avoid it, but can't see anything.

I can come up with insane models - you could replace the xor;ret
sequence with a jump to a trampoline where you've aligned the target
trampoline so that the third byte in the "jmp xxx" remains a 'ret'
instruction. Then replace _that_ one with a "call_rcu()" callback.
Wild handwaving of "I'm sure this could be made to work".

But nothing remotely sane comes to mind.

              Linus
