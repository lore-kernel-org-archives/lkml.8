Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A29C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89AF206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581629815;
	bh=ItnnmxoRJ5gT+30BziuxUd+qlmmx1CXkUL9ZfYPGf/k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OFkmHtDk2YNHBvWLJ8P9h7H9qPuuCpqBIbITdvw1dAP8/AbddyUDG+FX6UJ+vA1LX
	 oNyhczYUKN6BQssex6D58Ycc1fpteMmehuzAxGdrjSrMa0+gY/yD62CU2TdG43yzu6
	 W5QyLXHqvwTTs/9xTF3g69KGT6c7O3o8lxvVbPOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgBMVgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:36:55 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37019 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgBMVgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 16:36:54 -0500
Received: by mail-ed1-f68.google.com with SMTP id df17so1910233edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 13:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yfXM82VfoqeRc90gxFVeIWXJ41itdUqMd3xA0dVgW2Y=;
        b=BawgSQbYq1TbwSpri2I8yt8BLdW+yFwAYoE8dMiMSbSBq331xObis6ZCTB17z/2+pu
         BJ/TFbcNqMRECulsFRMIiMTcM/ovFgWzkJQC0Q8GiR94lJcnmNpi+fvP6UvLQSDrJh9R
         cMZLEUQ8JhCaHYaouGQIdPmwtosqiphyKcUZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfXM82VfoqeRc90gxFVeIWXJ41itdUqMd3xA0dVgW2Y=;
        b=CEIhBZ61smOKyUM3Iwu2e5n/YH484luwfxautF/CP1ZXNfXNbPSlVuoy+sFe7tqoMp
         WIbMibPQ7Z6Ki25r8gwMk37UDP0Mv/EyJ66YcAppelPC18trHGA5ci00NMgB+nbgV7Ce
         fKhLWh6yQ5OAUO/G5s17pCSBUYIBYbFIOvoRj25dY88M6zobqnu+TMQugXRNsmTfgkiz
         DBDtPlNgxrutYpyX7oLu3Bg0erl7rL62/LHx4/SOd9PVfvJkuOrYDohJ4DN8mICC+Z9Z
         vjAATPyrVhmrDaPnRMvE6lwqbjhwkY6qyqn+RwfvElrv2RhbVLCndQSAqPnVcEhO+bfC
         l9Cw==
X-Gm-Message-State: APjAAAUiHrGRGJThsBaWMpEOxgxo6fE5uG4DcmC9NLthSqlBfgxsnFxD
        2sOqagT0YGLwjimRcx0vOfAvw9Z4vcI=
X-Google-Smtp-Source: APXvYqyV9ZL+0P2LlkQ//Oy6KPbhMWgZ6lS3uZE6gUpHQ2mkyrSt7UT+e5xDm+sTDaTkJa/fvVrvSA==
X-Received: by 2002:a17:906:af8b:: with SMTP id mj11mr18311684ejb.168.1581629812770;
        Thu, 13 Feb 2020 13:36:52 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id n10sm349718ejc.58.2020.02.13.13.36.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 13:36:52 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id e10so8639467edv.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 13:36:52 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr12460727ljb.150.1581629427873;
 Thu, 13 Feb 2020 13:30:27 -0800 (PST)
MIME-Version: 1.0
References: <87v9obipk9.fsf@x220.int.ebiederm.org> <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
 <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
 <87lfp7h422.fsf@x220.int.ebiederm.org> <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
 <87pnejf6fz.fsf@x220.int.ebiederm.org> <20200213055527.GS23230@ZenIV.linux.org.uk>
In-Reply-To: <20200213055527.GS23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Feb 2020 13:30:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgQnNHYxV7-SyRP=g9vTHyNAK9g1juLLB=eho4=DHVZEQ@mail.gmail.com>
Message-ID: <CAHk-=wgQnNHYxV7-SyRP=g9vTHyNAK9g1juLLB=eho4=DHVZEQ@mail.gmail.com>
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

On Wed, Feb 12, 2020 at 9:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> What I don't understand is the insistence on getting those dentries
> via dcache lookups.

I don't think that's an "insistence", it's more of a "historical
behavior" together with "several changes over the years to deal with
dentry-level cleanups and updates".

> _IF_ we are willing to live with cacheline
> contention (on ->d_lock of root dentry, if nothing else), why not
> do the following:
>         * put all dentries of such directories ([0-9]* and [0-9]*/task/*)
> into a list anchored in task_struct; have non-counting reference to
> task_struct stored in them (might simplify part of get_proc_task() users,

Hmm.

Right now I don't think we actually create any dentries at all for the
short-lived process case.

Wouldn't your suggestion make fork/exit rather worse?

Or would you create the dentries dynamically still at lookup time, and
then attach them to the process at that point?

What list would you use for the dentry chaining? Would you play games
with the dentry hashing, and "hash" them off the process, and never
hit in the lookup cache?

Am I misunderstanding what you suggest?

            Linus
