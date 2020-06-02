Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE07FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954E1206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591118311;
	bh=tb+xyliGtwI1tI3gv1PbxDFbgWXAWbvy+WEHLVNEd4k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WIRrRWNJimkLnlKkHgL6mrJdArt1uu8gr4R0+gsPj70hAXYxcBs3jJMqAQYdq95DV
	 NCySj2dVNpzrpBcO6KqlPceH6/U/ztVohLDV1adncAAsLVYcMMvOSbGeK8unF4KSBf
	 qQaHBzwJ2ugLjnLwPZVhm43Fx1sGy0rsSoc3Drr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgFBRSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgFBRSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:18:30 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7CDC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 10:18:29 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s1so13561332ljo.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 10:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SNRBsgEhndaWfJkwxqUhFkYrHA7Z2jK8v+SKAjBpMrw=;
        b=cHeKntEgM3HiICfht/pnCtDkCgAraRt+vGaiFUa0rbQQRGNJUmWfN31GQWT3/8Ltqs
         xGyw9NW6GGE0qRN1zYrj5A1Lp+0See6177U9da0iJoS/+M/e7Y5lNanIyNFQmxAWsbyv
         Eqfz4HZv3uqTzo08M9Ioc36wztuAz4V5eRnsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SNRBsgEhndaWfJkwxqUhFkYrHA7Z2jK8v+SKAjBpMrw=;
        b=CyQYqm9llH+3WxHf695FZk6apRwXDz7WLPlU2x7L7aAiEjLVW5kUpRreZJScoTfXgw
         N/9TpHYyumm3EYNL3tH//H6EjYKyK/Qe98ZTamiQAwbtimUEPi8FJRMnowSNyuFyKeQz
         AJxUeSxM6w/ax7J/I5ql7MC6QIKRu72/p0H/9AcWfcjdQjHkMB6K6iQthXVzjvGlpP4r
         PM4jHZ4qHZgtuhAP5zvWbCAoDO7Bu5J3wCYzUMxG61cbd5YggeqiX4BITcygyDGVfQQS
         22i6QR0eQF3WbozYSyqI9MTrqqZbWB/BMfcILCRM/KWRq1JZnC576C3Trwe6IRqbf4gx
         M+/g==
X-Gm-Message-State: AOAM533QlJEnNkQH618m0T9ujyIgdo++Qn8/CioJpnWF9v/K2agmtBP9
        XlWZiMUhAsCJeajDbJ6U7gtI6uDEMMA=
X-Google-Smtp-Source: ABdhPJwOIduOFZ6kagwqT/yacvlbCvW/gbjhQb1UutOooBbqXIVA1Sr69aQgchkn00CpczqlqlS2WA==
X-Received: by 2002:a2e:a0cc:: with SMTP id f12mr85216ljm.250.1591118307263;
        Tue, 02 Jun 2020 10:18:27 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id c5sm661891ljj.37.2020.06.02.10.18.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 10:18:26 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id z206so6647306lfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 10:18:25 -0700 (PDT)
X-Received: by 2002:ac2:504e:: with SMTP id a14mr235578lfm.30.1591118305358;
 Tue, 02 Jun 2020 10:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200602084257.134555-1-mst@redhat.com> <fc204429-7a6e-8214-a66f-bf2676018aae@redhat.com>
 <20200602163306.GM23230@ZenIV.linux.org.uk>
In-Reply-To: <20200602163306.GM23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 10:18:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgg0bpD0qjYF=twJNXmRXYPjXqO1EFLL-mS8qUphe0AQ@mail.gmail.com>
Message-ID: <CAHk-=wjgg0bpD0qjYF=twJNXmRXYPjXqO1EFLL-mS8qUphe0AQ@mail.gmail.com>
Subject: Re: [PATCH RFC] uaccess: user_access_begin_after_access_ok()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 9:33 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> >
> > It's not clear whether we need a new API, I think __uaccess_being() has the
> > assumption that the address has been validated by access_ok().
>
> __uaccess_begin() is a stopgap, not a public API.

Correct. It's just an x86 implementation detail.

> The problem is real, but "let's add a public API that would do user_access_begin()
> with access_ok() already done" is no-go.

Yeah, it's completely pointless.

The solution to this is easy: remove the incorrect and useless early
"access_ok()". Boom, done.

Then use user_access_begin() and the appropriate unsage_get/put_user()
sequence, and user_access_end().

The range test that user-access-begin does is not just part of the
ABI, it's just required in general. We have almost thirty years of
history of trying to avoid it, AND IT WAS ALL BOGUS.

The fact is, the range check is pretty damn cheap, and not doing the
range check has always been a complete and utter disaster.

You have exactly two cases:

 (a) the access_ok() would be right above the code and can't be missed

 (b) not

and in (a) the solution is: remove the access_ok() and let
user_access_begin() do the range check.

In (b), the solution is literally "DON'T DO THAT!"

Because EVERY SINGLE TIME people have eventually noticed (possibly
after code movement) that "oops, we never did the access_ok at all,
and now we can be fooled into kernel corruption and a security issue".

And even if that didn't happen, the worry was there.

End result: use user_access_begin() and stop trying to remove the two
cycles or whatever of the limit checking cost. The "upside" of
removing that limit check just isn't. It's a downside.

                 Linus
