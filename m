Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39CEC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64ED2085B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581356808;
	bh=s36p1l4ZPlQFYPOrfr/fxqnjD5UfABvmtBfZytlVlp4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VpUV9+wrRTuAfqRGB7aMx0pKFpf1bI5yRVvoxWuWtuQ651ziUR0L5GDCFJ4HUvMYE
	 yv0Bft752qqRBFTSKAk5a/uZAPiVsBIxKvvamYUVuIu2EiLMpMOUSkZQs6ACdf/2+s
	 TvwpQU6AWAVG/vux8DrqbDxTljImohoZpUTxBA+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgBJRqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:46:48 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34814 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgBJRqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:46:47 -0500
Received: by mail-lj1-f193.google.com with SMTP id x7so8250706ljc.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 09:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cMABvWd/7c4TphsJ+M/Bzt18EBtYsvxejNNk0qYwcjM=;
        b=AJWGb7viPUuSlXbBtks15QbiGc0V+5N1kFBw6HmGv/BocUHZwmHNnivHvSwIiPeEQm
         1fliH10RGyoPY6yV4O5rwY5izrulFkNof0M2GsGbSrfCirug6Mx7f0jNvrzCMioGftQD
         acWtx/PsAUjj64YLYfwg5kSuWK5If6M0QpBoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cMABvWd/7c4TphsJ+M/Bzt18EBtYsvxejNNk0qYwcjM=;
        b=MVN7gaUPKGL+tthcRH4ogr1kxfix7zuFEn189kIJL58fjSFVIEfGj8PksdL8UyNe8P
         ENNu1qFBFGpNPQ0H3eteTmHlFbg+Z5rfuIVjI/XG5SCKBQrM0PrCAHJu6NWmCSuDDiQ+
         Iiy6VikV16UpSVFFv22INlODMbm4a5aGLGqDeYFOKFwnfiLuSGNBhrQxm5h2mq+f5W7O
         +V7xlVw9QsCplxJgpQ4UMJpsQZfh7940buciCCS7z0JY4iGvNSWUnwAEbfxBsiSOFxc/
         HYeckoxcl1eKHOMadbjyHbY/H2TpgFgSqrboceqAsP78SY8qYXowOjqLj0yeMPpOHxad
         LhUw==
X-Gm-Message-State: APjAAAVnQHWaV0OwUcny7gZvCaRuQc34CfPEL5a/rmtmczfVugobWovP
        BEbASYTC2xa8XJb/uw4+KYpLGlDIJPI=
X-Google-Smtp-Source: APXvYqygPl55H+yDPtCRKZHX0vt+X+tLfMpjAzEmWs4S7O5M37V12yxGT/DzdLtoWZhFJEfALVvsrQ==
X-Received: by 2002:a2e:b5ce:: with SMTP id g14mr1501347ljn.264.1581356804945;
        Mon, 10 Feb 2020 09:46:44 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id v7sm667949ljd.12.2020.02.10.09.46.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 09:46:43 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id q8so8176675ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 09:46:42 -0800 (PST)
X-Received: by 2002:a2e:461a:: with SMTP id t26mr1591348lja.204.1581356802297;
 Mon, 10 Feb 2020 09:46:42 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-1-gladkov.alexey@gmail.com> <20200210150519.538333-8-gladkov.alexey@gmail.com>
In-Reply-To: <20200210150519.538333-8-gladkov.alexey@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Feb 2020 09:46:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh05FniF0xJYqcFrmGeCvOJUqR0UL4jTC-_LvpsfNCkNw@mail.gmail.com>
Message-ID: <CAHk-=wh05FniF0xJYqcFrmGeCvOJUqR0UL4jTC-_LvpsfNCkNw@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
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
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 7:06 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> This allows to flush dcache entries of a task on multiple procfs mounts
> per pid namespace.
>
> The RCU lock is used because the number of reads at the task exit time
> is much larger than the number of procfs mounts.

Ok, this looks better to me than the previous version.

But that may be the "pee-in-the-snow" effect, and I _really_ want
others to take a good look at the whole series.

The right people seem to be cc'd, but this is pretty core, and /proc
has a tendency to cause interesting issues because of how it's
involved in a lot of areas indirectly.

Al, Oleg, Andy, Eric?

             Linus
