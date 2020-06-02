Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8241BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526CC2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SQy7D7fN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgFBOC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBOC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:02:59 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712B5C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 07:02:58 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k15so7533729otp.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 07:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ggOR0Cl510IRTxzlmGLn42zz2g74i90VX9kjLvEOxG4=;
        b=SQy7D7fNQ3uB48bFB7C6078JBK3f2uXs9BQtMYI0Gu8eUcIq0o8jucbp0fmtfAR9wx
         XlIYQlW/J2Q+RqepPopExAwHAYiSSyrLZWXO4/By8juZgrE5WNzzHifzgqtv5p8dT0hU
         TsqdzKB7xJpi/e2byOH4RGCZvpC8+aaIuPK7tai5OnfW2r3FDoLvFZ+2HMlBpG7WTfYp
         /SBnza9WHkUW0IMuLqJqWb25LFQ8e7ZlHaA+mXGufx9OXNNhk8jG0dyGxZVZe3tL9QSp
         cDrPeRzozgk8kiS4KhVCKRFobBBHSoMxxr5eI8JvyeV4uC+lMD7+7b2V8A+JXYfkJRXW
         Nzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ggOR0Cl510IRTxzlmGLn42zz2g74i90VX9kjLvEOxG4=;
        b=dM0dlRolC/32gA55yyEMhDnP0j2nIjVXiyq0RIH4Q+8ee/uhJ5Ikf8P0DUJ0Rs15E4
         qIm2T/K7Fm89SLfNu5ULuY2frYyjZ4CY8Tm8/5yEMNxQ/M1u3cnB9xH5rSLJ4Qrygx1Y
         4kJEvyZVqhcKERgsa0fcD+ujkmFla7ZuWmM6u47RfFOFrjU104JbhoovNAD8wJvGPRfI
         h0QPovU8NwS9h/ukqLjqtD9ACHjcaW1HcrkDio8ljDeZhIsfPgAyHNB6wnwN/XCvAzCK
         K3M495o2wkAsjRU08eOtfhHCXUQOG8SC6kKWwzuit4gdvMwE6ykOqWN/td0akMlUqPcX
         6vug==
X-Gm-Message-State: AOAM532MxXkwKcsGZqkPSsRNi7cvl62PJYctIMeliBhzmW0SMEaIlrou
        zApse+jLtByCSi/oPFIIY5YcLCpJ9x5NqE+vJ+lrYA==
X-Google-Smtp-Source: ABdhPJytCbEQYf19zfmhcnF1C67ZEQmnyKMQzhw8ciOZ3Sp9IJlUwT3j1I6XVDW5aslGKqF0+wcRiwP/2RlvTqRyRTA=
X-Received: by 2002:a9d:7651:: with SMTP id o17mr4779813otl.21.1591106577587;
 Tue, 02 Jun 2020 07:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <1590751607-29676-1-git-send-email-sumit.garg@linaro.org>
 <1590751607-29676-5-git-send-email-sumit.garg@linaro.org> <20200602134650.mdovxoa6cj2hgvei@holly.lan>
In-Reply-To: <20200602134650.mdovxoa6cj2hgvei@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 2 Jun 2020 19:32:46 +0530
Message-ID: <CAFA6WYNSDbh6uuD03oNWDL2a3x2g5XCeYRWg1toZ8DstvJgWYw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] kdb: Switch to use safer dbg_io_ops over console APIs
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jslaby@suse.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020 at 19:16, Daniel Thompson <daniel.thompson@linaro.org> wrote:
>
> On Fri, May 29, 2020 at 04:56:47PM +0530, Sumit Garg wrote:
> > In kgdb context, calling console handlers aren't safe due to locks used
> > in those handlers which could in turn lead to a deadlock. Although, using
> > oops_in_progress increases the chance to bypass locks in most console
> > handlers but it might not be sufficient enough in case a console uses
> > more locks (VT/TTY is good example).
> >
> > Currently when a driver provides both polling I/O and a console then kdb
> > will output using the console. We can increase robustness by using the
> > currently active polling I/O driver (which should be lockless) instead
> > of the corresponding console. For several common cases (e.g. an
> > embedded system with a single serial port that is used both for console
> > output and debugger I/O) this will result in no console handler being
> > used.
> >
> > In order to achieve this we need to reverse the order of preference to
> > use dbg_io_ops (uses polling I/O mode) over console APIs. So we just
> > store "struct console" that represents debugger I/O in dbg_io_ops and
> > while emitting kdb messages, skip console that matches dbg_io_ops
> > console in order to avoid duplicate messages. After this change,
> > "is_console" param becomes redundant and hence removed.
> >
> > Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> Looking good, only one minor comment left on my side (including the
> three patches prior).
>
> > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > index 9e5a40d..5e00bc8 100644
> > --- a/kernel/debug/kdb/kdb_io.c
> > +++ b/kernel/debug/kdb/kdb_io.c
> > @@ -560,12 +560,14 @@ static void kdb_msg_write(char *msg, int msg_len)
> >       if (msg_len == 0)
> >               return;
> >
> > -     if (dbg_io_ops && !dbg_io_ops->is_console)
> > +     if (dbg_io_ops)
> >               kdb_io_write(msg, msg_len);
>
> Since this now slots on so cleanly and there are not multiple calls
> to kdb_io_write() then I think perhaps factoring this out into its
> own function (in patch 1) is no long necessary. The character write
> loop can go directly into this function.
>

Okay, will update it in the next version.

-Sumit

>
> Daniel.
