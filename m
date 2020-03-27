Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0876C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F2320716
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kwk8Dwxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgC0II5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:08:57 -0400
Received: from mail-yb1-f170.google.com ([209.85.219.170]:44874 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgC0II4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:08:56 -0400
Received: by mail-yb1-f170.google.com with SMTP id 11so4066331ybj.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 01:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XiMf0KkPfznb6FzIwAvwq95s3d+SISV4oAUy80r1jBU=;
        b=kwk8DwxxgB7iwpHOeQc9TXfa94ZbGOPhFuvPq1S3Mpcavp3kszwj6w9nEZo+gpMGuj
         +aaanYNyZyMeDwoV5hKoDUiJ7wQOKxthh2JaS43zDcZ5mHf3hYvR62d33ymy5Pqvh+jE
         Kj7uGc825KQsbcuH3K3a+rL2ch0upA7s1bXe/AygGRuYR3UrleRTCY6T+7rSWgnarSX3
         /yqgu31cmz6UG0j3lQz80CHEDscl/v8RMIaJ7PMOx9j8w5Eu/ufGcMShf3hc47iS6fys
         fjXDuDiNfDkbEJ4auU7FFp5EhU69N+ddqIxRdplVx1V/MSSKG+1vfEUVsI3aD3mqxAly
         I7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XiMf0KkPfznb6FzIwAvwq95s3d+SISV4oAUy80r1jBU=;
        b=DfcUGwfo+rmXEMXVMT0OvMTHmo82QxWZwCccDc5FrzOSKkCeQA0WjmSFQOYV6Pwmsx
         kTLnqIn/Ks693/08VbWT7mL4JVZhQAR0QhQQERVpw9S7pP+HrOOEfVXwG3WFvWRWbE7G
         087q7NM9YOuQWWJVa82lMpSIJkvAeNcco6G3rTzonrSDBUsiMHjiw8Kcb5tuLfut/bAv
         0Get6JNgF5BbpQ8lqk31oDWcZszJXNr2/pM4oCEjk9tPLvusO6li9lgHTKeqK6LS51Ki
         AqWzjlBoJkZ4tbfBaIVPxbOs9l6J8Ym8EmkCP/qIvt71uImjxeqIAeHWYm7bbKmNmxXv
         GMfw==
X-Gm-Message-State: ANhLgQ15ZssInA/dvxpv9eZd0KMJRxlbcgHNg3uRNguO2MjHsVxz2xXw
        8SpX4FuahDr2oixpwzd4sN8rJ8PBWu0sONHuKwYCTw==
X-Google-Smtp-Source: ADFU+vvVq0fsXgz6sgEvSt1ud/23H5X6PO3tAJOOpxVg7c9hJFoFeSYPNiP1hACneWrUMhEi8KHKQQnpElzByJhAOEI=
X-Received: by 2002:a25:15c8:: with SMTP id 191mr3376784ybv.452.1585296535460;
 Fri, 27 Mar 2020 01:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200327021058.221911-1-walken@google.com> <20200327021058.221911-5-walken@google.com>
 <d780d91f-43fa-b2ec-1a08-80013b153a56@web.de> <CANN689E-SZhv3tvYc11cNuvGwCi1V1n1ztAnLkUPGvvz7C85dQ@mail.gmail.com>
 <bc15b633-68ab-a121-53c6-32972ef1ad9b@web.de>
In-Reply-To: <bc15b633-68ab-a121-53c6-32972ef1ad9b@web.de>
From:   Michel Lespinasse <walken@google.com>
Date:   Fri, 27 Mar 2020 01:08:43 -0700
Message-ID: <CANN689EG-mYEUvfqHQQm_TBYtu0VSuVsWz3R5LnTOkAHW=4b+g@mail.gmail.com>
Subject: Re: [v2 04/10] mmap locking API: use coccinelle to convert mmap_sem
 rwsem call sites
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Ying Han <yinghan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 1:00 AM Markus Elfring <Markus.Elfring@web.de> wrot=
e:
>
> >>> The change is generated using coccinelle with the following rules:
> >>
> >> Would you like to apply only a single SmPL rule here?
> >
> > I think this version of the patch is already a single rule,
> > similar to what you suggested ?
>
> Yes. - But you repeated the wording =E2=80=9Crules=E2=80=9D in the change=
 description.
> Are there any other software extensions still in the waiting queue?

Ah yes, I did not change the wording before the included .cocci file.

I do not have any more coccinelle patches to push in the near future.
