Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F03C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B5D2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598315574;
	bh=HzNRSUeUL6OriNoi411G8DjwqUuqi7JFl1V+hmvfPWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gS7QwuN21IEOyDzi1NJqqqvn6tCzGVG4bcTqRRdaEqk7UQnYq7MDRKs/xFsA+dVLB
	 DdPnE0TevB6hPeDGPRyda6dh8frr0M0NVm9BzL6o+3xPtVBvWs5GAxeohAZs3NhRMn
	 ia9TsivcBCeomPs8zNhjjZmcqAg64oBKBZg9j720=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgHYAcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 20:32:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728439AbgHYAct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:32:49 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0684D22BEB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 00:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598315569;
        bh=HzNRSUeUL6OriNoi411G8DjwqUuqi7JFl1V+hmvfPWg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uRWu1h/pRTe38+cnhWVoUjMTGyUxj4FX6LHXPmQOHohc0UiMAuVFXRFfGvQuUXiFU
         x0m9GY1EjwLb2Vn/RymkjG2w7e8cfbzAb7e02+yOOlT1W3LXR000Pr7kw4RnV+6ZXj
         WrQB1im2A7usG0ceNRnrso4/XUttJEJC2aZHtYTM=
Received: by mail-wm1-f42.google.com with SMTP id t14so588261wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 17:32:48 -0700 (PDT)
X-Gm-Message-State: AOAM5326/J6Ldwqtoh3Z7okUS0CYSEJ56a90LPTh0BhAMNjdEbwuUMUW
        4xMbjZeKAY57Npzt8LWcN9s1QIV6JmuFdokcSzqkPg==
X-Google-Smtp-Source: ABdhPJyauPayFdftcuPZnq0MJTSphzvI2x0UgLNn081J3B9GZfktgEGZliAmuQJq8JPRJLx6kwBNbrs1VoFPRwDiqF4=
X-Received: by 2002:a7b:ca48:: with SMTP id m8mr1581098wml.36.1598315567552;
 Mon, 24 Aug 2020 17:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200825002645.3658-1-yu-cheng.yu@intel.com> <20200825002645.3658-10-yu-cheng.yu@intel.com>
In-Reply-To: <20200825002645.3658-10-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 24 Aug 2020 17:32:35 -0700
X-Gmail-Original-Message-ID: <CALCETrVXwUDu2m-XEd-_J03L=sricM4cMxQYVkdGRWZDjmMB2g@mail.gmail.com>
Message-ID: <CALCETrVXwUDu2m-XEd-_J03L=sricM4cMxQYVkdGRWZDjmMB2g@mail.gmail.com>
Subject: Re: [PATCH v11 9/9] x86: Disallow vsyscall emulation when CET is enabled
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 5:30 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> From: "H.J. Lu" <hjl.tools@gmail.com>
>
> Emulation of the legacy vsyscall page is required by some programs built
> before 2013.  Newer programs after 2013 don't use it.  Disallow vsyscall
> emulation when Control-flow Enforcement (CET) is enabled to enhance
> security.

NAK.

By all means disable execute emulation if CET-IBT is enabled at the
time emulation is attempted, and maybe even disable the vsyscall page
entirely if you can magically tell that CET-IBT will be enabled when a
process starts, but you don't get to just disable it outright on a
CET-enabled kernel.
