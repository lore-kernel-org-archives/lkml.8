Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF3DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8228C2073E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwdqCTnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGCAyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 20:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgGCAyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 20:54:35 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94250C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 17:54:35 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w34so2731882qte.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 17:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gmp3Sx0pjIvLynX6ju8pg2+6n+L9gz/8CB7hRCXkhfk=;
        b=fwdqCTnZCLxC184dA8HxziJBoAe0zO52Ae1M2LCViDgVE+qlKTRZt5IInzpUEVU5Jx
         XXWbiMOEeY5wBa9HQH6Kz2c65qVpf2wc6V50kEx/KgToQCtAwOizLd/F+crebi7LZZEF
         dRAV7gt1RcMoOPuOjKvT7UrQivfvxZzpnOWrLoXPMBhrxrt0bY3oxOYd6gEQKEUnMpG/
         +gLfJqft9x6XvsJd4AUg7/jlfZKZrxkgeiyfFBNPnb5rmtnvkdUth0fJp1lK/XQ3LIkM
         CKggfbt431MdbhyZWRFMASmWg46z3NdY90ZDn/eOFrl26NFhvpyp+M3Sp9TtJnI+3noY
         uDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gmp3Sx0pjIvLynX6ju8pg2+6n+L9gz/8CB7hRCXkhfk=;
        b=Tb7D5RlHeTSbtrcTHtRrKkG4J4YI+NnKFZ9aJ8zqi5EsCbBho4TLIfsl2OVAUaXrfA
         QnNMHSdZWf48CcagP01cLitvlQp1H6TdxuT77qH0N/6U+WeZGtz8cB0UOKD0yOdSWVeL
         YcPSxkaJ9SFEDiX5BofA1NaRaZNQE8qvqnqHAPTO+B0T5QgCG1C0ue3l3CfSRjWBdEgC
         P5sL6i6pQUS+V+SMGsO00ayZMNRcmm6qLcwAG1xMLwSa3vCTAP0x6gMxzlUR9q5V59Cp
         pKqGTsI3gXkjg+c7gDMqxKal6MfOvEmHvcAnu45sXCyqRQDZ+xeiVpApFBmmNxvj4oQC
         wcIA==
X-Gm-Message-State: AOAM5320vUIZwSRtD3D/GOOA7i7/2/DNCIIaKcGxxWn7/c2lUVYbIi/+
        EdzztBJ+2JzKUeeq8Q6wAZ+55tAkMZG1FkDd28HnlHfT
X-Google-Smtp-Source: ABdhPJzsWvh1evlYg5LXH01AzOqky+X9zniwui4WabZN4uqJTUu4SWHWM9IUtD/ko5W0xinzq/Q8ecLMkZZli/hM5U0=
X-Received: by 2002:ac8:5691:: with SMTP id h17mr30471835qta.35.1593737674869;
 Thu, 02 Jul 2020 17:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592371583-30672-7-git-send-email-iamjoonsoo.kim@lge.com> <ed5a75ea-42bb-9acf-c567-3ff2d2af4fcb@suse.cz>
In-Reply-To: <ed5a75ea-42bb-9acf-c567-3ff2d2af4fcb@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 3 Jul 2020 09:54:23 +0900
Message-ID: <CAAmzW4OOe9+NHZ5CxL-e=Gf8rd4MwtM-C2+L14uWQBc6zoXsWA@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] mm/vmscan: restore active/inactive ratio for
 anonymous LRU
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 7=EC=9B=94 2=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 10:45, V=
lastimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 6/17/20 7:26 AM, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > Now, workingset detection is implemented for anonymous LRU.
> > We don't have to worry about the misfound for workingset due to
> > the ratio of active/inactive. Let's restore the ratio.
>
> How about:
>
> Now that workingset detection is implemented for anonymous LRU, we don't =
need
> large inactive list to allow detecting frequently accessed pages before t=
hey are
> reclaimed, anymore. This effectively reverts the temporary measure put in=
 by
> commit "mm/vmscan: make active/inactive ratio as 1:1 for anon lru".

Much better!. I will use the comment you suggested. Thanks.

> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> Thanks!
> I still hope Matthew can review updated patch 4/6 (I'm not really familia=
r with
> proper xarray handling), and Johannes patch 5/6.

Okay, I hope so, too. :)

> And then we just need a nice Documentation file describing how reclaim re=
ally
> works after all the recent changes :)

Agreed.

Thanks.
