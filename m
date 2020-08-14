Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE85BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9873C2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KjgK+a6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgHNWYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgHNWYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 18:24:32 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5D5C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:24:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f5so4793280plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YeiaI0cBbmIVgM9KK8qJD1B8RoJBQ6CWSMWYzinrWjc=;
        b=KjgK+a6u6Kx6XUlBgSgd8V5i1YscGs6TojRN9+IHp9wxZStU60+jsrTI9g+0bSN1jl
         J77sCZ3P+O/Xga8pdnYF7q91ojj7jyNCzSc1hrx5X1QU0uWjPu8+o8bQEKkx9wl26ylr
         xHWLlFiSNkBxaY1NZn/ZBguIpR1iI/g+GR7k8vO5Rs7Uki7fWxn5aHZn4kHpCg3B1GPJ
         591tiiihnmDBrkpm7gRPxtbxp+PNMgn7GLZN7L28hVafnk36mOjS5qREqKRz96pe+YMM
         6dgtykvIbRjP3CNne9MS8Gw87BiEir1r6bn7lZqCmSeeeyl449ARF5BXTHApo+3FGEP4
         sicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YeiaI0cBbmIVgM9KK8qJD1B8RoJBQ6CWSMWYzinrWjc=;
        b=X4aNAIlh25J/7NadX9r6QN93Tnxz0cpikEQehVWOGVd2s9ppc/Q/PcpPnXdQzrlvWT
         PJeqsKMcVufzQFe/ufUelCpaFl11K1M6y0T6wiOTbqHHZI9qjMAniMAhHRZUIIAlzKmQ
         50kfRhYGNFmSEVBf7INBf8V/7qwY0zWEhEnFP5d/q9kjBnh82kl0+czs53nuKW8izBKZ
         vQJ0bs4fOS1UopT2hV4lDkqUeR0JcOax1/zycBUsWO63Ib6YgNGzOKuwPXDJUasQ3C+e
         V8NSdytWqed9n34SRzOO6xoWkdCeOo7MgQ+OAhxhB1MqwJmk9RpICP/ya3zij/tYOFym
         qnmg==
X-Gm-Message-State: AOAM531aHk7fk75cx1EcKtyBm5ep/AaaOMGthQnlwQIMdcUZK++ZRVj4
        u30MuBiecKuZFVUDnxeRkx/YHYpMxJLsBTaBpDPhCw==
X-Google-Smtp-Source: ABdhPJwIQT3IgIQ/kbIfKzriwToHojYpVqPKRA1c4+IXWI0W+BsDcitUmC+SA7WAqQjsofNh91Jf7Rf589EHI6QGVsA=
X-Received: by 2002:a17:902:cb91:: with SMTP id d17mr3326522ply.223.1597443871397;
 Fri, 14 Aug 2020 15:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200814212525.6118-1-john.ogness@linutronix.de>
In-Reply-To: <20200814212525.6118-1-john.ogness@linutronix.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Aug 2020 15:24:19 -0700
Message-ID: <CAKwvOdk_ex+v7XZEoY=1Rh3S_GuCPJD3_NTiMhtsmP+5=MctVA@mail.gmail.com>
Subject: Re: [PATCH 0/2][next] update gdb scripts for lockless printk ringbuffer
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kieran Bingham <kbingham@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 2:25 PM John Ogness <john.ogness@linutronix.de> wrote:
>
> Hi,
>
> When we brought in the new lockless printk ringbuffer, we overlooked the gdb
> scripts. Here are a set of patches to implement gdb support for the new
> ringbuffer.
>
> John Ogness (2):
>   scripts/gdb: add utils.read_ulong()
>   scripts/gdb: update for lockless printk ringbuffer

Thanks John! For the series:
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

>
>  Documentation/admin-guide/kdump/gdbmacros.txt | 153 ++++++++++++------
>  scripts/gdb/linux/dmesg.py                    | 139 +++++++++++-----
>  scripts/gdb/linux/utils.py                    |   7 +
>  3 files changed, 216 insertions(+), 83 deletions(-)
>
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
