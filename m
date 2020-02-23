Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666C1C35669
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCA920659
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582424889;
	bh=XXDevdsvXrMFfmYH0SIeJUUJ7CUK8AkX0UYKg2KVDCU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SxbDXZ5G6urcXxSXxFm08xj+JDZPhxq+0+0dIpoF9QIQC+MdCqgp4CjJFsrlsWap8
	 6HZNt9cI24yz3dcS4CIvYWz8ODYGIwAi/O4NyBW87Led3YZJ/dNm138wz2ItnxTp7F
	 XpSda+LZhWMbRHvvisjpJrGiaA5z9wcvh0JqaEVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgBWCYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:24:24 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43236 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729138AbgBWCYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:24:19 -0500
Received: by mail-lf1-f68.google.com with SMTP id s23so4294285lfs.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 18:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqfK9IxNwj7ckP+MpJmSceONpcVbgVpUow9PPlLP6iA=;
        b=IIfqKj2QdGhRadPaahvLYJUZd7WA2qCg1z6Q8cD1LMlvinW50KHFPhR9fFz/XyCE/k
         aB8JOGB9Flmf8exB5hf8IBB2QSftwDTwA+9g9UU6QgopoPRzetdU1Xp1ZpE+Z3rg3FoT
         y7h9slhbD53JXZysr17OqV0jFNfxzoQdI+4g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqfK9IxNwj7ckP+MpJmSceONpcVbgVpUow9PPlLP6iA=;
        b=Xq7rlLXyrAZ2+OEP3b3WGgM6ZXQ2lx6YMY6aPKXF40CxM8a45xJFr1nXo+zjjK/HMf
         KDyNPsk9t95mOfCrzxo/OzhClpEdZlJXXvd70gVRfBqC/SDHwZcpHZPzfpAcBr/fPKEC
         1LDGLFkSZrmuANuYzYb7rrPZZdJyEfswCCHCn47r2Oj80aamIhKAk4LUskduhmiqSW1C
         +0yhKTZYQriUdSaNTkfLIKKUKjFTSzlYMAcnGGq6HkDQBg7KSD0J2gTfwgDvCxtUSx4S
         F0LZSTfYbUEZ3RmjuJ8s4yxpydMv6NJfkGgEtk5rg+7cU//5gdpyTw9X8kmzvUwnk86v
         rkfw==
X-Gm-Message-State: APjAAAVi/qYoZENsYqomQtey355lxpDc5VcxS9Tm+MRWyN+zVjzIECEu
        QjsEcSAedPCgI5Aa0RZjZhE8qeQbdf8=
X-Google-Smtp-Source: APXvYqw8ZHfR7N089rhyb96H1EaTXin3D1wXpKQi+Llw6QzHhekXL33SDyrFBhyWYTO6KFD2v+gXJQ==
X-Received: by 2002:a19:9155:: with SMTP id y21mr9788843lfj.28.1582424657502;
        Sat, 22 Feb 2020 18:24:17 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id w29sm4697463ljd.99.2020.02.22.18.24.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 18:24:16 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id q8so6239899ljb.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 18:24:16 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr26665961ljb.150.1582424656256;
 Sat, 22 Feb 2020 18:24:16 -0800 (PST)
MIME-Version: 1.0
References: <20200223011154.GY23230@ZenIV.linux.org.uk> <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
 <20200223011626.4103706-23-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200223011626.4103706-23-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Feb 2020 18:24:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiD_410q9aBfQN44a3pPYrxjqa6OfFf=5ZCr=rCWgTt3A@mail.gmail.com>
Message-ID: <CAHk-=wiD_410q9aBfQN44a3pPYrxjqa6OfFf=5ZCr=rCWgTt3A@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 23/34] merging pick_link() with get_link(), part 6
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 5:23 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> -       err = pick_link(nd, &path, inode, seq);
> -       if (err > 0)
> -               return get_link(nd);
> -       else
> -               return ERR_PTR(err);
> +       return pick_link(nd, &path, inode, seq);

Yay! It's like Christmas.

Except honestly, I think I'd have been happier if the intermediate
points didn't have that odd syntax in them. Even if it then gets
removed in the end.

               Linus
