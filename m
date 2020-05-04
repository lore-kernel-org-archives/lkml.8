Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61E0C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7844B20643
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxO6t7Oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgEDDKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 23:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgEDDKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 23:10:47 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6908C061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 20:10:47 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b1so12934686qtt.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 20:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=djdavoQlcMLn5fwkocDKSySG9/s4rpsKXrcEkGBqZtM=;
        b=JxO6t7OiVJ9V+sTQLoAhyesCPGBIuVvDmmYlLKr3sdHIf8eMOh33WbSn4oSpSxe9kt
         DkGQ47zPKxiLN/kcbUmS6XQubKDGI+aK2+byzYZ+urMwyraSqFKqOZvW9biaFuGG9TkI
         PERI5mzAX92ADFzn3vFY1/Fk4ikYInzKveDmYqdVLdgiE2hCvPmB65FTB/pm3B9mH5oh
         DQTGZyokcz7dtCQZOFNKwYvmK3jDC9AWYDht3LqKDobIK2kAiIDev0gy+apZvilxHd+B
         nuBm+cQoJZ1TmX5xi1B7drJN5XSW7AHtNteAGvA4BpDIH1BsocQ8uM+Ps9XfkeWxotL3
         yQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=djdavoQlcMLn5fwkocDKSySG9/s4rpsKXrcEkGBqZtM=;
        b=Rc27+gZrj4D/dXTlIjj/hB1D6iEzL/m1YX/zYDH4SDKWZbJ+l/82p5OUfEIxoLM+fg
         mPD4QIVCB9EygywHOwFKytdtyn+HfxB2+beRLiUv/HBfkmJoC0vVZn3XISYzSbtACzvO
         h8LYVpgmysJSlk+osohfhBLGaBemW3WRdiPyMftYtJ4HAONq/pDDDk0qNbnpX07wzPlK
         6SiTvW3EhuLiuzfjDXACPufKny6DHH5wBZT7Ic+nfu3oC/E5HO+SMB2cqBqzjSYrgC+8
         udbyVZQhdCfXGpvUICSuDdYc8UNh43ANM31i8LcIrOqRRTMejfzybesUX/dnTVNR7IFm
         mJ6Q==
X-Gm-Message-State: AGi0PuaKdSg9MUJKXkHvRGGxLLOupfSiVigbgKkRFa4MXNqeX57VNXEQ
        DVeO3LChbWtr/7Qtl+tIs/Yp8ua6GowOiwE2Pkw=
X-Google-Smtp-Source: APiQypII5oOpAZnu/kUOCT9v27QOYf/JDwOsDN8bjeVxSk9v0jhihGUsVnH4lMddwFnO48fu/WRr97gOyTuhWfXtY4w=
X-Received: by 2002:ac8:2a70:: with SMTP id l45mr15345878qtl.232.1588561846918;
 Sun, 03 May 2020 20:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1588130803-20527-4-git-send-email-iamjoonsoo.kim@lge.com> <87h7wzvjko.fsf@x220.int.ebiederm.org>
In-Reply-To: <87h7wzvjko.fsf@x220.int.ebiederm.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 4 May 2020 12:10:36 +0900
Message-ID: <CAAmzW4MrD75+Prw=fQ=d5uXKgGy3urBwmxnNtoNsw5M1m9xjYQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] kexec: separate PageHighMem() and
 PageHighMemZone() use case
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 5=EC=9B=94 1=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 11:06, E=
ric W. Biederman <ebiederm@xmission.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> js1304@gmail.com writes:
>
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > Until now, PageHighMem() is used for two different cases. One is to che=
ck
> > if there is a direct mapping for this page or not. The other is to chec=
k
> > the zone of this page, that is, weather it is the highmem type zone or =
not.
> >
> > Now, we have separate functions, PageHighMem() and PageHighMemZone() fo=
r
> > each cases. Use appropriate one.
> >
> > Note that there are some rules to determine the proper macro.
> >
> > 1. If PageHighMem() is called for checking if the direct mapping exists
> > or not, use PageHighMem().
> > 2. If PageHighMem() is used to predict the previous gfp_flags for
> > this page, use PageHighMemZone(). The zone of the page is related to
> > the gfp_flags.
> > 3. If purpose of calling PageHighMem() is to count highmem page and
> > to interact with the system by using this count, use PageHighMemZone().
> > This counter is usually used to calculate the available memory for an
> > kernel allocation and pages on the highmem zone cannot be available
> > for an kernel allocation.
> > 4. Otherwise, use PageHighMemZone(). It's safe since it's implementatio=
n
> > is just copy of the previous PageHighMem() implementation and won't
> > be changed.
> >
> > I apply the rule #2 for this patch.
>
> Hmm.
>
> What happened to the notion of deprecating and reducing the usage of
> highmem?  I know that we have some embedded architectures where it is
> still important but this feels like it flies in the face of that.

AFAIK, deprecating highmem requires some more time and, before then,
we need to support it.

>
> This part of kexec would be much more maintainable if it had a proper
> mm layer helper that tested to see if the page matched the passed in
> gfp flags.  That way the mm layer could keep changing and doing weird
> gyrations and this code would not care.

Good idea! I will do it.

>
> What would be really helpful is if there was a straight forward way to
> allocate memory whose physical address fits in the native word size.
>
>
> All I know for certain about this patch is that it takes a piece of code
> that looked like it made sense, and transfroms it into something I can
> not easily verify, and can not maintain.

Although I decide to make a helper as you described above, I don't
understand why you think that a new code isn't maintainable. It is just
the same thing with different name. Could you elaborate more why do
you think so?

Thanks.
