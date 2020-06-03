Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F60C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E642077D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vv3735Jj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgFCUon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 16:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCUom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 16:44:42 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A77C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 13:44:42 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v17so3043772ote.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 13:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b8CzJ+FqssESnl3mBi6gkwykaMKjKen6olasDfdb0GY=;
        b=Vv3735Jju6p5aGz7YrCtFx9whs5k4RNmmhok/3IIkYLhOg7Yomd4cU9GFnDQfJp1jP
         ZjxVmKh1NqQ0Fji/zH4tjchWpWuO0R+iZ3PueeLAiCc6I44QxooXmCp84CAwyeuLb7tu
         JO0AIPyxUOGkC22B0yjkXKtf5I5qSxZbXhhrfKCNFiRU0493HnEy3kdcmqvabzFObfb8
         3N1UdQQWi1f6Ht2UBBNZ/bQvR7elMb1cjQ8PHfNK0nOtegYOm/qVUT0n2P76k97Nv++W
         dFoAiTlJ9jbBKXpnm5CS+OPJaIcj98wVHvjEPUEUolz7P4zFRRGQgFVK1hFeG4+XnEDI
         jYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b8CzJ+FqssESnl3mBi6gkwykaMKjKen6olasDfdb0GY=;
        b=cYtDyijD07xpEyBfNYhWfMWn418mvUh60/gWEnzP/DgcbWwPgJxxVhbL6+meqiazni
         8vNwNqKMlTEOtn3oT29+k/wS+suAiMJyWrNGfsvrwqY3Gz8tJn+ixkoV2zvn1ZSbWbRa
         7EMFFeXwAJTnp6NV6BezaUKPMZbtHJM9wsVEy1Sg0Ga9MHVc6uopQ+c5r6XPsqq+dJV0
         vxt8O9Czz2UV6c8jrzhlVfufcvQdhu8ju5qouj0pCnthQ9s6sB6hd8QOQ1YWKOtKuNoA
         1Vf9L32FA2fiOT3XX0kBul1QepP+suADtkzlAM2/e0m+20r6hDUajB0w3S4aO7p8Q5TI
         fbdw==
X-Gm-Message-State: AOAM531kK/SFwnwMTd980lz7Ej3W1hA8Oph8d3P7/95pWE7/FnX1Bf0X
        kuEm5+trhUNHfdVLmfvhyXKx+Ha/
X-Google-Smtp-Source: ABdhPJxJwVPQUCVIyXl62Xh3LzjOmhOnc45bHIPDTyIl6VtAro16p1wUwwP+OA9ACF0HFgsR1oBN1w==
X-Received: by 2002:a9d:4e93:: with SMTP id v19mr1366500otk.68.1591217081653;
        Wed, 03 Jun 2020 13:44:41 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id z11sm773362oop.38.2020.06.03.13.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 13:44:41 -0700 (PDT)
Date:   Wed, 3 Jun 2020 13:44:39 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [git pull] misc uaccess stuff
Message-ID: <20200603204439.GA2649647@ubuntu-n2-xlarge-x86>
References: <20200603192306.GX23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603192306.GX23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 08:23:06PM +0100, Al Viro wrote:
> 	uaccess patches that really didn't fit anywhere else.
> kvm_hv_set_msr() patch left as-is; __put_user() is by no means
> final there, but that'll be dealt with along with other KVM
> uaccess stuff next cycle.
> 
> The following changes since commit b44f687386875b714dae2afa768e73401e45c21c:
> 
>   drm/i915/gem: Replace user_access_begin by user_write_access_begin (2020-05-01 12:35:22 +1000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.misc
> 
> for you to fetch changes up to 4ec76a2b74c72ef9eed875ce63e27a5e7f8d80cc:
> 
>   bpf: make bpf_check_uarg_tail_zero() use check_zeroed_user() (2020-06-01 14:42:37 -0400)
> 
> ----------------------------------------------------------------
> Al Viro (9):
>       pselect6() and friends: take handling the combined 6th/7th args into helper
>       binfmt_elf: don't bother with __{put,copy_to}_user()
>       binfmt_elf_fdpic: don't use __... uaccess primitives

This patch breaks arm32:

$ make -sj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- allyesconfig fs/binfmt_elf_fdpic.o
...
In file included from ./include/linux/sched/task.h:11,
                 from ./include/linux/sched/signal.h:9,
                 from ./include/linux/rcuwait.h:6,
                 from ./include/linux/percpu-rwsem.h:7,
                 from ./include/linux/fs.h:34,
                 from fs/binfmt_elf_fdpic.c:11:
./include/linux/uaccess.h:149:1: note: declared here
  149 | copy_to_user(void __user *to, const void *from, unsigned long n)
      | ^~~~~~~~~~~~
fs/binfmt_elf_fdpic.c:612:7: error: too few arguments to function 'copy_to_user'
  612 |   if (copy_to_user(ent + nr, &v))    \
      |       ^~~~~~~~~~~~
fs/binfmt_elf_fdpic.c:659:2: note: in expansion of macro 'NEW_AUX_ENT'
  659 |  NEW_AUX_ENT(AT_EXECFN, bprm->exec);
      |  ^~~~~~~~~~~
...

Cheers,
Nathan
