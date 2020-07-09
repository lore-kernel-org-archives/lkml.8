Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4F5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9404C206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F/UUvtPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgGITnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 15:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgGITnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 15:43:46 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F55C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 12:43:46 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id k27so1428174pgm.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 12:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=LV8yOlhlgJtmA3PSCn38SrfJWuUPH5OH5CgM+ITjv9s=;
        b=F/UUvtPF0ou+BvkxR+Sjj6blLxs9Jpw28u9mafBl1/eBpptEmMf14XlHmUbFJ3HlWD
         XHAbERuI8oh1KiGiynAsWMx10X/1RPU+n5C+cV/nwtRGJMcOR4omdHCnD4N4NK2uKQ0m
         t3Ie5cQzjRfPglVb2i2SFvjWB+uAXew3qRbikx9Y0X6PNe4ln9JTr/hbjZ1womcUJCyF
         5d6X8KeczM4q/I6uPG9bvi0xaTuCxyBbRjhY8Cph1sARb+fGIarqDQaYKgrRHT08/Ygl
         VuVzaDjecGVRLM9PmjswPBK5uF/Svuq23say5GchOdmmyO4Aqua0M3o1VxvNKdE5ggMJ
         fUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=LV8yOlhlgJtmA3PSCn38SrfJWuUPH5OH5CgM+ITjv9s=;
        b=ZVkpACf9jPjPF2CWrJK0SQmTu5bYqpb8AevxmqohLYYx1KVIZt28rYSTAtitTLJPe0
         LyA6T80EBYEVHLDZfrJsBR+wgrbP18xnO87x0kRnSk7f4tRCsqsHPfJDLpFNVY7sVjfQ
         n1og8DZbr8w+yNmTF+6i2WK7zWVOOgnf94FfWpw5ZjjmPp8c5mfBhDxHzN2JImpCMwzo
         uBmyJ2NjGzZdvxKP0coifZAGy0HDKvUtraYkv4sgy69VvAJedk2F5ZbG4mXmQP7SMOlh
         6hMk4bRIYMyGuZc7CaUxDau7t8S9ruevpGI6PmlzsRFhUaXlosgGtjA/QHO3p2+eixDV
         1FAQ==
X-Gm-Message-State: AOAM532FeINL6a548LJw9AIPQtqSa5rDjK4nf/v5JR7XB7V+n8HRz9SR
        Mx+3GoAB68H01HOMBmnqilSLIxUA5BabSwgbuUVYXkZ5V8k=
X-Google-Smtp-Source: ABdhPJztaxDMOIbwH/m3iH7aw6zQA08qR8CqwjY526DbYAgi45L5ICY4ryZ9HWZANxAvp0jepV2XviHEbChMTjIkdfQ=
X-Received: by 2002:a63:a119:: with SMTP id b25mr54079220pgf.10.1594323826101;
 Thu, 09 Jul 2020 12:43:46 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 9 Jul 2020 12:43:34 -0700
Message-ID: <CAKwvOdnT5ZMjvz2_UJ4MtvDEs9+90bsDp-Rd2SnXZZ+AqebYHw@mail.gmail.com>
Subject: Plumbers session on GNU+LLVM collab?
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Segher, Rasmus, and Ramana,
I am working on finalizing a proposal for an LLVM microconference at
plumbers, which is focusing on a lot of issues we currently face on
the LLVM side.

I'd really like to host a session with more GNU toolchain developers
to discuss collaboration more.

I was curious; are either of you planning on attending plumbers this year?

If so, would such a session be interesting enough for you to attend?

I was curious too, who else we should explicitly invite?  I ran a
quick set analysis on who's contributed to both kernel and
<toolchain>, and the list was much much bigger than I was expecting.
https://gist.github.com/nickdesaulniers/5330eea6f46dea93e7766bb03311d474
89 contributors to both linux and llvm
283 linux+gcc
159 linux+binutils
(No one to all four yet...also, not super scientific, since I'm using
name+email for the set, and emails change. Point being I don't want to
explicitly invite hundreds of people)

The details of the MC are still being worked out, and it might not
happen, but I think with more explicit interest it's likely.
-- 
Thanks,
~Nick Desaulniers
