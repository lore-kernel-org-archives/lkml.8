Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14948C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD38222B48
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="cNYr+iRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgCDRLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:11:02 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:42053 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgCDRLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:11:01 -0500
Received: by mail-qt1-f171.google.com with SMTP id r6so1902837qtt.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s8bsXGCRRJ0ImpTHMURebBvYjheGcXTfz4nsGdOTkXk=;
        b=cNYr+iRCJkEFyXleNOGaRrQw2f0+ltCk0IDvDTl74M7Lnm3m+52BRSlEisx0cAaWEY
         oTkaia1KvzVVUuCOJcYrpNJXRRC8+c5BvecTXPwo6AxLpF8jZQw6fcOk/abyO1wWhD8m
         SqzhfqyseKlJgEZ6SUMUS9Bra3QM/ison/7izr7oXYi5avhZ8QdrBrQJeVMG6/WWqE3z
         UB6Elo++zXRkjrB4tJhtbPNI4xXiaCFJVYrdmTB1JGZNPGVr65iEzbyr7m3ERxd7Ta3k
         0XZ1x1rZB+kOplz86w47eTbPkF/H1sk1BwrXf3PBoDteSOAvM0yWBmSMkwHfQ19Aik9X
         Mz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s8bsXGCRRJ0ImpTHMURebBvYjheGcXTfz4nsGdOTkXk=;
        b=GqqCuOJDm9CRZFv1g7xEE0gH3MPJkkUgkqO2ueJsF+kg+YgtvB2XqjIJZEOYuyReq8
         CBvB+CIH+2SmuyJSnsQMebOK4RSiUwj7Kw4mvgQbm6p0DoqIIJFBRKpfuYw3zVqPtkcm
         mp3hmBl+8PMtJnexH4Bphzh5rY5tmx8LfYMuZlyy7mhY2aBnyWNAoTsgXR0gPrG1Px0p
         o+hBKtncmRAFmn9FtqR8fqiO3/3SGlMN0cwDdkgAaLJEJjus2JIITYvOvY/XleZeyQPA
         j/jHoER93obabf0Gs+bAeQH9pzOZP/HWSPVTd2i5ZqPrGmRuRYicZxR7Lt1W4uVsKzoh
         FhyQ==
X-Gm-Message-State: ANhLgQ3MA+2eD5q45UdsSGFrB2BClxSkdf/5pygx9uh6IANuUvBoyWve
        vdJ1yCBbaW8qqaYp62qfaEJRgA==
X-Google-Smtp-Source: ADFU+vvFwn7lLQcicTGy7gFAAJWlHgV8j+T+wl/CYuJHilPTKbUrlukgCHes1ArvpLezQ5x/L4lkzA==
X-Received: by 2002:ac8:3798:: with SMTP id d24mr3358903qtc.178.1583341860182;
        Wed, 04 Mar 2020 09:11:00 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x44sm13257923qtc.88.2020.03.04.09.10.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2020 09:10:59 -0800 (PST)
Message-ID: <1583341858.7365.155.camel@lca.pw>
Subject: Re: [PATCH -next] lib: disable KCSAN for XArray
From:   Qian Cai <cai@lca.pw>
To:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 04 Mar 2020 12:10:58 -0500
In-Reply-To: <CANpmjNOotdBa_7EhA75f2Y59HfEVsGsquv1cvQ=OjtA784poRA@mail.gmail.com>
References: <20200304031551.1326-1-cai@lca.pw>
         <20200304033329.GZ29971@bombadil.infradead.org>
         <20200304040515.GX2935@paulmck-ThinkPad-P72>
         <20200304043356.GC29971@bombadil.infradead.org>
         <20200304141021.GY2935@paulmck-ThinkPad-P72>
         <CANpmjNOotdBa_7EhA75f2Y59HfEVsGsquv1cvQ=OjtA784poRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-04 at 17:40 +0100, Marco Elver wrote:
> On Wed, 4 Mar 2020 at 15:10, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > On Tue, Mar 03, 2020 at 08:33:56PM -0800, Matthew Wilcox wrote:
> > > On Tue, Mar 03, 2020 at 08:05:15PM -0800, Paul E. McKenney wrote:
> > > > On Tue, Mar 03, 2020 at 07:33:29PM -0800, Matthew Wilcox wrote:
> > > > > On Tue, Mar 03, 2020 at 10:15:51PM -0500, Qian Cai wrote:
> > > > > > Functions like xas_find_marked(), xas_set_mark(), and xas_clear_mark()
> > > > > > could happen concurrently result in data races, but those operate only
> > > > > > on a single bit that are pretty much harmless. For example,
> 
> I currently do not see those as justification to blacklist the whole
> file. Wouldn't __no_kcsan be better? That is, in case there is no
> other solution that emerges from the remainder of the discussion here.

I suppose it is up to Matthew. Currently, I can see there are several functions
may need __no_kcsan,

xa_get_mark(), xas_find_marked(), xas_find_chunk() etc.

My worry was that there could be many of those functions operating on marks
(which is a single-bit) in xarray that could end up needing the same treatment.

So far, my testing is thin on filesystem side where xarray is pretty much used
for page caches, so the reports I got from KCSAN runs does not necessary tell
the whole story. Once I updated my KCSAN runs to include things like xfstests,
it could add quite a few churns later if we decided to go with the __no_kcsan
route.
