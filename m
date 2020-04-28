Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7CDC83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64F522063A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588092419;
	bh=0SBjeu3Sqkw1ahQ8G4xdzWiNVOAuCTOA951G9ea88Cg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CU2MYW+Q1Prn7jnfBmuoUYwXXHR0JvXUyjxa5NxoxMwa5AMj2D16uVw3HzYJ2XLt0
	 zqUebnKlpW+QOATzMtpSkX651MZ/Ves8uRPLsHdDqFT1NsaMpv/Ov+Eg3h4BpWHFmw
	 He+kFWqub4duUWjxDL1sArFYYRgrqUUQp2ud3W44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgD1Qq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgD1Qq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:46:58 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F237BC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 09:46:57 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e2so17732708eje.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 09:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHXIK5KG4MM6NL6ZnqDyJCo1++3O5tMDxa0Oox/FCk0=;
        b=Qu+2TQv0OYiYE16287sogB8uDjS8JZz9MFHDIwMmE4QWXix8Yj3Rir/mLPwz00RjUg
         hnk6uNKaE0hzn5zlYIZTWKFCs2u3Lk4U9c8hgRG4h/3lWuPoDD91flVvK19N8QzMsCzs
         vJ6aDNedAL1ptIzuTwxhsiNW9/aiFum9pNkTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHXIK5KG4MM6NL6ZnqDyJCo1++3O5tMDxa0Oox/FCk0=;
        b=Mpg84VHDhllpicR0qpWSh1OJSchjGlzKYqkLvmxHqSu93iwoPa8kGfdSPEyqnkRW4O
         zGKNken+2MJ0YLMk0kGR6dRC4oEBQAbEoN1E5F2aNZjBoEBHCRVurODalegnu1kh6gzV
         2Ny9Ioc+LgyDDy3RhVsWF1ruINrs8zV7m4aSSjRqRDeopTdLjPLhODXCGkR+eh8pRI9P
         ag1xE1iPEN0N00/a3FDxOBJbGU0y5FQoFHXb+qzOEKRGLjCBWoZpx2DqQ27kb++VnrQC
         xSvZUufRIV2ggt+GOHsJxURbnYGgFY8z1L6cs7sqto9hOVNdxXFjN0oAv+PknbKsbR/i
         H6Rg==
X-Gm-Message-State: AGi0PuYcb4HPPXNKruH2bfZa4uJmlpicU7u3lMHkOdVp+0ASEBhzRQr+
        1HVBRlpPy9bvOny3MJ+O1rOQYzJqmlo=
X-Google-Smtp-Source: APiQypLHGz+2/bjKHfeRHjP/I/QpclJ3IINPAXyZXEbhIhL9ymLEd5rY0XdrpOVjbhyVuji5154r8w==
X-Received: by 2002:a17:906:d0da:: with SMTP id bq26mr24781564ejb.344.1588092416307;
        Tue, 28 Apr 2020 09:46:56 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id d18sm299566eds.15.2020.04.28.09.46.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 09:46:56 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id s10so16923458edy.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 09:46:55 -0700 (PDT)
X-Received: by 2002:a19:240a:: with SMTP id k10mr19924040lfk.30.1588092037785;
 Tue, 28 Apr 2020 09:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200428032745.133556-1-jannh@google.com> <20200428032745.133556-3-jannh@google.com>
 <CAHk-=wjSYTpTH0X8EcGGJD84tsJS62BN3tC6NfzmjvXdSkFVxg@mail.gmail.com> <94141fbb-9559-1851-54c1-cdc5fc529a1a@landley.net>
In-Reply-To: <94141fbb-9559-1851-54c1-cdc5fc529a1a@landley.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Apr 2020 09:40:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2uw09tJMKTooQBr=AJPzzLTaq95b+SSS513Gm0gy5sw@mail.gmail.com>
Message-ID: <CAHk-=wg2uw09tJMKTooQBr=AJPzzLTaq95b+SSS513Gm0gy5sw@mail.gmail.com>
Subject: Re: [PATCH 2/5] coredump: Fix handling of partial writes in dump_emit()
To:     Rob Landley <rob@landley.net>
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 9:34 AM Rob Landley <rob@landley.net> wrote:
>
> Writes to a local filesystem should never be short unless disk full/error.

Well, that code is definitely supposed to also write to pipes.

But it also has "was I interrupted" logic, which stops the core dump.

So short writes can very much happen, it's just that they also imply
that the core dump should be aborted.

So the loop seems to be unnecessary. The situations where short writes
can happen are all the same situations where we want to abort anyway,
so the loop count should probably always be just one.

The same would go for any potential network filesystem with the
traditional NFS intr-like behavior.

            Linus
