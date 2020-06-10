Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFA1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC63D206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwMtaEzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgFJPz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbgFJPz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:55:28 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0163C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 08:55:26 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id i27so3086901ljb.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 08:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SEUPY1uSL4EEx5wS5at/fsramWYDqy3CI3YeN8vkC9s=;
        b=KwMtaEzFz239gBKZPYXQXMqP5efm9L94Yn8Kyv8BCiint4zdYdVLG5E0Q7hDR7c2VH
         KERXEOLbs+SIyzkDK4I53QmUViPVAGIXEMj3Ls3DghckPBJQyHR32wCDMLbYbkGZtLzE
         or53oiqN+D4w4KaYwNWy7F2Ku4EJO26bocAN1wY0I9yPKSEnnvtlzemSIE/mQSn0by+X
         RqR/CoA7VGtNEFb2bvMt9+JhOVpBSgiQheBgzemzmglovAhOVkLwQr9RN4+EA5luC3Rf
         rR4MR+s9tbAjDCTgQk08lVpTWUgs2asT7KWVIemKuF7uN4PfZBsM4z/aEhUgBbsQZXz4
         1LaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SEUPY1uSL4EEx5wS5at/fsramWYDqy3CI3YeN8vkC9s=;
        b=lNxdNnzdt3yDlGvOh58garXewgqpNs+GHF3wyFD8SWcxSekqVfX2wDmh4E2SKgJwrm
         IdkMuegIgoG+rQw7SAi8zQTiHJLW8iQv5VGnK/UYTFKn/xz+GKsjRksaxO7XITjiX8wp
         Zc/oSJiHtHiPxfZgf3qCWEqu2qDVATjcm0wuHAZzsWo2+utPWqa+NxufBVvHXHDys8J2
         ajd/T6JQqf7bwuKsmZ3XgtULYXeepC26Z9Mh2WZmuUk/2g7rGjj8wJOGK90ZDfBdBJOi
         zxFjRL1e6LxuLtYjBFoTsLe1L2+nsnK6xxWC8huZP/p6M6vy8NaB1ruaEFnZzztThOlf
         Tr3w==
X-Gm-Message-State: AOAM531JmCwP4bwV/HbiifkwaZJOqVvNuPnJ/h0PSK7iDgVfz3Yo1sEF
        grLnzGZoa0+ytkDEdT3yEQVLB18zMJK1xwpMOHc=
X-Google-Smtp-Source: ABdhPJzBstYjcC0H7h5ZvFx07Q3wJ2sGxtz/nfjMnDfzycjS34tkDan3rENGrm3GlLFAu3CNEGJMUoWJkeZ9BJnugkc=
X-Received: by 2002:a2e:1558:: with SMTP id 24mr2120753ljv.202.1591804525341;
 Wed, 10 Jun 2020 08:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200610125147.2782142-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200610125147.2782142-1-christian.brauner@ubuntu.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 10 Jun 2020 17:55:14 +0200
Message-ID: <CANiq72m_p2BRXswCGhUZi-Nta2y0uNXDQLRjPUFydB7YGV-6HQ@mail.gmail.com>
Subject: Re: [PATCH] .clang-format: update column limit
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Wed, Jun 10, 2020 at 2:51 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> The provided clang-format file wraps at 80 chars. If no one minds, I'd like
> to adjust this limit to 100 similar to what checkpatch (cf. [1]) uses now.

Thanks! Picking this up with a few changes to the commit message.

Cheers,
Miguel
