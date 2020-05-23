Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDDCC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 19:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 011BC20735
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 19:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuNYv47+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbgEWTEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 15:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387536AbgEWTEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 15:04:44 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B03C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 12:04:43 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id r2so2853047ila.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 12:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0LV47rSe890XlogISSGIE6i2W6NCdilGYWQjmkeWAcI=;
        b=MuNYv47+N7wRiR6DVM2pf+KbMZNdP4Jmmg/+eibCEvfZxDyF/ypNY7XnSb/unnXcpi
         dmwBTLa4AS/9LkWJMVX7blfX/bi/37u61nq5+ZjWr8Po491XDEByhvIhVo4sp1V/DibH
         NaLrB91HEVJbnbtCj+8IpyWJi55kNivatt1psiherUomDFFxxC+Rn7WRxv2H82NlrPk1
         xcFvGzfBDg7nT7Au3OqrYVFMhkhg34d2AqTD3C72TezUbCbqBhx6F+cQVKkwzK0GWiIZ
         Il9QoPaQS1eLnnjiB/MwEr/H4MXSrY5HWuDB/t8g2Ak+NECpzS2riffmdqUzJzwiEHb4
         2WVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0LV47rSe890XlogISSGIE6i2W6NCdilGYWQjmkeWAcI=;
        b=dh8U7h+9SgD9DgpV5AGzYA9xLHUUcvUtX2kGbc0AxKVghlEjrLMCF2zrz/UJ5G7k82
         xlQnYtfYrAE8NdJO7mkjA8Ra3egRT0NEzwK0vHGgpmkuVY6Hc+223JKgHCCBjb8nlr+i
         IMDmQSwY1wjXSJFaKV4h65yzDDD6Xqbk7IfX88DlJOMvM27WQx+ND3MLT+oVqmNiPVb2
         yWtBoTItntuHJM0qkQBXoWpYwY/hpq0cAqxfoT189yKZ0zYMH9la9CgFxMzWJtu2KG2d
         3NdejNNgyfbD3q0pihua7I/MTK9D0WLsDTjrYtrQVdpp5Ljqhc7TMdFF1tbZS2WDZQy8
         CfPw==
X-Gm-Message-State: AOAM5322BzW4HWXeoZ/urSo0nueOSiTjB8oKDhgEhNKC46+08CBDhYVv
        ldrdvA20T6wDcECMd7LqZaOJ/wL/aLYJN239+/c=
X-Google-Smtp-Source: ABdhPJz1D1HZP31wZpW+FICO4CVrUuQnF8P/L4/J+Gw6ZO9o/P+Mbrwsjchg6wq8uAghZnfJmH2DQBPanIHkyjFHdjY=
X-Received: by 2002:a92:6411:: with SMTP id y17mr18834396ilb.161.1590260682377;
 Sat, 23 May 2020 12:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
 <20200523153643.GA226270@kroah.com> <7a5e4740-8099-ef70-776f-0d92ce84ab3d@infradead.org>
In-Reply-To: <7a5e4740-8099-ef70-776f-0d92ce84ab3d@infradead.org>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Sat, 23 May 2020 12:04:30 -0700
Message-ID: <CAKdAkRQvQkC8aHUjOPdUrJTSQ8z3jK90RJ85VyTQaOfnfmj9Cg@mail.gmail.com>
Subject: Re: [PATCH] kobject: Make sure the parent does not get released
 before its children
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 8:48 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 5/23/20 8:36 AM, Greg Kroah-Hartman wrote:
> > On Wed, May 13, 2020 at 06:18:40PM +0300, Heikki Krogerus wrote:
> >> In the function kobject_cleanup(), kobject_del(kobj) is
> >> called before the kobj->release(). That makes it possible to
> >> release the parent of the kobject before the kobject itself.
> >>
> >> To fix that, adding function __kboject_del() that does
> >> everything that kobject_del() does except release the parent
> >> reference. kobject_cleanup() then calls __kobject_del()
> >> instead of kobject_del(), and separately decrements the
> >> reference count of the parent kobject after kobj->release()
> >> has been called.
> >>
> >> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> >> Reported-by: kernel test robot <rong.a.chen@intel.com>
> >> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> >> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
> >> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> >> Tested-by: Brendan Higgins <brendanhiggins@google.com>
> >> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> >> ---
> >>  lib/kobject.c | 30 ++++++++++++++++++++----------
> >>  1 file changed, 20 insertions(+), 10 deletions(-)
> >
> > Stepping back, now that it turns out this patch causes more problems
> > than it fixes, how is everyone reproducing the original crash here?
>
> Just load lib/test_printf.ko and boom!
>
>
> > Is it just the KUNIT_DRIVER_PE_TEST that is causing the issue?
> >
> > In looking at 7589238a8cf3 ("Revert "software node: Simplify
> > software_node_release() function""), the log messages there look
> > correct.  sysfs can't create a duplicate file, and so when your test is
> > written to try to create software nodes, you always have to check the
> > return value.  If you run the test in parallel, or before another test
> > has had a chance to clean up, the function will fail, correctly.
> >
> > So what real-world thing is this test "failure" trying to show?

Well, not sure about the test, but speaking more generally, should not
we postpone releasing parent's reference until we are in
kobj->release() handler? I.e. after all child state is cleared, and
all memory is freed, _then_ we unpin the parent?

Thanks.

-- 
Dmitry
