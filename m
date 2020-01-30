Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DA2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4E92063A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bLf97hh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgA3XFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:05:03 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45111 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgA3XFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 18:05:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so2405815pgk.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 15:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZVCoy0c6zBh/23HJ8qV14vEXBoPTNgRjwz7/2GTwHIc=;
        b=bLf97hh1JmbfTKxaOIa/hfizEnh8PioMn1Y9TI7CEopKUPmgeQBicnEdwrFatxlt9U
         /dF+mwGLbsQW7KmPTy8I6XvXreO4N48lEX+Ehw6v+hoPAgu86vKzIbhOK4gM6oTf8mzR
         cUmaOPLKTOy/zPKtP/xK5WHSM7BjdC+E9H/qWV2SFU1exl9sfnhtxf2MfNs0DfBmIsih
         drKywXHDy84lMq4TuYIprVFUFSLN67kw0IUzFFhKIkCU/UHmgiJqlOOqaSS+2J072x0h
         J3RdIyqQ5IBv58TAQv0tMiutT2U2bysgST7jCLtDi7nTZT3kvU1poPBXQgw1qd6KjzT/
         afJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZVCoy0c6zBh/23HJ8qV14vEXBoPTNgRjwz7/2GTwHIc=;
        b=JqGHqyGSWbBF27FVJSw8H24nBIVzKuzfw2kuGZOkgWEHRwz9d6CvW8k0QvWH9NZrSc
         K6zFYUZ6p/o70XYE3BZ8VLhFXnhYfNbu+NiQUk2HTc9X+Ag0iKVJ4LGs5JaZ8xSswMq/
         2ae3LRZJekzzOzKThQ7VPH6tBgEeLuwJHRiuW5PEd+0coA5KC1ErnCQvkLx1QJKOqUF5
         +b/iZPQ9IyJiMlR3Qvu+Gr9hjoTRrM+gTtb3QNdtFtZUiPvx3HKWg40CcwOHxhaMqdVG
         u88ewvZ73tSCm/dRyMR9B+8483PkFlDMup9MGsmQWx0PaxwZN5O97d8IxLzhjlBXR7vb
         yKTQ==
X-Gm-Message-State: APjAAAXMYlyW6o6XQAQ0/ZFLI/oKLWfZvP74PzZ84M2K2XKZ8mNHO1e+
        mniSt+O6IuesglxgzV6rsaenjzzLzaV0LMRx/+L9pA==
X-Google-Smtp-Source: APXvYqzpy57/EHOzTXSLzSf3keMtVmLBKsmU0rRVRaSHQpEvmWIO/hSL5ezfKU+X1bWMMEn/DiuqtJfLEN9g3PJzcvQ=
X-Received: by 2002:a63:480f:: with SMTP id v15mr6926030pga.201.1580425499190;
 Thu, 30 Jan 2020 15:04:59 -0800 (PST)
MIME-Version: 1.0
References: <20200128072002.79250-1-brendanhiggins@google.com>
 <20200128072002.79250-8-brendanhiggins@google.com> <20200129062709.5B2A22067C@mail.kernel.org>
In-Reply-To: <20200129062709.5B2A22067C@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 30 Jan 2020 15:04:47 -0800
Message-ID: <CAFd5g47cha8DJdS9x=Qjj-vLXjGOugQK38Ln85eznfuN11cLrQ@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] Documentation: Add kunit_shutdown to kernel-parameters.txt
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 10:27 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2020-01-27 23:20:02)
> > Add kunit_shutdown, an option to specify that the kernel shutsdown after
> > running KUnit tests, to the kernel-parameters.txt documentation.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index ade4e6ec23e03..0472b02ce16bb 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2054,6 +2054,13 @@
> >                         0: force disabled
> >                         1: force enabled
> >
> > +       kunit_shutdown  [KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
> > +                       running tests.
> > +                       Default:        (flag not present) don't shutdown
> > +                       poweroff:       poweroff the kernel after running tests.
> > +                       halt:           halt the kernel after running tests.
> > +                       reboot:         reboot the kernel after running tests.
>
> Maybe drop the full stops on the short descriptions.

Will fix.

> Otherwise,
>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>

Thanks!
