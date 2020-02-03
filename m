Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDB9C3524E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FEE20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFwu8jrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgBCIrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:47:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23389 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727441AbgBCIrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 03:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580719627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZsuCEZWqHm0EboxhQiNEItt1THk0pieZ6uxJHO780LI=;
        b=bFwu8jrX8uvkRzwdclp8kW3WcsjpVRahIoa/5V+FnXxVPZD2gg2G7gOpiNyOWGNQwmGdN7
        QY0FYPVXKp4lkCznYHyFq+h5wHc9pydx8ToGdc6rz0U0N/rB6xfb47SeMZEST9VhKQNmoI
        y6sKBrU17/qJbFgCCfJc72x4LXl82O8=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-ibx9IA8jPfyDNY4_lL8ohQ-1; Mon, 03 Feb 2020 03:47:04 -0500
X-MC-Unique: ibx9IA8jPfyDNY4_lL8ohQ-1
Received: by mail-oi1-f199.google.com with SMTP id o5so5541934oif.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 00:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZsuCEZWqHm0EboxhQiNEItt1THk0pieZ6uxJHO780LI=;
        b=dt27cSPz77JCPo0m52P+22FC0feQtIDhH0M+4iY17B+1bR7u9/Uqrk23tdvl9/Nfj5
         +H+/vt1P9HY3uCKbepcf8dwDsqJmkTpetaSEYj+4obyWb9ieHIxCHmlir7MD95GT4BuO
         S7IQ3gewESNZWurhS+UuqOzddmUF9Nq8exQVIKzGOGblhwhWT0roKSBulvHodQRwkXBN
         xDf+TkBW4cNSpvsCJrJ4o2fr//QyQotnPQbkZsKwvR4wyeuypcl8tKqi76zeMXy4xY0B
         IvYKv9q1pry6LZev9ecx6qMsDQJNiVdyQpjzFIv+VrUZ3bHhEMrl6rQXu+r9PivRJazX
         WNKg==
X-Gm-Message-State: APjAAAVj97/tA+/R2eIZSv/b9QjZx1xo3BypeervfgMybp78EvY472Mz
        bsH2KOi7bB6a20uZm5oJc0WXmhQRpghXmf0zP4N8FSRzIGiMc7dUaLVI+ulaCe/eqQElWcvgfol
        hXRiFH0Z+iRm3UcaLurI/6NLIlT8tqYNuZKQ0+dKy
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr17777408otn.22.1580719623227;
        Mon, 03 Feb 2020 00:47:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzcWGD0Qnyj7Zne1ZyFHDPESnShitOfod21/McfCGO8zVVTe9jY0RaLcelk1g0/Mer4HCl1lv6TfgIaHzfS23k=
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr17777391otn.22.1580719622947;
 Mon, 03 Feb 2020 00:47:02 -0800 (PST)
MIME-Version: 1.0
References: <000000000000143de7059d2ba3e5@google.com> <000000000000fdbd71059d32a906@google.com>
 <CAHC9VhS_Bfywhp+6H03bY7LrQsBz+io672pSS0DpiZKFiz4L6g@mail.gmail.com>
 <850873b8-8a30-58e5-ad3c-86fb35296130@tycho.nsa.gov> <CAFqZXNuxFTKXVZDpPGCTHifn_AeCdVmP+PZrMDKDOYiLOWtsUA@mail.gmail.com>
 <CAHC9VhR9a1xEB3gXUkb4KRVkwXUAo-701ZumN2OTOmJ7r5ez8g@mail.gmail.com>
 <CAFqZXNv77JHa-6BPzEomZaj2uJqGrBRXrK68cTL0N0--Kz_PkA@mail.gmail.com> <CAHC9VhTHUjdYujta-bOd=AG+XLic6rAZbp2sEpC86vVnpkmBVA@mail.gmail.com>
In-Reply-To: <CAHC9VhTHUjdYujta-bOd=AG+XLic6rAZbp2sEpC86vVnpkmBVA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 3 Feb 2020 09:46:51 +0100
Message-ID: <CAFqZXNviT4NRyE=CkiQdNy0DRfAi6pV-u=RcJhmMooDuPNhwRw@mail.gmail.com>
Subject: Re: possible deadlock in sidtab_sid2str_put
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Jeff Vander Stoep <jeffv@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 6:29 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Jan 28, 2020 at 11:31 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > ... the current rawhide 5.5.0-1 kernel seems to have some bug
> > that prevents it from booting on anything with more than one core.
> > I'll see if I can work around it somehow...
>
> I'm not sure how you are building your kernels, but gcc v10 is causing
> a lot of problems, I would suggest compiling with an earlier gcc for
> the near future until things get sorted (I'm doing the kernel-secnext
> builds on stable Fedora, not Rawhide, for now).

Right, thanks, I was using the Rawhide buildroot to build the test
kernel (derived from Rawhide dist-git source + selinux-next + the
patch). Fortunately the Rawhide kernel can be also built against the
f31 target without any additional hacks, so I managed to build a an
upstream-based kernel with GCC 9 and it didn't have the
crash-on-multi-core issue. Regardless, I wasn't able to reproduce the
syzbot crash locally, so I had to ask syzbot to test the patch from my
git tree [1] and it passed.

Nonetheless, I checked to see how the sidtab string cache + IRQ-safe
locking (assuming mostly cache hits) compares to the non-cache
situation with a category-free label
(unconfined_u:unconfined_r:unconfined_t:s0) and the cache (3.2% impact
when mostly hits) is still faster than the non-cache version (5.5%
impact best case, 65% impact worst case).

I intend to incorporate all this information into the log message and
then post the patch.

[1] https://groups.google.com/d/msg/syzkaller-bugs/1UwATFnIiW8/kOpRrjyNAAAJ

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

