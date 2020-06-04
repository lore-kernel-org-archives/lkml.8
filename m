Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0B4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF96207DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjHkdzUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgFDOCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgFDOCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:02:00 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547D6C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 07:02:00 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 82so3669139lfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 07:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RyahCwj7GWFMqqvRbPUi/TlPiAHD4KqpSE60TAEaL9A=;
        b=gjHkdzUMhdyHJkapNYoxi9E/bvX0FBFiSvfqIhYHEmYQTT7TsTNlVhAesWRAL7isYP
         lsna+Fr7cHbRtH48eiLL8jfUvf8a5+6nuqcuxFZt/wGr1wGuhifGi+ylwfCLPZBAO82I
         Q3OvNuGkRmpIli8heThK0uGKWFAxsAIWwF1U54EWDKNOJlKtVaXqUX+JzWrUVavBKvqB
         iFXYlKgXAdF4Q95WyKBxD8X1AdyHA5WeZRKC8nk2uz5BDKsKTZl+l3QGpqv+NeShBwcv
         eMXXQFW75HJDx5wd1ToS/HhRrjtFKP+7hSfuFsfKEYeHvp1RvkiP5BS3ZElqqVJpanMo
         9Pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RyahCwj7GWFMqqvRbPUi/TlPiAHD4KqpSE60TAEaL9A=;
        b=eZBI9r8RJ0PleUWTa6TNHkiGEuu3dVfvtCeMWDfp64NSPQpyGyzGIxa766GTWRFcmG
         CIRZfFPjO5kIdYYwau94EyEInZgIl3sfJgW7RKhc3sa8D5E1tQzI31maV3e2zgqkrzd4
         SBfO8C836XzGMzoh02tCmam2YJMaep6ovdUFjBEE9C40yL2fAGsctjfUJ+i4cF51+Eog
         KwaDvqYpE/OZVhaQMYFvgp3emxV1JIeAFFOdWooKZrkDzcavf07bSqRkBApppjw+llvA
         OVjYQfTw2i43VERTtuFiHPPcReMsoZ4nWRdC4VKrZS2PhzXBG/XcRJmRWXiwcqwmMYLb
         tUrA==
X-Gm-Message-State: AOAM531KVRQQEdzGfBTHzYEfFxVuIwqBOMD317wUXO8j6v+Kw76flPJR
        vXAonn+JZG70XnRhwyKna88D4JPkMIa094veFZxNxw==
X-Google-Smtp-Source: ABdhPJwB31t3SsgcUaqovXgGt8jFxRPQdX0SXfXfNcrhI263Zb2nRLIjrQ392jUb57HBWnL6OVG/nj7aV6lYdX+datU=
X-Received: by 2002:a19:cb92:: with SMTP id b140mr2706702lfg.63.1591279318209;
 Thu, 04 Jun 2020 07:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200604134957.505389-1-alex.popov@linux.com> <20200604134957.505389-2-alex.popov@linux.com>
In-Reply-To: <20200604134957.505389-2-alex.popov@linux.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 4 Jun 2020 16:01:30 +0200
Message-ID: <CAG48ez05JOvqzYGr3PvyQGwFURspFWvNvf-b8Y613PX0biug8w@mail.gmail.com>
Subject: Re: [PATCH 1/5] gcc-plugins/stackleak: Exclude alloca() from the
 instrumentation logic
To:     Alexander Popov <alex.popov@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>
Cc:     Emese Revfy <re.emese@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Alexander Monakov <amonakov@ispras.ru>,
        Mathias Krause <minipli@googlemail.com>,
        PaX Team <pageexec@freemail.hu>,
        Brad Spengler <spender@grsecurity.net>,
        Laura Abbott <labbott@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-kbuild@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>, gcc@gcc.gnu.org,
        notify@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 3:51 PM Alexander Popov <alex.popov@linux.com> wrote:
> Some time ago Variable Length Arrays (VLA) were removed from the kernel.
> The kernel is built with '-Wvla'. Let's exclude alloca() from the
> instrumentation logic and make it simpler. The build-time assertion
> against alloca() is added instead.
[...]
> +                       /* Variable Length Arrays are forbidden in the kernel */
> +                       gcc_assert(!is_alloca(stmt));

There is a patch series from Elena and Kees on the kernel-hardening
list that deliberately uses __builtin_alloca() in the syscall entry
path to randomize the stack pointer per-syscall - see
<https://lore.kernel.org/kernel-hardening/20200406231606.37619-4-keescook@chromium.org/>.
