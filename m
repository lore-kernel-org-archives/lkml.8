Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12F5C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF37206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579709614;
	bh=GpFGbLDyDcsYETOekamoCMbKYLs3AiKWzySn/G3zg2k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y1rmFs0uyAtAejnecE8fG4nhpBI9sTbCP0JcwFWUuWswKAs3L1xyr3PVlVLbCS/LI
	 8CU6BgaVMO2T7MnS9aPGpFn54kWdvLwxLARrR+EozaBowsC1eC8jGvGd7ItTQ8zdUn
	 C+30Fe+GCtXcYjbewudCQb6qZ4Bx4ED14CckVuL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgAVQNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:13:34 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40214 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgAVQNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:13:33 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18so2507670ljo.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 08:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PxCSo2JcEGlTJhdmVOOHLpuyjFAWieC3FhzbX6ms3Bk=;
        b=WVzg/4mZaQ3ubctvikpmoB2+8YZnmRK2+VSYiWGQ33nJZL1OeIGMyFE3sBcuqoQVbi
         rwpNneTfpLB3RAwTWttAZsxz4mdwPNf2Y8+kgY4tYIeLbjPU7jrBtLrLWh4mnN0ddI2k
         Y06yr95wD8GFqmmXgcgeinrku41v7nODIWRxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PxCSo2JcEGlTJhdmVOOHLpuyjFAWieC3FhzbX6ms3Bk=;
        b=S+nrBoHN1ziI3NkYcZGPwy3eGj0+sVjiCTo/KgaIUxXT8hGzfYi2E8HKfWfrHI5UUz
         /aPzM4k3jiCGUIxhI+LPA+YSfSuWoCDwe4gwy2ROOLs2GzBjs7IRQkV+7oMJdsWNZc+K
         8yFiF/ZDZYLUqUa52Q7LUxGCLrpjHJ0oRq+gBkwkSAC/6pQHmY+B2jN9fFUgz/wnCoaL
         R4X7C/9lB4zu1j/QZVM5zFs185GH7xr/8Dki9k/RdSePCAUA4nwMKojdMLq/k7+N3mm0
         D2cJxHCWmkm3rN0wz+cHZCkhh0WBSzESM03vWUiFlfQCkwZ56gutfla5KSrnx+L5JlUz
         s3tw==
X-Gm-Message-State: APjAAAVz09YZis16kkqhVTctfJRTAOMDnmTWeI7P7goG4qw0O846ZHMS
        u3fu2XiWTccC+pny85BS/UVRNVakE54=
X-Google-Smtp-Source: APXvYqyJ6vWcaMCOkJ6qEQJxyb35b6LIoqlaJjaVeaiQV0w2dLMopiOri6vmQjBwR/UDWg6x87otQQ==
X-Received: by 2002:a2e:a37c:: with SMTP id i28mr18955908ljn.118.1579709610232;
        Wed, 22 Jan 2020 08:13:30 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id w8sm20746978ljd.13.2020.01.22.08.13.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 08:13:29 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id y6so7486061lji.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 08:13:28 -0800 (PST)
X-Received: by 2002:a2e:9510:: with SMTP id f16mr19943444ljh.249.1579709608444;
 Wed, 22 Jan 2020 08:13:28 -0800 (PST)
MIME-Version: 1.0
References: <a02d3426f93f7eb04960a4d9140902d278cab0bb.1579697910.git.christophe.leroy@c-s.fr>
In-Reply-To: <a02d3426f93f7eb04960a4d9140902d278cab0bb.1579697910.git.christophe.leroy@c-s.fr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Jan 2020 08:13:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTzEu5=sMEVLzuf7uOnoCyUs8wbfw87njes9FyE=mj1w@mail.gmail.com>
Message-ID: <CAHk-=whTzEu5=sMEVLzuf7uOnoCyUs8wbfw87njes9FyE=mj1w@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] fs/readdir: Fix filldir() and filldir64() use of user_access_begin()
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 5:00 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> Modify filldir() and filldir64() to request the real area they need
> to get access to.

Not like this.

This makes the situation for architectures like x86 much worse, since
you now use "put_user()" for the previous dirent filling. Which does
that expensive user access setup/teardown twice again.

So either you need to cover both the dirent's with one call, or you
just need to cover the whole (original) user buffer passed in. But not
this unholy mixing of both unsafe_put_user() and regular put_user().

              Linus
