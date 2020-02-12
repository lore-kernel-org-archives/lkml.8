Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7E4C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB492173E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581539726;
	bh=iOg40SPFaflkL01eQ3QKOZ5KkBFX3OXuFa2Vt/XxJmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Znlkq7vFixp/IQjY3b5oyzxpx06+a6FU6wnaP747BQiC769TBPoEqofrS0cmyfp1x
	 Qc0+HW7KtUo/Qsqk9OBnN33CyIwOlsom0tHQzmr3K75IPU7SkDKraYsyYcVPmsUugT
	 E9cfRSTLVmpNqaEHxGfXls82I9RXoa5FW71z3ABQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgBLUfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:35:25 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38712 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgBLUfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:35:25 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so2564175lfm.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 12:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqyVLATGO6MwZ1NPxpHKDD7nGLBCP8OMxbpMcz0c8xI=;
        b=IgiKGasrvpx5KEqTjK3uSOaiUPZJr6oQaxEeiUKRSC7Mzut+kfrtuMYf7JfgJYo2j9
         r6YHIpl0Oomh/U1TMzjQtQYQDvEFopln06zrn/G9JdYxAN1cr+G4MM7V+yIgIdgHmkT5
         mB2IAKAHrGr3Dq04+09yh6iga9CCs4Dv6Lzfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqyVLATGO6MwZ1NPxpHKDD7nGLBCP8OMxbpMcz0c8xI=;
        b=JIJcpfrA5BmzCoLAJpp00QHs4MnAYbYOgN05U9e8xkaAigXdja0xkCdGrWQb9uZVPn
         4s06/Hgkb10BpwnAW/0hUBrwVQH1nLh/3csOzLEEw71YLja23xir6GMY9gdyM3WU0bkb
         nsK0Srr0JOE2LKfgW6AV9Qn09Xvz6g3O2JBAKbAKTlLZwaSbFh16ZkEhO9poCi//Ory8
         fP1gd0u218tcoKt5kmVoJiEZkWxKAUjvLsLtUfa+8hILGIZG6s5iKlhjj16vgDivCMEA
         Ohn2En6meM0xtiekiOb/KWYciLfCIx6He3Q8L5ztOE+NnruZ47X2b8zbLzxg0xNtYWn5
         3A+w==
X-Gm-Message-State: APjAAAWfUTabrSFQo1Jm6hJRpN92rl7S39vFlbxgdtIGdTq/USYb8Rjw
        njrJDKjdwmrR35w71enBBY2bRfZtSmc=
X-Google-Smtp-Source: APXvYqwEoQ4midWgptX2PLNDYGC2TssAaAQBVVCdo/T/DfS4CnSja9c7cdJHD4IhIwNl3t3P528dFg==
X-Received: by 2002:a19:f812:: with SMTP id a18mr538490lff.0.1581539722473;
        Wed, 12 Feb 2020 12:35:22 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 4sm96905lfj.75.2020.02.12.12.35.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 12:35:21 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id o15so3909435ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 12:35:21 -0800 (PST)
X-Received: by 2002:a2e:9d92:: with SMTP id c18mr9321452ljj.265.1581539720898;
 Wed, 12 Feb 2020 12:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
 <20200210150519.538333-8-gladkov.alexey@gmail.com> <87v9odlxbr.fsf@x220.int.ebiederm.org>
 <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org> <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org> <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
 <20200212200335.GO23230@ZenIV.linux.org.uk>
In-Reply-To: <20200212200335.GO23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 12:35:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
Message-ID: <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
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

On Wed, Feb 12, 2020 at 12:03 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> What's to prevent racing with fs shutdown while you are doing the second part?

I was thinking that only the proc_flush_task() code would do this.

And that holds a ref to the vfsmount through upid->ns.

So I wasn't suggesting doing this in general - just splitting up the
implementation of d_invalidate() so that proc_flush_task_mnt() could
delay the complex part to after having traversed the RCU-protected
list.

But hey - I missed this part of the problem originally, so maybe I'm
just missing something else this time. Wouldn't be the first time.

               Linus
