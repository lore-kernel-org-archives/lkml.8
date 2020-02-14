Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1F8C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDFE2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581718090;
	bh=jI8Tsjt3sqGpWzhrMjU8VtxGkMgVgAyd4fVp/0/7Phc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uWt1FVaExuwwhMzEFNpTO7Kp+A+cUUxHf36KMrJ5vpGaE7knMbqmQWtbuCUHyxEEt
	 UhRiG4n+1SB18ULQLCSHx1dyeUc9kHPO7jnNi2YN0Z73EmXBtzDx3RAZhoqbZYEsq1
	 qewDUQVjgIFsB7d2ur+rnCA9QjXKrJSguRc5fPhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbgBNWIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:08:09 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34167 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgBNWIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:08:09 -0500
Received: by mail-lf1-f66.google.com with SMTP id l18so7788886lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 14:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EOnxQ29nW6q/oFLiEGQt+o0NnkrJlvHBiIqJVTvoqsg=;
        b=gotL2+qrzLvoZp38NJ8oaGMKiVnhONIgVhjei+CfhjB2fkGaJA3BPayPjJ3tfO+pCQ
         ScJfGp7rS7PAQHVIRnUUvDLEPTgGSx5kfeJRt0mDgPX7RHAKN2rz3CnedLufppr9whEE
         balgyURvaANBJj1oJGjUjALE/YaITta9HmOsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOnxQ29nW6q/oFLiEGQt+o0NnkrJlvHBiIqJVTvoqsg=;
        b=QR+wnefQdYqc8Hk94IvhwFFCt7wE4sz92Bq6FY1wskhd1jD/uTzCfb79UhoaZn+Yhh
         +FNiTZ4fLYPsKzVEQcTT9zbqtte5aku5o947I0L+fjJlrPT3JfxvkU1cmIJryIrbfZyU
         NyfMuLN+8iENScNDXNlylafVRJg0pX8xNYFw8X0ymUbN8HsVZHpUwAFo88/tcyKEnCpx
         0GwRpSW/JA+XVpx3x7GvJOS4wkhmPrJvODN8JSmLrEMrG3HbioB1AFPfzelbBXFqPaPb
         mTfPibt4zBT8DGssQOUh5V2wl+8m7oJBvmf5t2D6n/ZLhVrWMKARXd4pDYhpHDkwJjzK
         +NaA==
X-Gm-Message-State: APjAAAXVaI+Zf6gsTW+GAMV1CAJvIWbBjnVmH8m2m43vWXqP7BPVX9Qx
        5lcGiJTfBt3z4FQDCDwQgYQwWlZl7RM=
X-Google-Smtp-Source: APXvYqxXTD1TNRcY5MxIDHkqDp5aGV8AN9zF8s/OSvp4ANUULc3c8Y1WLMeUjaJ8VfQF6m8LfcT/Qw==
X-Received: by 2002:ac2:4a89:: with SMTP id l9mr2604515lfp.121.1581718086386;
        Fri, 14 Feb 2020 14:08:06 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id w29sm4967069ljd.99.2020.02.14.14.08.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 14:08:05 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id y19so7741706lfl.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 14:08:05 -0800 (PST)
X-Received: by 2002:a19:c7d8:: with SMTP id x207mr2719756lff.142.1581718084244;
 Fri, 14 Feb 2020 14:08:04 -0800 (PST)
MIME-Version: 1.0
References: <d72d51a9-488d-c75b-4daf-bb74960c7531@kernel.dk>
In-Reply-To: <d72d51a9-488d-c75b-4daf-bb74960c7531@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Feb 2020 14:07:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wixEw+wKJzwfEFnBYLNt5zU6zA2kpNVu_36e33_zsawKA@mail.gmail.com>
Message-ID: <CAHk-=wixEw+wKJzwfEFnBYLNt5zU6zA2kpNVu_36e33_zsawKA@mail.gmail.com>
Subject: Re: [GIT PULL] io_uring fixes for 5.6-rc2
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 8:45 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Here's a set of fixes for io_uring that should go into this release.

Whaa?

          for_each_node(node) {
+                if (!node_online(node))
+                        continue;

that's just silly.

We have 'for_each_online_node()' for this.

There's something like four patterns of that pointless thing.

And in io_wq_create(), do you really want to allocate that wqe for
nodes that aren't online? Right now you _allocate_ the node data for
them (using a non-node-specific allocation), but then you won't
actually create the thread for them io_wq_manager().

Plus if the node online status changes, it looks like you'll mess up
_anyway_, in that  io_wq_manager() will first create the workers on
one set of nodes, but then perhaps set the state flags for a
completely different set of nodes if some onlining/offlining has
happened.

I've pulled this, but Jens, you need to be more careful. This all
looks like completely random state that nobody spent any time thinking
about.

Seriously, this "io_uring FIXES ONLY" needs to be stricter than what
you seem to be doing here. This "fix" is opening up a lot of new
possibilities for inconsistencies in the data structures.

               Linus
