Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3829EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 106A52245C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf6LEin+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbgGaPtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGaPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:49:02 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA501C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 08:49:02 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g19so5073152plq.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 08:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7k9huCaoUiykFMQi1bHPTD0nkp/If40ytG/MCKguQys=;
        b=Pf6LEin+GEPsD5iYuHes0bQXHIek1Humy4C2weaxOhAR0mEfnXema8KSd/FejANbXi
         6iEQi3UBemtJWC2TEtCAqAERC8yWjCDW/5uIKjaD64T1UEXnkpYNV2DgTwuhCWEiYj9+
         eptl7qOXnyN/xlX7fcO8X23ydxT301AsX8e9PHJswfIo1Xp3qqBN2YMCEARIjwRqu5nR
         nxp2HmUVP5hPLlbJssD3ZKVS6t2QM3g+5JaVI9vwvB4+JA05PizxY0hsDZMDcbhAmbZa
         XAjqyqmBbAAq7BZmP2lIaOnWkv7TbGyKPWcP+fgKtjQ7lrWBg532ZjXPAd0wmIBf3YO3
         XsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7k9huCaoUiykFMQi1bHPTD0nkp/If40ytG/MCKguQys=;
        b=Wz7Sj2G7E7fGX9zPCraytnKtbZHx4JLSFBIJwCod34KcQGB34mTIaEkXCVpgvYDTqx
         rNDzLwtEt+Vd9YkEe/7kqoSw7/1u7QAfTFAbz49ZHr+B7ft8QCX1xUHfn1RkxkfPjT0/
         NmBb2nLHQvc4jEFa6VPlApQuizESQcXGAYlFxoWGO8TP4HK859ALK5mWGGDq4am+PSaY
         /biTPDOI3P4iGz9s2Xm/VOvEifHN+OZ7vLy+jwDbl/L5Tpbympfbegv0uI9xQXAEQzOn
         7ATAILiUTCeDr3j0jXc7YjeMXstV3Mq+NRZP2s3TRYmQ8NKvYweeWoP2IpeX3Dnd/DAS
         zS4g==
X-Gm-Message-State: AOAM533GL8feWbE32er3SGnGIzPs/bGvh+bqO/0QQxF1ely0rfOKhoLi
        4MO+oSp2SFjQ/Ovi0pwkrpvpQVSfakTLl8G8M8Y=
X-Google-Smtp-Source: ABdhPJzAY8OpzEngMP1t35Gkk80xmy3BANJXADYWSn2JFVXR0WpAt4JLCO/qYzurs/7rBSTqk5ddXCWTACunO9flMHw=
X-Received: by 2002:a17:902:4b:: with SMTP id 69mr4324861pla.18.1596210542347;
 Fri, 31 Jul 2020 08:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200731123145.22357-1-andriy.shevchenko@linux.intel.com> <20200731103800.36a412eb@oasis.local.home>
In-Reply-To: <20200731103800.36a412eb@oasis.local.home>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 31 Jul 2020 18:48:45 +0300
Message-ID: <CAHp75VcwEnQh5hJw0xHwAHm2qJeHVe4WtPN=qQX2mSPSO3OQPw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] lib/vsprintf: Replace hidden BUILD_BUG_ON() with static_assert()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 5:40 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 31 Jul 2020 15:31:43 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > First of all, there is no compile time check for the SMALL
> > to be ' ' (0x20, i.e. space). Second, for ZEROPAD the check
> > is hidden in the code.
> >
> > For better maintenance replace BUILD_BUG_ON() with static_assert()
> > for ZEROPAD and move it closer to the definition. While at it,
> > introduce check for SMALL.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  lib/vsprintf.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 31a674dd2674..8a8ac7ce0289 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -381,6 +381,9 @@ int num_to_str(char *buf, int size, unsigned long long num, unsigned int width)
> >  #define SMALL        32              /* use lowercase in hex (must be 32 == 0x20) */
> >  #define SPECIAL      64              /* prefix hex with "0x", octal with "0" */
> >
> > +static_assert(ZEROPAD + ' ' == '0');
>
> I would have it match the comment above:
>
> static_assert(ZEROPAD == ('0' - ' '));

Okay, makes sense.
Will do in v2.

> But other than that:
>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks!

>
> -- Steve
>
> > +static_assert(SMALL == ' ');
> > +
> >  enum format_type {
> >       FORMAT_TYPE_NONE, /* Just a string part */
> >       FORMAT_TYPE_WIDTH,
> > @@ -507,7 +510,7 @@ char *number(char *buf, char *end, unsigned long long num,
> >       /* zero or space padding */
> >       if (!(spec.flags & LEFT)) {
> >               char c = ' ' + (spec.flags & ZEROPAD);
> > -             BUILD_BUG_ON(' ' + ZEROPAD != '0');
> > +
> >               while (--field_width >= 0) {
> >                       if (buf < end)
> >                               *buf = c;
>


-- 
With Best Regards,
Andy Shevchenko
