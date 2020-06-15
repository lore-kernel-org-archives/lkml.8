Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D720FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9F8F207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alsetzwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbgFOUvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbgFOUvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:51:03 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DED2C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:51:03 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id w20so6172960uaa.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CRdCEDBFsemOGqYAvEiPbOTW3ZUWqB86Y8kM4dxKrgw=;
        b=alsetzwTb0qaWQq7mITdJt96B9vvSKwUZ6Nb8rkNR8SlkcO1AdePBXaopcgvqmrtd6
         2Dlw0kNOxor6Xr4csselybI4a2yznFbWxlZMeYN1GwVyUu3nGccsh0WOwvSYPNBEuJSq
         cc3QsME6XPiAp2N0PMA66AbxLUUX/1y4r+YSoHJIMaQsDHpw2IPAAMk4UAFScE+07/eI
         EAdNQl/fgNURZBUlzsp7IGcYzBQ+FU3fbOfoAPVSU84XGIUCKsTFvbtdirRnub/dmSez
         IEFvDQEU0jbjHzX5X2k59kJpNT6XCWHJl1nMRdW5oelba9tiaGkJOmxSEtFX/pmmI32K
         f3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CRdCEDBFsemOGqYAvEiPbOTW3ZUWqB86Y8kM4dxKrgw=;
        b=SoytAV3wyG6TnORcQJ1E79CYtx/OnNnWYe4k8Ntp1c++QRM/a8F2CW6WlKno7SuzJq
         cFaDg5m48QRP6NdB2dWCGKCI8s1Q7W6SsAIm6BvYUwA37KIjfLJZAlHIUx/rPJZXmLI9
         jfUNdixi+jLl2vcaQpUXD0cqOkSPX7Pf46J0SObyxeRvRubGJ4dpPbcZbOwgEXIuE8+u
         y7GdwdhZwqaMyclOgZ9s+mD5mjTRj8wNpvKgIV9zsayqop9Puc0QINJeoON2VDHqG93E
         V273/uIztjOL+rXItVyViIZBQCyGIPEdO/aoYzS1fF6rboPvyMqJAyuxfnIcwoqNc6aX
         qBwA==
X-Gm-Message-State: AOAM533ZWMThkAb3LVwesRvSnEfj5+5+i4N/n4NIT2otbax4vmcpQlwp
        UFVuG8oqIZ7fKeZg5isZqF1cRU1vhy65CzkLE4Y=
X-Google-Smtp-Source: ABdhPJxKVrqAH3MBhNnTloHggPE1qwlCBpKchgwRA7XjS0K8F1vDKxqF4h3LgRLImhwS/i330jzcV94OqcqUd1JTPRU=
X-Received: by 2002:ab0:30d1:: with SMTP id c17mr16028511uam.142.1592254262514;
 Mon, 15 Jun 2020 13:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-10-jim.cromie@gmail.com> <030bb11d193d13a2d1c161a133bb7b88093a1fe9.camel@perches.com>
In-Reply-To: <030bb11d193d13a2d1c161a133bb7b88093a1fe9.camel@perches.com>
From:   jim.cromie@gmail.com
Date:   Mon, 15 Jun 2020 14:50:36 -0600
Message-ID: <CAJfuBxz1mPVrpZQvS2NM-pD+6h+tvE3gT6H=pMF0KxvrFCqTsw@mail.gmail.com>
Subject: Re: [PATCH v2 09/24] dyndbg: add maybe(str,"") macro to reduce code
To:     Joe Perches <joe@perches.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 10:14 AM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2020-06-13 at 09:57 -0600, Jim Cromie wrote:

> > +#define maybe(str, empty)    ( str ? str : empty )
>
> This macro is unnecessary.
>
> An even shorter very commonly used gcc extension would be
>
>         str ?: empty
>

ooh yes.  I'll do this
