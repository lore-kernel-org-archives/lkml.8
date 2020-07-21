Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B391BC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9288D20720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595350180;
	bh=cNxlSKmjygBarBhg16tpRebArXf2XdV2e7RUdeUHPj8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Xtj2zGuzyWRjMAgJmAKamPvAjChjKStsb/Y4qLr3uAv5fetPyz3CZ3FdzfGJSDmGW
	 e1ZWnL7iN2I82no7QP9c5FX25c4TXr5soyEYa6THFWbW1U6qbzp2QonXaOlwEiDZtO
	 8Vzfj3ruR/SnxUSJLg+TtoOI1/jN28LPT3WvT9iI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbgGUQtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730141AbgGUQth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:49:37 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AE3C0619DA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:49:37 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f5so24810792ljj.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfw0I9KLEinugvOkAIz5pYOKJ30/9U2i4w2l/E0VlLI=;
        b=PjZtpMWcBcYWc/PE2aBDgylpCarGxoRxa+Aq0zab6N7GaIbKRzPu2GNf3RxtSC05dA
         0K7/GHfK0uf/8tRqEMTILPd7F3g3dNdNNYY6ahsv+8BW0iD5iZnwvyqTPsbIeqjdBP3p
         khN1GHy7kDI63rJCnCaLHtNH6mG1r6HGYxAjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfw0I9KLEinugvOkAIz5pYOKJ30/9U2i4w2l/E0VlLI=;
        b=Kdd8/8rCNYEtzvKyHlI61SMaYGHupFLDHCbOj5DwsxNdcsYST2LpTW88MRn1CRsCvO
         yfJzOKjRJUjQN+RtB5VDGGMitBS9JVKbzGd6yCN48oRE8HlRZoYmvCej8wq1e9TXlYUR
         sl2K8BZXvxqSZhWK1nUtKB5jyy6Zo5F2S++eYq2/gxn6rRopwR6bIEGSvAy/EP6iM6Yr
         5G1KFHPkCn44qgGX6nFQgiH1C7jSId0772ue+mfwLJnbe30Tf6XYmgMP26P3M0WrhM2O
         gNwHPnw2OVmUnMf8e7JTlHMe4uCsprvgvPkzHxKUvjduUc1/siYn2wnGvMJmbNRjwEBy
         YmRQ==
X-Gm-Message-State: AOAM532wl+NRQf18I6L5yYmwikx2b3se2u+UjlFzanIWlBT0B5Ea6Jvm
        UPCo3A0F7bzNxbAnuaMPVwMOoeNrhQ8=
X-Google-Smtp-Source: ABdhPJxPT7KTUYiHp45AIYlbtPKO9rQbN6WZcPD8oBTvnIUAxehDl18Kc/gCIuXzJqPHyC1i4o5kYA==
X-Received: by 2002:a2e:97d7:: with SMTP id m23mr13750564ljj.103.1595350175319;
        Tue, 21 Jul 2020 09:49:35 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id z1sm4705110ljn.88.2020.07.21.09.49.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 09:49:34 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id q7so24863988ljm.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:49:33 -0700 (PDT)
X-Received: by 2002:a2e:760b:: with SMTP id r11mr13904367ljc.285.1595350173585;
 Tue, 21 Jul 2020 09:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200721162818.197315-1-hch@lst.de> <20200721162818.197315-6-hch@lst.de>
In-Reply-To: <20200721162818.197315-6-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Jul 2020 09:49:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0GQqAq6VSY=O2iWnPuuS54TkyRBH5B9Ca0Kg5A9d2aA@mail.gmail.com>
Message-ID: <CAHk-=wi0GQqAq6VSY=O2iWnPuuS54TkyRBH5B9Ca0Kg5A9d2aA@mail.gmail.com>
Subject: Re: [PATCH 05/24] devtmpfs: open code ksys_chdir and ksys_chroot
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 9:28 AM Christoph Hellwig <hch@lst.de> wrote:
>
> +
> +       /* traverse into overmounted root and then chroot to it */
> +       if (!kern_path("/..", LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path) &&
> +           !inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR) &&
> +           ns_capable(current_user_ns(), CAP_SYS_CHROOT) &&
> +           !security_path_chroot(&path)) {
> +               set_fs_pwd(current->fs, &path);
> +               set_fs_root(current->fs, &path);
> +       }
> +       path_put(&path);

This looks wrong.

You're doing "path_put()" even if kern_path() didn't succeed.

As far as I can tell, that will either put some uninitialized garbage
and cause an oops, or put something that has already been released by
the failure path.

Maybe that doesn't happen in practice in this case, but it's still
very very wrong.

Plus you shouldn't have those kinds of insanely complex if-statements
in the first place. That was what caused the bug - trying to be
clever, instead of writing clear code.

I'm not liking how I'm finding fundamental mistakes in patches that
_should_ be trivial conversions with no semantic changes.

               Linus
