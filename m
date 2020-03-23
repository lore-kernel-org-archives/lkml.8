Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85936C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4950B20753
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ahtsdj4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgCWUvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:51:20 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:47699 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgCWUvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:51:19 -0400
Received: by mail-pf1-f202.google.com with SMTP id h191so12209491pfe.14
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 13:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+b00bb+PEHuwwbrBh+jXdgzDNV1aGS9nDxW/xv3omWY=;
        b=ahtsdj4ELpCQnmiOYkuLHzAu5rdET9qMc16OuZt5bFyYwMdikGX4f2ipXKV6+vyprf
         9r8FF8ZUkf5i5s2KaLD1g7oOrSQoOG8g9+WeQlUiDWr3CHEm77HA0Z3aqhPdTins50iJ
         VjoeT2+N+NBkx2aw6zWjCv9cagdH6rGKp+eWqeRvt4NB4JM5CVeEl1GT7RrzLt1pSsal
         /F2PDT0OY2vEDyVVBXvPyL4YSqsWZsmU1McDy+fogK/gJq3yoeCUyMLUhAYobfJ+3oQX
         uUJUSY8RsGexa4VeVb4BemGAol3K4hKx8nHqufsEIfin3Qbel3ew3Yfo/r9nBtXHorGR
         Xcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+b00bb+PEHuwwbrBh+jXdgzDNV1aGS9nDxW/xv3omWY=;
        b=mgFMyqvttLFmSb4qJjKB0eS4jOfLAK8wWyyUnpqEjCOVa7ZLXDVep/g1ce1l1XJh6E
         z4c5KjHKacyiDMvCsYNvj1gDgMrJZ1+eaIz85BhjCogOZGwYZyOEDvpkyT53rUQ3K0Nw
         7Kt+ObzLPiSOK6t4V9wTgCrhlPHFbzON0vKjgm81vjbw4BaQ9ySedcZCRBAHWpR7oxCZ
         7ED5npwSE/fxt52zWnkcu4KEyZwpztQ76blHADcEbJYIYIHZAfQspe42pj+Q7FdekBD0
         TjwbhY4j7rKUlLQkHuB9vi2bSUANDd8XsweS/xojQHDxXf/zze14nnZIcXEHbLX6D3FT
         Y8jw==
X-Gm-Message-State: ANhLgQ3gm4D8QXEtn2t4J9yz6S+SmHt6L4JaIMNxOTfbKY+z+5YROmg5
        /lO6cKrkmNyYPJQaBoVFuDDCKcIM3cVGrNIJbTA=
X-Google-Smtp-Source: ADFU+vsGxdofbj/6L1MajbPD2ZFlX8UIxw03aIwIG3JtuTKB4XZl+iU2Ydyg4rzO4c637lrpq9hFR3mptSdQd+fiXPA=
X-Received: by 2002:a17:90b:1954:: with SMTP id nk20mr1318401pjb.69.1584996676897;
 Mon, 23 Mar 2020 13:51:16 -0700 (PDT)
Date:   Mon, 23 Mar 2020 13:50:59 -0700
In-Reply-To: <20200316160259.GN26126@zn.tnic>
Message-Id: <20200323205059.59037-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200316160259.GN26126@zn.tnic>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: Re: [PATCH] Documentation/changes: Raise minimum supported binutilsa
 version to 2.23
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     bp@alien8.de
Cc:     Thomas.Lendacky@amd.com, hpa@zytor.com, issor.oruam@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org, matz@suse.de,
        mingo@redhat.com, nivedita@alum.mit.edu, tglx@linutronix.de,
        x86@kernel.org, x@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The currently minimum-supported binutils version 2.21 has the problem of
> promoting symbols which are defined outside of a section into absolute.
> According to Arvind:
> 
>   binutils-2.21 and -2.22. An x86-64 defconfig will fail with
>           Invalid absolute R_X86_64_32S relocation: _etext
>   and after fixing that one, with
>           Invalid absolute R_X86_64_32S relocation: __end_of_kernel_reserve
> 
> Those two versions of binutils have a bug when it comes to handling
> symbols defined outside of a section and binutils 2.23 has the proper
> fix, see: https://sourceware.org/legacy-ml/binutils/2012-06/msg00155.html
> 
> Therefore, up to the fixed version directly, skipping the broken ones.
> 
> Currently shipping distros already have the fixed binutils version so
> there should be no breakage resulting from this.
> 
> For more details about the whole thing, see the thread in Link.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://lkml.kernel.org/r/20200110202349.1881840-1-nivedita@alum.mit.edu

Acked-by: Nick Desaulniers <ndesaulniers@google.com>
