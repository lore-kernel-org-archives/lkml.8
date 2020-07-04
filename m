Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5246C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 23:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4F6620772
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 23:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kup5Q35r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgGDXjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 19:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbgGDXjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 19:39:42 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70066C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 16:39:42 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n2so22310206edr.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 16:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wiOQQZ02XFm/BV4L3Jk1shIvr/SgSyC6/7/Nw0lQ+ZA=;
        b=kup5Q35rKbLnb1mEjO8X6MKkJrcWslIPp6mdkMvRY0G1dR/BCUgniv2XMdUgQx8BP0
         WdqSljKF6PIRc+5Q5lO0Q3uBGpO7GjIrgaIaeNHJyDnaQkmMJQeGlF9rT2UJXyErJ8EJ
         0NiEJ0pu6U74hLy+C1UpY2QxTCIQSUH7362ciYBgckTfc7auJkrziYcZmVBweBxWyPwa
         mC6xVATf6Vp4gS4WRuTtPM8aHV7dA9K6+GeNdqWUfzDUtHlI2edaTooIYe1QZp5BVdvD
         QnQchV6QQJKykJE9sWiUSF5lW6Th9AQe2GMYD4g0PuITzvM9Mv2qVkWh75Edu5Ov9yt/
         0DOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wiOQQZ02XFm/BV4L3Jk1shIvr/SgSyC6/7/Nw0lQ+ZA=;
        b=rrT9P40lIzJs1kvxmUr+/CQseUdmpYO1mjLjuC//0qnI+h3AmG98dffShMTuD3k/br
         2SSVCuoo38OMgioEW2QrscDlbUqmMPY2DRnHxwZdCsEiuVraTrPS+Vj4z2KXml4HWm8C
         WCd/jr1nZWwtH7YAPv+xkO7+K/e/hM//HoeMR+QF3P7seHQSvOAh32OFEL5AUt1xj3DI
         cqJKWzR6YsBAEoz2rl/3mXJ7UasC2J4PzzbjHOjurLbEqENlulu8GMw5F2FJ0St2a4AZ
         Y3r1XuapQxxN181OzRpd2lTZ3cB2J2uukoU5E90sSxJAqWR7iZnIi9QzQr7bK6gSyoWU
         3nzg==
X-Gm-Message-State: AOAM530c6vqJiSozEdYA3aeKLRpifccviGKnXPZztCvYUU/7K+G4Cphe
        BszsR8rWhFkTAL0XOCZbFaHKAmx8aTPrfU4K77s=
X-Google-Smtp-Source: ABdhPJzbei+YhbyxBBky+9dDKnl8xs2AYHFFXGBEnxjE+lcFPY0N5s9i6KJs6PQtIT40TdEoIG90VJW5+1F1Of5ao3E=
X-Received: by 2002:a50:f08c:: with SMTP id v12mr47055813edl.119.1593905981048;
 Sat, 04 Jul 2020 16:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1593897917.7058.11.camel@HansenPartnership.com>
In-Reply-To: <1593897917.7058.11.camel@HansenPartnership.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Sun, 5 Jul 2020 09:39:29 +1000
Message-ID: <CAPM=9tyjdzU-O2nAWFngGSE=aSfUsaRer9x3bk8hpyhCOX0Bew@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Mason <clm@fb.clm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jul 2020 at 07:25, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Sat, 2020-07-04 at 13:02 -0700, Dan Williams wrote:
> [...]
> > diff --git a/Documentation/process/inclusive-terminology.rst
> > b/Documentation/process/inclusive-terminology.rst
> > new file mode 100644
> > index 000000000000..a8eb26690eb4
> > --- /dev/null
> > +++ b/Documentation/process/inclusive-terminology.rst
>
> Could we just lose this entire document?  The one thing we should learn
> from recent history is that we really want prevent people distracting
> from the good inclusive (and technically more accurate) terminology
> will do.  One way the detractors do this by engaging in ultimately
> pointless arguments about historical accuracy of supporting statements.
>   By making pejorative statements about history (which are open to
> challenge on several fronts), this document acts as a magnet for such
> attention.  Simply leave it out and the detractors will have nothing to
> attack except the bald statement of desiring more inclusive language.
> I'd much rather defend why we want inclusive and more descriptive
> language than get into a pointless argument over whether the Ottoman
> slave trade was more or less evil than the American one.

I don't totally agree on that, because like the CoC discussion, people
need concrete examples. People need reasons, saying simply "be
inclusive" doesn't work.

You say "be inclusive" people don't think about it, they just go "I'm
inclusive" and proceed, never questioning what it means to be
inclusive, they normalise inclusivity to their self image and within
their lives where they might never confront anything like this.

I don't doubt we get the American/Ottoman/Barbery coast people and the
correct answer to those people is to tell them to examine why they
suddenly care about Barbery slavery now when they have never even
heard or worried about it before. Why haven't they submitted patches
removing slavery terminology from the kernel before?

Dave.
