Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FCBC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C65B20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="of3NEExB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgBFSWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:22:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37476 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgBFSWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 13:22:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so1185656wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 10:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9qzkt0YHl1j1zQLYfgUtStKm8RvBNZBr/cpsyPQQSI=;
        b=of3NEExBfV2fM3I7sikgdT51i48Le7uGtsh0aom2rPnbXnlRVzXZslTrwBengkOpRM
         xzK9PhZ54PL14asPAWbWPNlJ0XAfSFKw6J6kaRrdWkqiEuWbJK8SFRCG9HF0bvux/Xuh
         3qKGCz/THV4rH4Oatl7fJiyyny9fVGqB3mVVzR4/VWmnxFJCgEddpFJ8btmrPAKOKttM
         on1g6h5SGxVJj/KVPgMz8gWdgpHugVI7ovgGKwP4yJtjPtt8mmIkspa3iqgztzpXaIje
         S4GLKh1iz044JTZVSGbLejM9DJIpQQXbTamJ3tlthKcVWzCAzNm95u5mI5/OTy+hRRdA
         6A2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9qzkt0YHl1j1zQLYfgUtStKm8RvBNZBr/cpsyPQQSI=;
        b=Q/M12ejfs0WOsXr7DxIcyDBTrMS59NI8N9Rul01hsOBPkpXw7dW3VpHIxEg/gQHY0i
         8zwVwStV5/1PkvpBTMg+J0GEDtesiCFPBPT2WBnIt0REkSIXQblFkOXM5ko7ylRSo3yp
         +0Eq/zanohHig3HyFzbUuNhp6zhJ+ETWw7fuKTAs+4oKN/6jjyjFV3l6AQ4RAYFm++aA
         SkMgqSKEDlfvazRV48kHbX0g6PM15rUBRbCW/mveYhIITXLTaFRgNwTR28Ijm05XCNj1
         10EtcQlSKVE/INAbjUDPrcnPPYfApL2LwTPV7DfrEJY0qyBM8dPEs1LPiqc2DLWGoHxL
         pVTA==
X-Gm-Message-State: APjAAAUkUlbKCWMoLJyUpvcAAxjUELD09beCDfyTeJIWS/fGg6+vP2Gd
        b0CPCsTdkt9dlJ7rmdzu9GXqjMCPhDvTjReEszbKtA==
X-Google-Smtp-Source: APXvYqxWWrye1vWcP96iwDxzT2tJqI9xuz4NXwRoyq4OWYzF4N+GWFWa2hejgtOa5MtGKqBmdpTXY7Rv6Aq3NkdTIf4=
X-Received: by 2002:a7b:c119:: with SMTP id w25mr6125664wmi.112.1581013330505;
 Thu, 06 Feb 2020 10:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
 <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net>
 <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
 <4f382794416c023b6711ed2ca645abe4fb17d6da.camel@sipsolutions.net> <b55720804de8e56febf48c7c3c11b578d06a8c9f.camel@sipsolutions.net>
In-Reply-To: <b55720804de8e56febf48c7c3c11b578d06a8c9f.camel@sipsolutions.net>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Thu, 6 Feb 2020 10:21:59 -0800
Message-ID: <CAKFsvUJu7NZpM0ER45zhSzte3ovkAvXBKx3Tppxci7O=0TwJMg@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     richard@nod.at, jdike@addtoit.com,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-um@lists.infradead.org, David Gow <davidgow@google.com>,
        aryabinin@virtuozzo.com, Dmitry Vyukov <dvyukov@google.com>,
        anton.ivanov@cambridgegreys.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 12:03 AM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Thu, 2020-01-16 at 08:57 +0100, Johannes Berg wrote:
> >
> > And if I remember from looking at KASAN, some of the constructors there
> > depended on initializing after the KASAN data structures were set up (or
> > at least allocated)? It may be that you solved that by allocating the
> > shadow so very early though.
>
> Actually, no ... it's still after main(), and the constructors run
> before.
>
> So I _think_ with the CONFIG_CONSTRUCTORS revert, this will no longer
> work (but happy to be proven wrong!), if so then I guess we do have to
> find a way to initialize the KASAN things from another (somehow
> earlier?) constructor ...
>
> Or find a way to fix CONFIG_CONSTRUCTORS and not revert, but I looked at
> it quite a bit and didn't.
>
> johannes


I've looked at this quite extensively over the past week or so. I was
able to initialize KASAN as one of the first things that gets executed
in main(), but constructors are, in fact, needed before main(). I
think it might be best to reintroduce constructors in a limited way to
allow KASAN to work in UML. I have done as much testing as I can on my
machine and this limited version seems to work, except when
STATIC_LINK is set. I will send some patches of what I have done so
far and we can talk more about it there. I would like to add your
name, Johannes, as a co-developed-by on that patch. If there is a
better way to give you credit for this, please let me know.


-- 
Patricia Alfonso
