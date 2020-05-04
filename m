Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1360C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81B882073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY0BX8QJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgEDDJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 23:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgEDDJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 23:09:23 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0E4C061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 20:09:22 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id v18so7697387qvx.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 20:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IjhzQ3oHa9nNeIuiLupnxo7YU2u+0fWxdlUhWitx3YU=;
        b=VY0BX8QJL/Ls8mKkxdOnZWoc/16ZP/mvIQfcoHIcj1h/K2Q2zQh4jUPwqUTBdL0/gf
         B/V3IiNsa7a7TQFt2egmpLSRf7jrnXzSaQhRP4vAamVcc+66FrZSPEWYVrbYuzcEC126
         damw8M1AurzoePG5McVEwdfx+HHJ78R3X9+vqJUwrzBP8PW0VmM2UDFvA0LhACCwFWa5
         ZENGXzZ+BPVX7AgJElbGuJdcFA3A8KksJ9U8cDmfCbVNyEBLTxim+YNdRHfgkjJFHz+Q
         rCyOz/nrabbolc5/vqm39RXSn6Yy3h00G+9J0rJ0pter4I7xyDYZ0RNdDJM8oMXAF9Bg
         Wa0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IjhzQ3oHa9nNeIuiLupnxo7YU2u+0fWxdlUhWitx3YU=;
        b=Qg4Gcs3QVyC3wEJnQNa5Kaij9jZoSSARr/VnouOvUA/4f5qdUkT59YaR2GHnsM+FTB
         1iO5/161r8CUMvyPGc3R+WL7/k1R+NJjh0GTGQP/5xN1D7imPeoxL3v4xBsSCRZNmNnZ
         vPHEWVQ22Hujtwnc8YNCh/8jZ65Ij7T+7dPFCnFu6u9uSGRQ3GoAtrfanrXBIvJQwJT6
         iN01Ci5hfGxkk1vuHYIz1q0z0jUGMXw3ADu3Q0P7XT4VVMiBDjA673KEHXOO0GQJ5gh1
         B0gVCZU+8IDZbqkISxGeJJdfRo2D9QBGKGOUy/rmB26aTf7Hf9Ao75Yh3U7lWpZZ/HFn
         rvwg==
X-Gm-Message-State: AGi0Puavg8FqKXGfQ1Mqx0fxV3OIcczQYGuKNyHhf4hWQs7X+fgePB40
        YDxI/IapD4gBeZbIE5s8CIVb9asuKXnRHC/9n/g=
X-Google-Smtp-Source: APiQypJZnb1KhKURAZgc+1wjYSttxzA52ie++9Xhfq/pqC2ENO5/rrIWom4CorrSsaCSFMI4ZXJjRxkFSBOB8lhbrz8=
X-Received: by 2002:a05:6214:7e1:: with SMTP id bp1mr14347599qvb.208.1588561762103;
 Sun, 03 May 2020 20:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20200429184711.9d603da097fdea80f574f1f1@linux-foundation.org>
 <CAAmzW4NC4LHXSoU8r6Jrh7WP8fouuaSkM--0gQVWf8G4wkDupg@mail.gmail.com>
 <20200501105545.GA29460@infradead.org> <CAAmzW4M+EoPqhossgJKxpZ_5=uto1jXK56qYmUd6SNKmbswuJQ@mail.gmail.com>
 <20200501123429.GA26861@infradead.org>
In-Reply-To: <20200501123429.GA26861@infradead.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 4 May 2020 12:09:11 +0900
Message-ID: <CAAmzW4Mcar3PfL+_VV66hxJ1H2rMJxskiJ7JYvcbWp4yRYyXvg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] change the implementation of the PageHighMem()
To:     Christoph Hellwig <hch@infradead.org>
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
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 5=EC=9B=94 1=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 9:34, Ch=
ristoph Hellwig <hch@infradead.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, May 01, 2020 at 09:15:30PM +0900, Joonsoo Kim wrote:
> > I think that PageHighMemZone() is long and complicated enough to have
> > a macro.
>
> It is.  But then again it also shouldn't really be used by anything
> but MM internals.

I'm not sure that we can make it MM internal but I will try.

> >
> > PageHighMemZone(page) =3D is_highmem_idx(zone_idx(page_zone(page))
> >
> > Instead of open-code, how about changing the style of macro like as
> > page_from_highmem()? What PageHighMemZone() represent is derivated
> > attribute from the page so PageXXX() style may not be appropriate.
>
> Maybe page_is_highmem_zone() with a big kerneldoc comment explaining
> the use case?  Bonus points of killing enough users that it can be
> in mm/internal.h.

I will try to kill page_is_highmem_zone() as much as possible in next versi=
on.

Thanks.
