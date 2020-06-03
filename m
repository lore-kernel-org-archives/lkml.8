Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE25C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 04:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D832067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 04:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUe25Cg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgFCErI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 00:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCErH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 00:47:07 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1A4C05BD43
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 21:47:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so1018483ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 21:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5HyznCRSqZKzp8yxYccefdnyUnHkOKLPSiD7FrX1pVE=;
        b=OUe25Cg22WDYpRQ3XCaRcJ8nvIFDL++1wJ/8vhdCEGylPavhoKCvOcfB8UqmXCEEzm
         QAaJcNA0prtyQ4Ns5VW0t1iHhGEm4e2XLP+ankfK8QmKgzY5kgO00Chd5xwIoaDWSLdk
         Eia05lSaRZaSnrPlDc2RZ0iEM0bykCtNo2IGVdBBeP4tgWzqnItxIFYExBPCFbYjxos7
         OAl9WiwYvn8Aq2u1ZqRqWMmS/j/WO1Rf6RhsDH4VRnz3uEyFQqv3epIy+2b7loQ5ejTq
         v3D/h2pdRkV/2t6joCyzshZ5JXZm658VhLGhQADOK0CoMox9NFKdr35dzQ2+wAUqMZIQ
         FrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5HyznCRSqZKzp8yxYccefdnyUnHkOKLPSiD7FrX1pVE=;
        b=suIU/QamLA3Z2PdGpx+QTvCEVUgJDUQ6c2suekQNj5zkBUXeItnv9G+xAq+RWIvZly
         1QzB1Oa3592C100OyIiGLMGbg3u4n1Pz4ygg+Ua2JZvFrZlfqP4ht/DC3I3ywSKuGU47
         FhhGzSn32zFSIGR6h7MhIvhEJreEoRC04BZB3GPtRnPTYO0nAhcVFHI4mZwvCNeaJuhu
         MNtP8jQJxeA8TK2i3gv9WAEkRaH/eVLc96jkQP6OI/0th6hctHeXzxBPaLPmOgF+65N8
         h91mNxOgEP9YZ55HM20I2da4INcpa/UBVoSr5DPJz7+14WbD6WCt7C4Y4mnrviuYEVL0
         YLeg==
X-Gm-Message-State: AOAM532nK1XE3JzI9DwqP/sfdsUYZJD7ebtF/vsGcvpApQjZ98ayx/76
        x5RYLCcuwSR6c8NaXp+iPC/3oITMFyrXf+EQBYQRYg==
X-Google-Smtp-Source: ABdhPJzX/QPYO+IFkLwCC/pcn+l34ZzpqPaDG1GSY3dO4wqzcrCQkLqFUew2QLYvZN8DZ75w1+s67PXQw6+A7EJ7zd0=
X-Received: by 2002:a05:651c:1103:: with SMTP id d3mr1171214ljo.110.1591159625236;
 Tue, 02 Jun 2020 21:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <1590751607-29676-1-git-send-email-sumit.garg@linaro.org>
 <1590751607-29676-2-git-send-email-sumit.garg@linaro.org> <CAD=FV=WVdRcvfR-O-A2809AqFggqhJmvrTSo9qafxq=DgSbLrw@mail.gmail.com>
In-Reply-To: <CAD=FV=WVdRcvfR-O-A2809AqFggqhJmvrTSo9qafxq=DgSbLrw@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 3 Jun 2020 10:16:53 +0530
Message-ID: <CAFA6WYM0=WaFd7uUYaTje+22oVmG1fCBOYAz8UUmB2z6qcK=6g@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] kdb: Re-factor kdb_printf() message write code
To:     Doug Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020 at 03:02, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, May 29, 2020 at 4:27 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Re-factor kdb_printf() message write code in order to avoid duplication
> > of code and thereby increase readability.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  kernel/debug/kdb/kdb_io.c | 61 +++++++++++++++++++++++++----------------------
> >  1 file changed, 32 insertions(+), 29 deletions(-)
> >
> > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > index 924bc92..e46f33e 100644
> > --- a/kernel/debug/kdb/kdb_io.c
> > +++ b/kernel/debug/kdb/kdb_io.c
> > @@ -542,6 +542,33 @@ static int kdb_search_string(char *searched, char *searchfor)
> >         return 0;
> >  }
> >
> > +static void kdb_io_write(char *cp, int len)
>
> nit: "const char *" just to make it obvious that we don't modify the string?
>
>
> > +{
> > +       if (len == 0)
> > +               return;
>
> Remove the above check.  It's double-overkill.  Not only did you just
> check in kdb_msg_write() but also the while loop below will do a
> "no-op" just fine even without your check.
>

I will get rid of kdb_io_write() as per Daniel's comment on patch #4.

>
> > +
> > +       while (len--) {
> > +               dbg_io_ops->write_char(*cp);
> > +               cp++;
> > +       }
> > +}
> > +
> > +static void kdb_msg_write(char *msg, int msg_len)
>
> nit: "const char *" just to make it obvious that we don't modify the string?
>

Okay.

>
> Other than those small things, this looks nice to me.  Feel free to
> add my Reviewed-by tag once small things are fixed.
>

Thanks.

-Sumit

>
> -Doug
