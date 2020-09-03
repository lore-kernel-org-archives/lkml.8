Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE3BC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 05:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1225B2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 05:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVRTaNTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgICFfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 01:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgICFfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 01:35:08 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A61C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 22:35:07 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w3so2053491ljo.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 22:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KvfRDr9m7GFxF53fVORc45Jz6EFpqNAlUtbFuBE05q0=;
        b=nVRTaNTrShblWXsxOqNK0W6rz6j88SE8Qnvhy+mAfd7s4ieqEXDF9qx66ny63Ei4FI
         ccsbd69Q27Avy+5ZhZpeSPHiCi3NsZ9Hd6j93MDkzlgwSPj9EgjFk7+hrGwUW8S4uzb6
         u7Tol+CCLby4U7ueP6n2vZW+k82JJ4G8FGr2mLDlQUtObTZEXFYvOkxie3B7K25/tJ7J
         T+W4qOEPo0OAjgk28A3UQgHjYPndKZKDAZJa/EAaeAp8ilLMN4BynEZ+oXzRo10Wt/d5
         TUe5Youak8nRWQhZwt/lyrXy4eHdFy5kudluCE9SAGgKoOBsaAoRV3XZ6wTTo/59N3uP
         rFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvfRDr9m7GFxF53fVORc45Jz6EFpqNAlUtbFuBE05q0=;
        b=UQwcfEzuk/glp65LChagDaNcyU5llV6FJ34F0IJzygplGpLZbxyjL98Qj74W6zKGoe
         S+xVpDjPo5VamHgJ8mLSwqSFFwpk/2DjAq5qT2Q2Wa6Rwq0ujwWGKu0gwpW+AQ6zSFH7
         eKNKzFj/NXrzRReOtVWfEL8+6XChT3be2eo5JaenCNd93XDU9/Kyv+Ty9pRRrjys+4g5
         gkKZBCjyWK0qqvNPC+K87EebLqtUQyHWwBXkymI5iLrRUnI1H24+pln5faW9s0naivA6
         phgFSuoOneBgMOwc8CvyS/i+kXmaVgWSn/gUwruLKvzhYojKtKdHKGFMGHurH1AMfKFY
         2ypw==
X-Gm-Message-State: AOAM5314EEeL8Im25qe6YK/ZYBoImWHScI3wjLWgXFJ8rGPSSyTp8/P7
        knzh0r1KH9zxTNSxgHCwPxTRw/2BT7GS/z9D3cE=
X-Google-Smtp-Source: ABdhPJx6vZNoorqKRJ95PX8u/didMEXIfHfhVMvxYh6YzQP3K9nfDJgSZk9/qnOYm7symMReaenNfQZZjcix6V+9YEY=
X-Received: by 2002:a2e:9b59:: with SMTP id o25mr299127ljj.264.1599111306283;
 Wed, 02 Sep 2020 22:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200823212550.3377591-1-nivedita@alum.mit.edu> <20200902232152.3709896-1-nivedita@alum.mit.edu>
In-Reply-To: <20200902232152.3709896-1-nivedita@alum.mit.edu>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 3 Sep 2020 07:34:55 +0200
Message-ID: <CANiq72=u33tiyp38WnxyyKOy4b5XSsw3JY6-ECWZvduHb4zqdQ@mail.gmail.com>
Subject: Re: [PATCH v3] x86/asm: Replace __force_order with memory clobber
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>, nadav.amit@gmail.com,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 1:21 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Changes from v2:
> - Clarify commit log and source comment some more

Much better now, thanks!

Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
