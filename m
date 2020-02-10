Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB54C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3412214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581359460;
	bh=omPLg79kMPvUSKiyNNvd0/ylILD31wzwomGJPrNGyQg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=M3tf51ZZ9+CMfsS/eDYOkl3+zBWGnSXtULwOFqK5xUNvI6Rm2bZvtpskLJWwOy2WJ
	 M9EtdKVhmjLsdkNvmiUBUzIFrCFlQrMkBDq9BN589skfUNaoma+b7qtvKqF1KRI+gK
	 bFJrlQn2Jl06Y7rHTmoq0JpXvWAT2yElEVN29MxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgBJSa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:30:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbgBJSa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:30:58 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35B96214DB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 18:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581359458;
        bh=omPLg79kMPvUSKiyNNvd0/ylILD31wzwomGJPrNGyQg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dZmJEdXyo7TiCuP494908+DDQqiXuByAFM/5ZYZdUBh1RBbsjG4Nj8BtvNderACDu
         buUtqSZaMUtzDuCNulwdaDkgV5kqZL7lno4QgAbQ/lGQBv705tgeTFjmzJtXJCSjQ1
         BFRJCZcEs4eVwRoiOiwkJ6JclPVFDKSbcrF3PIR0=
Received: by mail-wr1-f49.google.com with SMTP id w12so9076554wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 10:30:58 -0800 (PST)
X-Gm-Message-State: APjAAAUNr03bj5+/jnD4xKew7SrVoj24sYbuImCa06KnlcAKb/dU+V87
        KAeVYnMBTSJ06t1I6fhnzEuaNSfB/uURbQrZ/mR4OQ==
X-Google-Smtp-Source: APXvYqzr7b50VDslir7PKIqAsDCapDo139eIqmv/8TM15nWdMYYpgSAHPnXtkGdcaP89mSWD9lXJHS+xhiOGpQ18who=
X-Received: by 2002:adf:ea85:: with SMTP id s5mr3242839wrm.75.1581359456683;
 Mon, 10 Feb 2020 10:30:56 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-1-gladkov.alexey@gmail.com> <20200210150519.538333-6-gladkov.alexey@gmail.com>
In-Reply-To: <20200210150519.538333-6-gladkov.alexey@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 10 Feb 2020 10:30:45 -0800
X-Gmail-Original-Message-ID: <CALCETrVjv04OOdzGNf7sRmRR-KUgY7xdMXA236nHZ1arn0KwVQ@mail.gmail.com>
Message-ID: <CALCETrVjv04OOdzGNf7sRmRR-KUgY7xdMXA236nHZ1arn0KwVQ@mail.gmail.com>
Subject: Re: [PATCH v8 05/11] proc: add helpers to set and get proc hidepid
 and gid mount options
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 7:06 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> This is a cleaning patch to add helpers to set and get proc mount
> options instead of directly using them. This make it easy to track
> what's happening and easy to update in future.

On a cursory inspection, this looks like it obfuscates the code, and I
don't see where it does something useful later in the series.  What is
this abstraction for?

--Andy
