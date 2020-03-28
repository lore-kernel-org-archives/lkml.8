Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71A0C2D0E8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E440206F2
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JUObUgRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgC1Ixm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 04:53:42 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:43392 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgC1Ixm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 04:53:42 -0400
Received: by mail-yb1-f177.google.com with SMTP id o70so5956057ybg.10
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 01:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VcMXP9kKkoDSkAWpwZibgZEebuHA/f4VzON6mG+RLvo=;
        b=JUObUgREFSOVke/eCuZ4G+0EhvK+rWozJZgWgkfBGJI9r3P9/Su+o+HTSyZOF67sGH
         dNsRWiQe175l9AU2xXx9XtLB/z02YVC3yoO8/IpiLT9KwTWvnDp/Ctd20VhOjztafiT4
         sqOpbfdwoMNRQuje3GkRUz68A7L2jq3hWBVwMoBXhl01+F2Cyp3vshzhHN1EUoW74G0d
         W11OYDzk9A+MDtAKT6ukIvmZYCcloylK2QR+Dj1XyNbGfdwb6bpnWFQ74D58/2WOKtyo
         VJ0tWCoK0kvzJkT1W8WXQm6Eh8pY16M03mUtqkpP9+cmJ+zCpgMmZ2PpHwE+05+Rj78g
         riVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VcMXP9kKkoDSkAWpwZibgZEebuHA/f4VzON6mG+RLvo=;
        b=uaOMzijkAp+FPAcs0RFatCSdVpl9LWg/YinblxMtgn1JksHhP0BKwcx8aZdXCmjZp6
         4h/4shDLcvPFrSjvsBVeJ1Axwb8UiA3y6Ygj/YkgGSwMZCW5g2CTg8+CFf6H+s4+8UKI
         9wBauyZjA/fajIREQkEl2rz9lZ149yY36x5LHAYPj/7RUfESAPBSxOd0eI7Azb1H346u
         ls/W1Hw6rMtxyk1835qG0HjcyGA9nz/isPbYxcBMTPbySxdQPA9QNJUBBYNyvFiNnch8
         Cm6/tgGVCumFoicIhwAsDBzfpMDH63veIew28oOLXNc5BIbUMhDu9lJACx4CZuClooWz
         rkRg==
X-Gm-Message-State: ANhLgQ0IuGa9JDiXuxSoMsp6P8LdorEJWr82niqPm+9QZFkf5Pem2M9i
        uGKuP/nwYlKkpye8DfZ9KEbr2uGzH8CoLD6CNc63cybcuhIDBg==
X-Google-Smtp-Source: ADFU+vvlKy21P6FfgcE5xtIgg+AHvek5xsesheRSeKeLs8jWRYEgjd819dYreTrbjtVaRkYNPaWsh6pk+FIFDnb7KD4=
X-Received: by 2002:a25:ccd0:: with SMTP id l199mr4734314ybf.446.1585385620467;
 Sat, 28 Mar 2020 01:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200327225102.25061-1-walken@google.com> <20200327225102.25061-6-walken@google.com>
 <bc2980d7-b823-2fff-d29c-57dcbc9aaf27@web.de> <CANN689H=tjNi=g6M776qo8inr+OfAu8mtL5xsJpu4F=dB6R9zA@mail.gmail.com>
 <3c222f3c-c8e2-660a-a348-5f3583e7e036@web.de>
In-Reply-To: <3c222f3c-c8e2-660a-a348-5f3583e7e036@web.de>
From:   Michel Lespinasse <walken@google.com>
Date:   Sat, 28 Mar 2020 01:53:27 -0700
Message-ID: <CANN689HyS0dYWZw3AeWGBvN6_2G4hRDzjMJQ_adHMh0ZkiACYg@mail.gmail.com>
Subject: Re: [v3 05/10] mmap locking API: convert mmap_sem call sites missed
 by coccinelle
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 1:39 AM Markus Elfring <Markus.Elfring@web.de> wrot=
e:
> > I would be interested to find out why coccinelle wasn't able to do the
> > last 1%, but only as part of a long-term learning process on getting
> > better with coccinelle - =E2=80=A6
>
> How will corresponding software development resources evolve?

I don't think I understand the question, or, actually, are you asking
me or the coccinelle developers ?

--=20
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
