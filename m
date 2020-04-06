Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FDBC2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8724320781
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qaBk2+HT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgDFNEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:04:33 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33947 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgDFNEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:04:33 -0400
Received: by mail-yb1-f193.google.com with SMTP id l84so8730228ybb.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 06:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hqays/GgCtOUvwT2vqd65B6v/EdiY+pv7CQuSIyzhwk=;
        b=qaBk2+HTmwMXeDkQvZgAbChKseeTvOYD0s6k+kZQI+PzqFj6/pTDGTBqkgNXU3TWBA
         PNuBz09nHXgEmrJb1lJ/db+fFxgHdGEqHbzhkkhDmAADdcs3ujBUL7/fsS9+1yKJrXLP
         S2RQnTHeZa52m287uOjJUrwkXlGpcsK/n/T02tjoAH/U5o0m/CYnjG5lPCeKeeCrrust
         3myXYEK6uLDdm2m1eVbNSMXqQiaQQwFHoJKX7OgxfFlheTE6zuInCGSINWcCdW2PbRmD
         4d0xPAecAxwTiUicAvfOGNS/kJSRGqqjKPjTATFyp/ud4FIUB944l0B8DJ8oo4D9GLPr
         SZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hqays/GgCtOUvwT2vqd65B6v/EdiY+pv7CQuSIyzhwk=;
        b=B99PDlxUCDZf+jg1NtUPaJwSWajVYM2BnZH8f1aNkKT7D9hIoLqOooAQJ6kcmhoEKQ
         pqlK53lRSE1/y7ueIN+DxlUYJig71HDKiLOLkizPWkNOErfbPqgnBtpe4wXEL1gi9Uie
         dStpDruywf1MzPZV6DD5rCw0wvVPQQWb34V7A91ubNaWyUSGe51pNjV5RWnhrpSiFvTd
         ag5iIJbhJjNZsDq3bFBksHAWVx1mtcXtosYmMn4zy3/5jEjwjDu6KPQzOzwZR/szyzse
         nz/+erFQ2sHEsJ3MDoknG4KPCe12QXIaPwoSzFIDAVvP19K6QMDzGa9zBgRMahYz5S1q
         hJ8g==
X-Gm-Message-State: AGi0PuYNtzeT2Ug1fvdgui+BnEO/l0vmP+BkhpeY3cWwlFxayyzP9/tJ
        ihl5Qdg9JZbvPlXvVyLW/vc+CD0cGJSxJyPg/ioLxw==
X-Google-Smtp-Source: APiQypI2IEkYW9hmYrDfNANzdNQ5jVMW479+9pqFos58Wn9zjkZKryk5SxnCwhVQD+cDhAHP9pSOQmeN/x1cix9yEuk=
X-Received: by 2002:a5b:cc7:: with SMTP id e7mr35902157ybr.7.1586178270122;
 Mon, 06 Apr 2020 06:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200326070236.235835-1-walken@google.com> <20200326070236.235835-8-walken@google.com>
 <1c463464-1d72-287e-e785-f077a95ccf20@linux.ibm.com>
In-Reply-To: <1c463464-1d72-287e-e785-f077a95ccf20@linux.ibm.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Mon, 6 Apr 2020 06:04:16 -0700
Message-ID: <CANN689GOqEnLQHD-VNjwhTCwvLWNsRPLmo+yBumzE_y2_YsoMQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] mmap locking API: add MMAP_LOCK_INITIALIZER
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 2:46 AM Laurent Dufour <ldufour@linux.ibm.com> wrote=
:
>
> Le 26/03/2020 =C3=A0 08:02, Michel Lespinasse a =C3=A9crit :
> > Define a new initializer for the mmap locking api.
> > Initially this just evaluates to __RWSEM_INITIALIZER as the API
> > is defined as wrappers around rwsem.
>
> I can't see the benefit of this change.
> The overall idea is to hide the mmap_sem name. Here the macro
> MMAP_LOCK_INITIALIZER() doesn't hide the name.

The idea for the initializer is that it makes it easier to change the
underlying implementation - if we do, we can change the initializer
without having to change every place where it is used. I actually do
that in my other patch series converting the mmap_sem to a range lock.

But you are correct that it does not help with renaming the mmap_sem
field - my next commit in this series still has to do that in every
place this initializer is used.
