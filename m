Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1972C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB29206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="Gukgr50R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgHYAqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 20:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgHYAqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:46:22 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5B7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 17:46:21 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l63so6669866edl.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 17:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hjKqIZLzmHd4p7kyaSwWp24u2GNn12XnZUdGmho9Jcc=;
        b=Gukgr50RNodxfXTTBzruy3oCMBvOtbOKndtYi99p3fzNN/nAiWauej2yuDwwx1B9v5
         x3hrRWEh3f9BVGlHsxPUFF5Y2Y8KLfwmT4G1vA0uA3v1SoGKPbACxtAMaB/zt5E8NZnx
         tCWhKnfHF0kwalFm/1hHwQ4u1SuSqr23klpYVsMHMJiVndajb6qY1eMs62ZkmeDlrPYS
         FksqDzOkPP1NjqM+LDcnHCXQ1ldWRfsIEFdZxr85EYurxGFV+EHrFXWW2fJLvhlfYxFX
         VFZyWN72qTlEGLchjKKbchHUx1uBFLpB+2f6R/rb5NP5vOuBTvYn4dg8snLRNJQ9EX3z
         lxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hjKqIZLzmHd4p7kyaSwWp24u2GNn12XnZUdGmho9Jcc=;
        b=edPzGv0xJxGgIwGcYTAjfFm8M/V3QxT2TiLOp2uGEE/ZA2NkKGqUmsFPe6PUICU0AY
         V4CdeLJBeGzpDBY4QAzw3b+DFZIQ0WCVm4RG070Y4w7Q56HJPfwcU7nXOWnq7oyVhYL5
         uIQY3IQEIW+j8gLAzQfJQUCBcPqSEU6FXc2Smj2fBXX3JMf4HN01vzlfA7x9WaRkdbwk
         1gynvECBlP7vZlKvhcVEdg5eOkuEvpp29XMyh/pPFt1eGprJK6vo0cGGFGR3VWb6kNcl
         +HLfz5GzRdift5kXbKCeHgecEh6EtR+xis4GRv9l0WolPc1YoclrA/HFJJs16PDUuowL
         sDyw==
X-Gm-Message-State: AOAM5311dtNBpqHeTz7ThSivL6IF5B8dcsM8Hcbjf6kzZkS7PVw1/NaH
        zO/bz4z/oKr6E/iFs/JCZnXqWFL+RYWGK+1WOyiL1v/fz3KFQqVg
X-Google-Smtp-Source: ABdhPJyrUJewW7tGk1AEDaQKUn0xsE8weAKH+gBJaf0g6+ZXdiaFxkmJiIIbVKd6WLqq+YT0MHmj9qMPR7RgzS1+moE=
X-Received: by 2002:a05:6402:2212:: with SMTP id cq18mr7996788edb.34.1598316380072;
 Mon, 24 Aug 2020 17:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAOp6jLYrwMqV=7hmxgdZUdDZ2aeUB27TTHm=j6cQT7C10Muhww@mail.gmail.com>
 <7DF88F22-0310-40C9-9DA6-5EBCB4877933@amacapital.net> <CALCETrUrvrQNw6dPau_rtHjA_YuCVdCTWYd4dsdcvcGsOaspmg@mail.gmail.com>
 <b0813ec5-b163-cc11-bfc9-e9d08c9c4ff2@zytor.com> <CALCETrXvgb257CWnaA1NgUUp3x08+gJBEOQh4o9OYkB-RvAo1A@mail.gmail.com>
In-Reply-To: <CALCETrXvgb257CWnaA1NgUUp3x08+gJBEOQh4o9OYkB-RvAo1A@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Mon, 24 Aug 2020 17:46:04 -0700
Message-ID: <CAP045Ao6xBquwSDoCLzzNbEW1Lr969d+D0jQQ2Zb4pX3B77-Xw@mail.gmail.com>
Subject: Re: [REGRESSION] x86/cpu fsgsbase breaks TLS in 32 bit rr tracees on
 a 64 bit system
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 5:31 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Mon, Aug 24, 2020 at 4:52 PM H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > On 2020-08-24 14:10, Andy Lutomirski wrote:
> > >
> > > PTRACE_READ_SEGMENT_DESCRIPTOR to read a segment descriptor.
> > >
> > > PTRACE_SET_FS / PTRACE_SET_GS: Sets FS or GS and updates the base accordingly.
> > >
> > > PTRACE_READ_SEGMENT_BASE: pass in a segment selector, get a base out.
> > > You would use this to populate the base fields.
> > >
> > > or perhaps a ptrace SETREGS variant that tries to preserve the old
> > > base semantics and magically sets the bases to match the selectors if
> > > the selectors are nonzero.
> > >
> > > Do any of these choices sound preferable to any of you?
> > >
> >
> > My suggestion would be to export the GDT and LDT as a (readonly or mostly
> > readonly) regset(s) rather than adding entirely new operations. We could allow
> > the LDT and the per-thread GDT entries to be written, subject to the same
> > limitations as the corresponding system calls.
> >
>
> That seems useful, although we'd want to do some extensive
> sanitization of the GDT.  But maybe it's obnoxious to ask Kyle and
> Robert to parse the GDT, LDT, and selector just to emulate the
> demented pre-5.9 ptrace() behavior.
>
> --Andy

We've already addressed the main issue on rr's side[0]. The only
outstanding issue is that if you record a trace with 32 bit programs
on a pre-5.9 64 bit kernel and then try to replay it on 5.9 it won't
work. If you hit this case rr will print an error message telling you
to boot your 5.9 kernel with nofsgsbase if you want to replay the
trace. I think that's probably sufficient. 32 bit is legacy stuff we
don't care that much about anyways, replaying traces on a different
kernel/machine has always been a bit dicey, and if you absolutely must
do it there is a workaround. I'm not inclined to do much work to
support the narrow remaining case.

- Kyle

[0] Namely, we're tracking fs/gsbase for 32 bit tracees on 64 bit
kernels where the fs/gsbase instructions work in new recordings now:
https://github.com/mozilla/rr/commit/c3292c75dbd8c9ce5256496108965c0442424eef
