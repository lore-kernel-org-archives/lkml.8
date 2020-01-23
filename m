Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FA6C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDA2206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cHIAbkji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgAWWpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:45:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38887 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgAWWpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 17:45:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id t6so1985573plj.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 14:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lDS+3WSPujoShC7doDseBAcn2qbrDXuKgW17o9svkCE=;
        b=cHIAbkjiGYyGWlr3Qz9vajplT0PI/Z+8Fu/987ccE+I6XbK1j4skJ2XgVqKVyg0WCE
         ExvFumHeQgiYha4XHUjAOLhyreLsvwM4jgACWap39lK/AWGFloVw4Hr5STe9eoFyCWUc
         I/+yqinWGOTw/eo9zFj3l98TQryNcCi7uFIjGzyqFr3N70b0pQqrLd6TzhugV5MwVXId
         TYgVR9BKfj5YodqfA9q20jXt0V8aXLDs8mY8TxdF9GpDTG8MsOxUgdFSjrwLlM6GvNO/
         sBf/y2aQhew8mrLgtCJYyOsHpz8+lKJkco0uulnwq9ln9kwGFrnE61XkMVvKfbxUedwL
         slzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lDS+3WSPujoShC7doDseBAcn2qbrDXuKgW17o9svkCE=;
        b=PzLMTaVCjSr/vIgVkQsT6jxphPKvlTPyuQBW/ncp5lWJ/ety3PtjKvPWitzdplUF2x
         Fvo9wheb/0typboucOWOrh4JJllkd6yGrAmvWNW9bNbCRKFtt/LPAAEDXD5KYzpG5fw8
         23sc0GTqoxf9n7ahufQDfRX9zPr/9jfiEZDLvF2RVnuRU8zDEzHU1dSKJiJte0L23PJ5
         A1yHUbolaCuq8GgaW4ccmBc8KRbjWMqUepB0HZ8Nlb5cXKqgfOx6PUkFZIxm678CHfLm
         qum32nMSOXdZKcG8MZkVOlxQ44cNerHL1J/wS+e0PtgP4T8i5+BA50OI/BL4deNQbVrm
         clUg==
X-Gm-Message-State: APjAAAUfkHWiY9kK6m/m6cEdSpxnAVmK9vG2+fvMgOr9oXBoDwS5CAUD
        zS1lEd+Pos7LtMUfAbngJ37Y2t3ZNdCG/4J53RywBQ==
X-Google-Smtp-Source: APXvYqw7Z3x2noRBQ2heUDMAvH6d/E7XrpibeDUNwqhuI6EQkiajmtzVh7BryjyvfCVGWCPH76TTKcMb42RHhJibjjc=
X-Received: by 2002:a17:902:9f98:: with SMTP id g24mr393688plq.325.1579819554213;
 Thu, 23 Jan 2020 14:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20191216220555.245089-5-brendanhiggins@google.com> <20191217075836.C76942072D@mail.kernel.org>
In-Reply-To: <20191217075836.C76942072D@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 23 Jan 2020 14:45:43 -0800
Message-ID: <CAFd5g47=FxbKtm9rA3zKvnipdTdP_VR8zJ3pad-QukL5Ottrjw@mail.gmail.com>
Subject: Re: [RFC v1 4/6] init: main: add KUnit to kernel init
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>, rppt@linux.ibm.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Knut Omang <knut.omang@oracle.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply. I sent this thinking I would check in over
vacation, and then didn't.

On Mon, Dec 16, 2019 at 11:58 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-12-16 14:05:53)
> > Remove KUnit from init calls entirely, instead call directly from
> > kernel_init().
>
> Yes, but why? Is it desired to run the unit tests earlier than opening
> the console or something?

I want to make sure it is called after late_init is done (so that you
can test things initialized in late_init). And I want to make sure it
runs before init*fs is loaded so that there is a mechanism to run
tests without having to put a userland together.

> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index 978086cfd257d..ca880224c0bab 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -32,12 +32,10 @@ static bool kunit_run_all_tests(void)
> >         return !has_test_failed;
> >  }
> >
> > -static int kunit_executor_init(void)
> > +int kunit_executor_init(void)
>
> Should be marked __init? Even before this patch presumably.

Just this function? No strong opinion.

If by "before this patch" you mean other stuff in this patchset?

> >  {
> >         if (kunit_run_all_tests())
> >                 return 0;
> >         else
> >                 return -EFAULT;
> >  }
> > -
> > -late_initcall(kunit_executor_init);
