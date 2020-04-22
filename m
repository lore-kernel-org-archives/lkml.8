Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67D8C5518B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9441B206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzfB+ou4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgDVHkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726110AbgDVHkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:40:41 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1707BC03C1A6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:40:41 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id v38so399940qvf.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ikk0dQhyFpwnAVzmiYRwmj+JonOTl74dqJfYXMk90xI=;
        b=MzfB+ou4iSfP5dGvECieDS9Qg0EXAWdTbXCbdZLMF5zLkna1zUEVjfLYTyXFs+N02F
         XJ5I8uLIqEFwvfXvw6BSKEYKcPqxMGFOs33HL61tmO+S0gfoFeue+7E/7Ov8sBv2rUQF
         GPatoNGcopgIFcYssgUfwmysEDXEUX/DLIuIWUEphMI8fNLNK6KwOYRDWqctr30RKTvi
         Bl086By8QVGYMYV4FZSQXZR74tfuP4EL3L1IFm3GwVLIzYs/BqlZ1ATA+ENDd4navY4A
         gSvED2WRlDCaJs0K4kZHsgT/fssUbob2DLi7NJSqGZC+AwhEcb4yHGz9DxM57kv6OlcF
         qn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ikk0dQhyFpwnAVzmiYRwmj+JonOTl74dqJfYXMk90xI=;
        b=E8EKZlsf/ig8r6hJnULZcnTvDP42Oe1GCY7smxXnhQhwP5eV+bowM8p07LD/oXDLch
         +QeubBdnvQBEq4zm3Pss8DQQztB6yuLdhbWY+FhHKIpCZi/9xFe/WH+RTe+5G7101bbE
         nkIcYH768gs6AsFkjacrCdZcfLMy3MWNJNpsI0oJPJ3EBgHjcimV+fmf8PBtD+8TkL6s
         9jlD//SOBJmiXQ3yNN8wfGPYOrhwj9V4ePG1CPrHwzB5SzDcex5vn99iEjiuXHRXGE9G
         osV2ZP19GZe3kdUrpAvrtBn5Iq/ozZ0tdG5KepMh1WKXkjPyGeGE2aUV5KN1Ais0eRlR
         QTjA==
X-Gm-Message-State: AGi0PuaffDZnJ+Lki7I6xgPyfJH7zwY2jNvpHzlll9L4gjTeX8Lh7Ie0
        rMakpr2fq3r3hrL/RhDhpy9SaCKdPU6uGkC7z9U=
X-Google-Smtp-Source: APiQypKU451lMNB3ed5dMLHj/7iehwfMZhGAanJvgkwaF9PIbZlpgAXC2qvOOoOkyoZdgH9Z2Wv9zYrYXjFPAFmRDxA=
X-Received: by 2002:a05:6214:1248:: with SMTP id q8mr23924825qvv.66.1587541240162;
 Wed, 22 Apr 2020 00:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1587369582-3882-2-git-send-email-iamjoonsoo.kim@lge.com> <20200421090005.GA23085@infradead.org>
In-Reply-To: <20200421090005.GA23085@infradead.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 22 Apr 2020 16:40:29 +0900
Message-ID: <CAAmzW4MQaZ8CRHtNEyFstuSwD_LwYa24WJGs93sP__Mr3+=eog@mail.gmail.com>
Subject: Re: [PATCH 01/10] mm/page-flags: introduce PageHighMemZone()
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
        Pavel Machek <pavel@ucw.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 4=EC=9B=94 21=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 6:00, C=
hristoph Hellwig <hch@infradead.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> I don't think the names are very good.  I'd keep PageHighMem for the
> existing highmem zone, and add something like PageDirectMapped or
> similar for ay page that has a valid direct mapping address.  This will
> also come in handy if we plan to go ahead with the xpfo work.

For PageHighMem(), as mentioned in patch description, my next plan is
to rename PageHighMem() that checks valid direct mapping to
PageNoDirectMapped() or something else. PageDirectMapped() looks better.
Reason that rename isn't implemented in this patchset is that I'd like to r=
ename
after everything is settle down.

For PageHighMemZone(), I think that it serves correct meaning.

Thanks.
