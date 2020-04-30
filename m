Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85599C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A4C207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVwgAkFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgD3VIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:08:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50626 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726336AbgD3VIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588280892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7VZLSjXfN7iXJ8eJ+NDw2LG6g4a8Y8iJ2XndpsGf3FM=;
        b=eVwgAkFrN3YoinuhaYCNwfATOkblWB6k7OO6hA9JH+eyxtgURXtwRbbBjcyrBvkmZYxaVX
        sCa3ooaLnw0Ma1KUNFkgaWy3rFo8raEWCkqd+z+Q0TSoiz3nOh4DA904HVdsrQY2WmQ94g
        HekD8aNkSM2VzfpGPG8/Qxuy+JvPmd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-dK0Y6FziPn-mAAcCBg-csA-1; Thu, 30 Apr 2020 17:08:09 -0400
X-MC-Unique: dK0Y6FziPn-mAAcCBg-csA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6B2E100A8E8;
        Thu, 30 Apr 2020 21:08:07 +0000 (UTC)
Received: from treble (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 004B860C87;
        Thu, 30 Apr 2020 21:08:06 +0000 (UTC)
Date:   Thu, 30 Apr 2020 16:08:05 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200430210805.67h5la6m7rtygeq5@treble>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble>
 <20200429185536.5xshpcwtn4be4llh@treble>
 <CAK8P3a0M9qh2-_5VKx89ZsTfy5S1zhfWwnO7rN4xYhDwBBvPjw@mail.gmail.com>
 <20200429231115.z2mo5bsmrmj4oark@treble>
 <20200429232835.yw6ajtjyleob3lmz@treble>
 <CAK8P3a07P49-AdHForem=V0_cfiTFSLLhHCEQk6-UDBOg3-Q_g@mail.gmail.com>
 <20200430143350.qezebqmx2xwdxqxq@treble>
 <20200430194630.jkwysx6eftkaf6bu@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200430194630.jkwysx6eftkaf6bu@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 02:46:30PM -0500, Josh Poimboeuf wrote:
> > Yup, makes sense.  I think I've been getting confused by the syscall
> > wrappers.
> > 
> > > How hard would it be to change objtool instead of changing the sources?

So I just realized this is an objtool bug after all.  Or at least a new
GCC quirk.  The quick fix is:

  sed -si 's/cold./cold/' tools/objtool/check.c

However... after studying how all this works, I'm actually thinking that
it makes sense to move the SYS_NI usage into kernel/sys_ni.c, like you
originally suggested.  That seems cleaner to me: all the syscall
aliasing code together in one file.  SYS_NI is similar to COND_SYSCALL,
except it has a custom ENOSYS handler.  Having "NI" in the name is
another clue it belongs in sys_ni.c.

Alternatively, I could do the x86-specific SYSCALL_ALIAS, which is easy
enough, but I really prefer the sys_ni.c approach.

Either of those would allow the removal of some hacky objtool code,
which only ever existed in the first place because of posix-stubs.c and
that inline asm SYSCALL_ALIAS macro.

One of objtool's goals is to standardize ELF data, and it seems
reasonable to require the use of C-based aliases.  And I think it would
be a nice cleanup anyway.

-- 
Josh

