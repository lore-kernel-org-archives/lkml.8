Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D016C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3F12075A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590693233;
	bh=s9D2lFfhQRK79z+tGsuVgLXmSvOc7unABKdMunJCWy8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BXRuth0HIGrq7lIiRtjyoHMG7T8hmlZunkYrc5iUDnU5zOed8RxcZ4O6tlubjl9Zt
	 NfeqshUp4Sxe7hejq0uFiYRkfaCJRiPwXNdbtNjs0lEwKvR7vKzfgwlDARHEVQGN9k
	 jHJkNocwhLJktZxCMtQzYUis5mF4EdqCoObzuIpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406203AbgE1TNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405596AbgE1TNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:13:49 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35343C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:13:49 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f7so868691ejq.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0HTVBakDVN8XNdtT+CkYT4htvCqU+BWizMrhpaCpVUU=;
        b=aFMSYB2ECpaxe8CY18ljTFJv4xRZ5bv1Zi4GWChAC1vehbJjLJ6zd3EKxvcmaiQMve
         SRJN/ivKuQqNVzeGQp3DjmIyYFrTa8FYINcRjHaUHAuPfavRik3b9xZHsSgl1vMIU6Gg
         uFypusNji8uKclzDC/fRxY3b+szIfbFvyasjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HTVBakDVN8XNdtT+CkYT4htvCqU+BWizMrhpaCpVUU=;
        b=dRVw53xMWu3HKKO7JZ1nugSMft9lWalpz6pmJ95vTYokc/nw1Xqe1AHogA/skul2PT
         3AJS5FrXfH3Zy3wB0nu5TZBoyFm8NroKQcXyA+7Sb5fVdSYhKRg4YFk3xd+XwCeE89Yb
         SiWVFHdTB7KV83ZhnY/6vZirJ7Si+oSa24rOhSkaTVwH+hf4o/HfouLYYVeffGeuyKw7
         mBX38HFOwtUckuD2gT8P/n7Xuj6o85bfQ8dcJ6DaruG/UNBU5bUhLN5S5Ed3wAAk8oSz
         9rYMQroMiCXyep86U58a5syW9gXWcdZIPEH9FDtabunYQip7ZaoSQ8+XA6IsxmbN6Jfs
         spKQ==
X-Gm-Message-State: AOAM530BjEjT3ELkRKSVqjvKZWzPD4FF0ehQcMocEBioVpZNbXskeS62
        rMx5HGsn7FOtAhfQmWq0xptBaD8greE=
X-Google-Smtp-Source: ABdhPJwzppfNAK/Du222WU6wyLv9gHjIhWtI2hAjFcH9MOcoZAF7td1SuFDl7/04HVY4APQzbOqcgg==
X-Received: by 2002:a17:906:57c5:: with SMTP id u5mr4331699ejr.419.1590693227612;
        Thu, 28 May 2020 12:13:47 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id v6sm5919433ejv.120.2020.05.28.12.13.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 12:13:47 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id y13so1183498eju.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:13:47 -0700 (PDT)
X-Received: by 2002:a2e:150f:: with SMTP id s15mr2157651ljd.102.1590692898773;
 Thu, 28 May 2020 12:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87k10wysqz.fsf_-_@x220.int.ebiederm.org> <87y2pcvz3b.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87y2pcvz3b.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 12:08:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAG4tpPoWsWSqHbyMZDnWR8RHUpbwxB9_tdAqbE59NxA@mail.gmail.com>
Message-ID: <CAHk-=wiAG4tpPoWsWSqHbyMZDnWR8RHUpbwxB9_tdAqbE59NxA@mail.gmail.com>
Subject: Re: [PATCH 09/11] exec: In bprm_fill_uid only set per_clear when
 honoring suid or sgid
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 8:53 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> It makes no sense to set active_per_clear when the kernel decides not
> to honor the executables setuid or or setgid bits.  Instead set
> active_per_clear when the kernel actually decides to honor the suid or
> sgid permission bits of an executable.

You seem to be confused about the naming yourself.

You talk about "active_per_clear", but the code is about "per_clear". WTF?

              Linus
