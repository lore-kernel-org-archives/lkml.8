Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B51C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB522067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598303428;
	bh=b+iTlV4khAeSnNkrYWDltD8Uy3YAJwyRMXjJv/hiPYg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wDW9HWMjF0pm6gsTAUXoFuYUJWssqg+P0T0YR6cyXRndx2j8lRBWSNXt3Gb8BJeXJ
	 njlXAq3y7LRMBBnIwAt+Tpr+Q6sBatSPHFpU7X6mFADT+SwjGnqNdmvxYQhL+Ds6q/
	 xFoYCwQw8aiHvYhzJqv0PSf7xDmNdArMFJB7UWOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgHXVK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgHXVK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:10:26 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE4B42067C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598303426;
        bh=b+iTlV4khAeSnNkrYWDltD8Uy3YAJwyRMXjJv/hiPYg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yhEtqZ2KhMRVW0ugCZ7+yBbW7Rru6i8YBIawZxecusPj3pn8Z/cSpLq9hkV5Lr6SF
         ksTcfY4lsUKzlLGjwO82EWogdV0xfR/xwpOGxQljOuFFDbK8z8iukLiw6nP2D/fs/I
         reOY7S8NxKdqKAlIbHX9oN1s1fIY7cOHBWYmJA1Q=
Received: by mail-wr1-f46.google.com with SMTP id l2so10534157wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 14:10:25 -0700 (PDT)
X-Gm-Message-State: AOAM5323gX8yfZhqmQwZHGt20UvaExLRwN5uQTAlkCLxGyvEOoIQBjjf
        9Bd7iPwSNa6UVl+Jgax1CgLOa8on5l/04HWIRIPW7Q==
X-Google-Smtp-Source: ABdhPJyUkd1o3GT1Xad0KTVsiy6YUHXaldUk6yXHUKz5yS4PycBxxsVaNUIYEAOkQzrdJZlCIFg6oFgKse2fzJ0lRiE=
X-Received: by 2002:a05:6000:10c6:: with SMTP id b6mr7336388wrx.257.1598303424431;
 Mon, 24 Aug 2020 14:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAOp6jLYrwMqV=7hmxgdZUdDZ2aeUB27TTHm=j6cQT7C10Muhww@mail.gmail.com>
 <7DF88F22-0310-40C9-9DA6-5EBCB4877933@amacapital.net>
In-Reply-To: <7DF88F22-0310-40C9-9DA6-5EBCB4877933@amacapital.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 24 Aug 2020 14:10:12 -0700
X-Gmail-Original-Message-ID: <CALCETrUrvrQNw6dPau_rtHjA_YuCVdCTWYd4dsdcvcGsOaspmg@mail.gmail.com>
Message-ID: <CALCETrUrvrQNw6dPau_rtHjA_YuCVdCTWYd4dsdcvcGsOaspmg@mail.gmail.com>
Subject: Re: [REGRESSION] x86/cpu fsgsbase breaks TLS in 32 bit rr tracees on
 a 64 bit system
To:     "Robert O'Callahan" <robert@ocallahan.org>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Kyle Huey <me@kylehuey.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 6:19 AM Andy Lutomirski <luto@amacapital.net> wrote:
>
> We can give you a new ptrace operation to load the selector and deduce the base from the descriptor table if it would help.

Concretely, we could add one of these:

PTRACE_READ_SEGMENT_DESCRIPTOR to read a segment descriptor.

PTRACE_SET_FS / PTRACE_SET_GS: Sets FS or GS and updates the base accordingly.

PTRACE_READ_SEGMENT_BASE: pass in a segment selector, get a base out.
You would use this to populate the base fields.

or perhaps a ptrace SETREGS variant that tries to preserve the old
base semantics and magically sets the bases to match the selectors if
the selectors are nonzero.

Do any of these choices sound preferable to any of you?

--Andhy
