Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFC0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9874206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594153462;
	bh=TbdwxGLQlZ0jGP98TtLe5hQDTqJJXLwEhn66YVw1rc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WFGyr3XOnYi2a9eko7YO2rBOClh0ie3CB0XSC9lXuNXA8I1BaE7k/pfmawrlOQNfH
	 3TKdAgwQ/0XfOV+TQnk0iF5MHn5vohbnA17kgZUy8ZAIs7sv6DJgiBgNqNvk0pLcKS
	 pQcXpGkdxkrWSWC7cyZGsmdd2zGuS4MtKFHLYVQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgGGUYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgGGUYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:24:21 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DED2C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 13:24:21 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k15so25530834lfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 13:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XqDOhPELSzMgZFeHVQzNLAfVHgv7dPOLnk5RnzM4P4=;
        b=LY4FvMZzILikh15a8T4+gZcC0iBGtJIHSCWGKPXPFccoqV7BkYRThzmBYw+Gn++IR0
         KDHlg9I55kRP3bn6OA1SY3gKt8aJQqmugf/5wZuoWhDeEEHYDWHOD/dvGo2Wt9x4Qui/
         iilyA/ngA43BVbE72OqjP1/UYdQ3shqLk3Ktc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XqDOhPELSzMgZFeHVQzNLAfVHgv7dPOLnk5RnzM4P4=;
        b=o7gTZi4ZSEFKBmmshl2g1Jd1jd1gL8SOO7qs7Ap5M5F0wGGy0hMMHF4oMp42Jn4DcR
         bsRnLlYR6ny2boSBRTTZjsSfnC8cueUHNVNyiMJpXRJUFRIAwITp3T0+ZhN+oicqjxyz
         WNEnSfdUZGju+TwfO9ges9bPZqvdbPpEUjuKGNHGkixG+IuiFR4jKt2qM87nXJwobtcX
         9jLxWA/pm/E/2At1hIWLSv4rs4uhsq1pVIf5aYU/awlEX/oFqpE5/4Zk9EFgGJvkMKSK
         ukqjC53oMXk7RVexqqIgTM8TBun7fs+a0BDVyv3cgaN46BgDoKBsl8GSufvoioeVI983
         C5Iw==
X-Gm-Message-State: AOAM5336B0f9dWcBpgCfOnoy/BTmV7o0vIwRdRfdxNawnZHOrWVoCjDq
        Rk562EAv/swFNh7WSzc8TiMc72Fb5jk=
X-Google-Smtp-Source: ABdhPJx7F5ysMcLsDmxj9/R5SEiTsJ1lAwfynaOLPg+Xf/va5w5kD2flwis/SJR69BY6DM0Hw0PokQ==
X-Received: by 2002:a05:6512:10ca:: with SMTP id k10mr23736568lfg.177.1594153459136;
        Tue, 07 Jul 2020 13:24:19 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id o4sm9766582lfb.52.2020.07.07.13.24.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 13:24:18 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id q7so38276278ljm.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 13:24:18 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr30598178ljj.102.1594153457543;
 Tue, 07 Jul 2020 13:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200707174801.4162712-1-hch@lst.de>
In-Reply-To: <20200707174801.4162712-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Jul 2020 13:24:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wib3BP9AoFzhR_Z0oPRwx7vkcS=zsDuUmx0FbCrtia7CA@mail.gmail.com>
Message-ID: <CAHk-=wib3BP9AoFzhR_Z0oPRwx7vkcS=zsDuUmx0FbCrtia7CA@mail.gmail.com>
Subject: Re: stop using ->read and ->write for kernel access v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 10:48 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Al and Linus (and Stephen, see below),
>
> as part of removing set_fs entirely (for which I have a working
> prototype), we need to stop calling ->read and ->write with kernel
> pointers under set_fs.

I'd be willing to pick up patches 1-6 as trivial and obvious cleanups
right now, if you sent those to me as a pull request. That would at
least focus the remaining series a bit on the actual changes..

           Linus
