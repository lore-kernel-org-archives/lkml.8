Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BAAC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 22:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F6A214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 22:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580511013;
	bh=oXpOaVGOS6SDp8q39m6kpslzFKXiI2MK/hsfwK+pcmc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rYnV67Hf9U20BlzIFsf405HXeBau/+9GjlgABZmPHbVtToo1LxHIN4Txd6GjMCBIF
	 t+vDBTkK6LSyXWTwORHq0OIkf6A63ygjj11BbcXgp457KrlkJR0r4y65WgZ6rjUcLR
	 Y9r6ibFhmNeRNWp/962OnDrGI2xyFC2t+FaTOrRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgAaWuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 17:50:12 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42803 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgAaWuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 17:50:12 -0500
Received: by mail-lj1-f193.google.com with SMTP id d10so8721122ljl.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 14:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YsjAu+tfEvoLC3dwMkCioXx0hC7IWMGyAJfLYgWB1b4=;
        b=IiZNGX+wDwmdzlBYBzzF8bFUmBUM/q2ECPUku4aCyw6YGltT7EaaLe+x+mvNda/0w1
         T17XRoUioyvD69g8aQiIpyBZs9gP/DiZ7FJSstZ33pf9E7vEke9Lw6vK0P6D71JAKJcI
         J/hamojyIzV/uvQu7is+4L6nFhpHXab2nnwQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YsjAu+tfEvoLC3dwMkCioXx0hC7IWMGyAJfLYgWB1b4=;
        b=Pm6iUpTf/KMkCTk0a52h6qhRiq3t2xhChU68+qx+B8XbUkIu0LU3XhKRyqvRDhdmHl
         YwZieATxn5oYO+L2H/nkpf4GmI/o7EfpOl455FERAldtU9+9jmXYsa4t7GsCle5/bBUX
         YYhsNps+er+eZikEO5e02hyWXGEFP5BUK8zXGIcSafLeGkxt9qRuAQH+u0ljRw7XCuox
         9PIf0Ekt1Oi5hFRJepZcz/9f/3vVEDIKjHsRl63r9VE0KKlW4DXxm1sbne38NDWmCENQ
         RVa6xjuO38gma2vLZNDEeGRARRQ1p89MBjCxbqiDaptbE95WJKc/0nrAce8p1KgZ2c6p
         +XUQ==
X-Gm-Message-State: APjAAAUz99ypj0ha+94Ylya6EzNXQS9TG2JA/5zUAz1Pp8RvkcMm2dnq
        7u/6QSWobO7rDRVZt+31X2iYjOpQoow=
X-Google-Smtp-Source: APXvYqwHfymH/qy8TJH84fzNIS4lSssQkIyaLCQcghckMahgDY29z6hXiFAh1jhyGsTArdVgWx7SVA==
X-Received: by 2002:a05:651c:102c:: with SMTP id w12mr7209516ljm.53.1580511009778;
        Fri, 31 Jan 2020 14:50:09 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id w16sm5323835lfc.1.2020.01.31.14.50.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 14:50:09 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id y19so5964884lfl.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 14:50:09 -0800 (PST)
X-Received: by 2002:a19:c82:: with SMTP id 124mr6569338lfm.152.1580511008060;
 Fri, 31 Jan 2020 14:50:08 -0800 (PST)
MIME-Version: 1.0
References: <20200131223407.GA105848@google.com>
In-Reply-To: <20200131223407.GA105848@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 Jan 2020 14:49:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjxMB3UYR5iUHB6+NXT7awOF4DD5=QQrskJ8yocyO+Ebw@mail.gmail.com>
Message-ID: <CAHk-=wjxMB3UYR5iUHB6+NXT7awOF4DD5=QQrskJ8yocyO+Ebw@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v5.6
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 2:34 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git 01b810ed7187

You must have screwed up your git request-pull somehow.

Yes, yes, the above works, and a branch is just a named SHA1. You can
give the SHA1 directly.

But it's not what you meant to do, I'm sure. Especially since you
pointed to the SHA1 of the top commit, not the tag that you have that
points to it.

I can see what you _meant_ to ask me to pull with "git ls-remote". I
clearly should - and will - pull the 'pci-v5.6-changes' tag, which
points to that commit.

But can you check what in your workflow went wrong for the above to happen?

               Linus
