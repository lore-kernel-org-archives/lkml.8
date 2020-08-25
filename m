Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98A1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B72FB2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="MMVkUG6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgHYQc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgHYQcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:32:24 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B1FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 09:32:21 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id b17so9110310ejq.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 09:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2+dIJmuSMgJbsQBBUKMgpxWSQF3Ivrp0GmzROa4iBmw=;
        b=MMVkUG6Q9GIG8JKpLRQRwf0zeRciqB1FjPAIfTWEWc28q11DdfHRMtydeftDYgiw5h
         4IIXJDbCuOUR3izFfE77eLxG4VdPbgY9h7cCHuGqaPd/Nf5wnSaGt3exsu01Vg60CgVa
         Xwysl2NWuxQMfm5EtFW1tvzfKSzAFzXaiRLmnd8WGlA5jwYeOBfVaTlWON8ZgvjemPLY
         97P2QWWrGq1HqLB0S1VFlgyxrjq5oP8g5BbO91JoQHO9SQQQdiRIGcNBxdgMFSxc0x7z
         B0wNBIJbu67Qe+myC/C5gfrO8VS4j2OQI7xJwU+5M0usx0JJmEr1D9KaviAYvTK93RqA
         fRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2+dIJmuSMgJbsQBBUKMgpxWSQF3Ivrp0GmzROa4iBmw=;
        b=qblwMqQZ5mDGMpUvdOERYCz6Zqq+9JDxclJeF/2gGLpf2V6XqiVLE471BXZhGLzX4F
         SZRK/3pMYKxcBjWfPTUx4rYQu8B2gCgG2tEJxbhUJ4w0ef1sLfwGNisscFNBhqWFuIhB
         gAYwznT9Cvs44iJLrcSdjJF7R6G4i17VKhPqkvf8a2w3SxvpOwYniy7EARtodgH5OeAk
         XxuNctcTVn1TIensB8AhGTSHe0+vVgaQVEa6khvsH4uv/bx9Dm3Oppju2MUbt0/Y8bw+
         RVGCuDsI1lsULVZdzGFPIGa4G+WIHBNm4czrgXDF2rJAFtsLuJQvDmczDtIC8+PHlpDb
         SKqA==
X-Gm-Message-State: AOAM530zKAOuKQ4jRWELZVMiVerByBS13wp5lQTxBbsCekvp3HSinTFa
        qkiP4Hxts6nxHDQgIH3EpMY0CpHSgLfUduJ372kzbPG3ofp7tA==
X-Google-Smtp-Source: ABdhPJz5Oqbea80XpYQhN6ZgBsYQzTZEyQCdO0DoTgIfj9OHeDrMgvau+6rRuKToV7mDWVgBMRFN2NHkLoRYV36g7c0=
X-Received: by 2002:a17:906:1c59:: with SMTP id l25mr11860868ejg.182.1598373139996;
 Tue, 25 Aug 2020 09:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAOp6jLYrwMqV=7hmxgdZUdDZ2aeUB27TTHm=j6cQT7C10Muhww@mail.gmail.com>
 <7DF88F22-0310-40C9-9DA6-5EBCB4877933@amacapital.net> <CALCETrUrvrQNw6dPau_rtHjA_YuCVdCTWYd4dsdcvcGsOaspmg@mail.gmail.com>
 <b0813ec5-b163-cc11-bfc9-e9d08c9c4ff2@zytor.com> <CALCETrXvgb257CWnaA1NgUUp3x08+gJBEOQh4o9OYkB-RvAo1A@mail.gmail.com>
 <CAP045Ao6xBquwSDoCLzzNbEW1Lr969d+D0jQQ2Zb4pX3B77-Xw@mail.gmail.com> <CALCETrUgm-Cph4fwqk108VHZPLuM7XWL=nff-xB+hc+hiDrqsg@mail.gmail.com>
In-Reply-To: <CALCETrUgm-Cph4fwqk108VHZPLuM7XWL=nff-xB+hc+hiDrqsg@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Tue, 25 Aug 2020 09:32:08 -0700
Message-ID: <CAP045Aqhox6YSdk0v_YZWY=y7Ps4ZfH779MG-W4a=gc+cYEY+Q@mail.gmail.com>
Subject: Re: [REGRESSION] x86/cpu fsgsbase breaks TLS in 32 bit rr tracees on
 a 64 bit system
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 9:12 AM Andy Lutomirski <luto@amacapital.net> wrote=
:
> I don=E2=80=99t like this at all. Your behavior really shouldn=E2=80=99t =
depend on
> whether the new instructions are available.  Also, some day I would
> like to change Linux to have the new behavior even if FSGSBASE
> instructions are not available, and this will break rr again.  (The
> current !FSGSBASE behavior is an ugly optimization of dubious value.
> I would not go so far as to describe it as correct.)

Ok.

> I would suggest you do one of the following things:
>
> 1. Use int $0x80 directly to load 32-bit regs into a child.  This
> might dramatically simplify your code and should just do the right
> thing.

I don't know what that means.

> 2. Something like your patch but make it unconditional.
>
> 3. Ask for, and receive, real kernel support for setting FS and GS in
> the way that 32-bit code expects.

I think the easiest way forward for us would be a PTRACE_GET/SETREGSET
like operation that operates on the regsets according to the
*tracee*'s bitness (rather than the tracer, as it works currently).
Does that sound workable?

- Kyle
