Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84797C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 566B82078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HfKOiwdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgGISmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgGISmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:42:00 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692B6C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 11:42:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x8so1175603plm.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nyJ6z6/Z5uBD4mzn7e7w/X29e4m5Kuuz07q/2+OOWkI=;
        b=HfKOiwdqbD/fjaZoy0riDrCalOgfIQV63UyvPwuwvAgp1xv5G8CfX0kcRTUutyWmzm
         fWJWzWKI8K0I3tFmmz3vC+ilDbcuvog6yohGM29AEQ5c/U2rOaqdSG4L46Qvvj592Iln
         +8mLlSW8rDZ6Yq9ee8Y2t6Fj2tfyDfDMkGl3ZTSWbPWx7Tvocu2UsIDxXT5QtzTmwrec
         QsWRglGTt7dMC37tGBEIG1XJ65cIWhmLukici9fE8zvbRCxmJKsJr26iZWjNlodYvRdC
         3n3WrqzTJzAQCoswLdP1BD5T2PlbLBmitHk6wkz2LyfHWAHkkQDBrHxECZATFbPs4HOM
         5fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nyJ6z6/Z5uBD4mzn7e7w/X29e4m5Kuuz07q/2+OOWkI=;
        b=f5miiePyhV3rZTC3rCbRf/j2+MWJmAo4ljNojVx4fFuE5tRWKUVgVa82kJE4IFoQBN
         HJwbF2B3rGj9knKxOE8dkF4lIkxjiLmYp2cMuqaQdX2rAuV1CCt2X8miOnNO/eMIE3Zl
         auaWCKuaftYyqW/lqcZXOjvptiz9+GuylczFdzOk4Z/b7QRThy5QWL4oKGjOW5EQmvjl
         trMe/LPcKx8gcmjUEx1O9jOGw0U0cLAJVxdLWILYZpjGjD2b8tmJuOOjm+Ipa23+Zgpg
         IVLWi8dPFsUJyRd+BSw3Fa5RWJ8WC1HpB9PL9/sgDFrmlKjB+v68CK87tL2RvnBHPf2S
         OVcw==
X-Gm-Message-State: AOAM533MIVFozL1DqEXUsW+fxKjYcazucVLGl19d8HRNfI49ET6leH4d
        xDBKdrpjzcx+4voQwtTtuj+jc0E1pZVNqA6CJFx4MA==
X-Google-Smtp-Source: ABdhPJzSVDHolNIoahj22gXF9IUGjlqR8byYLHahwGm0WhTKF8Ls73bT/En9lv4otFG5mSjAx5U2lpEbTwE9iwRZYhU=
X-Received: by 2002:a17:90a:21ef:: with SMTP id q102mr1524895pjc.101.1594320119549;
 Thu, 09 Jul 2020 11:41:59 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 9 Jul 2020 11:41:47 -0700
Message-ID: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
Subject: Linux kernel in-tree Rust support
To:     alex.gaynor@gmail.com, geofft@ldpreload.com, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,
I'm working on putting together an LLVM "Micro Conference" for the
upcoming Linux Plumbers Conf
(https://www.linuxplumbersconf.org/event/7/page/47-attend).  It's not
solidified yet, but I would really like to run a session on support
for Rust "in tree."  I suspect we could cover technical aspects of
what that might look like (I have a prototype of that, was trivial to
wire up KBuild support), but also a larger question of "should we do
this?" or "how might we place limits on where this can be used?"

Question to folks explicitly in To:, are you planning on attending plumbers?

If so, would this be an interesting topic that you'd participate in?
-- 
Thanks,
~Nick Desaulniers
