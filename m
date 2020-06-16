Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FB6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E7B2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="pBngrVW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbgFPQ4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgFPQ4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:56:32 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F266CC06174E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:56:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c3so21487747wru.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hwa2L1ImB15dIKmz7yLgrRrD9ZoRLynU8SCNI5jmVrA=;
        b=pBngrVW0fXgxGsUIB6iI6b9pR1mda14Neyp1D17D1rL+Hqqb3DpCGo4eohRlSyVnzp
         uvF3VYCjFeCCj0VsPcT6xwM8ISHlqv4N5ntmdzKgH4vComcnzC9on7c3xslUejjFZWGM
         hXigSpz86luPhPTAC1e4heu2+L7XscKr5Q3H30PhoXE+OzrYjT1a5miTd3j9fMF9b3iy
         IfDUsBdSDAtFknCr4P442lz/V/lJ7q39XCwc5W9Er4R5wuYuKbb2U0YDZkPJJ+BElZ1L
         11ngbe3M814XPzBZu6XvpnCwnqVyASlReBROo1HnYGUcuy3HkB4Ia68i5OwT7Jz11zxs
         F+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hwa2L1ImB15dIKmz7yLgrRrD9ZoRLynU8SCNI5jmVrA=;
        b=Qe8a4/zDqXlhlO5nPikSTmvcMuuNM+A1BALRUw9P7zZJ+F3JhfD3OxU/b78NRDEEAP
         2k8GoayhRau4XogXd112LpNvbbXKUtitN0kifxtlOXPD3L5rr4xmHSIeZBxEqci9xhqt
         0mE+2/nWS9SC9jFgvQJmutvHf8sVhTwQGgB8B6pkKElCAq7DUycLrf9Q8juCGq5wBdlZ
         TnwEYd6HSBbrkIyF/UtMqQPf40dKq1nKDuzeCm/1PrV2Bwy3lm2PuNbf9LDbBS0vjCYp
         0TMQEQpsG04kHKi3+7CdHuA4GF5XXaiYRO9FKqUErcUqh+MPZZdSOX8FEsKK18h5a303
         P/Hg==
X-Gm-Message-State: AOAM532RXgIAe+rNo7mo82BXq6pNupzeziw5Jj4VIULsqWumUOA4VWJH
        3621wrgUvS+9rr/u0HHePZhs2GTo2iorwv5GncYFIg==
X-Google-Smtp-Source: ABdhPJwlsWcL5tuSvSwcQCGpYRnQYLKsq+2Pt1JDO4/kJYBxWuUrjKMfTrAQtvwN0YDp9Y7hqi4ccSQZ4XHm6yl3W90=
X-Received: by 2002:adf:e387:: with SMTP id e7mr3978360wrm.70.1592326589637;
 Tue, 16 Jun 2020 09:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200616074934.1600036-1-keescook@chromium.org> <20200616074934.1600036-4-keescook@chromium.org>
In-Reply-To: <20200616074934.1600036-4-keescook@chromium.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 16 Jun 2020 09:56:18 -0700
Message-ID: <CALCETrUs2Xso=Yztmcrx_7bmXYoPLpcHeNpQSgcbSbvM_Jkw5w@mail.gmail.com>
Subject: Re: [PATCH 3/8] seccomp: Introduce SECCOMP_PIN_ARCHITECTURE
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Will Drewry <wad@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>, X86 ML <x86@kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 12:49 AM Kees Cook <keescook@chromium.org> wrote:
>
> For systems that provide multiple syscall maps based on architectures
> (e.g. AUDIT_ARCH_X86_64 and AUDIT_ARCH_I386 via CONFIG_COMPAT), allow
> a fast way to pin the process to a specific syscall mapping, instead of
> needing to generate all filters with an architecture check as the first
> filter action.

Can you allow specification of the reject action?  I can see people
wanting TRAP instead, for example.
