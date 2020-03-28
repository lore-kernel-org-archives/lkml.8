Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735F8C2D0F0
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 07:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4889D206CC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 07:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WOVV8fRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgC1HrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 03:47:21 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35784 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgC1HrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 03:47:20 -0400
Received: by mail-yb1-f196.google.com with SMTP id x63so5924201ybx.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 00:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jl+BpbHZ/7r9CkbFROQ9el447QHzytPcgY1mfe7n2I=;
        b=WOVV8fRn0QHeIZLcDiHRypp+CZ74Q7ALHPvHpNEf9Y72LLtBAWPEWhdu1+WfMmSslm
         UWERIzqxKzdnY73jCAj7ReOrGf9m58xY5hJxs0UaAj7e2o8D0tsas4KPyi2OOFj72j42
         NcPNtcWWUeBSr0/fk6cAAnyzC0H1eLxJaBRjwjuZc4J6XKHlXGGVoUX1KsEM0hbZByjM
         IyS69XD5dopcswpVYiQCH5U4YbxNbvaNyXdpA2Jymn71KM7rMcTt02v5bCIDEmmRiPqa
         K+m9WQstmHWeSar87A5wR2lcItFBo/9UVt4aYJC3p7uxeZDf6bMcSe5NkkFbByv2Dkpq
         0dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jl+BpbHZ/7r9CkbFROQ9el447QHzytPcgY1mfe7n2I=;
        b=sjuIUBrX0rbdrU7QiCYYCv4P6o71m4xjhXDSsxqZyT1qgDZ8414WeyLHmRX4yeAszE
         CeAxUvdnHUt3M0OEoqwZ87hTre2wZETzrrriX28hK2UiaNDR4Cb8elSvgvbBy/oafOWn
         UEw5cMkEPXC/997dqJBuZEWUOorDD3liFJZ7vPvvPj89H4vZFeu/jCsdZNSnvtoAt0/b
         4BWbaE2y3dV/T+AsaLj5j2xzQdCx2Nb+K1ke+nyuWIyKZArYepcFk9uxiB4WyTQ+6eia
         fZCblALZyhZB7elaCh9qpsZlMd7MJ6PxGXAN7XQ4E7Dhgh4P6Sb14xBG75w4fSQr0ldy
         M7lQ==
X-Gm-Message-State: ANhLgQ3lJaQFox3T2xCCsMpPns804Xv34BgFyzk+BXuiVEGnjSG3podI
        /nyxy5yE7s/o0gDuDdCKDotBYk3VtoAG1BSdxA7iLw==
X-Google-Smtp-Source: ADFU+vszhRv5ayaRSxIAK9LsFFYzkpzCnkWSEHJUDdkTE99yJa1AGlFn/ETcRFmuPn19IzHAqxLW++TFE8J8+cyA28Q=
X-Received: by 2002:a5b:4ce:: with SMTP id u14mr1565259ybp.518.1585381638995;
 Sat, 28 Mar 2020 00:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200327225102.25061-1-walken@google.com> <20200327225102.25061-6-walken@google.com>
 <bc2980d7-b823-2fff-d29c-57dcbc9aaf27@web.de>
In-Reply-To: <bc2980d7-b823-2fff-d29c-57dcbc9aaf27@web.de>
From:   Michel Lespinasse <walken@google.com>
Date:   Sat, 28 Mar 2020 00:47:06 -0700
Message-ID: <CANN689H=tjNi=g6M776qo8inr+OfAu8mtL5xsJpu4F=dB6R9zA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] mmap locking API: convert mmap_sem call sites
 missed by coccinelle
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Coccinelle <cocci@systeme.lip6.fr>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

On Sat, Mar 28, 2020 at 12:37 AM Markus Elfring <Markus.Elfring@web.de> wrote:
> > Convert the last few remaining mmap_sem rwsem calls to use the new
> > mmap locking API. These were missed by coccinelle for some reason
>
> Will the clarification of this software situation become more interesting?
>
> > (I think coccinelle does not support some of the preprocessor
> > constructs in these files ?)
>
> I suggest to omit this information from the final change description.
> Would you like to help any more to find nicer solutions
> for remaining open issues?

So, from a practical perspective I think coccinelle has filled its
purpose for me - it got 99% of the job done, and I had to do the last
1% by hand which is not ideal, but really not too bad either. Also, by
using coccinelle I think reviewers can appreciate that the
change is purely mechanical, and reproduce it on their end if needed,
which facilitates the review process greatly.

I would be interested to find out why coccinelle wasn't able to do the
last 1%, but only as part of a long-term learning process on getting
better with coccinelle - I don't consider it a blocker for short-term
progress on this patchset.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
