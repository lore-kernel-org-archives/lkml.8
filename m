Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE89C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C88520758
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="BEW03iIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgHSRyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgHSRyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:54:15 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADC9C061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 10:54:14 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id g19so27301061ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 10:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=uQuCMT3JAS43f6T45CVGGRAmxHBJTkERExczdcLcZVY=;
        b=BEW03iIu095qgBD2t+0qPzvlw3Q4Ph0RcFBp2F+pwNCXFvvLBlfoSNly+Y2Fem9AyI
         Q3d8jS01LKhSuzyG2o6DSO4T+cGAjv5Cdt9+DOnOcmUPrX0sxVluSrDDVkt8r6VSS5Rf
         KApMApMu0YDehVWZEq0EHCdeUICnL7SoBHSZ7Qktq1KPY2hIcjEYYtoxHrwmGBw2Z8wV
         yTX7uaH2b2RnvxJ1Y1wr2YJQTlxWklnQ74fB1S2O2ijKDhW6WebMT6PKYb0iW0xkK3pv
         FUePRdolqgN8JYQBH/SOJUEo2vlhy/3JqFpM4ONJx/BqA2Eyv2rHC2Npc6nuiXGaJTAb
         PVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uQuCMT3JAS43f6T45CVGGRAmxHBJTkERExczdcLcZVY=;
        b=Ank8czPIDOql7n3AEkPAAFF3Fcwo0mXvZHHK2ewI+6ZtvY7t1s1IngStHMCqkNRj1U
         k/VSiibC0HIG0b5C6PIdy5wV9hLLBP0Gh7d0WmrG2CWLyoqeAipsqgQIU0eTxyAkZhro
         6YVoEZcRu1vcSN7PJHTMjYMWXbc/DSaAE+Xxyuz81H67WP8oRL/Aaad6aDYAGDQuGTw6
         ptC3i51Fbt8xypcZ0h55k+1GV2iHC/yCQQYkD0pX1pzPptNgpwKez5O4gJTC10gw9I7i
         h1vGN51yeMGaKRke/ocC9jHUjgnDlhx+BbETFhUwBYeLcSjMyY7O5ZRmMYg2TzdmwKRu
         ISCA==
X-Gm-Message-State: AOAM5311RZmKEC+RL/EwlKoKtvFLTBx8jX2s90q4oCF4zOQ7mNNSqknY
        p7XTuSEd8507oG/RnWgtJbFFNirD3o6AkROHoe70Mg==
X-Google-Smtp-Source: ABdhPJwQzinONCrDVftCcA8T6ck8BmMOT9XvCK2EXjx2FD+4YpVUicQ9HjLRKVMyTKUsY/5QM8zLF4V/GIyNoZMxKgM=
X-Received: by 2002:a17:906:c7d2:: with SMTP id dc18mr5678373ejb.135.1597859653240;
 Wed, 19 Aug 2020 10:54:13 -0700 (PDT)
MIME-Version: 1.0
From:   Kyle Huey <me@kylehuey.com>
Date:   Wed, 19 Aug 2020 10:53:58 -0700
Message-ID: <CAP045Ao5-+vvTzCOaCkfwztsd2Q0_8kh85UxuXW0bbcfVbF40w@mail.gmail.com>
Subject: [REGRESSION 5.8] x86/entry: DR0 break-on-write not working
To:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     "Robert O'Callahan" <rocallahan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rr, a userspace record and replay debugger[0], has a test suite that
attempts to exercise strange corners of the Linux API. One such
test[1] began failing after 2bbc68f8373c0631ebf137f376fbea00e8086be7.
I have not tried to understand what has changed in the kernel here but
since the commit message says "No functional change" I assume
something has gone wrong.

The test expects to get a SIGTRAP when watchvar is written to in the
forked child, but instead the program just exits normally and we get a
status value corresponding to that (exit code 77 = wait status
0x4d00). This test program should be usable outside of rr's test suite
if you replace the test_assert/atomic_puts functions with
assert/printf and replace the util.h include with appropriate standard
includes.

This regression is present in 5.8.

- Kyle

[0] https://rr-project.org/
[1] https://github.com/mozilla/rr/blob/master/src/test/x86/ptrace_debug_regs.c#L55
