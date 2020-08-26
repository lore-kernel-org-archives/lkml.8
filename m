Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC81FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 05:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A53E620825
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 05:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErlMU/Ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgHZFV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 01:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgHZFV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 01:21:56 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245B1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 22:21:56 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id v1so246539qvn.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 22:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=js0EBC62eWGyWAw9YJWIyLBqx2ojH0IgaEQrWHEIoXI=;
        b=ErlMU/KeJReMDDWNhlUIRGySVmy3ZbFLthcDLUwgpSWt8bgf6Y+3A+gXACc3aSugat
         uVPawmSTv1QFEVkBmYXMoMvv8ZzBiUT8eWET69xlh8dOPXS+WxYELokjxMqn2d9BQ90L
         iaC0+khrDU6LMOcUv4Xvg6AThTYLNBlAqbPYybxt9ikwIFLiQV3seXYwEwuo/KZTaf/f
         8fDErVlBkYsJDK1GSU2opAeCL7ChvFpQBDxYKJNq6gfNgyXhW+16CCPIi6y2WDmz9fsr
         pzHKd3lyT2fHNoTiyISi1CRm5wOdgayb9SalsfWtZ0GBiOUBFiPb1prQLtGffhqUHcL4
         trRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=js0EBC62eWGyWAw9YJWIyLBqx2ojH0IgaEQrWHEIoXI=;
        b=j2XtZJC9x3VZaBkyxifI8vIvYPEXGhM5BPmNM0VrDUWlx/SPDqQP8ZzRI1yWyJeIi3
         10YqN3+bRWHJQjtfmv5XCWXxNbzpiCVHZW9d+e4RIoa2AndgH/weRTV92iaKgoVKO9j+
         VDvswc762paPUyb5wQPfs+razccNYKwW802fLFTdGjkFD/9K4WvRKR/zuKq0IZQn5aaL
         Oh2dmeNMVC0nAzlolfGuip0aW8uinYwMizKXQPWCPm+gxme2wan9l9lKCtRsKVE8sLML
         E7ZWfvIthqY5dfuBmiA8UCRx575dc+0Ehr9Br2ITutfl/5hCc5gT0FM6b7rJR/00g8ek
         PkbA==
X-Gm-Message-State: AOAM532Xi4T/pOQ16PGMfUKMEWGxr+htl+wH4WRJO8pQYR4iTbf2mLrs
        SQSrErUzabQ+FVAyRGpod+lUNjDgDzdQRQfeHpU=
X-Google-Smtp-Source: ABdhPJx+R64pJw48sxesha5UFmsvqWxbki3DIAa8ABi4VpfdPgoyGpwdHW/9IAVPPWzez5itZdMXGCnOPCuwpIlmN+I=
X-Received: by 2002:a05:6214:68b:: with SMTP id r11mr12451619qvz.226.1598419315432;
 Tue, 25 Aug 2020 22:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <1598331582-19923-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20200824221049.edb3c540bbfc859a6806600d@linux-foundation.org>
 <CAAmzW4MYQsRoR-q8tUmwPYLvCbiMq_zt19_AgorAQHnbwnu37g@mail.gmail.com> <20200825174257.5b48a5dd24b5e08a915b101e@linux-foundation.org>
In-Reply-To: <20200825174257.5b48a5dd24b5e08a915b101e@linux-foundation.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 26 Aug 2020 14:21:44 +0900
Message-ID: <CAAmzW4PLv_6wfJFsDKGNziHwAS94ERJL4tEwPLuUCpCDC1DnAA@mail.gmail.com>
Subject: Re: [PATCH for v5.9] mm/page_alloc: handle a missing case for
 memalloc_nocma_{save/restore} APIs
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        kernel-team@lge.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 8=EC=9B=94 26=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 9:42, A=
ndrew Morton <akpm@linux-foundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> On Tue, 25 Aug 2020 14:34:32 +0900 Joonsoo Kim <js1304@gmail.com> wrote:
>
> > >
> > > That's a bunch more code on a very hot path to serve an obscure featu=
re
> > > which has a single obscure callsite.
> > >
> > > Can we instead put the burden on that callsite rather than upon
> > > everyone?  For (dumb) example, teach __gup_longterm_locked() to put t=
he
> > > page back if it's CMA and go get another one?
> >
> > Hmm... Unfortunately, it cannot ensure that we eventually get the non-C=
MA page.
> > I think that the only way to ensure it is to implement the
> > functionality here. We can
> > use 'unlikely' or 'static branch' to reduce the overhead for a really
> > rare case but
> > for now I have no idea how to completely remove the overhead.
>
> Gee, there must be something?  Provide the gup code with a special
> entry point which takes the page straight from __rmqueue() and bypasses
> the pcp lists?

Hmm... it seems not possible. It's allocation context API and maybe actual
allocation happens in handle_mm_fault() or it's successor. We cannot use
a special entry point for allocation there since it's a general function.

And, IMHO, making a special allocation function that bypasses the pcp list
would not be a good practice.

Thanks.
