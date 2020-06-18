Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43DBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E5E620773
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki5dlN0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731135AbgFROz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730810AbgFROz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:55:26 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44715C06174E;
        Thu, 18 Jun 2020 07:55:26 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id y123so3683401vsb.6;
        Thu, 18 Jun 2020 07:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QxylAeoi1RdijlBolNyB107grl4c0Z6IUSHPzwEZAN8=;
        b=ki5dlN0mkilxusgNHuCfwgy29JDDOpq1TgujbrYbQNfXOzwI8C0icqIfqs/lC8K9Ia
         PCcoa0cSrnuZxlHHkqHWKTPH9QQkD6BrCe8yutaQPmumiINy87ilD+xjKDp/mkFNypiS
         GkwxKzK22AdsnKpgECfQkbl3tmKLAs3HIychOa8WAawaZnMBF7wuQYRD4fjMuF8WtmwU
         4q7cLmQMfAd1qVH2NRBADzyihmK4A1YkxQzRaNK6KUjHCaVC1tC7ST3U23ewQRZaS4zo
         NGLZlszkP+u6CJPhfxqk2BJqkawNzatS6Q0vV1Xu6PQFYT83XPD1V5UFn7Qdz2GpoYTZ
         hZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QxylAeoi1RdijlBolNyB107grl4c0Z6IUSHPzwEZAN8=;
        b=hbCEOBs5Ai+7aItXnN0neUXw/S+eYgBjfYnYUQwk2g3tOZoSa6OrcMRFdRkHlrA8uK
         AfjdfX05tK4BX6Byny1L+jI2EOyWwAgwfNMhVhHU4kS3AP6FSjdqTZ5JtP6aAOI/fPtZ
         p6xDGFlUFAjAswYfCqSTjiyHwTM2gFtCC25wSCoUGY4BpMXFYApUs1ATCvN65MKmdhEU
         5ncIcu8YAbOIx9RVBnSZtv1+hu2TckqpUxKO57a2IWgo21+vwqhOqmi/qCSRNmZ5h3oS
         v0R034lTY0KK2abqdf35WX7n8BlnXhbE7XD9cyCc/eVtQblvHRZf21tU0jvXu3mClMH8
         XR8A==
X-Gm-Message-State: AOAM532ec16qIwusg192SuOuWJ7AJEkQQabxlKAjMf8BKVH17AcmFcj9
        ZtxPied9B+Dea02ETJS/hEysDVZmM8QMRBX9INU=
X-Google-Smtp-Source: ABdhPJwGPoTdNqsFnfWoNVKcc8wCaayYTmBRc/ZAt524J9s5mS5Y0GSYU21bnLR9hJWqiCMS84Agwtf/yrj0pwTFOjI=
X-Received: by 2002:a67:c511:: with SMTP id e17mr3467953vsk.210.1592492125322;
 Thu, 18 Jun 2020 07:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200617162536.611386-1-jim.cromie@gmail.com> <20200617162536.611386-22-jim.cromie@gmail.com>
 <20200618124400.GA7536@alley>
In-Reply-To: <20200618124400.GA7536@alley>
From:   jim.cromie@gmail.com
Date:   Thu, 18 Jun 2020 08:54:58 -0600
Message-ID: <CAJfuBxyw7v=uQFMLHbsP_MAub7DFZOto6SnU71upXZDcK9L9QQ@mail.gmail.com>
Subject: Re: [PATCH v3 19/21] dyndbg: extend ddebug_parse_flags to accept
 optional leading filter-flags
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 6:44 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Wed 2020-06-17 10:25:34, Jim Cromie wrote:
> > Change ddebug_parse_flags to accept optional filterflags before the
> > required operator [-+=].  Read the flags into the filter_flags
> > parameter added in the previous patch.  So this now supplies the
> > filterflags to ddebug_exec_query.
> >
> > filterflags work like query terms, they constrain what callsites get
> > matched before theyre modified.  So like a query, they can be empty.
> >
> > Filterflags let you read callsite's flagstate, including results of
> > previous modifications, and require that certain flags are set, before
> > modifying the callsite further.
> >
> > So you can build up sets of callsites by marking them with a
> > particular flagstate, for example 'fmlt', then enable that set in a
> > batch.
> >
> >   echo fmlt+p >control
> >
> > Naturally you can use almost any combo of flags you want for marking,
> > and can mark several different sets with different patterns.  And then
> > you can activate them in a bunch:
> >
> >   echo 'ft+p; mt+p; lt+p;' >control
> >
> > + * Parse `str' as a flags-spec, ie: [pfmlt_]*[-+=][pfmlt_]+
>
> This interface is simply _horrible_ and I do not see a point in this feature!!!
>
> I as a normal dynamic debug user am interested into:
>
>    + enabling/disabling messages from a given module/file/line/function
>    + list of available modules/files/lines/functions
>    + list of enabled modules/files/lines/functions
>
> I do not understand why I would ever want to do something like:
>
>    + enable messages that print module name and line number
>    + disable message that does not print a module name

messages dont print them, the flags do, according to USER CHOICE.
a developer who is deeply familiar with the code doesnt need to
see most of it in the logs, average user might need them to comprehend things.

>
> In fact, IMHO, all the 'flmt' flags were a wrong idea and nobody
> really needed them. This information in not needed by other
> printk() messages. Why pr_debug() would need them?
> They just made the code and interface complicated.
>

it looks like they landed fully formed in lib/dynamic_debug.c
probably because that was a unification of several different print
debug systems.

you are free to set them globally:
echo +fmlt >control

or just the ones youre using
echo up+fmlt >control

> Please, stop all this non-sense!!!
>
> Best Regards,
> Petr
