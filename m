Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BC6CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8CE7206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cJXtddWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbgELRxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 13:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgELRxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 13:53:12 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6C7C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 10:53:12 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 19so18991812oiy.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 10:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NkOoyxp+KOfXBJgSgsmTbcJqNZ2GGnNdvXTFmavoPqM=;
        b=cJXtddWTuDJRf+CmWTK1TB/ivAn0sQMUeBhtE5kBCZ5crRtq55EMpkXbCwDrWFdnG2
         hw/jaxgXukOHTPwvYFbv5bhgRwrMwTf9T7YxLz/pgY6ngXJcMWcQnRi6fpXVWarUAkf1
         T9m1woadtB13mx35loE0yBtMOqsFfGNBmGCXcty1tKKbQ7qxfsAxTIn8H+P0kaqcXCkc
         Gs7IvOII9jlcgWojPmJmO+89TkRnzHVX+248d3y1wPUNdY3LBWbECFM9TdA+YcUOzIXS
         QJz7fEBPgG3qmasdKr6psI5Pmw9WTOiPeWGPQyGUiL8b0l8JJWv5jccf5FeWT5jsOpCT
         lbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NkOoyxp+KOfXBJgSgsmTbcJqNZ2GGnNdvXTFmavoPqM=;
        b=nG3QyHORxLcWusU3ou2YZ51i+R6jLMnshJ4Xkim2vuHOsndYl7edmxzji3OWinseST
         O7c0/LQkBuOBPV+EPnUXPi0gawrSsHGhh8oTean+K4mV/sLGWgj0daNOMdZIKzN8fcvn
         HCRCCyguECmaEP+jbu5CeFGqTDm6gdec6uQ/SvqzQ9frWocs9944Zs3BCcXynS7GrJwl
         oKQzR3K+bfX1ulGir2BwllpiCF1FWUVwFN22uRlcS3oxwvtsxZPmTTZIUFKdJwbwE6E+
         9a399w/IQnFhD5oPl4v5im8F9mvdrkIPMU1H21I3+iU3I4+uSzCRCaAjK+ztUOBo7T0E
         J+xQ==
X-Gm-Message-State: AGi0Pub2yi93mDhW41fWHdMlNNWZ4GtdM+ZFRrBXe3A4T1xeIy4VSN+C
        xJ7yBolv1bpje4HkWf4Qp9e40dKtt0pNKz3PEo8wFA==
X-Google-Smtp-Source: APiQypLkP5pPehJigDDlRNOn4+iVPva7JZfnu6dHE84/k8Lgg0hD4kcUuABKGJzkgwomRT/MBTH5un/l88p/4CBGWJA=
X-Received: by 2002:a05:6808:b36:: with SMTP id t22mr24884545oij.121.1589305991490;
 Tue, 12 May 2020 10:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200511204150.27858-1-will@kernel.org> <20200512081826.GE2978@hirez.programming.kicks-ass.net>
In-Reply-To: <20200512081826.GE2978@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 May 2020 19:53:00 +0200
Message-ID: <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 at 10:18, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, May 11, 2020 at 09:41:32PM +0100, Will Deacon wrote:
> > Hi folks,
> >
> > (trimmed CC list since v4 since this is largely just a rebase)
> >
> > This is version five of the READ_ONCE() codegen improvement series that
> > I've previously posted here:
> >
> > RFC: https://lore.kernel.org/lkml/20200110165636.28035-1-will@kernel.org
> > v2:  https://lore.kernel.org/lkml/20200123153341.19947-1-will@kernel.org
> > v3:  https://lore.kernel.org/lkml/20200415165218.20251-1-will@kernel.org
> > v4:  https://lore.kernel.org/lkml/20200421151537.19241-1-will@kernel.org
> >
> > The main change since v4 is that this is now based on top of the KCSAN
> > changes queued in -tip (locking/kcsan) and therefore contains the patches
> > necessary to avoid breaking sparc32 as well as some cleanups to
> > consolidate {READ,WRITE}_ONCE() and data_race().
> >
> > Other changes include:
> >
> >   * Treat 'char' as distinct from 'signed char' and 'unsigned char' for
> >     __builtin_types_compatible_p()
> >
> >   * Add a compile-time assertion that the argument to READ_ONCE_NOCHECK()
> >     points at something the same size as 'unsigned long'
> >
> > I'm happy for all of this to go via -tip, or I can take it via arm64.
>
> Looks good to me; Thanks!
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I just ran a bunch of KCSAN tests. While this series alone would have
passed the tests, there appears to be a problem with
__READ_ONCE/__WRITE_ONCE. I think they should already be using
'data_race()', as otherwise we will get lots of false positives in
future.

I noticed this when testing -tip/locking/kcsan, which breaks
unfortunately, because I see a bunch of spurious data races with
arch_atomic_{read,set} because "locking/atomics: Flip fallbacks and
instrumentation" changed them to use __READ_ONCE()/__WRITE_ONCE().
From what I see, the intent was to not double-instrument,
unfortunately they are still double-instrumented because
__READ_ONCE/__WRITE_ONCE doesn't hide the access from KCSAN (nor KASAN
actually). I don't think we can use __no_sanitize_or_inline for the
arch_ functions, because we really want them to be __always_inline
(also to avoid calls to these functions in uaccess regions, which
objtool would notice).

I think the easiest way to resolve this is to wrap the accesses in
__*_ONCE with data_race().

Thanks,
-- Marco
